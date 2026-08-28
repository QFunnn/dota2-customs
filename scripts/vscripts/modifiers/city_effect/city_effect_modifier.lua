--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_effect_modifier"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringReplace
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 7,
		["11"] = 7,
		["12"] = 7,
		["13"] = 7,
		["15"] = 7,
		["16"] = 10,
		["17"] = 10,
		["18"] = 10,
		["19"] = 10,
		["20"] = 10,
		["21"] = 8,
		["22"] = 12,
		["23"] = 13,
		["24"] = 12,
		["25"] = 15,
		["26"] = 16,
		["27"] = 15,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
g.CityEffectModifier = c()
local j = g.CityEffectModifier
j.name = "CityEffectModifier"
d(j, i)
function j.prototype.____constructor(self)
	i.prototype.____constructor(self)
	self._city_name = e(self:GetName(), "modifier_", "")
end
function j.prototype.GetAbilitySpecialValueFor(self, k)
	return CityEffect:GetSpecialValueFor(self._city_name, k)
end
function j.prototype.GetCityName(self)
	return self._city_name
end
return g