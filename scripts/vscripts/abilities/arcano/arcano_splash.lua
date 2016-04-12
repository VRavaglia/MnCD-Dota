function projectile_hit(keys)
	
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local level = ability:GetLevel() - 1
	local int_as_damage = ((ability:GetLevelSpecialValueFor("int_as_damage",level)/100) * caster:GetIntellect())
	local base_damage = ability:GetLevelSpecialValueFor("base_damage",level)
	local damage = base_damage + int_as_damage

	local damageTable = {
	        victim = target,
	        attacker = caster,
	        damage = damage,
	        damage_type = DAMAGE_TYPE_MAGICAL,
	        ability = ability,
	        }

	ApplyDamage(damageTable)


end

function projectile_launch(keys)

	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local level =	ability:GetLevel() - 1
	local speed = ability:GetLevelSpecialValueFor("projectile_speed",level)

	local info = 
	{
		Target = target,
		Source = ability.maintarget,
		Ability = ability,	
		EffectName = "particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_base_attack.vpcf",
	        iMoveSpeed = speed,
		vSourceLoc= ability.maintarget:GetAbsOrigin(),                -- Optional (HOW)
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

function setup_target(keys)
	local ability = keys.ability
	ability.maintarget = keys.target
end