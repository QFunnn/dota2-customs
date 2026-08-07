--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100538"
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
		["12"] = 12,
		["13"] = 4,
		["14"] = 12,
		["15"] = 13,
		["16"] = 14,
		["17"] = 14,
		["18"] = 14,
		["19"] = 14,
		["20"] = 14,
		["21"] = 15,
		["22"] = 15,
		["23"] = 15,
		["24"] = 15,
		["25"] = 15,
		["26"] = 16,
		["27"] = 16,
		["28"] = 16,
		["29"] = 16,
		["30"] = 16,
		["31"] = 17,
		["32"] = 17,
		["33"] = 17,
		["34"] = 17,
		["35"] = 17,
		["36"] = 13,
		["37"] = 12,
		["38"] = 4,
		["39"] = 4,
		["40"] = 4,
		["41"] = 4,
		["42"] = 4,
		["43"] = 4,
		["44"] = 4,
		["45"] = 4,
		["46"] = 12,
		["48"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100538 = c()
local k = g.modifier_5100538
k.name = "modifier_5100538"
d(k, i)
function k.prototype.OnCreated(self, l)
	Wearable:registerUnitModelModifier(
		self:GetParent(),
		"models/heroes/tiny/tiny_01/tiny_01.vmdl",
		"models/items/tiny/frozen_stonehenge/frozen_stonehenge_lvl_01.vmdl"
	)
	Wearable:registerUnitModelModifier(
		self:GetParent(),
		"models/heroes/tiny/tiny_02/tiny_02.vmdl",
		"models/items/tiny/frozen_stonehenge/frozen_stonehenge_lvl_02.vmdl"
	)
	Wearable:registerUnitModelModifier(
		self:GetParent(),
		"models/heroes/tiny/tiny_03/tiny_03.vmdl",
		"models/items/tiny/frozen_stonehenge/frozen_stonehenge_lvl_03.vmdl"
	)
	Wearable:registerUnitModelModifier(
		self:GetParent(),
		"models/heroes/tiny/tiny_04/tiny_04.vmdl",
		"models/items/tiny/frozen_stonehenge/frozen_stonehenge_lvl_04.vmdl"
	)
end
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
			}
		),
	},
	k
)
g.modifier_5100538 = k
return g