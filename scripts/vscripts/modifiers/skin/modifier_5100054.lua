--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100054"
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
		["36"] = 13,
		["37"] = 12,
		["38"] = 4,
		["39"] = 4,
		["40"] = 4,
		["41"] = 4,
		["42"] = 4,
		["43"] = 4,
		["44"] = 4,
		["45"] = 4,
		["46"] = 12,
		["48"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100054 = c()
local k = g.modifier_5100054
k.name = "modifier_5100054"
d(k, i)
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_witchdoctor/witchdoctor_base_attack.vpcf",
		"models/eom/hero/witchdoctor_1/particles/witchdoctor_1_fx_base_attack.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_witchdoctor/custom_witchdoctor_maledict_aoe.vpcf",
		"models/eom/hero/witchdoctor_1/particles/witchdoctor_1_fx_base_attack_maledict_aoe.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_witchdoctor/witchdoctor_voodoo_restoration.vpcf",
		"models/eom/hero/witchdoctor_1/particles/witchdoctor_skill.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_witchdoctor/witchdoctor_maledict_c.vpcf",
		"models/eom/hero/witchdoctor_1/particles/witchdoctor_1_fx_base_attack_actor_wenli_01.vpcf"
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
g.modifier_5100054 = k
return g