--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_41"
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
		["17"] = 17,
		["18"] = 18,
		["19"] = 19,
		["20"] = 17,
		["21"] = 22,
		["22"] = 23,
		["23"] = 24,
		["25"] = 22,
		["26"] = 28,
		["27"] = 29,
		["28"] = 30,
		["30"] = 28,
		["31"] = 13,
		["32"] = 5,
		["33"] = 5,
		["34"] = 5,
		["35"] = 5,
		["36"] = 5,
		["37"] = 5,
		["38"] = 5,
		["39"] = 5,
		["40"] = 13,
		["42"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.registerEOMModifier
local j = require("modifiers.city_effect.city_effect_modifier")
local k = j.CityEffectModifier
g.modifier_city_41 = c()
local l = g.modifier_city_41
l.name = "modifier_city_41"
d(l, k)
function l.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
	self.level = self:GetAbilitySpecialValueFor("level")
end
function l.prototype.OnCreated(self)
	if IsServer() then
		GameState:modifyTreasureForcedEquipmentRound(self.round, self.level)
	end
end
function l.prototype.OnDestroy(self)
	if IsServer() then
		GameState:modifyTreasureForcedEquipmentRound(self.round, self.level, true)
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
g.modifier_city_41 = l
return g