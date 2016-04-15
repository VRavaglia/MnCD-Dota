function projectile_hit(keys)
	
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local level = ability:GetLevel() - 1
	local int_as_damage = ((ability:GetLevelSpecialValueFor("int_as_damage",level)/100) * caster:GetIntellect())
	local agi_as_damage = ability:GetLevelSpecialValueFor("agi_as_damage",level)
	--local damage = agi_as_damage + int_as_damage
	local duration = ability:GetLevelSpecialValueFor("duration", level)

	--[[local damageTable = {
	        victim = target,
	        attacker = caster,
	        damage = damage,
	        damage_type = DAMAGE_TYPE_PURE,
	        ability = ability,
	        }

	ApplyDamage(damageTable)]]

	if not caster:HasModifier("arcano_splash_counter") then

		ability:ApplyDataDrivenModifier(caster, caster, "arcano_splash_counter", {})
	end

	local counter = caster:FindModifierByName("arcano_splash_counter")
	
	counter:IncrementStackCount()

	ability:ApplyDataDrivenModifier(caster, caster, "arcano_splash_buff", {duration = duration})		


end

function projectile_launch(keys)

	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local level =	ability:GetLevel() - 1
	local speed = ability:GetLevelSpecialValueFor("projectile_speed",level)
	local duration = ability:GetLevelSpecialValueFor("duration", level)

	local info = 
	{
		Target = caster,
		Source = target,
		Ability = ability,	
		EffectName = "particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_base_attack.vpcf",
	        iMoveSpeed = speed,
		vSourceLoc= target:GetAbsOrigin(),                -- Optional (HOW)
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


	if not target:HasModifier("arcano_splash_debuff_counter") then

		ability:ApplyDataDrivenModifier(caster, target, "arcano_splash_debuff_counter", {})
	end

	local counter = target:FindModifierByName("arcano_splash_debuff_counter")
	
	counter:IncrementStackCount()

	ability:ApplyDataDrivenModifier(caster, target, "arcano_splash_debuff", {duration = duration})




end

function setup_target(keys)
	local ability = keys.ability
	ability.maintarget = keys.target
end

function decrement(keys)
	local caster = keys.caster
	local counter = caster:FindModifierByName("arcano_splash_counter")
	counter:DecrementStackCount()
	if counter:GetStackCount() == 0 then
		caster:RemoveModifierByName("arcano_splash_counter")
	end	
end
function decrement_debuff(keys)

	local target = keys.target
	local counter = target:FindModifierByName("arcano_splash_debuff_counter")
	counter:DecrementStackCount()

	if counter:GetStackCount() == 0 then
		target:RemoveModifierByName("arcano_splash_debuff_counter")
	end	
end