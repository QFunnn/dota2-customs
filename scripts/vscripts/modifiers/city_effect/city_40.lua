--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_40"
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
		["17"] = 16,
		["18"] = 17,
		["19"] = 16,
		["20"] = 20,
		["21"] = 21,
		["22"] = 22,
		["24"] = 20,
		["25"] = 26,
		["26"] = 27,
		["27"] = 28,
		["29"] = 26,
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
g.modifier_city_40 = c()
local l = g.modifier_city_40
l.name = "modifier_city_40"
d(l, k)
function l.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
end
function l.prototype.OnCreated(self)
	if IsServer() then
		GameState:modifyTreasureStageBoostRound(self.round)
	end
end
function l.prototype.OnDestroy(self)
	if IsServer() then
		GameState:modifyTreasureStageBoostRound(self.round, true)
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
g.modifier_city_40 = l
return g