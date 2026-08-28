--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100056"
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
		["26"] = 12,
		["27"] = 16,
		["28"] = 17,
		["29"] = 16,
		["30"] = 19,
		["31"] = 20,
		["32"] = 19,
		["33"] = 11,
		["34"] = 3,
		["35"] = 3,
		["36"] = 3,
		["37"] = 3,
		["38"] = 3,
		["39"] = 3,
		["40"] = 3,
		["41"] = 3,
		["42"] = 11,
		["44"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100056 = c()
local k = g.modifier_5100056
k.name = "modifier_5100056"
d(k, i)
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_magnataur/magnataur_shockwave.vpcf",
		"models/eom/hero/magnataur_1/particles/magnataur_1_fx_shockwave.vpcf"
	)
	Wearable:registerSoundModifier(
		self:GetParent(),
		"Hero_Magnataur.ShockWave.Particle",
		"Hero_Magnataur.ShockWave.Particle.Anvil"
	)
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND }
end
function k.prototype.GetAttackSound(self)
	return "Hero_OgreMagi.Attack"
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
g.modifier_5100056 = k
return g