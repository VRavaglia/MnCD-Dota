function setup(keys)
	local ability = keys.ability
	ability.counter = 0
end

function counter(keys)
	local ability = keys.ability
	ability.counter = ability.counter + 0.1
	print(ability.counter)
end

function start(keys)
	
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local level = ability:GetLevel()
	local min_damage = ability:GetLevelSpecialValueFor("min_damage", level)
	local max_damage = ability:GetLevelSpecialValueFor("max_damage", level)
	local atks_per_unit = ability:GetLevelSpecialValueFor("atks_per_unit", level)
	local duration = ability:GetLevelSpecialValueFor("atks_duration_base", level) + (ability:GetLevelSpecialValueFor("atks_duration_bonus", level)/(ability:GetLevelSpecialValueFor("duration", level) - 0.1) * ability.counter)
	 

	if not caster:HasModifier("arcano_beam_buff_counter") then
		ability:ApplyDataDrivenModifier(caster, caster,"arcano_beam_buff_counter", {duration = duration})
	else 
		local counter_buff = caster:FindModifierByName("arcano_beam_buff_counter")
		counter_buff:SetDuration(duration, true)	
	end

	local counter_buff = caster:FindModifierByName("arcano_beam_buff_counter")
	counter_buff:IncrementStackCount()
	ability:ApplyDataDrivenModifier(caster, caster,"arcano_beam_buff", {duration = duration})		
	ability:ApplyDataDrivenModifier(caster, target,"arcano_beam_debuff", {duration = duration})
	local damage = min_damage + (max_damage/(ability:GetLevelSpecialValueFor("duration", level) - 0.1) * ability.counter)
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

function decrement(keys)
	local caster = keys.caster
	local counter_buff = caster:FindModifierByName("arcano_beam_buff_counter")
	if counter_buff then
		counter_buff:DecrementStackCount()
	end	
	
end
