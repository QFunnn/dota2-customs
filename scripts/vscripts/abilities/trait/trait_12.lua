--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_12"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 2,
		["9"] = 2,
		["10"] = 2,
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
		["14"] = 6,
		["15"] = 7,
		["16"] = 6,
		["17"] = 7,
		["18"] = 8,
		["19"] = 9,
		["20"] = 8,
		["21"] = 7,
		["22"] = 6,
		["23"] = 7,
		["25"] = 7,
		["26"] = 13,
		["27"] = 20,
		["28"] = 13,
		["29"] = 20,
		["30"] = 22,
		["31"] = 22,
		["32"] = 20,
		["33"] = 13,
		["34"] = 13,
		["35"] = 13,
		["36"] = 13,
		["37"] = 13,
		["38"] = 13,
		["39"] = 13,
		["40"] = 20,
		["42"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_12 = c()
local n = g.trait_12
n.name = "trait_12"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_12"
end
n = e({ j(nil) }, n)
g.trait_12 = n
g.modifier_trait_12 = c()
local o = g.modifier_trait_12
o.name = "modifier_trait_12"
d(o, l)
function o.prototype.OnCreated(self, p) end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_12 = o
return g