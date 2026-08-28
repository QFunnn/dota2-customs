--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_24"
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
		["17"] = 14,
		["18"] = 14,
		["19"] = 16,
		["20"] = 17,
		["21"] = 18,
		["23"] = 16,
		["24"] = 21,
		["25"] = 22,
		["26"] = 23,
		["28"] = 21,
		["29"] = 13,
		["30"] = 5,
		["31"] = 5,
		["32"] = 5,
		["33"] = 5,
		["34"] = 5,
		["35"] = 5,
		["36"] = 5,
		["37"] = 5,
		["38"] = 13,
		["40"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.registerEOMModifier
local j = require("modifiers.city_effect.city_effect_modifier")
local k = j.CityEffectModifier
g.modifier_city_24 = c()
local l = g.modifier_city_24
l.name = "modifier_city_24"
d(l, k)
function l.prototype.GetAbilitySpecialValue(self) end
function l.prototype.OnCreated(self, m)
	if IsServer() then
		RuneTask:setCityEffectNoTask(true)
	end
end
function l.prototype.OnDestroy(self)
	if IsServer() then
		RuneTask:setCityEffectNoTask(false)
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
g.modifier_city_24 = l
return g