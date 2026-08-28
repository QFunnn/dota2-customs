--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100019"
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
		["41"] = 13,
		["42"] = 12,
		["43"] = 4,
		["44"] = 4,
		["45"] = 4,
		["46"] = 4,
		["47"] = 4,
		["48"] = 4,
		["49"] = 4,
		["50"] = 4,
		["51"] = 12,
		["53"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100019 = c()
local k = g.modifier_5100019
k.name = "modifier_5100019"
d(k, i)
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_ember_spirit/ember_spirit_flameguard.vpcf",
		"models/eom/hero/ember_spirit_2/particles/ember_spirit_2_flameguard_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_ember_spirit/ember_spirit_sleightoffist_trail.vpcf",
		"models/eom/hero/ember_spirit_2/particles/ember_spirit_2_sleightoffist_trail_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_ember_spirit/ember_spirit_sleightoffist_tgt.vpcf",
		"models/eom/hero/ember_spirit_2/particles/ember_spirit_2_sleightoffist_tgt_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_ember_spirit/ember_spirit_sleight_of_fist_cast.vpcf",
		"models/eom/hero/ember_spirit_2/particles/ember_spirit_2_sleight_of_fist_cast_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_ember_spirit/ember_spirit_sleight_of_fist_caster.vpcf",
		"models/eom/hero/ember_spirit_2/particles/ember_spirit_2_sleight_cover_fire.vpcf"
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
g.modifier_5100019 = k
return g