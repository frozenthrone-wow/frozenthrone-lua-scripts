local DAMAGE_MULTIPLIER = 10

local function Nathanos_OnDamageTaken(event, creature, attacker, damage)
    if attacker then
        return false, damage * DAMAGE_MULTIPLIER
    end
end

RegisterCreatureEvent(11878, 9, Nathanos_OnDamageTaken)