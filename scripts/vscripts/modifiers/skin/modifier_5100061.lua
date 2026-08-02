--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100061"
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
		["26"] = 15,
		["27"] = 15,
		["28"] = 15,
		["29"] = 15,
		["30"] = 15,
		["31"] = 12,
		["32"] = 17,
		["33"] = 18,
		["34"] = 17,
		["35"] = 23,
		["36"] = 24,
		["37"] = 23,
		["38"] = 26,
		["39"] = 28,
		["40"] = 26,
		["41"] = 11,
		["42"] = 3,
		["43"] = 3,
		["44"] = 3,
		["45"] = 3,
		["46"] = 3,
		["47"] = 3,
		["48"] = 3,
		["49"] = 3,
		["50"] = 11,
		["52"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100061 = c()
local k = g.modifier_5100061
k.name = "modifier_5100061"
d(k, i)
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_mars/mars_spear.vpcf",
		"models/eom/hero/mars_1/particles/mars_1_attack_1_01.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/econ/items/mars/mars_fall20_immortal_shield/mars_fall20_immortal_shield_bash.vpcf",
		"models/eom/hero/mars_1/particles/mars_1_skill_3_01.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_mars/mars_shield_bash_crit.vpcf",
		"models/eom/hero/mars_1/particles/mars_1_attack_1_0_1.vpcf"
	)
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE, MODIFIER_PROPERTY_MODEL_SCALE_ANIMATE_TIME }
end
function k.prototype.GetModifierModelScale(self)
	return 25
end
function k.prototype.GetModifierModelScaleAnimateTime(self)
	return 0.1
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
g.modifier_5100061 = k
return g