--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/abilities/heroes/silencer_show.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__Class
local e = c.__TS__ClassExtends
local f = c.__TS__Decorate
local g = c.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{ ["8"] = 1, ["9"] = 1, ["10"] = 1, ["11"] = 4, ["12"] = 5, ["13"] = 4, ["14"] = 5, ["15"] = 5, ["16"] = 4, ["17"] = 5, ["19"] = 5 }
)
local h = {}
local i = require("abilities.ability_ai")
local j = i.BaseAbilityAI
local k = i.registerAbilityAI
h.silencer_show = d()
local l = h.silencer_show
l.name = "silencer_show"
e(l, j)
l = f({ k(nil) }, l)
h.silencer_show = l
return h