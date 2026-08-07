--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_14"
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
		["10"] = 2,
		["11"] = 2,
		["13"] = 5,
		["14"] = 13,
		["15"] = 5,
		["16"] = 13,
		["17"] = 15,
		["18"] = 16,
		["19"] = 15,
		["20"] = 18,
		["21"] = 19,
		["22"] = 20,
		["24"] = 18,
		["25"] = 23,
		["26"] = 24,
		["27"] = 25,
		["29"] = 23,
		["30"] = 13,
		["31"] = 5,
		["32"] = 5,
		["33"] = 5,
		["34"] = 5,
		["35"] = 5,
		["36"] = 5,
		["37"] = 5,
		["38"] = 5,
		["39"] = 13,
		["41"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.registerEOMModifier
local j = require("modifiers.city_effect.city_effect_modifier")
local k = j.CityEffectModifier
g.modifier_city_14 = c()
local l = g.modifier_city_14
l.name = "modifier_city_14"
d(l, k)
function l.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
end
function l.prototype.OnCreated(self, m)
	if IsServer() then
		Match:setMergeAbilityRound(self.round)
	end
end
function l.prototype.OnDestroy(self)
	if IsServer() then
		Match:setMergeAbilityRound()
	end
end
l = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	l
)
g.modifier_city_14 = l
return g