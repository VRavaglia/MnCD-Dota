function midas(keys)
	local target = keys.target
	local caster = keys.caster
	local midas = caster:FindAbilityByName("diego_midas")
	local level_midas = midas:GetLevel()
	local ability = midas


	if level_midas > 0 then
		if target:HasModifier("diego_midas_debuff") then

			local damage = ability:GetLevelSpecialValueFor("damage", (ability:GetLevel()-1)) 

			local damageTable = {
				victim = target,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = ability,
			}

			ApplyDamage(damageTable)

			target:AddNewModifier(caster, ability, "modifier_stunned", {Duration = ability:GetLevelSpecialValueFor("stun", (ability:GetLevel()-1))}
			

			target:RemoveModifierByName("diego_midas_debuff")
		

		else
			ability:ApplyDataDrivenModifier(caster, target, "diego_midas_debuff", {duration = 5.0})
		end
	end	



end

