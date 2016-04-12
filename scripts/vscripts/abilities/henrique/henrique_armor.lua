function cooldown(keys)
	print("foi")
	local caster = keys.caster
	local ability = keys.ability
	local level = (ability:GetLevel()-1)
	local cooldown = ability:GetLevelSpecialValueFor("cooldown", level)
	local duration_d = ability:GetLevelSpecialValueFor("duration", level)
	local target = keys.target

	if ability:IsCooldownReady() then
		ability:ApplyDataDrivenModifier(caster, caster, "henrique_armor_buff", {duration = duration_d})
		ability:ApplyDataDrivenModifier(caster, target, "henrique_armor_debuff", {duration = duration_d})
		ability:StartCooldown(cooldown)
	end
end	