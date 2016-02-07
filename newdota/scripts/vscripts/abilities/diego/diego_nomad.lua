function Charge(keys)


	local caster = keys.caster
	local modifierName = "diego_nomad_counter"
	local charges = caster:GetModifierStackCount(modifierName, caster)

	if charges < 20 then
		
		local increment = charges + 1
		caster:SetModifierStackCount(modifierName, caster, increment)
	end	

end	

function Damage(keys)

	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local modifierName = "diego_nomad_counter"
	local damage_per_charge = (ability:GetLevelSpecialValueFor("damage_per_charge", (ability:GetLevel()-1))) 
	local damageToBeDone = (damage_per_charge * caster:GetModifierStackCount(modifierName, caster))
 
	local damageTable = {
        victim = target,
        attacker = caster,
        damage = damageToBeDone,
        damage_type = DAMAGE_TYPE_PURE,
        ability = ability,
        }

	ApplyDamage(damageTable)


	caster:SetModifierStackCount(modifierName, caster, 0)	

end