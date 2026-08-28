--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/neutral/neutral_temp"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 6,
		["19"] = 5,
		["20"] = 6,
		["22"] = 6,
		["23"] = 9,
		["24"] = 10,
		["25"] = 9,
		["26"] = 10,
		["27"] = 11,
		["28"] = 11,
		["29"] = 10,
		["30"] = 9,
		["31"] = 10,
		["33"] = 10,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("abilities.ability_ai")
local l = k.BaseAbilityAI
local m = k.registerAbilityAI
g.neutral_temp_talent = c()
local n = g.neutral_temp_talent
n.name = "neutral_temp_talent"
d(n, i)
n = e({ j(nil) }, n)
g.neutral_temp_talent = n
g.neutral_temp_ult = c()
local o = g.neutral_temp_ult
o.name = "neutral_temp_ult"
d(o, l)
function o.prototype.OnSpellStart(self) end
o = e({ m(nil) }, o)
g.neutral_temp_ult = o
return g