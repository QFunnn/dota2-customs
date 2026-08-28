--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_26"
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
		["20"] = 13,
		["21"] = 15,
		["22"] = 5,
		["23"] = 16,
		["24"] = 17,
		["25"] = 16,
		["26"] = 19,
		["27"] = 20,
		["28"] = 19,
		["29"] = 24,
		["30"] = 25,
		["31"] = 26,
		["32"] = 27,
		["33"] = 29,
		["34"] = 30,
		["35"] = 31,
		["36"] = 32,
		["38"] = 34,
		["40"] = 36,
		["41"] = 40,
		["42"] = 40,
		["43"] = 40,
		["44"] = 40,
		["45"] = 40,
		["46"] = 40,
		["47"] = 40,
		["48"] = 41,
		["49"] = 42,
		["50"] = 47,
		["51"] = 40,
		["52"] = 40,
		["53"] = 27,
		["55"] = 24,
		["56"] = 13,
		["57"] = 5,
		["58"] = 5,
		["59"] = 5,
		["60"] = 5,
		["61"] = 5,
		["62"] = 5,
		["63"] = 5,
		["64"] = 5,
		["65"] = 13,
		["67"] = 13,
	}
)
local i = {}
local j = require("modifiers.eom_modifier")
local k = j.registerEOMModifier
local l = require("modifiers.city_effect.city_effect_modifier")
local m = l.CityEffectModifier
i.modifier_city_26 = c()
local n = i.modifier_city_26
n.name = "modifier_city_26"
d(n, m)
function n.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.enable = true
end
function n.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
end
function n.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function n.prototype.OnRoundStart(self, o)
	if self.enable then
		self.enable = false
		PlayerData:eachAlivePlayerHero(function(p, q, r)
			local s = AbilityShop:GetRecommendSectByHeroName(q.unitName)
			local t = {}
			if s ~= "sect_none" then
				t = e(s, "|")
			else
				t = AbilityShop.pickList
			end
			local u = AbilityShop:getRandomAbility(r, self.count, { specifySect = t, isAbilityShop = false })
			f(u, function(p, v, w)
				local x
				local y
				y = v.aid
				x = v.rarity
				q:learnAbility(y, true)
				Notification:combatToPlayer(
					r,
					{
						message = "notify_artifact_ability_" .. x,
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self._city_name,
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. y,
					}
				)
				CityEffect:addCityEffectAbilites(r, y, w == #u - 1)
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
i.modifier_city_26 = n
return i