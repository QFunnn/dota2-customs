--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_23"
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
		["20"] = 19,
		["21"] = 20,
		["22"] = 21,
		["23"] = 22,
		["24"] = 23,
		["27"] = 25,
		["28"] = 25,
		["29"] = 26,
		["30"] = 25,
		["33"] = 28,
		["35"] = 19,
		["36"] = 31,
		["37"] = 32,
		["39"] = 33,
		["40"] = 33,
		["41"] = 34,
		["42"] = 33,
		["46"] = 31,
		["47"] = 13,
		["48"] = 5,
		["49"] = 5,
		["50"] = 5,
		["51"] = 5,
		["52"] = 5,
		["53"] = 5,
		["54"] = 5,
		["55"] = 5,
		["56"] = 13,
		["58"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.registerEOMModifier
local j = require("modifiers.city_effect.city_effect_modifier")
local k = j.CityEffectModifier
g.modifier_city_23 = c()
local l = g.modifier_city_23
l.name = "modifier_city_23"
d(l, k)
function l.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
end
function l.prototype.OnCreated(self, m)
	if IsServer() then
		local n = NEUTRAL_ROUND
		if IsTurboMode(nil) then
			n = NEUTRAL_ROUND_TURBO
		end
		do
			local o = 0
			while o < #n do
				Roshan:modifyRoshanTreasureRound(n[o + 1])
				o = o + 1
			end
		end
		self.rounds = shallowcopy(n)
	end
end
function l.prototype.OnDestroy(self)
	if IsServer() then
		do
			local o = 0
			while o < #self.rounds do
				Roshan:modifyRoshanTreasureRound(self.rounds[o + 1], true)
				o = o + 1
			end
		end
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
g.modifier_city_23 = l
return g