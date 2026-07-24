--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




function Spawn( entityKeyValues )
if not IsServer() then
    return
end
if not IsValidEntity(thisEntity) then return end


thisEntity.init = false
thisEntity.tower = nil

thisEntity.black_hole = thisEntity:FindAbilityByName("enigma_boss_black_hole_custom")
thisEntity.midnight = thisEntity:FindAbilityByName("enigma_boss_midnight_custom")
thisEntity.malefice = thisEntity:FindAbilityByName("enigma_boss_malefice_custom")

thisEntity:SetContextThink( "bevavior", bevavior, FrameTime() )
end


function bevavior()
if not IsValidEntity(thisEntity) then return end
if thisEntity.ally == nil and not thisEntity.summoned then return 0.5 end
if GameRules:IsGamePaused() == true then return 0.5 end
if thisEntity:IsChanneling() then return 0.5 end


if not thisEntity.init then
    thisEntity.init = true

    thisEntity.start_abs = thisEntity:GetAbsOrigin()

    local towers = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_BUILDING, 0, FIND_CLOSEST, false)
    for _, tower in pairs(towers) do
        if IsValidEntity(tower) and (tower:GetUnitName() == "npc_towerradiant" or tower:GetUnitName() == "npc_towerdire") then
            thisEntity.tower_location = tower:GetAbsOrigin()
            thisEntity.tower = tower
            break
        end
    end
end

if thisEntity:HasModifier("modifier_return_to_path") then return 0.3 end
local path_dist = thisEntity:GetPathPoint(true)
if path_dist >= 700 then
    thisEntity:AddNewModifier(thisEntity, nil, "modifier_return_to_path", {duration = 6})
    return 1
end

if (not thisEntity:IsAlive()) then return -1 end
if not IsValidEntity(thisEntity.tower) then return -1 end
if not thisEntity.tower:IsAlive() then thisEntity:ForceKill(false) return -1 end

local enemy_for_ability = nil
local enemy_for_ability = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, 1000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO, FIND_CLOSEST, false)
local enemy_for_attack = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, 1000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_CLOSEST, false)

local control = false
if thisEntity:IsSilenced() or thisEntity:IsHexed() then
    control = true
end

if control == false then
    if thisEntity.midnight:IsFullyCastable() then
        if IsValidEntity(enemy_for_ability[1]) then

            if (thisEntity:GetAbsOrigin() - enemy_for_ability[1]:GetAbsOrigin()):Length2D() <= thisEntity.midnight:GetCastRange(thisEntity:GetAbsOrigin(), thisEntity) then
                thisEntity:CastAbilityOnTarget(enemy_for_ability[1], thisEntity.midnight, 1)
                return 1
            end
        end
    end

    if thisEntity.malefice:IsFullyCastable() then
        if IsValidEntity(enemy_for_ability[1]) and thisEntity:GetHealthPercent() <= thisEntity.malefice:GetSpecialValueFor("cast_health") then

            if (thisEntity:GetAbsOrigin() - enemy_for_ability[1]:GetAbsOrigin()):Length2D() <= thisEntity.malefice:GetCastRange(thisEntity:GetAbsOrigin(), thisEntity) then
                thisEntity:CastAbilityOnTarget(enemy_for_ability[1], thisEntity.malefice, 1)
                return 1
            end
        end
    end

    if thisEntity.black_hole:IsFullyCastable() and not thisEntity:HasModifier("modifier_enigma_boss_black_hole_custom_caster") then
        if IsValidEntity(enemy_for_ability[1]) then
           thisEntity:CastAbilityNoTarget(thisEntity.black_hole, 1)
           return 1
        end
    end
end


local enemy = nil

if IsValidEntity(enemy_for_attack[1]) 
    and not enemy_for_attack[1]:IgnoredByCreeps()
    and (enemy_for_attack[1]:GetAbsOrigin() - thisEntity.tower:GetAbsOrigin()):Length2D() > 800 then
    enemy = enemy_for_attack[1]
end

for _, target in pairs(enemy_for_attack) do

    if IsValidEntity(target) 
    and not target:IgnoredByCreeps()
    and (target:GetAbsOrigin() - thisEntity.tower:GetAbsOrigin()):Length2D() > 800  
    and not target:IsInvulnerable() 
    and not target:IsAttackImmune() then
        enemy = target
        break
    end
end

if IsValidEntity(enemy) and (thisEntity:GetAbsOrigin() - thisEntity.tower_location):Length2D() > 1000 then
    thisEntity:SetForceAttackTarget(enemy)
    return 0.5
end

if ((thisEntity:GetAbsOrigin() - thisEntity.tower_location):Length2D() < 1000 ) or not IsValidEntity(enemy) then
    thisEntity:SetForceAttackTarget(thisEntity.tower)
    return 0.5
end

return 0.5
end