--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_13"
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
		["18"] = 13,
		["19"] = 17,
		["20"] = 5,
		["21"] = 18,
		["22"] = 19,
		["23"] = 20,
		["24"] = 18,
		["25"] = 22,
		["26"] = 23,
		["27"] = 24,
		["29"] = 22,
		["30"] = 27,
		["31"] = 28,
		["32"] = 27,
		["33"] = 32,
		["34"] = 33,
		["35"] = 32,
		["36"] = 35,
		["37"] = 36,
		["38"] = 37,
		["39"] = 38,
		["40"] = 39,
		["41"] = 40,
		["42"] = 41,
		["43"] = 42,
		["44"] = 47,
		["45"] = 40,
		["47"] = 35,
		["48"] = 13,
		["49"] = 5,
		["50"] = 5,
		["51"] = 5,
		["52"] = 5,
		["53"] = 5,
		["54"] = 5,
		["55"] = 5,
		["56"] = 5,
		["57"] = 13,
		["59"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.registerEOMModifier
local j = require("modifiers.city_effect.city_effect_modifier")
local k = j.CityEffectModifier
g.modifier_city_13 = c()
local l = g.modifier_city_13
l.name = "modifier_city_13"
d(l, k)
function l.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.enable = true
end
function l.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
	self.gold = self:GetAbilitySpecialValueFor("gold")
end
function l.prototype.OnCreated(self, m)
	if IsServer() then
		self:EffectFunc()
	end
end
function l.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function l.prototype.OnRoundStart(self, m)
	self:EffectFunc()
end
function l.prototype.EffectFunc(self)
	if self.enable and Rounds:getCurrentRound() == self.round then
		self.enable = false
		local n = PlayerData:getAlivePlayerCount()
		local o = math.floor(self.gold / n)
		PlayerData:eachAlivePlayerHero(function(p, q, r)
			PlayerData:modifyGold(r, o)
			Notification:combatToPlayer(
				r,
				{
					message = "notify_bonus_gold",
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self._city_name,
					int_gold = o,
				}
			)
			CityEffect:modifyCityEffectExtraData(r, "bonus_gold", o)
		end)
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
g.modifier_city_13 = l
return g