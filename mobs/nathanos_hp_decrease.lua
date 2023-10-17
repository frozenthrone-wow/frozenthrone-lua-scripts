

-- local function Nathanos_HPDecreaseOnEnterCombat(event, creature, target)
--     -- creature = enemy
--     -- target = player

--     if target then
--         target:DealDamage(creature, creature:GetHealth() / 4)
--     end
-- end

local DAMAGE_MULTIPLIER = 10

local function Nathanos_OnDamageTaken(event, creature, attacker, damage)
    if attacker then
        return false, damage * DAMAGE_MULTIPLIER
    end
end

-- RegisterCreatureEvent(11878, 1, Nathanos_HPDecreaseOnEnterCombat)
RegisterCreatureEvent(299, 9, Nathanos_OnDamageTaken)