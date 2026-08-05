--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


local sheepsName = {
	["npc_snow"] = true,
	["npc_snow2"] = true,
	["npc_snow3"] = true,
}

function CDOTA_BaseNPC:IsQuestSheep()
	return sheepsName[self:GetUnitName()] or false
end