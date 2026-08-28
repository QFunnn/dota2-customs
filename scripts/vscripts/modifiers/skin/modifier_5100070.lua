--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/skin/modifier_5100070"
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
		["11"] = 2,
		["12"] = 10,
		["13"] = 2,
		["14"] = 10,
		["15"] = 11,
		["16"] = 12,
		["17"] = 12,
		["18"] = 12,
		["19"] = 12,
		["20"] = 12,
		["21"] = 14,
		["22"] = 14,
		["23"] = 14,
		["24"] = 14,
		["25"] = 14,
		["26"] = 11,
		["27"] = 10,
		["28"] = 2,
		["29"] = 2,
		["30"] = 2,
		["31"] = 2,
		["32"] = 2,
		["33"] = 2,
		["34"] = 2,
		["35"] = 2,
		["36"] = 10,
		["38"] = 10,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_5100070 = c()
local k = g.modifier_5100070
k.name = "modifier_5100070"
d(k, i)
function k.prototype.OnCreated(self, l)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_antimage/antimage_counter.vpcf",
		"models/eom/hero/antimage_1/particles/antimage_1_fx_skill_01_01.vpcf"
	)
	Wearable:registerParticleModifier(
		self:GetParent(),
		"particles/units/heroes/hero_antimage/antimage_manavoid.vpcf",
		"models/eom/hero/antimage_1/particles/antimage_1_fx_skill_02.vpcf"
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
g.modifier_5100070 = k
return g