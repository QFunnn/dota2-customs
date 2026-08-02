--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100050"
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
		["16"] = 12,
		["17"] = 14,
		["18"] = 4,
		["19"] = 15,
		["20"] = 16,
		["21"] = 16,
		["22"] = 16,
		["23"] = 16,
		["24"] = 16,
		["25"] = 17,
		["26"] = 17,
		["27"] = 17,
		["28"] = 17,
		["29"] = 17,
		["30"] = 18,
		["31"] = 18,
		["32"] = 18,
		["33"] = 18,
		["34"] = 18,
		["35"] = 19,
		["36"] = 19,
		["37"] = 19,
		["38"] = 19,
		["39"] = 19,
		["40"] = 20,
		["41"] = 20,
		["42"] = 20,
		["43"] = 20,
		["44"] = 20,
		["45"] = 15,
		["46"] = 22,
		["47"] = 23,
		["48"] = 22,
		["49"] = 29,
		["50"] = 30,
		["51"] = 29,
		["52"] = 32,
		["53"] = 33,
		["54"] = 32,
		["55"] = 35,
		["56"] = 37,
		["57"] = 35,
		["58"] = 12,
		["59"] = 4,
		["60"] = 4,
		["61"] = 4,
		["62"] = 4,
		["63"] = 4,
		["64"] = 4,
		["65"] = 4,
		["66"] = 4,
		["67"] = 12,
		["69"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100050 = c()
local k = g.modifier_5100050
k.name = "modifier_5100050"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.state = false
end
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_alchemist/alchemist_chemical_rage.vpcf",
		"models/eom/hero/alchemist_1/particles/alchemist_1_fx_ultimate_skill.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/status_fx/status_effect_chemical_rage.vpcf",
		"particles/status_fx/status_effect_obsidian_matter.vpcf"
	)
	Wearable:registerSoundModifier(self:GetParent(), "Hero_Alchemist.ChemicalRage.Cast", "Hero_Terrorblade.Sunder.Cast")
	Wearable:registerSoundModifier(
		self:GetParent(),
		"Hero_Alchemist.ChemicalRage.PreAttack",
		"Hero_QueenOfPain.PreAttack"
	)
	Wearable:registerSoundModifier(
		self:GetParent(),
		"Hero_Alchemist.ChemicalRage.Attack",
		"Hero_QueenOfPain.ArcanaAttack"
	)
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE, MODIFIER_PROPERTY_MODEL_SCALE_ANIMATE_TIME }
end
function k.prototype.GetAttackSound(self)
	return "Hero_NagaSiren.Attack"
end
function k.prototype.GetModifierModelScale(self)
	return -15
end
function k.prototype.GetModifierModelScaleAnimateTime(self)
	return 0.1
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
g.modifier_5100050 = k
return g