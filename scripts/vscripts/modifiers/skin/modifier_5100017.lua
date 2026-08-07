--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100017"
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
		["36"] = 18,
		["37"] = 18,
		["38"] = 18,
		["39"] = 18,
		["40"] = 18,
		["41"] = 19,
		["42"] = 19,
		["43"] = 19,
		["44"] = 19,
		["45"] = 19,
		["46"] = 13,
		["47"] = 21,
		["48"] = 22,
		["49"] = 21,
		["50"] = 27,
		["51"] = 28,
		["52"] = 27,
		["53"] = 30,
		["54"] = 32,
		["55"] = 30,
		["56"] = 12,
		["57"] = 4,
		["58"] = 4,
		["59"] = 4,
		["60"] = 4,
		["61"] = 4,
		["62"] = 4,
		["63"] = 4,
		["64"] = 4,
		["65"] = 12,
		["67"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100017 = c()
local k = g.modifier_5100017
k.name = "modifier_5100017"
d(k, i)
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_marci/marci_unleash_stack.vpcf",
		"models/eom/hero/marci_1/particles/marci_1_unleash_stack.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_marci/marci_unleash_cast.vpcf",
		"models/eom/hero/marci_1/particles/marci_1_unleash_cast.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_marci/marci_unleash_buff.vpcf",
		"models/eom/hero/marci_1/particles/marci_1_unleash_buff.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_marci/marci_unleash_pulse.vpcf",
		"models/eom/hero/marci_1/particles/marci_1_unleash_pulse.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_marci/marci_unleash_attack.vpcf",
		"models/eom/hero/marci_1/particles/marci_1_unleash_attack.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_marci/marci_sidekick_self_buff.vpcf",
		"models/eom/hero/marci_1/particles/marci_1_sidekick_self_buff.vpcf"
	)
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE, MODIFIER_PROPERTY_MODEL_SCALE_ANIMATE_TIME }
end
function k.prototype.GetModifierModelScale(self)
	return 15
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
g.modifier_5100017 = k
return g