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
    if thisEntity == nil then
        return
    end


    thisEntity.init = false
    thisEntity.tower = nil
    thisEntity.stun = thisEntity:FindAbilityByName("npc_lina_stun")
    thisEntity.ulti = thisEntity:FindAbilityByName("npc_lina_ulti")
    
    thisEntity:SetContextThink( "bevavior", bevavior, FrameTime() )
end


function bevavior()


	if (not thisEntity:IsAlive()) then
        return -1
    end
	if GameRules:IsGamePaused() == true then
        return 0.5
    end

if not thisEntity.init then
    thisEntity.init = true

    local tower = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_BUILDING, 0, FIND_CLOSEST, false)   
    for _,t in pairs(tower) do
        if t:GetUnitName() == "npc_towerradiant" or t:GetUnitName() == "npc_towerdire" then
            thisEntity.tower_location = t:GetAbsOrigin()
            thisEntity.tower = t
            break
        end 
    end
         
       
end

    if not thisEntity.tower:IsAlive() then thisEntity:ForceKill(false)
    return -1 end 


    if thisEntity:IsChanneling() then
    	return 0.4
    end






---------------------------------------------------------------------------------------------------

local enemy_for_ability = nil


local enemy_for_ability = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, 1000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE , FIND_CLOSEST, false)

local enemy_for_attack = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, 1000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false)




    
if thisEntity.stun:IsFullyCastable() then 

           
    if (thisEntity:GetAttackTarget() ~= nil)  then

            thisEntity:CastAbilityNoTarget(thisEntity.stun, 1) 
             return 0.5
    end



end

if thisEntity.ulti:IsFullyCastable() then 

if enemy_for_ability[1] ~= nil 
    and (thisEntity:GetAbsOrigin() - enemy_for_ability[1]:GetAbsOrigin()):Length2D()  <= thisEntity.ulti:GetCastRange(thisEntity:GetAbsOrigin(), thisEntity) 
    and not thisEntity:HasModifier("modifier_lina_stun_noulti")
            then 
            thisEntity:CastAbilityOnTarget(enemy_for_ability[1], thisEntity.ulti, 1)

            return 0.5
        end


end


local enemy = nil

if #enemy_for_attack == 1 and enemy_for_attack[1]:GetUnitName() == "npc_teleport" then 
  enemy = nil  
end
if #enemy_for_attack > 1 and enemy_for_attack[1]:GetUnitName() == "npc_teleport" then 
 enemy = enemy_for_attack[2]
end
if #enemy_for_attack > 0 and enemy_for_attack[1]:GetUnitName() ~= "npc_teleport" then 
 enemy = enemy_for_attack[1]
end

if  enemy ~= nil and
(thisEntity:GetAbsOrigin() - thisEntity.tower_location):Length2D() > 1000 
 then   thisEntity:SetForceAttackTarget(enemy) return 0.5 end


if ((thisEntity:GetAbsOrigin() - thisEntity.tower_location):Length2D() < 1000 ) or (enemy == nil)
    then 
    thisEntity:SetForceAttackTarget(thisEntity.tower)
    return 0.5
else 

   
end

return 0.5


end