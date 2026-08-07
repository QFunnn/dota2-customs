--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_9"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__DecorateLegacy
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 2,
		["12"] = 2,
		["14"] = 5,
		["15"] = 13,
		["16"] = 5,
		["17"] = 13,
		["18"] = 15,
		["19"] = 16,
		["20"] = 15,
		["21"] = 18,
		["22"] = 19,
		["23"] = 18,
		["24"] = 24,
		["25"] = 25,
		["26"] = 26,
		["27"] = 27,
		["28"] = 28,
		["29"] = 33,
		["30"] = 33,
		["31"] = 33,
		["32"] = 33,
		["33"] = 33,
		["34"] = 33,
		["35"] = 33,
		["36"] = 34,
		["37"] = 35,
		["38"] = 40,
		["39"] = 33,
		["40"] = 33,
		["41"] = 27,
		["43"] = 24,
		["44"] = 13,
		["45"] = 5,
		["46"] = 5,
		["47"] = 5,
		["48"] = 5,
		["49"] = 5,
		["50"] = 5,
		["51"] = 5,
		["52"] = 5,
		["53"] = 13,
		["55"] = 13,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.registerEOMModifier
local k = require("modifiers.city_effect.city_effect_modifier")
local l = k.CityEffectModifier
h.modifier_city_9 = c()
local m = h.modifier_city_9
m.name = "modifier_city_9"
d(m, l)
function m.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
end
function m.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 } }
end
function m.prototype.OnRoundChange(self, n)
	local o = n.round_number
	if o % self.round == 0 then
		PlayerData:eachAlivePlayerHero(function(p, q, r)
			local s = AbilityShop:getRandomAbility(
				r,
				1,
				{ specifyRarity = "r", isAbilityShop = false, specifyRarityIgnoreRule = true }
			)
			e(s, function(p, t, u)
				local v
				local w
				w = t.aid
				v = t.rarity
				q:learnAbility(w, true)
				Notification:combatToPlayer(
					r,
					{
						message = "notify_artifact_ability_" .. v,
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self._city_name,
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. w,
					}
				)
				CityEffect:addCityEffectAbilites(r, w, u == #s - 1)
			end)
		end)
	end
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
h.modifier_city_9 = m
return h