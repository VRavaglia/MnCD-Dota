function start(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local level = (ability:GetLevel() - 1)
	local target_pos = target:GetAbsOrigin()

	local radius = {}
	radius[1] = ability:GetLevelSpecialValueFor("radius_slow", level) 
	radius[2] = ability:GetLevelSpecialValueFor("radius_slow_bonus", level)
	radius[3] = ability:GetLevelSpecialValueFor("radius_stun", level)

	local min_damage = ability:GetLevelSpecialValueFor("min_damage", level)
	local max_damage = ability:GetLevelSpecialValueFor("max_damage", level)

	local damage = min_damage

	local totem = Entities:FindByClassnameNearest("npc_dota_ward_base", Vector(target_pos.x, target_pos.y, target_pos.z), radius[1])

	if totem then

		local totem_pos = totem:GetAbsOrigin()

		local distance = math.sqrt(((totem_pos.x - target_pos.x)^2) + ((totem_pos.y - target_pos.y)^2))


		print(distance)

		if distance <= radius[3] then

			local duration = ability:GetLevelSpecialValueFor("duration_stun", level) 
			ability:ApplyDataDrivenModifier(caster, target, "hermann_disable_stun", {duration = duration})
			damage = max_damage

			print("Stun")


		elseif	distance <= radius[2] then

			local duration = ability:GetLevelSpecialValueFor("duration_slow", level) 
			ability:ApplyDataDrivenModifier(caster, target, "hermann_disable_slow_bonus", {duration = duration})
			damage = damage + (max_damage - (max_damage*(distance/radius[1])))

			print("Slow x 2")

		else

			local duration = ability:GetLevelSpecialValueFor("duration_slow", level) 
			ability:ApplyDataDrivenModifier(caster, target, "hermann_disable_slow_base", {duration = duration})
			damage = damage + (max_damage - (max_damage*(distance/radius[1])))

			print("Slow")

		end
		

	end

	print(damage)

	local damageTable = {
				victim = target,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = ability,
			}

			ApplyDamage(damageTable)	



end