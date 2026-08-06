--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 21:23:18 UTC
  ~ auto-generated — do not edit
]]


if IsClient() then
	return
end

function Spawn(entityKeyValues)
	thisEntity.destructable = 1
	thisEntity:FindAbilityByName("barrel_no_health_bar"):SetLevel(1)
	local unitName = thisEntity:GetUnitName()
	if unitName == "big_barrel" then
		thisEntity:SetHullRadius(24)
	end
	if unitName == "small_barrel" then
		thisEntity:SetHullRadius(24)
	end
	if unitName == "npc_dota_creature_barrel" then
		thisEntity:SetHullRadius(24)
	end
	if unitName == "small_barrel_side" then
		thisEntity:SetHullRadius(50)
	end
	thisEntity:SetTeam(DOTA_TEAM_GOODGUYS)
end