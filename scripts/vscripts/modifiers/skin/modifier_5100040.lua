--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100040"
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
		["37"] = 28,
		["38"] = 29,
		["39"] = 28,
		["40"] = 31,
		["41"] = 32,
		["42"] = 31,
		["43"] = 12,
		["44"] = 4,
		["45"] = 4,
		["46"] = 4,
		["47"] = 4,
		["48"] = 4,
		["49"] = 4,
		["50"] = 4,
		["51"] = 4,
		["52"] = 12,
		["54"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100040 = c()
local k = g.modifier_5100040
k.name = "modifier_5100040"
d(k, i)
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_hoodwink/hoodwink_base_attack.vpcf",
		"models/eom/hero/hoodwink_1/particles/hoodwink_1_base_attack_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_projectile.vpcf",
		"particles/econ/items/hoodwink/hoodwink_2022_immortal/hoodwink_2022_immortal_sharpshooter_projectile_blossom.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter.vpcf",
		"models/eom/hero/hoodwink_1/particles/hoodwink_1_skill_xuli_fx.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_hoodwink/hoodwink_boomerang.vpcf",
		"models/eom/hero/hoodwink_1/particles/hoodwink_1_feibiao_fx.vpcf"
	)
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND }
end
function k.prototype.GetAttackSound(self)
	return "Hero_Sniper.Attack.DT20"
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
g.modifier_5100040 = k
return g