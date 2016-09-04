function dash(keys)
	local caster = keys.caster
	local modifierName = "henrique_dash_cooldown"
	local cooldownModifiers = caster:FindAllModifiersByName(modifierName)
	local ability = keys.ability
	local modifierCharges = "henrique_dash_charges"
	local charges =caster:GetModifierStackCount(modifierCharges, caster) 

	caster:SetModifierStackCount(modifierCharges, caster, (charges - 1))

	ability:ApplyDataDrivenModifier(caster, caster, modifierName, {duration = (ability:GetLevelSpecialValueFor("cooldown", (ability:GetLevel()-1)))})

	if charges == 1 then
		local modifierList = caster:FindAllModifiersByName(modifierName)
		local cooldown = 0
		
		for key,value in pairs(modifierList) do
			print("cooldown: " .. cooldown)
			print("remaining time: " .. value:GetRemainingTime())

			if value:GetRemainingTime() < cooldown or cooldown == 0 then
				cooldown = value:GetRemainingTime()
			end	
		end

		ability:StartCooldown(cooldown)
	end


end

function stackup(keys)
	local caster = keys.caster
	local modifierName = "henrique_dash_charges"
	local charges =caster:GetModifierStackCount(modifierName, caster)
	caster:SetModifierStackCount(modifierName, caster, (charges + 1))

end

function create(keys)

	if keys.ability:GetLevel() == 1 then
	--print("foi") 
	--	return
	--else
	local caster = keys.caster
	local modifierName = "henrique_dash_charges"
	--print("modifierName: " .. modifierName)
	local ability = keys.ability
	caster:SetModifierStackCount(modifierName, caster, (ability:GetLevelSpecialValueFor("max_charges", (ability:GetLevel()-1))))
	--end
	end	
end

--[[function move(keys)
	local hero = keys.caster
    local point = keys.target_points[1]
    hero:SetAbsOrigin(point)

end]]--	


--at the start of the spell this function will be called
function dashStart( keys )

    local caster = keys.caster
    local ability = keys.ability
    local ability_level = ability:GetLevel() - 1
    --local point = keys.target_points[1]  
  

    -- Clears any current command and disjoints projectiles
    caster:Stop()
    ProjectileManager:ProjectileDodge(caster)

    -- Ability variables
    ability.dash_direction = caster:GetForwardVector()
    --ability.dash_direction = (caster:GetAbsOrigin() - point)
    ability.dash_distance = ability:GetLevelSpecialValueFor("range", ability_level)
    ability.dash_speed = (ability:GetLevelSpecialValueFor("speed", ability_level) * 1/50)
    ability.dash_traveled = 0

    --Projectile

    --[[local projectileTable = {
    Ability = ability,
    EffectName = "particles/units/heroes/hero_ember_spirit/ember_spirit_fire_remnant_trail.vpcf",
    vSpawnOrigin = caster:GetAbsOrigin(),
    fDistance = ability:GetLevelSpecialValueFor("range", ability_level),
    fStartRadius = ability:GetLevelSpecialValueFor("radius", ability_level),
    fEndRadius = ability:GetLevelSpecialValueFor("radius", ability_level),
    fExpireTime = GameRules:GetGameTime() + 1.0,
    Source = caster,
    bHasFrontalCone = false,
    bReplaceExisting = false,
    bProvidesVision = false,
    iUnitTargetTeam = "DOTA_UNIT_TARGET_TEAM_ENEMY",
    iUnitTargetType = "DOTA_UNIT_TARGET_HERO | DOTA_UNIT_TARGET_BASIC",
    vVelocity = caster:GetForwardVector() * ability:GetLevelSpecialValueFor("speed", ability_level) * 6/10,
    }
    ProjectileManager:CreateLinearProjectile( projectileTable )]]--







end

--each 1/50 of second this function will be called
function moveHorizontal(keys)
	--print("started")	
    local caster = keys.caster
    local ability = keys.ability



    --while ability.dash_traveled < ability.dash_distance do

   if ability.dash_traveled < ability.dash_distance then
    --if 0 == 0 then
    	--print("tick")
        caster:SetAbsOrigin(caster:GetAbsOrigin() + ability.dash_direction * ability.dash_speed)
        ability.dash_traveled = ability.dash_traveled + ability.dash_speed
       
   	else
	--end
       	caster:InterruptMotionControllers(true)
    --return
    end
end

function bugg(keys)


	local caster = keys.caster
	local point = caster:GetAbsOrigin()

	FindClearSpaceForUnit(caster, point, false)

end	






