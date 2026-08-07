--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100046"
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
		["16"] = 12,
		["17"] = 14,
		["18"] = 4,
		["19"] = 15,
		["20"] = 16,
		["21"] = 16,
		["22"] = 16,
		["23"] = 16,
		["24"] = 16,
		["25"] = 17,
		["26"] = 17,
		["27"] = 17,
		["28"] = 17,
		["29"] = 17,
		["30"] = 18,
		["31"] = 18,
		["32"] = 18,
		["33"] = 18,
		["34"] = 18,
		["35"] = 19,
		["36"] = 19,
		["37"] = 19,
		["38"] = 19,
		["39"] = 19,
		["40"] = 15,
		["41"] = 22,
		["42"] = 23,
		["43"] = 22,
		["44"] = 32,
		["45"] = 33,
		["46"] = 32,
		["47"] = 35,
		["48"] = 37,
		["49"] = 35,
		["50"] = 12,
		["51"] = 4,
		["52"] = 4,
		["53"] = 4,
		["54"] = 4,
		["55"] = 4,
		["56"] = 4,
		["57"] = 4,
		["58"] = 4,
		["59"] = 12,
		["61"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100046 = c()
local k = g.modifier_5100046
k.name = "modifier_5100046"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.state = false
end
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_kez/kez_hungering_blades.vpcf",
		"models/eom/hero/kez_1/particles/kez_1_long_ultimate_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_kez/kez_vulnerable_marker.vpcf",
		"models/eom/hero/kez_1/particles/kez_dagger_marker_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_kez/kez_sai_ultimate_crit.vpcf",
		"models/eom/hero/kez_1/particles/kez_dagger_marker_strike_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_kez/kez_sai_ultimate_buff_start.vpcf",
		"models/eom/hero/kez_1/particles/kez_1_dagger_ultimate_fx.vpcf"
	)
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE, MODIFIER_PROPERTY_MODEL_SCALE_ANIMATE_TIME }
end
function k.prototype.GetModifierModelScale(self)
	return -20
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
g.modifier_5100046 = k
return g