--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100078"
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
		["12"] = 4,
		["13"] = 5,
		["14"] = 6,
		["15"] = 7,
		["16"] = 8,
		["17"] = 9,
		["18"] = 10,
		["19"] = 11,
		["20"] = 12,
		["21"] = 13,
		["22"] = 14,
		["23"] = 16,
		["24"] = 24,
		["25"] = 16,
		["26"] = 24,
		["27"] = 25,
		["28"] = 26,
		["29"] = 27,
		["30"] = 28,
		["31"] = 29,
		["32"] = 30,
		["33"] = 31,
		["34"] = 32,
		["35"] = 25,
		["36"] = 34,
		["37"] = 35,
		["38"] = 36,
		["39"] = 37,
		["40"] = 38,
		["41"] = 39,
		["42"] = 40,
		["43"] = 41,
		["44"] = 34,
		["45"] = 24,
		["46"] = 16,
		["47"] = 16,
		["48"] = 16,
		["49"] = 16,
		["50"] = 16,
		["51"] = 16,
		["52"] = 16,
		["53"] = 16,
		["54"] = 24,
		["56"] = 24,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = "particles/units/heroes/hero_zuus/zuus_base_attack.vpcf"
local l = "models/eom/hero/zeus_3/particles/zeus_3_base_attack1_fx.vpcf"
local m = "particles/units/heroes/hero_zuus/zuus_arc_lightning_head.vpcf"
local n = "models/eom/hero/zeus_3/particles/zeus_3_skill_1_fx.vpcf"
local o = "particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf"
local p = "models/eom/hero/zeus_3/particles/zeus_3_lightning_boltc.vpcf"
local q = "particles/units/heroes/hero_zuus/zuus_thundergods_wrath_start.vpcf"
local r = "models/eom/hero/zeus_3/particles/zeus_3_skill_2_fx.vpcf"
local s = "particles/units/heroes/hero_zuus/zuus_thundergods_wrath.vpcf"
local t = "models/eom/hero/zeus_3/particles/zeus_3_skill_2_fx1.vpcf"
local u = "particles/units/heroes/hero_zeus/zeus_cloud.vpcf"
local v = "models/eom/hero/zeus_3/particles/zeus_3_cloud_fx.vpcf"
g.modifier_5100078 = c()
local w = g.modifier_5100078
w.name = "modifier_5100078"
d(w, i)
function w.prototype.OnCreated(self, x)
	local y = self:GetParent()
	Wearable:registerParticleModifier(y, k, l)
	Wearable:registerParticleModifier(y, m, n)
	Wearable:registerParticleModifier(y, o, p)
	Wearable:registerParticleModifier(y, q, r)
	Wearable:registerParticleModifier(y, s, t)
	Wearable:registerParticleModifier(y, u, v)
end
function w.prototype.OnDestroy(self)
	local y = self:GetParent()
	Wearable:unregisterParticleModifier(y, k)
	Wearable:unregisterParticleModifier(y, m)
	Wearable:unregisterParticleModifier(y, o)
	Wearable:unregisterParticleModifier(y, q)
	Wearable:unregisterParticleModifier(y, s)
	Wearable:unregisterParticleModifier(y, u)
end
w = e(
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
	w
)
g.modifier_5100078 = w
return g