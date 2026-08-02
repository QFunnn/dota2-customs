--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_7"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringSplit
local f = b.__TS__ArrayForEach
local g = b.__TS__DecorateLegacy
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["15"] = 5,
		["16"] = 13,
		["17"] = 5,
		["18"] = 13,
		["19"] = 16,
		["20"] = 17,
		["21"] = 18,
		["22"] = 16,
		["23"] = 20,
		["24"] = 21,
		["25"] = 20,
		["26"] = 25,
		["27"] = 26,
		["28"] = 27,
		["29"] = 28,
		["30"] = 30,
		["31"] = 31,
		["32"] = 32,
		["33"] = 33,
		["35"] = 35,
		["37"] = 37,
		["38"] = 41,
		["39"] = 41,
		["40"] = 41,
		["41"] = 41,
		["42"] = 41,
		["43"] = 41,
		["44"] = 41,
		["45"] = 42,
		["46"] = 43,
		["47"] = 48,
		["48"] = 41,
		["49"] = 41,
		["50"] = 28,
		["52"] = 25,
		["53"] = 13,
		["54"] = 5,
		["55"] = 5,
		["56"] = 5,
		["57"] = 5,
		["58"] = 5,
		["59"] = 5,
		["60"] = 5,
		["61"] = 5,
		["62"] = 13,
		["64"] = 13,
	}
)
local i = {}
local j = require("modifiers.eom_modifier")
local k = j.registerEOMModifier
local l = require("modifiers.city_effect.city_effect_modifier")
local m = l.CityEffectModifier
i.modifier_city_7 = c()
local n = i.modifier_city_7
n.name = "modifier_city_7"
d(n, m)
function n.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.round = self:GetAbilitySpecialValueFor("round")
end
function n.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function n.prototype.OnRoundStart(self, o)
	local p = Rounds:getCurrentRound()
	if p % self.round == 0 then
		PlayerData:eachAlivePlayerHero(function(q, r, s)
			local t = AbilityShop:GetRecommendSectByHeroName(r.unitName)
			local u = {}
			if t ~= "sect_none" then
				u = e(t, "|")
			else
				u = AbilityShop.pickList
			end
			local v = AbilityShop:getRandomAbility(s, self.count, { specifySect = u, isAbilityShop = false })
			f(v, function(q, w, x)
				local y
				local z
				z = w.aid
				y = w.rarity
				r:learnAbility(z, true)
				Notification:combatToPlayer(
					s,
					{
						message = "notify_artifact_ability_" .. y,
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self._city_name,
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. z,
					}
				)
				CityEffect:addCityEffectAbilites(s, z, x == #v - 1)
			end)
		end)
	end
end
n = g(
	{
		k(
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
	n
)
i.modifier_city_7 = n
return i