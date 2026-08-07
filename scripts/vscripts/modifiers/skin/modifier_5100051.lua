--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100051"
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
		["35"] = 15,
		["36"] = 20,
		["37"] = 21,
		["38"] = 20,
		["39"] = 27,
		["40"] = 28,
		["41"] = 27,
		["42"] = 30,
		["43"] = 31,
		["44"] = 30,
		["45"] = 33,
		["46"] = 35,
		["47"] = 33,
		["48"] = 12,
		["49"] = 4,
		["50"] = 4,
		["51"] = 4,
		["52"] = 4,
		["53"] = 4,
		["54"] = 4,
		["55"] = 4,
		["56"] = 4,
		["57"] = 12,
		["59"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100051 = c()
local k = g.modifier_5100051
k.name = "modifier_5100051"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.state = false
end
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_earthshaker/earthshaker_aftershock.vpcf",
		"models/eom/hero/earthershaker_1/particles/earthshaker_aftershock_skill_01.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_earthshaker/earthshaker_fissure.vpcf",
		"models/eom/hero/earthershaker_1/particles/earthshaker_fissure_skill_01.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_earthshaker/earthshaker_echoslam_start.vpcf",
		"models/eom/hero/earthershaker_1/particles/earthershaker_1_skill02.vpcf"
	)
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE, MODIFIER_PROPERTY_MODEL_SCALE_ANIMATE_TIME }
end
function k.prototype.GetAttackSound(self)
	return "Hero_NagaSiren.Attack"
end
function k.prototype.GetModifierModelScale(self)
	return -15
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
g.modifier_5100051 = k
return g