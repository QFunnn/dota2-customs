--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100057"
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
g.modifier_5100057 = c()
local k = g.modifier_5100057
k.name = "modifier_5100057"
d(k, i)
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf",
		"models/eom/hero/abaddon_2/particles/abaddon_2_explosion_boost_02_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_abaddon/abaddon_borrowed_time_e.vpcf",
		"models/eom/hero/abaddon_2/particles/abaddon_2_explosion_boost_02_fxe.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_explosion.vpcf",
		"models/eom/hero/abaddon_2/particles/abaddon_2_explosion_boost_03_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/status_fx/status_effect_abaddon_borrowed_time.vpcf",
		"models/eom/hero/abaddon_2/particles/status_effect_abaddon_2_borrowed_time.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_abaddon/abaddon_death_coil.vpcf",
		"models/eom/hero/abaddon_2/particles/abaddon_2_death_coil.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_abaddon/abaddon_death_coil_explosion.vpcf",
		"models/eom/hero/abaddon_2/particles/abaddon_2_death_coil_explosion.vpcf"
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
g.modifier_5100057 = k
return g