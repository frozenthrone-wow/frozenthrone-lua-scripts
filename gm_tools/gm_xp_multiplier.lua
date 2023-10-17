local GM_XP_MULTIPLIER = 10 -- Adjust the XP multiplier as needed

local function GMxpBuff(event, player, amount, victim)
    player:SendBroadcastMessage(player:GetGMRank())
    local playerGMrank = player:GetGMRank()
    if playerGMrank > 0 then
        return amount * GM_XP_MULTIPLIER
    else
        return amount
    end
end


RegisterPlayerEvent(12, GMxpBuff)