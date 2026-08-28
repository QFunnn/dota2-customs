--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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