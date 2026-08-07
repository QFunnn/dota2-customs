--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100025"
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
		["46"] = 20,
		["47"] = 20,
		["48"] = 20,
		["49"] = 20,
		["50"] = 20,
		["51"] = 21,
		["52"] = 21,
		["53"] = 21,
		["54"] = 21,
		["55"] = 21,
		["56"] = 22,
		["57"] = 22,
		["58"] = 22,
		["59"] = 22,
		["60"] = 22,
		["61"] = 23,
		["62"] = 23,
		["63"] = 23,
		["64"] = 23,
		["65"] = 23,
		["66"] = 25,
		["67"] = 25,
		["68"] = 25,
		["69"] = 25,
		["70"] = 25,
		["71"] = 13,
		["72"] = 12,
		["73"] = 4,
		["74"] = 4,
		["75"] = 4,
		["76"] = 4,
		["77"] = 4,
		["78"] = 4,
		["79"] = 4,
		["80"] = 4,
		["81"] = 12,
		["83"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100025 = c()
local k = g.modifier_5100025
k.name = "modifier_5100025"
d(k, i)
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_dark_willow/dark_willow_base_attack.vpcf",
		"models/eom/hero/dark_willow_1/particles/dark_willow_1_base_attack.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/econ/items/dark_willow/dark_willow_chakram_immortal/dark_willow_chakram_immortal_bramble_wraith.vpcf",
		"models/eom/hero/dark_willow_1/particles/dark_willow_1_chakram_immortal_bramble_wraith.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/econ/items/dark_willow/dark_willow_immortal_2021/dw_2021_willow_wisp_spell_debuff.vpcf",
		"models/eom/hero/dark_willow_1/particles/dark_willow_1_wisp_spell_debuff.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_dark_willow/dark_willow_wisp_spell_channel.vpcf",
		"models/eom/hero/dark_willow_1/particles/dark_willow_1_wisp_spell_channel.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/econ/items/dark_willow/dark_willow_immortal_2021/dw_2021_willow_wisp_bedlam_projectile.vpcf",
		"models/eom/hero/dark_willow_1/particles/dark_willow_1_wisp_bedlam_projectile.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_dark_willow/dark_willow_wisp_spell.vpcf",
		"models/eom/hero/dark_willow_1/particles/dark_willow_1_wisp_spell.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_dark_willow/dark_willow_wisp_spell_marker.vpcf",
		"models/eom/hero/dark_willow_1/particles/dark_willow_1_wisp_spell_marker.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_dark_willow/dark_willow_willowisp_ambient.vpcf",
		"models/eom/hero/dark_willow_1/particles/dark_willow_1_willowisp_ambient.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_dark_willow/dark_willow_willowisp_base_attack.vpcf",
		"models/eom/hero/dark_willow_1/particles/dark_willow_1_willowisp_base_attack.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/econ/items/dark_willow/dark_willow_immortal_2021/dw_2021_willow_wisp_aoe_cast.vpcf",
		"models/eom/hero/dark_willow_1/particles/dark_willow_1_wisp_aoe_cast.vpcf"
	)
	Wearable:registerUnitModelModifier(
		self:GetParent(),
		"models/heroes/dark_willow/dark_willow_wisp.vmdl",
		"models/eom/courier/dark_willow_1_shouwei/dark_willow_1_shouwei_skin.vmdl"
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
g.modifier_5100025 = k
return g