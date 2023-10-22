require "frozenthrone.utility.commandSplit"
require "frozenthrone.utility.hasValue"

-- CLASS_TYPES:
--     type: the type of class (physical damage class or caster clasS)
--     armorType: what kind of amror the class is waering
--         - 1: cloth
--         - 2: cloth & leather
--         - 3: leather & mail
--         - 4: plate & mail
--     weaponType: what kind of weapons class is using
--         - 1: 1h
--         - 2: 2h
--         - 3: 2h & 1h
--         - 4: ranged & 1h
--         - 5: ranged & 2h


local SEPARATE_EQUIPMENT_SETS = {
    ["caster"] = {
        ["cloth"] = {42985, 44107}, -- 1
        ["leather"] = {42984, 44105}, -- 2
        ["mail"] = {42951, 44102}, -- 3
        ["plate"] = {44100}, -- 4
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
        42991, 42992, 
    },
    ["horde"] = {
        44097 -- horde signet
    },
    ["alliance"] = {
        44098 -- alliance signet
    },
    ["extra" ] = { -- these get sent to every new character

    }
}
local CLASS_TYPES = {
    [1] = {
        type = 1, -- caster
        armorType = 4, -- uses cloth, letaher, mail and plate
        weaponType = 2,
    }, -- Warrior
    [2] = {
        type = 1,
        armorType = 4,
        weaponType = 2,
    },   -- Paladin
    [3] = {
        type = 1,
        armorType = 3,
        weaponType = 5,
    },   -- Hunter
    [4] = {
        type = 1,
        armorType = 2,
        weaponType = 1,
    },   -- Rogue
    [5] = {
        type = 2,
        armorType = 2,
        weaponType = 2,
    },   -- Priest
    [6] = {
        type = 1,
        armorType = 4,
        weaponType = 3,
    },   -- Death Knight
    [7] = {
        type = 2,
        armorType = 3,
        weaponType = 1,
    },   -- Shaman
    [8] = {
        type = 2,
        armorType = 2,
        weaponType = 2,
    },   -- Mage
    [9] = {
        type = 2,
        armorType = 2,
        weaponType = 2,
    },   -- Warlock
    [11] = {
        type = 2,
        armorType = 2,
        weaponType = 2,
    }   -- Druid
}

local playerClassType = "";
local playerArmorType = "";
local playerWeaponType = "";
local playerFaction = "";

local function sg_getPlayerDetails(player)
    local currentPlayerFaction = player:IsHorde();
    local currentPlayerClass = player:GetClass();

    if currentPlayerFaction then 
        playerFaction = "horde";
    else playerFaction = "alliance";
    end

    local playerClassTypeData = CLASS_TYPES[currentPlayerClass];

    playerClassType = playerClassTypeData.type;

    if playerClassType == 1 then
        playerClassType = "physical"
    else playerClassType = "caster"
    end

    playerArmorType = playerClassTypeData.armorType;
    playerWeaponType = playerClassTypeData.weaponType;
end

local function sg_GiveItemSet(equipmentSet, player)
    if equipmentSet then
        for _, itemID in ipairs(equipmentSet) do
            player:AddItem(itemID, 1)
        end
    end
end

local function sg_GiveArmor(player)
    local mainArmorSet = SEPARATE_EQUIPMENT_SETS[playerClassType];
    player:SendBroadcastMessage(playerClassType);
    if playerArmorType == 4 then
        sg_GiveItemSet(mainArmorSet["mail"], player);
        sg_GiveItemSet(mainArmorSet["plate"], player);
    end

    if playerArmorType == 3 then
        sg_GiveItemSet(mainArmorSet["leather"], player);
        sg_GiveItemSet(mainArmorSet["mail"], player);
    end
    
    if playerArmorType == 2 then
        sg_GiveItemSet(mainArmorSet["cloth"], player);
        sg_GiveItemSet(mainArmorSet["leather"], player);
    end

    if playerArmorType == 1 then
        sg_GiveItemSet(mainArmorSet["cloth"], player);
    end
end

local function sg_GiveWeapon(player)
    local mainArmorSet = SEPARATE_EQUIPMENT_SETS[playerClassType];

    if playerWeaponType == 5 then
        sg_GiveItemSet(mainArmorSet["ranged"], player);
        sg_GiveItemSet(mainArmorSet["2h"], player);
    end

    if playerWeaponType == 4 then
        sg_GiveItemSet(mainArmorSet["ranged"], player);
        sg_GiveItemSet(mainArmorSet["1h"], player);
    end

    if playerWeaponType == 3 then
        sg_GiveItemSet(mainArmorSet["1h"], player);
        sg_GiveItemSet(mainArmorSet["2h"], player);
    end
    
    if playerWeaponType == 2 then
        sg_GiveItemSet(mainArmorSet["2h"], player);
    end

    if playerWeaponType == 1 then
        sg_GiveItemSet(mainArmorSet["1h"], player);
    end
end

local function sg_GiveTrinkets(player)
    sg_GiveItemSet(SEPARATE_EQUIPMENT_SETS["trinkets"], player);
    sg_GiveItemSet(SEPARATE_EQUIPMENT_SETS[playerFaction], player);
end

local function sg_GiveExtra(player)
    sg_GiveItemSet(SEPARATE_EQUIPMENT_SETS["extra"], player)
end

local function sg_GearupHeirloom(event, player, msg, _, lang)
        sg_getPlayerDetails(player)    

        sg_GiveArmor(player);
        sg_GiveWeapon(player);
        sg_GiveTrinkets(player);
        sg_GiveExtra(player);
end


RegisterPlayerEvent(30, sg_GearupHeirloom)
