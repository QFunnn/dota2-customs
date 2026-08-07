--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_33"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringSplit
local f = b.__TS__DecorateLegacy
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 2,
		["12"] = 2,
		["13"] = 4,
		["14"] = 12,
		["15"] = 4,
		["16"] = 12,
		["17"] = 14,
		["18"] = 15,
		["19"] = 14,
		["20"] = 17,
		["21"] = 18,
		["22"] = 17,
		["23"] = 22,
		["24"] = 23,
		["25"] = 24,
		["26"] = 25,
		["27"] = 26,
		["28"] = 27,
		["29"] = 28,
		["31"] = 30,
		["33"] = 32,
		["35"] = 37,
		["36"] = 37,
		["37"] = 38,
		["38"] = 39,
		["39"] = 40,
		["40"] = 40,
		["41"] = 40,
		["42"] = 40,
		["43"] = 40,
		["44"] = 40,
		["45"] = 40,
		["46"] = 40,
		["47"] = 45,
		["48"] = 37,
		["52"] = 23,
		["53"] = 22,
		["54"] = 12,
		["55"] = 4,
		["56"] = 4,
		["57"] = 4,
		["58"] = 4,
		["59"] = 4,
		["60"] = 4,
		["61"] = 4,
		["62"] = 4,
		["63"] = 12,
		["65"] = 12,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.registerEOMModifier
local k = require("modifiers.city_effect.city_effect_modifier")
local l = k.CityEffectModifier
h.modifier_city_33 = c()
local m = h.modifier_city_33
m.name = "modifier_city_33"
d(m, l)
function m.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
end
function m.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BUY_EFFECT_CARD] = { -1, -1 } }
end
function m.prototype.OnBuyEffectCard(self, n)
	PlayerData:eachAlivePlayerHero(function(o, p, q)
		if q == n.playerID then
			local r = AbilityShop:GetRecommendSectByHeroName(p.unitName)
			local s = {}
			if r ~= "sect_none" then
				s = e(r, "|")
			else
				s = AbilityShop.pickList
			end
			local t = AbilityShop:getRandomAbility(
				q,
				1,
				{ specifySect = s, isAbilityShop = false, specifyRarityIgnoreRule = true }
			)
			do
				local u = 0
				while u < #t do
					local v = t[u + 1]
					p:learnAbility(v.aid, true)
					Notification:combatToPlayer(
						q,
						{
							message = "notify_artifact_ability_" .. v.rarity,
							string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetCityName(),
							string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. v.aid,
						}
					)
					CityEffect:addCityEffectAbilites(q, v.aid, u == #t - 1)
					u = u + 1
				end
			end
		end
	end)
end
m = f(
	{
		j(
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
	m
)
h.modifier_city_33 = m
return h