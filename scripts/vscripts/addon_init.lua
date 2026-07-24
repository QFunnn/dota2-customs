--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("utils/link_modifiers")
require("utils/encryption")
if not IsClient() then return end
require("utils/client_functions")
SendToConsole("r_farz 50000")
Convars:SetInt("r_farz", 50000)