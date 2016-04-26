function shield(keys)

	local caster = keys.caster
	local ability = keys.ability
	local modifier_reduction = "paladin_shield_reduction"
	local modifier_counter = "paladin_shield_main"
	local charges = caster:GetModifierStackCount(modifier_counter, caster)
	local modifier = caster:FindModifierByName(modifier_counter)
	local time_remaining = modifier:GetRemainingTime()



	if charges < ability:GetLevelSpecialValueFor("max_charges", (ability:GetLevel() - 1)) then
		local increment = charges + (ability:GetLevelSpecialValueFor("damage_per_charge_hero", (ability:GetLevel()-1)) * -1)
		caster:SetModifierStackCount(modifier_counter, caster, increment)
		ability:ApplyDataDrivenModifier(caster, caster, modifier_reduction, {duration = time_remaining})
	end	


end