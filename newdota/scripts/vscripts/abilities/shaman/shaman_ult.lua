function destroy_old(keys)
	local ability = keys.ability
	local caster = keys.caster
	local target = keys.target

	if ability.spawn_table then
		for i = 1, ability.index do
			if ability.spawn_table[i] then
				ability.spawn_table[i]:ForceKill(true)
			end	
		end		
	end
	ability.index = 0
	ability.rotation = 0
	ability.spawn_table = {}
	caster.summon_count = 0	
end

function create(keys)
	local ability = keys.ability
	local caster = keys.caster
	local pID = caster:GetPlayerID()
	local point = caster:GetAbsOrigin()
	local spawn_count = keys.spawn_count
	local duration = keys.duration
	local target = keys.target
	if caster.shaman_ult_target then
		caster.shaman_ult_target:RemoveModifierByName("shaman_ult_main")
	end		
	caster.shaman_ult_target = target
	ability:ApplyDataDrivenModifier(caster, target, "shaman_ult_main", {duration = duration}) 
	caster.summon_count = spawn_count
	for i = 1, spawn_count do
		ability.index = ability.index + 1
		local target = CreateUnitByName("npc_shaman_ult", point, true, caster, caster, caster:GetTeamNumber())		
		ability.spawn_table[ability.index] = target
		ability:ApplyDataDrivenModifier(caster, target, "shaman_ult_creature", {duration = duration})
	end	
end

function move(keys)
	local ability = keys.ability
	local level = ability:GetLevel() - 1
	local target = keys.target
	local point = target:GetAbsOrigin()
	local radius = 120
	ability.rotation = ability.rotation + (2*math.pi)/100
	local angle = math.pi/(ability.index/2) + ability.rotation
	for i = 1, ability.index do
		local position = Vector(point.x+radius*math.sin(angle), point.y+radius*math.cos(angle), point.z)
 	    ability.spawn_table[i]:SetAbsOrigin(position)
        
        angle = angle + math.pi/ (ability.index/2)
    end
    if ability.rotation >= 2*math.pi then
    	ability.rotation = 0
    end	 
end

function attack(keys)
	local ability = keys.ability
	local target = keys.target
	local caster = keys.caster
	if target:IsOpposingTeam(caster:GetTeam()) then
		for i = 1, ability.index do
			local info = 
			{
				Target = target,
				Source = ability.spawn_table[i],
				Ability = ability,	
				EffectName = "particles/units/heroes/hero_lina/lina_base_attack.vpcf",
			        iMoveSpeed = 900,
				vSourceLoc= ability.spawn_table[i]:GetAbsOrigin(),                -- Optional (HOW)
				bDrawsOnMinimap = false,                          -- Optional
			        bDodgeable = true,                                -- Optional
			        bIsAttack = false,                                -- Optional
			        bVisibleToEnemies = true,                         -- Optional
			        bReplaceExisting = false,                         -- Optional
			        --flExpireTime = GameRules:GetGameTime() + 10,      -- Optional but recommended
				bProvidesVision = false,                           -- Optional
				--iVisionRadius = 400,                              -- Optional
				--iVisionTeamNumber = caster:GetTeamNumber()        -- Optional
			}
			projectile = ProjectileManager:CreateTrackingProjectile(info)
		end
	end		
end

function GetSummonPoints(keys)
	local ability = keys.ability
	local target = keys.target
	return target:GetAbsOrigin()
end

function attack_land(keys)
	local target = keys.target
	if target:IsAlive() then
		local caster = keys.caster
		local ability = caster:FindAbilityByName("shaman_disable")
		local level = ability:GetLevel()
		if level > 0 then
			local duration = ability:GetLevelSpecialValueFor("duration", (level - 1))
			ability:ApplyDataDrivenModifier(caster, target, "shaman_disable_stack_counter", {duration = duration})
			local modifier = target:FindModifierByName("shaman_disable_stack_counter")
			modifier:IncrementStackCount()
			local max = ability:GetLevelSpecialValueFor("max_stacks", (level - 1))
			if modifier:GetStackCount() > max then
				modifier:SetStackCount(max)
			end
		end
	end			

end