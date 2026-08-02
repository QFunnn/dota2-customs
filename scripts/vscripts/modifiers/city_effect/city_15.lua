--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_15"
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
		["19"] = 15,
		["20"] = 5,
		["21"] = 16,
		["22"] = 17,
		["23"] = 16,
		["24"] = 19,
		["25"] = 20,
		["26"] = 19,
		["27"] = 24,
		["28"] = 25,
		["29"] = 26,
		["30"] = 27,
		["31"] = 28,
		["32"] = 29,
		["33"] = 34,
		["34"] = 27,
		["36"] = 24,
		["37"] = 13,
		["38"] = 5,
		["39"] = 5,
		["40"] = 5,
		["41"] = 5,
		["42"] = 5,
		["43"] = 5,
		["44"] = 5,
		["45"] = 5,
		["46"] = 13,
		["48"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.registerEOMModifier
local j = require("modifiers.city_effect.city_effect_modifier")
local k = j.CityEffectModifier
g.modifier_city_15 = c()
local l = g.modifier_city_15
l.name = "modifier_city_15"
d(l, k)
function l.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.enable = true
end
function l.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
end
function l.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function l.prototype.OnRoundStart(self, m)
	if self.enable then
		self.enable = false
		PlayerData:eachAlivePlayerHero(function(n, o, p)
			PlayerData:modifyGold(p, self.gold)
			Notification:combatToPlayer(
				p,
				{
					message = "notify_bonus_gold",
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self._city_name,
					int_gold = self.gold,
				}
			)
			CityEffect:modifyCityEffectExtraData(p, "bonus_gold", self.gold)
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
g.modifier_city_15 = l
return g