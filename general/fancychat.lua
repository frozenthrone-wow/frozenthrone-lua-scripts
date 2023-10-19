local ChatPrefix = "#w";
local WorldChannelName = "World";

local allianceColor = "2e8bc0" -- Blue
local hordeColor = "db1f48" -- Red

local CooldownTimer = 0; -- Cooldown in seconds. Set to 0 for no CD obviously.
 
local Class = { -- Class colors :) Prettier and easier than the elseif crap :) THESE ARE HEX COLORS!
    [1] = "C79C6E", -- Warrior
    [2] = "F58CBA", -- Paladin
    [3] = "ABD473", -- Hunter
    [4] = "FFF569", -- Rogue
    [5] = "FFFFFF", -- Priest
    [6] = "C41F3B", -- Death Knight
    [7] = "0070DE", -- Shaman
    [8] = "69CCF0", -- Mage
    [9] = "9482C9", -- Warlock
    [11] = "FF7d0A" -- Druid
};
 
local Rank = {
    [0] = "7DFF00", -- Player
    [1] = "E700B1", -- Moderator
    [2] = "E7A200", -- Game Master
    [3] = "E7A200", -- Admin
    [4] = "E7A200" -- Console
};
 
 -- Do not edit below unless you know what you're doing :)
if (ChatPrefix:sub(-1) ~= " ") then
    ChatPrefix = ChatPrefix.." ";
end
 
local RCD = {};
function ChatSystem(event, player, msg, _, lang)
    local isHorde = player:IsHorde();
    local factionColor = " ";
    local isGM = player:GetGMRank() > 0;
    local playerGM = "NOGM";

    if(isHorde == true) then
        factionColor = table.concat({"|cff",hordeColor,"[H]|h|r"});
    elseif(isHorde == false) then
        factionColor = table.concat({"|cff",allianceColor,"[A]|h|r"});
    end

    if (RCD[player:GetGUIDLow()] == nil) then
        RCD[player:GetGUIDLow()] = 0;
    end

    if isGM then
        playerGM = "|cffFF0000GM|h|r - "
    end


    if (msg:sub(1, ChatPrefix:len()) == ChatPrefix) then
        local timeSinceLastMessage = RCD[player:GetGUIDLow()] - os.clock();
        if (0 < timeSinceLastMessage) then
            local chatCooldownMessage = string.format("|cFFFF0000You must wait %i second(s) before sending another World message!|r", math.floor(r));
            player:SendAreaTriggerMessage(chatCooldownMessage);
        else
            RCD[player:GetGUIDLow()] = os.clock() + CooldownTimer;
            local worldMessage = table.concat({"|cff81F7BE[", WorldChannelName, "] ", factionColor.." [|r|cff", Class[player:GetClass()], playerGM.."|Hplayer:", player:GetName(), "|h", player:GetName(), "|h|r|cff81F7BE]: |h|r|cffFFFFFF", msg:sub(ChatPrefix:len()+1), "|r"});        
            SendWorldMessage(worldMessage);
        end
        return false;
    end
end
 
RegisterPlayerEvent(18, ChatSystem);
RegisterPlayerEvent(4, function(_, player) RCD[player:GetGUIDLow()] = 0; end);