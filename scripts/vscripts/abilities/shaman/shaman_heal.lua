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
	print(ability:GetLevelSpecialValueFor("heal_base", level))
	print((ability.index - 1))
	print(ability:GetLevelSpecialValueFor("heal_per_ally", level))

	local main_heal = ability:GetLevelSpecialValueFor("heal_base", level) + (ability.index - 1) * ability:GetLevelSpecialValueFor("heal_per_ally", level)
	
	caster:Heal(main_heal, caster)
	print(main_heal)
	
	local heal_add = main_heal / 100 * ability:GetLevelSpecialValueFor("add_heal_percent", level)
	
	for i = 1, ability.index do
		i = i + 1
		if not ability.target_table[i] == target then
			ability.target_table[i]:Heal(heal_add, caster)
			print(heal_add)
		end
	end
	ability.target_table = nil
end