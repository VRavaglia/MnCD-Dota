function think(keys)
	local ability = keys.ability
	local caster = keys.caster
	local int = caster:GetIntellect()
	local original_agi = caster:GetBaseAgility()



	if ability.agi_bonus then
		original_agi = original_agi - ability.agi_bonus
	end


	
	ability.agi_bonus = math.floor(int * ability.agi_per_int)



	caster:SetBaseAgility(original_agi + ability.agi_bonus)
	caster:CalculateStatBonus()
	
	

	ability.modifier_counter:SetStackCount(ability.agi_bonus)
end

function upgrade(keys)
	local caster = keys.caster
	local ability = keys.ability
	local level = ability:GetLevel() - 1
	local bat = ability:GetLevelSpecialValueFor("reduced_bat", level)
	ability.modifier_counter = caster:FindModifierByName("arcano_passive_counter")
	ability.agi_per_int = ability:GetLevelSpecialValueFor("agi_per_int", level)
	caster:SetBaseAttackTime(bat)

end