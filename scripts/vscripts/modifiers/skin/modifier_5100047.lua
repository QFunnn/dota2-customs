--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100047"
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
		["40"] = 20,
		["41"] = 20,
		["42"] = 20,
		["43"] = 20,
		["44"] = 20,
		["45"] = 21,
		["46"] = 21,
		["47"] = 21,
		["48"] = 21,
		["49"] = 21,
		["50"] = 15,
		["51"] = 25,
		["52"] = 26,
		["53"] = 25,
		["54"] = 32,
		["55"] = 33,
		["56"] = 32,
		["57"] = 35,
		["58"] = 36,
		["59"] = 35,
		["60"] = 38,
		["61"] = 40,
		["62"] = 38,
		["63"] = 12,
		["64"] = 4,
		["65"] = 4,
		["66"] = 4,
		["67"] = 4,
		["68"] = 4,
		["69"] = 4,
		["70"] = 4,
		["71"] = 4,
		["72"] = 12,
		["74"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100047 = c()
local k = g.modifier_5100047
k.name = "modifier_5100047"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.state = false
end
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_abaddon/abaddon_death_coil_explosion.vpcf",
		"models/eom/hero/abaddon_1/particles/abaddon_1_passive_skill_explosion.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_abaddon/abaddon_death_coil.vpcf",
		"models/eom/hero/abaddon_1/particles/abaddon_1_passive_skill_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/status_fx/status_effect_alacrity.vpcf",
		"particles/status_fx/status_effect_abaddon_borrowed_time.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf",
		"models/eom/hero/abaddon_1/particles/abaddon_1_skill_shield_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_abaddon/abaddon_borrowed_time_e.vpcf",
		"models/eom/hero/abaddon_1/particles/abaddon_1_skill_shield_01.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf",
		"models/eom/hero/abaddon_1/particles/abaddon_1_skill_shield_blast.vpcf"
	)
end
function k.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_MODEL_SCALE_ANIMATE_TIME,
	}
end
function k.prototype.GetAttackSound(self)
	return "Hero_Terrorblade.Attack"
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
g.modifier_5100047 = k
return g