--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "requires"
pcall(require, "encrypt")
require("modifierfunction")
require("framework.index")
require("override.index")
require("modifiers.index")
require("mechanics.index")
if IsServer() then
	require("filter")
	require("service.index")
	require("game")
else
end