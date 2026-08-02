--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_37"
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
		["18"] = 15,
		["19"] = 16,
		["20"] = 17,
		["21"] = 18,
		["23"] = 14,
		["24"] = 21,
		["25"] = 22,
		["26"] = 23,
		["27"] = 24,
		["29"] = 21,
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
g.modifier_city_37 = c()
local l = g.modifier_city_37
l.name = "modifier_city_37"
d(l, k)
function l.prototype.OnCreated(self, m)
	if IsServer() then
		RuneTask:setRuneRewardBindTaskMode(true)
		RuneTask:setTaskRefreshCount(self:GetAbilitySpecialValueFor("refresh"))
		GameState:ModifyGameStateDuration("GameState_RuneTask", 10)
	end
end
function l.prototype.Destroy(self)
	if IsServer() then
		RuneTask:setRuneRewardBindTaskMode(false)
		RuneTask:setTaskRefreshCount(0)
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
g.modifier_city_37 = l
return g