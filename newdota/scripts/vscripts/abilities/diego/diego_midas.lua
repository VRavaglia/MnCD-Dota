function midas(keys)
	local target = keys.target
	local caster = keys.caster
	local midas = caster:FindAbilityByName("diego_midas")
	local level_midas = midas:GetLevel()
	local ability = midas
	local casted = keys.ability
	local charge_check = true
	local modifierName = "diego_nomad_counter"
	local charges = caster:GetModifierStackCount(modifierName, caster)

	if ability == caster:FindAbilityByName("diego_nomad") and not charges == 0 then
		charge_check = false 
	end
		

	if level_midas > 0 then
		if caster:IsOpposingTeam(target:GetTeamNumber()) and caster.skill == nil and not caster.skill == casted and target:HasModifier("diego_midas_debuff") and charge_check then		
			local damage = ability:GetLevelSpecialValueFor("damage", (ability:GetLevel()-1)) 

			local damageTable = {
				victim = target,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = ability,
			}

			ApplyDamage(damageTable)
			target:AddNewModifier(caster, ability, "modifier_stunned", {Duration = ability:GetLevelSpecialValueFor("stun", (ability:GetLevel()-1))})
			target:RemoveModifierByName("diego_midas_debuff")
		else
			ability:ApplyDataDrivenModifier(caster, target, "diego_midas_debuff", {duration = 5.0})
		end
	end	

	caster.skill = casted
	
end

