--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100022"
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
		["26"] = 13,
		["27"] = 12,
		["28"] = 4,
		["29"] = 4,
		["30"] = 4,
		["31"] = 4,
		["32"] = 4,
		["33"] = 4,
		["34"] = 4,
		["35"] = 4,
		["36"] = 12,
		["38"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100022 = c()
local k = g.modifier_5100022
k.name = "modifier_5100022"
d(k, i)
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_riki/cutom_riki_tricks.vpcf",
		"models/eom/hero/riki_1/particles/riki_1_tricks.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_riki/riki_tricks_backstab_ring.vpcf",
		"models/eom/hero/riki_1/particles/riki_1_backstab_ring.vpcf"
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
g.modifier_5100022 = k
return g