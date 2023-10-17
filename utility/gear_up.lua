local EQUIPMENT_SETS = {
    [1] = { -- Warrior
        40404, 
        40405,
        40406,       
    },
    [2] = { -- Paladin
        40407, 
        40408,
        40409,
    },
    [3] = { -- Hunter
        40410, 
        40411,
        40412,
    },
    [4] = { -- Rogue
    },
    [5] = { -- Priest
    },
    [6] = { -- Death Knight
        40413, 
        40414,
        40415,
    },
    [7] = { -- Shaman
    },
    [8] = { -- Mage
    },
    [9] = { -- Warlock
    },
    [11] = { -- Druid
    }
    -- TODO: Add items
}

local ChatPrefix = "#gearUp"

local function GearedUpAndReadyToRoll(event, player, msg, _, lang)
    if (msg:find(ChatPrefix) == 1) then
        player:SendBroadcastMessage("The Frozen Throne has blessed you.")
        local class = player:GetClass()
        local equipmentSet = EQUIPMENT_SETS[class]

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

RegisterPlayerEvent(18, GearedUpAndReadyToRoll)
