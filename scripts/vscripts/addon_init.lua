--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


require("utils/link_modifiers")
require("utils/encryption")
if not IsClient() then
	return
end
require("utils/client_functions")
SendToConsole("r_farz 50000")
Convars:SetInt("r_farz", 50000)