--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100052"
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
		["16"] = 16,
		["17"] = 16,
		["18"] = 16,
		["19"] = 16,
		["20"] = 16,
		["21"] = 17,
		["22"] = 17,
		["23"] = 17,
		["24"] = 17,
		["25"] = 17,
		["26"] = 18,
		["27"] = 18,
		["28"] = 18,
		["29"] = 18,
		["30"] = 18,
		["31"] = 14,
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
g.modifier_5100052 = c()
local k = g.modifier_5100052
k.name = "modifier_5100052"
d(k, i)
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_broodmother/broodmother_spin_web_cast.vpcf",
		"models/eom/hero/broodmother_1/particles/broodmother_1_fx_spin_web_cast.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_broodmother/broodmother_web.vpcf",
		"models/eom/hero/broodmother_1/particles/broodmother_1_fx_passivity_black.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_broodmother/broodmother_web_cast.vpcf",
		"models/eom/hero/broodmother_1/particles/broodmother_1_fx_trail_skill.vpcf"
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
g.modifier_5100052 = k
return g