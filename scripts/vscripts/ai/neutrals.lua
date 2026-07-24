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
 thisEntity.neutral_centaur_stun = thisEntity:FindAbilityByName("neutral_centaur_stun")

    thisEntity:SetContextThink( "bevavior", bevavior, FrameTime() )
end

function check_cd( unit , ability , n)
if not IsServer() then return end
	local near = FindUnitsInRadius(unit:GetTeamNumber(), unit:GetAbsOrigin(), nil, 2000, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, 0, 0, false)
 		for _,i in pairs(near) do
 					if unit ~= i then
 					local a = i:FindAbilityByName(ability)
 						if a then
 							if a:GetCooldownTimeRemaining() < (a:GetCooldown(1) - n) then return true end
 						end
 				end
 	end	
	return false
end

function bevavior()
	if (not thisEntity:IsAlive()) then
        return -1
    end
	if GameRules:IsGamePaused() == true then
        return 1
    end
    if thisEntity:IsChanneling() then
    	return 0.5
    end

    if thisEntity:GetAttackTarget() ~= nil then 

    end



   return 1
end