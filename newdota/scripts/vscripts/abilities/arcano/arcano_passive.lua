function think(keys)
	local ability = keys.ability
	local caster = keys.caster
	local int = caster:GetIntellect()
	local level = ability:GetLevel() - 1
	local atks_per_int = ability:GetLevelSpecialValueFor("atks_per_int", level)
	local modifier_counter = caster:FindModifierByName("arcano_passive_counter")	
	local atks_bonus = math.floor(int * atks_per_int)
	modifier_counter:SetStackCount(atks_bonus)
end

function upgrade(keys)
	local caster = keys.caster
	local ability = keys.ability
	local level = ability:GetLevel() - 1
	local bat = ability:GetLevelSpecialValueFor("reduced_bat", level)
	caster:SetBaseAttackTime(bat)
end