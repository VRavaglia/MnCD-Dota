function apply_target(keys)
	local caster = keys.caster
	local modifier = "berserker_ignite_target"
	local ability = keys.ability
	local level = (ability:GetLevel()-1)
	local duration_d = ability:GetLevelSpecialValueFor("duration_target", level)
	local target = keys.target

	ability:ApplyDataDrivenModifier(caster, target, modifier, {duration = duration_d})


end

function area_ignite(keys)

	local caster = keys.caster
	local ability = caster:FindAbilityByName("berserker_ignite")
	local modifier = "berserker_fury_buff"

	if caster:HasModifier(modifier) then

		local level = (ability:GetLevel()-1)
		local modifier_target = "berserker_ignite_target"
		local duration_d = ability:GetLevelSpecialValueFor("duration_target", level)
		local target = keys.target
		ability:ApplyDataDrivenModifier(caster, target, modifier_target, {duration = duration_d})

	end

end

