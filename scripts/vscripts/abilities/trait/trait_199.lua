--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_199"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{ ["8"] = 1, ["9"] = 1, ["10"] = 1, ["11"] = 2, ["12"] = 2, ["13"] = 2, ["14"] = 2, ["15"] = 2, ["16"] = 2, ["17"] = 2, ["19"] = 2 }
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
g.trait_199 = c()
local k = g.trait_199
k.name = "trait_199"
d(k, i)
k = e({ j(nil) }, k)
g.trait_199 = k
return g