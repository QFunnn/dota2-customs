--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100060"
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
		["46"] = 12,
		["47"] = 11,
		["48"] = 3,
		["49"] = 3,
		["50"] = 3,
		["51"] = 3,
		["52"] = 3,
		["53"] = 3,
		["54"] = 3,
		["55"] = 3,
		["56"] = 11,
		["58"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100060 = c()
local k = g.modifier_5100060
k.name = "modifier_5100060"
d(k, i)
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_pickup.vpcf",
		"models/eom/hero/primal_beast_1/particles/primal_beast_1_throw_pickup.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_arc.vpcf",
		"models/eom/hero/primal_beast_1/particles/primal_beast_1_smash_2_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_impact.vpcf",
		"models/eom/hero/primal_beast_1/particles/primal_beast_1_smash_3_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_primal_beast/primal_beast_pulverize_hit.vpcf",
		"models/eom/hero/primal_beast_1/particles/primal_beast_1_skill_3_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_primal_beast/primal_beast_trample.vpcf",
		"models/eom/hero/primal_beast_1/particles/primal_beast_1_skill_2_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_primal_beast/primal_beast_pulverize_tectonic_shift_projectile.vpcf",
		"models/eom/hero/primal_beast_1/particles/primal_beast_1_skill_1_base_attack_fx.vpcf"
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
g.modifier_5100060 = k
return g