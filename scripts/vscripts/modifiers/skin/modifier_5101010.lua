--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5101010"
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
		["31"] = 13,
		["32"] = 12,
		["33"] = 4,
		["34"] = 4,
		["35"] = 4,
		["36"] = 4,
		["37"] = 4,
		["38"] = 4,
		["39"] = 4,
		["40"] = 4,
		["41"] = 12,
		["43"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5101010 = c()
local k = g.modifier_5101010
k.name = "modifier_5101010"
d(k, i)
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_phantom_strike_end.vpcf",
		"models/eom/hero/phantom_assassin_3/particles/phantom_assassin_3_strike.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf",
		"models/eom/hero/phantom_assassin_1/particles/pa_1_persona_crit_impactc.vpcf"
	)
	Wearable:registerSoundModifier(
		self:GetParent(),
		"Hero_PhantomAssassin.CoupDeGrace",
		"Hero_PhantomAssassin.CoupDeGrace.Arcana"
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
g.modifier_5101010 = k
return g