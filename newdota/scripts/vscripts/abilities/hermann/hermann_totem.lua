function start(keys)
	local caster = keys.caster
	local modifierName = "hermann_totem_cooldown"
	local cooldownModifiers = caster:FindAllModifiersByName(modifierName)
	local ability = keys.ability
	local modifierCharges = "hermann_totem_charges"
	local charges =caster:GetModifierStackCount(modifierCharges, caster) 

	caster:SetModifierStackCount(modifierCharges, caster, (charges - 1))

	ability:ApplyDataDrivenModifier(caster, caster, modifierName, {duration = (ability:GetLevelSpecialValueFor("cooldown", (ability:GetLevel()-1)))})

	if charges == 1 then
		local modifierList = caster:FindAllModifiersByName(modifierName)
		local cooldown = 0
		
		for key,value in pairs(modifierList) do			
			if value:GetRemainingTime() < cooldown or cooldown == 0 then
				cooldown = value:GetRemainingTime()
			end	
		end

		ability:StartCooldown(cooldown)
	end


end

function stackup(keys)
	local caster = keys.caster
	local modifierName = "hermann_totem_charges"
	local charges =caster:GetModifierStackCount(modifierName, caster)
	caster:SetModifierStackCount(modifierName, caster, (charges + 1))

end

function create(keys)
    local ability = GetAbilityByIndex(5)
    

	if ability:GetLevel() == 0 then
        ability:SetLevel(1)
    	local caster = keys.caster
    	local modifierName = "hermann_totem_charges"
    	caster:SetModifierStackCount(modifierName, caster, (ability:GetLevelSpecialValueFor("max_charges", (ability:GetLevel()-1))))

	end	
end







