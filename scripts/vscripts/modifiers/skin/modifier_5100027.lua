--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100027"
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
		["15"] = 14,
		["16"] = 15,
		["17"] = 15,
		["18"] = 15,
		["19"] = 15,
		["20"] = 15,
		["21"] = 16,
		["22"] = 16,
		["23"] = 16,
		["24"] = 16,
		["25"] = 16,
		["26"] = 17,
		["27"] = 17,
		["28"] = 17,
		["29"] = 17,
		["30"] = 17,
		["31"] = 18,
		["32"] = 18,
		["33"] = 18,
		["34"] = 18,
		["35"] = 18,
		["36"] = 19,
		["37"] = 19,
		["38"] = 19,
		["39"] = 19,
		["40"] = 19,
		["41"] = 20,
		["42"] = 20,
		["43"] = 20,
		["44"] = 20,
		["45"] = 20,
		["46"] = 14,
		["47"] = 12,
		["48"] = 4,
		["49"] = 4,
		["50"] = 4,
		["51"] = 4,
		["52"] = 4,
		["53"] = 4,
		["54"] = 4,
		["55"] = 4,
		["56"] = 12,
		["58"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100027 = c()
local k = g.modifier_5100027
k.name = "modifier_5100027"
d(k, i)
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_zuus/zuus_base_attack.vpcf",
		"models/eom/hero/zeus_2/particles/zeus_2_base_attack.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_zuus/zuus_arc_lightning_head.vpcf",
		"models/eom/hero/zeus_2/particles/zeus_2_arc_lightning_head.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_zuus/zuus_thundergods_wrath_start.vpcf",
		"models/eom/hero/zeus_2/particles/zeus_2_thundergods_wrath_start_bolt_parent.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_zuus/zuus_thundergods_wrath.vpcf",
		"models/eom/hero/zeus_2/particles/zeus_2_thundergods_wrath.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf",
		"models/eom/hero/zeus_2/particles/zeus_2_lightning_boltc.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_zeus/zeus_cloud.vpcf",
		"models/eom/hero/zeus_2/particles/zeus_2_cloud.vpcf"
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
g.modifier_5100027 = k
return g