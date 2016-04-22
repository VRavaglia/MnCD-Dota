function stack(keys)
	local target = keys.target
	local caster = keys.caster
	local modifier = "shaman_disble_stack_counter"
	local ability = keys.ability
	local level = ability:GetLevel() - 1
	local max_stacks = ability:GetLevelSpecialValueFor("max_stacks", level)
	
	local act_modifier = target:FindModifierByName("shaman_disable_stack_counter")
	
	act_modifier:IncrementStackCount()
	
	if act_modifier:GetStackCount() > max_stacks then
		act_modifier:SetStackCount(max_stacks)
	end
end

function projectile(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local level = ability:GetLevel() - 1
	local damage = ability:GetLevelSpecialValueFor("damage_base", level)
	local stacks = 0

	if target:HasModifier("shaman_disable_stack_counter") then
		
		local modifier = target:FindModifierByName("shaman_disable_stack_counter")
		stacks = modifier:GetStackCount()
	end

	

	local damage_per_stack = ability:GetLevelSpecialValueFor("damage_per_stack", level)


	local duration = ability:GetLevelSpecialValueFor("duration_base", level)
	local duration_per_stack = ability:GetLevelSpecialValueFor("duration_per_stack", level)

	damage = damage + damage_per_stack * stacks
	duration = duration + duration_per_stack * stacks

	ability:ApplyDataDrivenModifier(caster, target, "shaman_disable_stun", {duration = duration})

	local damageTable = {
					victim = target,
					attacker = caster,
					damage = damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
					ability = ability,
				}

				ApplyDamage(damageTable)
	target:RemoveModifierByName("shaman_disable_stack_counter")
	print("stacks " .. stacks)
	print("damage " .. damage)
	print("stun " .. duration)

end