function tick(keys)
	local caster = keys.caster
	local ability = keys.ability
	local level = ability:GetLevel()
	local radius = ability:GetLevelSpecialValueFor("radius_buff", level)
	local caster_pos = caster:GetAbsOrigin()
	local totem = Entities:FindByClassnameNearest("npc_dota_ward_base", Vector(caster_pos.x, caster_pos.y, caster_pos.z), radius)


	if totem then
		local heal_amount = ability:GetLevelSpecialValueFor("heal_percent_base", level)
		caster:Heal((caster:GetMaxHealth() * heal_amount / 100), caster)

		local mana_amount = ability:GetLevelSpecialValueFor("mana_percent_base", level)
		caster:GiveMana(caster:GetMaxHealth() * heal_amount / 100)
		local duration = 2/10

		ability:ApplyDataDrivenModifier(caster,caster,"hermann_buff_effect",{duration = duration})
	end	

end

function tick_buff(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local level = ability:GetLevel()
	local radius = ability:GetLevelSpecialValueFor("radius_buff", level)
	local target_pos = target:GetAbsOrigin()
	local totem = Entities:FindByClassnameNearest("npc_dota_ward_base", Vector(target_pos.x, target_pos.y, target_pos.z), radius)


	if totem then
		local heal_amount = ability:GetLevelSpecialValueFor("heal_percent_buff", level)
		target:Heal((target:GetMaxHealth() * heal_amount / 100), caster)

		local mana_amount = ability:GetLevelSpecialValueFor("mana_percent_buff", level)
		target:GiveMana(target:GetMaxHealth() * heal_amount / 100)
		local duration = 2/10

		ability:ApplyDataDrivenModifier(caster,target,"hermann_buff_effect",{duration = duration})
	end	

end

function cast(keys)
	local ability = keys.ability
	local level = ability:GetLevel() - 1
	local cooldown = ability:GetLevelSpecialValueFor("cooldown", level)
	ability:StartCooldown(cooldown)
end