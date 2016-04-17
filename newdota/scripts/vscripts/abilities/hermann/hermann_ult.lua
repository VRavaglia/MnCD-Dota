function start(keys)
    local ability = keys.ability
    local point = ability:GetCursorPosition()
    local search_radius = 100
    local totem = Entities:FindByClassnameNearest("npc_dota_ward_base", Vector(point.x, point.y, point.z), search_radius)
    
    if totem and totem:HasModifier("hermann_totem_setup") then
        local caster = keys.caster             
        local abilityLevel = (ability:GetLevel()- 1)
        local duration = ability:GetLevelSpecialValueFor("duration", abilityLevel)
    	ability:ApplyDataDrivenModifier(caster, totem, "hermann_ult_invulnerability", {duration = duration})
        ability:ApplyDataDrivenThinker(caster, Vector(point.x, point.y, point.z), "hermann_ult_thinker", {duration = duration})
        ability.caster = caster
        ability.totem_origin = totem:GetAbsOrigin()

    end	 
end

function setup(keys)
    local target = keys.target
    local ability = keys.ability
    local level = keys.ability:GetLevel()
    local target_pos = target:GetAbsOrigin()
    local distance = math.sqrt(((ability.totem_origin.x - target_pos.x)^2) + ((ability.totem_origin.y - target_pos.y)^2))
    target.HU_speed = (ability:GetLevelSpecialValueFor("radius", level) - distance + 100) / 50
    target.HU_angle =  (target_pos - ability.totem_origin) * Vector(1,1,0)
    target.HU_angle = target.HU_angle:Normalized()
    target.HU_height = target_pos.z
    target.HU_time = 0


    
end

function knockback(keys)
    local target = keys.target
    if target.HU_angle then
        local target_pos = target:GetAbsOrigin()   
        local new_origin = target_pos + target.HU_angle * target.HU_speed
        target.HU_time = target.HU_time + 0.02
        local kb_height = (-800*(target.HU_time^2)) + (800*target.HU_time)
        new_origin.z = target.HU_height + kb_height
        target:SetAbsOrigin(new_origin)
    end
end

function bugg(keys)


    local target = keys.target
    local point = target:GetAbsOrigin()

    FindClearSpaceForUnit(target, point, false)

end 