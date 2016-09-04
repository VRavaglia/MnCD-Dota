--after upgrading for the first time
function start(keys)
    local ability = keys.ability
    local level = ability:GetLevel()

    if level == 1 then
        ability.caster = keys.caster
        ability.dmg_table = {}
    end 
end
--each time an enemy hero deals damage
function store(keys)
    local attacker = keys.attacker
    local damage = keys.attack_damage
    local ability = keys.ability
    
    ability.dmg_table[GameRules:GetGameTime()] = {hero = attacker, amount = damage}

    for k, v in pairs(ability.dmg_table) do
        if k < (GameRules:GetGameTime() - (ability:GetLevelSpecialValueFor("time_interval", (ability:GetLevel()-1)))) then
            ability.dmg_table[k] = nil
        end
    end
end

--when the spell is cast

function gamble(keys)
    local ability = keys.ability
    local target = keys.target 
    local caster = keys.caster

    local damage_done = 0

    for key,value in pairs(ability.dmg_table) do
        if value.hero == target then
            damage_done = damage_done + value.amount
        end
    end

    local formula_bolada = damage_done * 0.5 * ability:GetLevelSpecialValueFor("damage_constant", (ability:GetLevel()-1))

    local damage_to_be = formula_bolada

--[[	local damageTable{
	victim = target,
	attacker = caster,
	damage = damage_to_be,
	damage_type = DAMAGE_TYPE_MAGICAL,
	ability = ability,
	}

	ApplyDamage(damageTable)]]--
 
			
	end
end

	