--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100572"
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
		["11"] = 4,
		["12"] = 13,
		["13"] = 4,
		["14"] = 13,
		["15"] = 13,
		["16"] = 4,
		["17"] = 4,
		["18"] = 4,
		["19"] = 4,
		["20"] = 4,
		["21"] = 4,
		["22"] = 4,
		["23"] = 4,
		["24"] = 4,
		["25"] = 13,
		["27"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100572 = c()
local k = g.modifier_5100572
k.name = "modifier_5100572"
d(k, i)
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				RemoveOnDeath = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_HIGH,
			}
		),
	},
	k
)
g.modifier_5100572 = k
return g