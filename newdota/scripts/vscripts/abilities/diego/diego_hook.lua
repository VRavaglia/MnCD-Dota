function Blink(keys)


	local caster = keys.caster
	local target = keys.target
	local point = target:GetAbsOrigin()

	FindClearSpaceForUnit(caster, point, false)

end	