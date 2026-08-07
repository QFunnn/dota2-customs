--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100069"
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
		["31"] = 12,
		["32"] = 11,
		["33"] = 3,
		["34"] = 3,
		["35"] = 3,
		["36"] = 3,
		["37"] = 3,
		["38"] = 3,
		["39"] = 3,
		["40"] = 3,
		["41"] = 11,
		["43"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100069 = c()
local k = g.modifier_5100069
k.name = "modifier_5100069"
d(k, i)
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_crystalmaiden/maiden_base_attack.vpcf",
		"models/eom/hero/crystal_maiden_2/particles/crystal_maiden_2_base_attack_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf",
		"models/eom/hero/crystal_maiden_2/particles/crystal_maiden_2_field_explosion_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_cowlofice.vpcf",
		"models/eom/hero/crystal_maiden_2/particles/crystal_maiden_2_crystal_nova_fx.vpcf"
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
g.modifier_5100069 = k
return g