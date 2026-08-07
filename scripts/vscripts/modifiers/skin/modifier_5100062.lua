--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100062"
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
		["31"] = 16,
		["32"] = 16,
		["33"] = 16,
		["34"] = 16,
		["35"] = 16,
		["36"] = 17,
		["37"] = 17,
		["38"] = 17,
		["39"] = 17,
		["40"] = 17,
		["41"] = 18,
		["42"] = 18,
		["43"] = 18,
		["44"] = 18,
		["45"] = 18,
		["46"] = 19,
		["47"] = 19,
		["48"] = 19,
		["49"] = 19,
		["50"] = 19,
		["51"] = 20,
		["52"] = 20,
		["53"] = 20,
		["54"] = 20,
		["55"] = 20,
		["56"] = 12,
		["57"] = 11,
		["58"] = 3,
		["59"] = 3,
		["60"] = 3,
		["61"] = 3,
		["62"] = 3,
		["63"] = 3,
		["64"] = 3,
		["65"] = 3,
		["66"] = 11,
		["68"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100062 = c()
local k = g.modifier_5100062
k.name = "modifier_5100062"
d(k, i)
function k.prototype.OnCreated(self, l)
	Wearable:registerUnitModelModifier(
		self:GetParent(),
		"models/heroes/ember_spirit/ember_spirit_sfm.vmdl",
		"models/development/invisiblebox.vmdl"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_ember_spirit/ember_spirit_flameguard.vpcf",
		"models/eom/hero/virgo_1/particles/virgo_1_skill_1_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_ember_spirit/ember_spirit__2fire_remnant.vpcf",
		"models/eom/hero/virgo_1/particles/virgo_1_sleight_cover_fire.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_ember_spirit/ember_spirit_fire_remnant_trail.vpcf",
		"models/eom/hero/virgo_1/particles/virgo_1_sleight_fire_trail.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_ember_spirit/ember_spirit_sleight_of_fist_cast.vpcf",
		"models/eom/hero/virgo_1/particles/virgo_1_sleight_of_fist_cast_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_ember_spirit/ember_spirit_sleight_of_fist_caster.vpcf",
		"models/eom/hero/virgo_1/particles/sleight_of_fist_caster_1.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_ember_spirit/ember_spirit_sleightoffist_tgt.vpcf",
		"models/eom/hero/virgo_1/particles/virgo_1_sleightoffist_tgt_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_ember_spirit/ember_spirit_sleightoffist_trail.vpcf",
		"models/eom/hero/virgo_1/particles/virgo_1_sleightoffist_trail_fx.vpcf"
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
g.modifier_5100062 = k
return g