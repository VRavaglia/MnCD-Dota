function start(keys)

	local caster = keys.caster
	local ability = keys.ability
	local modifier = "berserker_ignite_self"
	local level = (ability:GetLevel()-1)
	local target = keys.target
	local damage_base = ability:GetLevelSpecialValueFor("damage_base", level)
	local damage = damage_base

	if caster:HasModifier(modifier) then
		
		local duration_d = ability:GetLevelSpecialValueFor("duration", level)
		local damage_bonus = ability:GetLevelSpecialValueFor("damage_bonus", level)
		damage = damage_base + damage_bonus
		local modifier_target = "berserker_burnout_slow"		
		ability:ApplyDataDrivenModifier(caster, target, modifier_target, {duration = duration_d})
	end

	local damageTable = {
				victim = target,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = ability,
			}
	ApplyDamage(damageTable)


end

