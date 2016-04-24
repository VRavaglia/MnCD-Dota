function main(keys)
	local caster = keys.caster
	local ability = keys.ability
	local level = ability:GetLevel() - 1
	if level == 0 then
		ability.stacks = ability:GetLevelSpecialValueFor("base_charges", level)
	else
		ability.stacks = ability.stacks - ability:GetLevelSpecialValueFor("base_charges", (level - 1))
		ability.stacks = ability.stacks + ability:GetLevelSpecialValueFor("base_charges", level)
	end			
	
end
function sub_add(keys)
	local ability = keys.ability
	local target = keys.target
	local caster = keys.caster
	if target ~= caster then	 
		if target:IsHero() then
			ability.stacks = ability.stacks + 5
		else
			ability.stacks = ability.stacks + 1
		end
	end			
end
function sub_remove(keys)
	local ability = keys.ability
	local target = keys.target
	local caster = keys.caster
	if target ~= caster then	 
		if target:IsHero() then
			ability.stacks = ability.stacks - 5
		else
			ability.stacks = ability.stacks - 1
		end
	end
end
function sub_calculate(keys)
	local target = keys.target
	local ability = keys.ability
	local caster = keys.caster
	local modifier = target:FindModifierByName("shaman_buff_aura")
	if caster.shaman_ult_target and caster.summon_count and not caster.shaman_ult_target:IsNull() then
		local level = ability:GetLevel() - 1
		local pos1 = caster:GetAbsOrigin()
		local pos2 = caster.shaman_ult_target:GetAbsOrigin() 
		local distance = math.sqrt(((pos1.x - pos2.x)^2) + ((pos1.y - pos2.y)^2))
		local min_distance = ability:GetLevelSpecialValueFor("radius", level)
		if  distance <= min_distance then
			modifier:SetStackCount(ability.stacks + caster.summon_count)
		else
			modifier:SetStackCount(ability.stacks) 	
		end	
	else
		modifier:SetStackCount(ability.stacks)
	end		
end