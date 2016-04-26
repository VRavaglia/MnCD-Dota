function heal(keys)

	local caster = keys.caster
	local ability = keys.ability
	local caster_hp = caster:GetHealthPercent()
	local hp_proc = ability:GetLevelSpecialValueFor("hp_proc", (ability:GetLevel()-1))
	local heal = ability:GetLevelSpecialValueFor("heal", (ability:GetLevel()-1))

	if ability:IsCooldownReady() and caster_hp <= hp_proc then
		caster:Heal(heal, caster)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, caster, heal, nil)
		ability:ApplyDataDrivenModifier(caster, caster, "paladin_guardian_angel_buff", {duration = ability:GetLevelSpecialValueFor("duration", (ability:GetLevel()-1))})
		ability:StartCooldown(ability:GetLevelSpecialValueFor("cooldown", (ability:GetLevel()-1)))
	end
end	