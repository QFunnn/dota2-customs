--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_6"
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
		["19"] = 18,
		["20"] = 19,
		["22"] = 16,
		["23"] = 22,
		["24"] = 23,
		["25"] = 22,
		["26"] = 28,
		["27"] = 29,
		["28"] = 28,
		["29"] = 31,
		["30"] = 32,
		["31"] = 33,
		["32"] = 34,
		["33"] = 35,
		["34"] = 36,
		["35"] = 41,
		["36"] = 34,
		["38"] = 44,
		["39"] = 31,
		["40"] = 13,
		["41"] = 5,
		["42"] = 5,
		["43"] = 5,
		["44"] = 5,
		["45"] = 5,
		["46"] = 5,
		["47"] = 5,
		["48"] = 5,
		["49"] = 13,
		["51"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.registerEOMModifier
local j = require("modifiers.city_effect.city_effect_modifier")
local k = j.CityEffectModifier
g.modifier_city_6 = c()
local l = g.modifier_city_6
l.name = "modifier_city_6"
d(l, k)
function l.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
	if IsServer() then
		self.record = 0
	end
end
function l.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_KILLED] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE] = { -1, -1 },
	}
end
function l.prototype.OnPlayerKilled(self, m)
	self.record = self.record + 1
end
function l.prototype.OnPrepare(self, n)
	if self.record > 0 then
		local o = self.record * self.gold
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
	self.record = 0
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
g.modifier_city_6 = l
return g