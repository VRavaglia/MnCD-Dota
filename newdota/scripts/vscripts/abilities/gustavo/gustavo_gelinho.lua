function hit(keys)

	local caster = keys.caster
    local unit = keys.target
    local targets = keys.target_entities
    local ability = keys.ability
    local jump_range = ability:GetLevelSpecialValueFor( "search_radius", ability:GetLevel() - 1 )

    local projectile_speed = ability:GetLevelSpecialValueFor( "speed", ability:GetLevel() - 1 )

    local particle_name = "particles/units/heroes/hero_lich/lich_chain_frost.vpcf"

    if not ability.jump_counter then
        ability.jump_counter = 1
    end



    -- If there's still bounces to expend, find a new target
    if ability.jumps and ability.jump_counter <= ability.jumps then

        if unit:IsRealHero() then
            unit:EmitSound("Hero_Lich.ChainFrostImpact.Hero")
        else
            unit:EmitSound("Hero_Lich.ChainFrostImpact.Creep")
        end

        local ability_crit = caster:FindAbilityByName("gustavo_crit")
        local level = (ability:GetLevel()-1)
        local level_crit = (ability_crit:GetLevel()-1)
        local damage = ability:GetLevelSpecialValueFor("damage", level)
        local crit_chance = ability_crit:GetLevelSpecialValueFor("chance", level_crit)

        if level_crit >= 0 then
            local random = math.random(100)

            if random <= crit_chance then
                local mult = ability_crit:GetLevelSpecialValueFor("damage_percentage", level_crit)
                damage = (damage * mult / 100)
            end
        end

        local damageTable = {
                    victim = unit,
                    attacker = caster,
                    damage = damage,
                    damage_type = DAMAGE_TYPE_MAGICAL,
                    ability = ability,
                }
        ApplyDamage(damageTable)








        -- Go through the target_enties table, checking for the first one that isn't the same as the target
        local target_to_jump = nil
        for _,target in pairs(targets) do
            if target ~= unit and not target_to_jump then
                target_to_jump = target
            end
        end

        if target_to_jump then


            -- Create the next projectile
            local info = {
                Target = target_to_jump,
                Source = unit,
                Ability = ability,
                EffectName = particle_name,
                bDodgeable = true,
                bProvidesVision = true,
                iMoveSpeed = projectile_speed,
                iVisionRadius = 200,
                iVisionTeamNumber = caster:GetTeamNumber(), -- Vision still belongs to the one that casted the ability
                iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION
            }
            ProjectileManager:CreateTrackingProjectile( info )

            -- Add one to the jump counter for this bounce
            ability.jump_counter = ability.jump_counter + 1
        else

            ability.jump_counter = nil
            ability.jumps = nil
        end
    else
 
        ability.jump_counter = nil
        ability.jumps = nil
    end
end

function index(keys)
	local ability = keys.ability
	if not ability.jumps then
        ability.jumps = 0
    end
	
	ability.jumps = ability.jumps + ability:GetLevelSpecialValueFor( "bounces", ability:GetLevel() - 1 )
end

