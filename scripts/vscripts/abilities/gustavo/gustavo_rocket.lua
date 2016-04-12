function damage(keys)

	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local ability_crit = caster:FindAbilityByName("gustavo_crit")
	local level = (ability:GetLevel()-1)
	local level_crit = (ability_crit:GetLevel()-1)
	local damage = ability:GetLevelSpecialValueFor("damage", level)
	local crit_chance = ability_crit:GetLevelSpecialValueFor("chance", level_crit)

	if level_crit >= 0 then
		local random = math.random(100)

		if random <= crit_chance then
			local mult = ability_crit:GetLevelSpecialValueFor("damage_percentage", level_crit)
			damage = (damage * mult / 100)
		end
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