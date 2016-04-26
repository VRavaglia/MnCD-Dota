function start(keys)
	local caster = keys.caster
	local modifierName = "hermann_totem_cooldown"
	local cooldownModifiers = caster:FindAllModifiersByName(modifierName)
	local ability = keys.ability
	local modifierCharges = "hermann_totem_charges"
	local charges =caster:GetModifierStackCount(modifierCharges, caster)
	local totem = keys.target
	local totem_ability = totem:FindAbilityByName("hermann_totem_unit")
	totem_ability:SetLevel(1)
	caster:SetModifierStackCount(modifierCharges, caster, (charges - 1))
	ability:ApplyDataDrivenModifier(caster, caster, modifierName, {duration = (ability:GetLevelSpecialValueFor("cooldown", (ability:GetLevel()-1)))})
	local owner = totem:GetOwner()
	totem:SetDayTimeVisionRange(800 + (200 * ability:GetLevel()))
	totem:SetNightTimeVisionRange(800 + (200 * ability:GetLevel()))
	if not owner.totem_table then
		owner.totem_table = {}
	end
	if not owner.index then
		owner.index = 0
	end
	owner.index = owner.index + 1
	owner.totem_table[owner.index] = totem
	if owner.index > 3 then
		owner.totem_table[1]:ForceKill(true)
    end
	if charges == 1 then
		local modifierList = caster:FindAllModifiersByName(modifierName)
		local cooldown = 0
		for key,value in pairs(modifierList) do
			if value:GetRemainingTime() < cooldown or cooldown == 0 then
				cooldown = value:GetRemainingTime()
			end
		end
		ability:StartCooldown(cooldown)
	end
end
function stackup(keys)
	local caster = keys.caster
	local modifierName = "hermann_totem_charges"
	local charges =caster:GetModifierStackCount(modifierName, caster)
	caster:SetModifierStackCount(modifierName, caster, (charges + 1))
end
function create(keys)
    local caster = keys.caster
    local ability = caster:FindAbilityByName("hermann_totem")
	if ability:GetLevel() == 0 then
        ability:SetLevel(1)
    	local modifierName = "hermann_totem_charges"
    	caster:SetModifierStackCount(modifierName, caster, (ability:GetLevelSpecialValueFor("max_charges", (ability:GetLevel()-1))))
	end
end
function vision(keys)
    local caster = keys.caster
    local ability = keys.ability
   	local point = ability:GetCursorPosition()
    local abilityLevel = (ability:GetLevel()- 1)
   --[[ local duration = ability:GetLevelSpecialValueFor("duration", abilityLevel)
    local range = ability:GetLevelSpecialValueFor("totem_attack_range", abilityLevel)
    local vision_int = ability:GetLevelSpecialValueFor("totem_vision", abilityLevel)]]
    local modifier = "hermann_vision_buff"
    local search_radius = 100
    local totem = Entities:FindByClassnameNearest("npc_dota_ward_base", Vector(point.x, point.y, point.z), search_radius)
    if totem and totem:HasModifier("hermann_totem_setup") then
    	 ability:ApplyDataDrivenModifier(caster, totem, modifier, {duration = 10})
    else
    	ability:RefundManaCost()
    	ability:EndCooldown()
    end
    --[[print(abilityLevel)
    print(vision_int)
    print(range)
    print(caster)
    print(totem)
    print(modifier)
    print(duration)]]
    --ability:ApplyDataDrivenModifier(caster, caster, modifier, {duration = duration})
end
function setup(keys)
	local totem = keys.target
	local totem_ability = totem:FindAbilityByName("hermann_totem_unit")
	totem_ability:SetLevel(1)
end
function totem_die(keys)
	local caster = keys.caster
	local owner = caster:GetOwner()
	for i = 1, owner.index do
			owner.totem_table[i] = owner.totem_table[i+1]
	end
	owner.totem_table[owner.index] = {}
	owner.index = owner.index - 1
end
function totem_attacked(keys)
	local caster = keys.caster
	local attacker = keys.attacker
	local health = caster:GetHealth()
	print(health)
	if attacker:IsRealHero() then
		caster:SetHealth(health - 4)
	elseif attacker:IsTower() then
		caster:SetHealth(health - 2)
	else
		caster:SetHealth(health - 1)	
	end
end
