function create(keys)
	local caster = keys.caster
	local attackspeed = caster:GetAttackSpeed() * 100
	local ability = keys.ability
	local level = ability:GetLevel() - 1
	local shots = ability:GetLevelSpecialValueFor("shots_base", level)
	shots = shots + math.floor(attackspeed / ability:GetLevelSpecialValueFor("atks_per_shot", level))
	ability.interval = (ability:GetLevelSpecialValueFor("duration", level) - 0.1) / shots
	ability.counter = 0
	ability.target = keys.target_points[1]



end

function think(keys)
	local ability = keys.ability
	local caster = keys.caster
	local level = ability:GetLevel() - 1
	ability.counter = ability.counter + 0.01


	if ability.counter >= ability.interval then
		print(ability.counter)
	 	ability.counter = 0

	 	local forwardVec = (ability.target - caster:GetAbsOrigin()) * Vector(1,1,0)
    	forwardVec = forwardVec:Normalized()


    	caster:EmitSound("Hero_Magnataur.ShockWave.Particle")
    	

	 	local info = 
		{
			Ability = ability,
	        	EffectName = "particles/units/heroes/hero_magnataur/magnataur_shockwave.vpcf",
	        	vSpawnOrigin = caster:GetAbsOrigin(),
	        	fDistance = ability:GetLevelSpecialValueFor("distance", level),
	        	fStartRadius = ability:GetLevelSpecialValueFor("radius", level),
	        	fEndRadius = ability:GetLevelSpecialValueFor("radius", level),
	        	Source = caster,
	        	bHasFrontalCone = false,
	        	bReplaceExisting = false,
	        	iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	        	iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	        	iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	        	fExpireTime = GameRules:GetGameTime() + 10.0,
			bDeleteOnHit = false,
			vVelocity = forwardVec * ability:GetLevelSpecialValueFor("projectile_speed", level),
			bProvidesVision = false,
			--iVisionRadius = 1000,
			iVisionTeamNumber = caster:GetTeamNumber()
		}
		projectile = ProjectileManager:CreateLinearProjectile(info)
	end

end