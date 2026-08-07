--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100066"
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
		["12"] = 11,
		["13"] = 3,
		["14"] = 11,
		["15"] = 12,
		["16"] = 13,
		["17"] = 13,
		["18"] = 13,
		["19"] = 13,
		["20"] = 13,
		["21"] = 14,
		["22"] = 14,
		["23"] = 14,
		["24"] = 14,
		["25"] = 14,
		["26"] = 12,
		["27"] = 11,
		["28"] = 3,
		["29"] = 3,
		["30"] = 3,
		["31"] = 3,
		["32"] = 3,
		["33"] = 3,
		["34"] = 3,
		["35"] = 3,
		["36"] = 11,
		["38"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100066 = c()
local k = g.modifier_5100066
k.name = "modifier_5100066"
d(k, i)
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_axe/axe_attack_blur_counterhelix.vpcf",
		"models/eom/hero/axe_2/particles/axe_2_skill_01_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_axe/axe_beserkers_call_owner.vpcf",
		"models/eom/hero/axe_2/particles/axe_2_skill_02_fx.vpcf"
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
g.modifier_5100066 = k
return g