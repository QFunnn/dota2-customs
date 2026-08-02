--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100065"
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
		["31"] = 12,
		["32"] = 17,
		["33"] = 18,
		["34"] = 17,
		["35"] = 22,
		["36"] = 23,
		["37"] = 22,
		["38"] = 11,
		["39"] = 3,
		["40"] = 3,
		["41"] = 3,
		["42"] = 3,
		["43"] = 3,
		["44"] = 3,
		["45"] = 3,
		["46"] = 3,
		["47"] = 11,
		["49"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100065 = c()
local k = g.modifier_5100065
k.name = "modifier_5100065"
d(k, i)
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_silencer/silencer_glaives_of_wisdom.vpcf",
		"models/eom/hero/silencer_1/particles/sileccer_1_glaive_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_silencer/silencer_global_silence.vpcf",
		"models/eom/hero/silencer_1/particles/sileccer_1_global_silence_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_silencer/silencer_global_silence_hero.vpcf",
		"models/eom/hero/silencer_1/particles/sileccer_1_global_silence_fx.vpcf"
	)
end
function k.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROJECTILE_NAME }
end
function k.prototype.EOM_GetModifierProjectileName(self)
	return "models/eom/hero/silencer_1/particles/sileccer_1_glaive_fx.vpcf"
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
g.modifier_5100065 = k
return g