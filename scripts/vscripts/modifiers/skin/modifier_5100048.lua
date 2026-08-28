--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100048"
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
		["50"] = 22,
		["51"] = 22,
		["52"] = 22,
		["53"] = 22,
		["54"] = 22,
		["55"] = 23,
		["56"] = 23,
		["57"] = 23,
		["58"] = 23,
		["59"] = 23,
		["60"] = 24,
		["61"] = 24,
		["62"] = 24,
		["63"] = 24,
		["64"] = 24,
		["65"] = 15,
		["66"] = 26,
		["67"] = 27,
		["68"] = 26,
		["69"] = 36,
		["70"] = 37,
		["71"] = 36,
		["72"] = 39,
		["73"] = 41,
		["74"] = 39,
		["75"] = 12,
		["76"] = 4,
		["77"] = 4,
		["78"] = 4,
		["79"] = 4,
		["80"] = 4,
		["81"] = 4,
		["82"] = 4,
		["83"] = 4,
		["84"] = 12,
		["86"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100048 = c()
local k = g.modifier_5100048
k.name = "modifier_5100048"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.state = false
end
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_grimstroke/grimstroke_base_attack.vpcf",
		"models/eom/hero/grimstroke_1/particles/grimstroke_1_base_attack_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_grimstroke/grimstroke_darkartistry_proj.vpcf",
		"models/eom/hero/grimstroke_1/particles/grimstroke_1_skill_attack_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_grimstroke/last_stroke_cast_e.vpcf",
		"models/eom/hero/grimstroke_1/particles/grimstroke_1_last_stroke_cast_model.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_grimstroke/last_stroke_cast_light.vpcf",
		"models/eom/hero/grimstroke_1/particles/grimstroke_1_last_stroke_light.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_grimstroke/grimstroke_ink_swell_buff.vpcf",
		"models/eom/hero/grimstroke_1/particles/grimstroke_1_skill_edbuff_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_grimstroke/grimstroke_ink_swell_aoe.vpcf",
		"models/eom/hero/grimstroke_1/particles/grimstroke_1_skill_boom_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_grimstroke/custom_grimstroke_phantom_ambient.vpcf",
		"models/eom/hero/grimstroke_1/particles/grimstroke_1_snake_cfg_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_grimstroke/grimstroke_phantom_ambient.vpcf",
		"models/eom/hero/grimstroke_1/particles/grimstroke_1_snake_cfg_fx.vpcf"
	)
	Wearable:registerUnitModelModifier(
		self:GetParent(),
		"models/heroes/grimstroke/ink_phantom.vmdl",
		"models/eom/hero/grimstroke_1/ink_phantom_1.vmdl"
	)
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE, MODIFIER_PROPERTY_MODEL_SCALE_ANIMATE_TIME }
end
function k.prototype.GetModifierModelScale(self)
	return 20
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
g.modifier_5100048 = k
return g