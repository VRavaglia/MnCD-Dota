function reflect(keys)
	local damage = keys.attack_damage
	local caster = keys.caster

	local ability = keys.ability
	local level = (ability:GetLevel()-1)
	local reflect_percent = ability:GetLevelSpecialValueFor("damage_reflected", level)
	local damage_to_deal = damage * reflect_percent * 0.01

	local target = keys.attacker
	print(target)



	local damageTable = {
	victim = target,
	attacker = caster,
	damage = damage_to_deal,
	damage_type = DAMAGE_TYPE_PHYSICAL,
	ability = ability,
	}
	for key,value in pairs(damageTable)	do
		print(key,value)
	end

	ApplyDamage(damageTable)


end

