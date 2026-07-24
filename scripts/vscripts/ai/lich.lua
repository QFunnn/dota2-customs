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
    thisEntity.blast = thisEntity:FindAbilityByName("npc_lich_blast")
    thisEntity.ice = thisEntity:FindAbilityByName("npc_lich_ice")
    thisEntity.ulti = thisEntity:FindAbilityByName("npc_lich_ulti")

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

---------------------------------------------------------------------------------------------------

local enemy_for_ability = nil


local enemy_for_ability = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, 1000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE , FIND_CLOSEST, false)

local enemy_for_attack = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, 1000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_CLOSEST, false)

local ice = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, 1000, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false)

local flag = false



for _,i in pairs(ice) do

    if IsValidEntity(i) and i:GetUnitName() == "npc_lich_ice_unit" then
        flag = true
    end
end

local control = false
if thisEntity:IsSilenced() or thisEntity:IsHexed() then
    control = true
end

if control == false then


if thisEntity.blast:IsFullyCastable() then

if IsValidEntity(enemy_for_ability[1]) and IsValidEntity(enemy_for_ability[1])
	and (thisEntity:GetAbsOrigin() - enemy_for_ability[1]:GetAbsOrigin()):Length2D()  <= thisEntity.blast:GetCastRange(thisEntity:GetAbsOrigin(), thisEntity)
			then
			thisEntity:CastAbilityOnTarget(enemy_for_ability[1], thisEntity.blast, 1)

    		return 0.5
		end


end


if thisEntity.ice:IsFullyCastable() then

    if (thisEntity:GetAttackTarget() ~= nil) and thisEntity:GetHealthPercent() <= thisEntity.ice:GetSpecialValueFor("health") 
        and not thisEntity:HasModifier("modifier_lich_ice_resist")
        then

            thisEntity:CastAbilityNoTarget(thisEntity.ice, 1)
             return 0.5
    end

end

if thisEntity.ulti:IsFullyCastable() and flag then


    if IsValidEntity(enemy_for_ability[1])
    and (thisEntity:GetAbsOrigin() - enemy_for_ability[1]:GetAbsOrigin()):Length2D()  <= thisEntity.ulti:GetCastRange(thisEntity:GetAbsOrigin(), thisEntity)
        then

            local distance = false

            for _,i in pairs(ice) do

                 if IsValidEntity(i) and i:GetUnitName() == "npc_lich_ice_unit" and
                 (i:GetAbsOrigin() - enemy_for_ability[1]:GetAbsOrigin()):Length2D()  <= thisEntity.ulti:GetSpecialValueFor("radius")
                  then
                    distance = true
                    break
                 end
            end

            if distance then
               thisEntity:CastAbilityOnTarget(enemy_for_ability[1], thisEntity.ulti, 1)

              return 0.8
            end
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