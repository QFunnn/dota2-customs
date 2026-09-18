--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100077"
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
		["17"] = 14,
		["18"] = 15,
		["19"] = 16,
		["20"] = 17,
		["21"] = 12,
		["22"] = 20,
		["23"] = 21,
		["24"] = 22,
		["25"] = 23,
		["26"] = 24,
		["27"] = 25,
		["28"] = 20,
		["29"] = 11,
		["30"] = 3,
		["31"] = 3,
		["32"] = 3,
		["33"] = 3,
		["34"] = 3,
		["35"] = 3,
		["36"] = 3,
		["37"] = 3,
		["38"] = 11,
		["40"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100077 = c()
local k = g.modifier_5100077
k.name = "modifier_5100077"
d(k, i)
function k.prototype.OnCreated(self, l)
	local m = self:GetParent()
	Wearable:registerParticleModifier(
		m,
		"particles/units/heroes/hero_beastmaster/bird_attack.vpcf",
		"models/eom/hero/beastmaster_1/particles/beastmaster_1_bird_attack_fx1.vpcf"
	)
	Wearable:registerParticleModifier(
		m,
		"particles/units/heroes/hero_beastmaster/beastmaster_boar_attack.vpcf",
		"models/eom/hero/beastmaster_1/particles/beastmaster_1_beast_attack.vpcf"
	)
	Wearable:registerParticleModifier(
		m,
		"particles/units/heroes/hero_beastmaster/beastmaster_wildaxe.vpcf",
		"models/eom/hero/beastmaster_1/particles/beastmaster_1_skill_2_fx1.vpcf"
	)
	Wearable:registerParticleModifier(
		m,
		"particles/units/heroes/hero_beastmaster/bird_custom_idle.vpcf",
		"models/eom/hero/beastmaster_1/particles/beastmaster_1_bird_idle_fx.vpcf"
	)
end
function k.prototype.OnDestroy(self)
	local m = self:GetParent()
	Wearable:unregisterParticleModifier(m, "particles/units/heroes/hero_beastmaster/bird_attack.vpcf")
	Wearable:unregisterParticleModifier(m, "particles/units/heroes/hero_beastmaster/beastmaster_boar_attack.vpcf")
	Wearable:unregisterParticleModifier(m, "particles/units/heroes/hero_beastmaster/beastmaster_wildaxe.vpcf")
	Wearable:unregisterParticleModifier(m, "particles/units/heroes/hero_beastmaster/bird_custom_idle.vpcf")
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
g.modifier_5100077 = k
return g