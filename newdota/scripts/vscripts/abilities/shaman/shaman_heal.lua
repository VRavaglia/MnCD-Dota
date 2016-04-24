function setup(keys)
	local target = keys.target
	local ability = keys.ability
	if not ability.target_table then
		ability.index = 0
		ability.target_table = {}
	end

	ability.index = ability.index + 1
	ability.target_table[ability.index]	= target
		
end

function execute(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local level = ability:GetLevel() - 1
	local bonus = 0
	if caster.shaman_ult_target then
		local pos1 = target:GetAbsOrigin()
		local pos2 = caster.shaman_ult_target:GetAbsOrigin() 
		local distance = math.sqrt(((pos1.x - pos2.x)^2) + ((pos1.y - pos2.y)^2))
		local min_distance = ability:GetLevelSpecialValueFor("radius", level)
		if caster.summon_count and distance <= min_distance then
			bonus = caster.summon_count
		end
	end			

	local main_heal = ability:GetLevelSpecialValueFor("heal_base", level) + (ability.index - 1 + bonus) * ability:GetLevelSpecialValueFor("heal_per_ally", level)	
	caster:Heal(main_heal, caster)
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, caster, main_heal, nil)
	local heal_add = main_heal / 100 * ability:GetLevelSpecialValueFor("add_heal_percent", level)
	for i = 1, ability.index do
		
		if ability.target_table[i] ~= target then
			ability.target_table[i]:Heal(heal_add, caster)
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, ability.target_table[i], heal_add, nil) 
		end

		i = i + 1
	end
	ability.target_table = nil
end