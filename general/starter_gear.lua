require "frozenthrone.utility.commandSplit"

local SEPARATE_EQUIPMENT_SETS = {
    ["caster"] = {
        ["cloth"] = {42985, 44107},
        ["leather"] = {42984, 44105},
        ["mail"] = {42951, 44102},
        ["plate"] = {44100},
        ["1h"] = {42948, 44094},
        ["2h"] = {42947, 44095},
    },
    ["physical"] = {
        ["leather"] = {42952, 44103},
        ["mail"] = {42950, 44101},
        ["plate"] = {42949, 44099},
        ["1h"] = {42944, 44091, 42945, 44096, 48716},
        ["2h"] = {42943, 48718, 44092},
        ["ranged"] = {42946, 44093}
    },
    ["trinkets"] = {
        42991, 42992, 44098, 44097
    }
}

local CLASS_EQUIPMENT_SETS = {
   [1] = {44099, 48685, 42949}, -- Warrior
   [2] = {44099, 48685, 42949, 44100}, -- Paladin
   [3] = {44101, 42950, 48677}, -- Hunter
   [4] = {44103, 42952, 48689}, -- Rogue
   [5] = {44107, 42985, 48691}, -- Priest
   [6] = {44099, 48685, 42949}, -- Death Knight
   [7] = {42951, 44102, 48683, 44101, 42950, 48677}, -- Shaman
   [8] = {44107, 42985, 48691}, -- Mage
   [9] = {44107, 42985, 48691}, -- Warlock
   [11] = {44105, 48687, 42984, 44103, 42952, 48689}, -- Druid
}

local chatPrefixArmors = "#starterGear"

local casterTypePrefix = "caster"
local physicalTypePrefix = "physical"

local weaponTypePrefix1h = "1h"
local weaponTypePrefix2h = "2h"
local weaponTypePrefixRanged = "ranged"

local trinketsTypePrefix = "trinkets"
local wrongCommandMessage = chatPrefixArmors.." <physical/caster/trinkets> <1h/2h/ranged>"

local function sg_getHeirlooms(class, classType, weaponType)
    if classType == nil and weaponType == nil then
        return CLASS_EQUIPMENT_SETS[class];
    end

    if classType ~= nil and weaponType ~= nil then
        return SEPARATE_EQUIPMENT_SETS[classType][weaponType]
    end

    if classType == trinketsTypePrefix and weaponType == nil then
        return SEPARATE_EQUIPMENT_SETS['trinkets']
    end
end

local function sg_GearupHeirloom(event, player, msg, _, lang)
    if (msg:find(chatPrefixArmors) == 1) then

        local commandArray = CommandSplit(msg)
        local class = player:GetClass();
        
        local classTypePrefix = commandArray[2];
        local weaponTypePrefix = commandArray[3];

        -- check if command is valid
        if classTypePrefix ~= nil then
            if classTypePrefix ~= casterTypePrefix 
            and classTypePrefix ~= physicalTypePrefix 
            and classTypePrefix ~= trinketsTypePrefix
                then
                    player:SendBroadcastMessage(wrongCommandMessage)
                    return false
            end
        end
        
        if weaponTypePrefix ~= nil then
            if weaponTypePrefix ~= weaponTypePrefix1h 
            and weaponTypePrefix ~= weaponTypePrefix2h 
            and weaponTypePrefix ~= weaponTypePrefixRanged
                then
                    player:SendBroadcastMessage(wrongCommandMessage)
                    return false
            end
        end
       
      
        -- get equipment sets
        local equipmentSet = sg_getHeirlooms(class, classTypePrefix, weaponTypePrefix)
        if equipmentSet then
            for _, itemID in ipairs(equipmentSet) do
                player:AddItem(itemID, 1)
            end

            player:SendBroadcastMessage("The Frozen Throne has blessed you.")
        else
            player:SendBroadcastMessage("")
        end
    end
end


RegisterPlayerEvent(18, sg_GearupHeirloom)
