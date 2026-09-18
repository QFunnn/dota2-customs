--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
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
		["16"] = 9,
		["17"] = 17,
		["18"] = 9,
		["19"] = 17,
		["20"] = 18,
		["21"] = 19,
		["22"] = 20,
		["23"] = 21,
		["24"] = 22,
		["25"] = 18,
		["26"] = 24,
		["27"] = 25,
		["28"] = 26,
		["29"] = 27,
		["30"] = 28,
		["31"] = 24,
		["32"] = 17,
		["33"] = 9,
		["34"] = 9,
		["35"] = 9,
		["36"] = 9,
		["37"] = 9,
		["38"] = 9,
		["39"] = 9,
		["40"] = 9,
		["41"] = 17,
		["43"] = 17,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = "particles/units/heroes/hero_zuus/zuus_arc_lightning_head.vpcf"
local l = "models/eom/hero/zeus_3/particles/zeus_3_skill1_fxa.vpcf"
local m = "particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf"
local n = "particles/units/heroes/hero_zuus/zuus_thundergods_wrath.vpcf"
local o = "models/eom/hero/zeus_3/particles/zeus_3_skill2_fx.vpcf"
g.modifier_5100078 = c()
local p = g.modifier_5100078
p.name = "modifier_5100078"
d(p, i)
function p.prototype.OnCreated(self, q)
	local r = self:GetParent()
	Wearable:registerParticleModifier(r, k, l)
	Wearable:registerParticleModifier(r, m, o)
	Wearable:registerParticleModifier(r, n, o)
end
function p.prototype.OnDestroy(self)
	local r = self:GetParent()
	Wearable:unregisterParticleModifier(r, k)
	Wearable:unregisterParticleModifier(r, m)
	Wearable:unregisterParticleModifier(r, n)
end
p = e(
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
	p
)
g.modifier_5100078 = p
return g