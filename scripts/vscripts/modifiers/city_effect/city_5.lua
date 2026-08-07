--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_5"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__DecorateLegacy
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 2,
		["10"] = 2,
		["11"] = 3,
		["12"] = 3,
		["14"] = 6,
		["15"] = 14,
		["16"] = 6,
		["17"] = 14,
		["18"] = 16,
		["19"] = 17,
		["20"] = 16,
		["21"] = 19,
		["22"] = 20,
		["23"] = 19,
		["24"] = 25,
		["25"] = 26,
		["26"] = 27,
		["27"] = 27,
		["28"] = 27,
		["29"] = 27,
		["30"] = 28,
		["31"] = 31,
		["32"] = 31,
		["33"] = 31,
		["34"] = 31,
		["35"] = 31,
		["36"] = 31,
		["37"] = 31,
		["38"] = 32,
		["39"] = 33,
		["40"] = 38,
		["41"] = 31,
		["42"] = 31,
		["44"] = 25,
		["45"] = 42,
		["46"] = 43,
		["47"] = 44,
		["48"] = 45,
		["49"] = 45,
		["50"] = 45,
		["51"] = 45,
		["52"] = 46,
		["53"] = 49,
		["54"] = 50,
		["55"] = 51,
		["56"] = 51,
		["57"] = 51,
		["58"] = 51,
		["59"] = 51,
		["60"] = 51,
		["61"] = 51,
		["62"] = 52,
		["63"] = 53,
		["64"] = 58,
		["65"] = 51,
		["66"] = 51,
		["70"] = 42,
		["71"] = 14,
		["72"] = 6,
		["73"] = 6,
		["74"] = 6,
		["75"] = 6,
		["76"] = 6,
		["77"] = 6,
		["78"] = 6,
		["79"] = 6,
		["80"] = 14,
		["82"] = 14,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.registerEOMModifier
local k = require("modifiers.city_effect.city_effect_modifier")
local l = k.CityEffectModifier
h.modifier_city_5 = c()
local m = h.modifier_city_5
m.name = "modifier_city_5"
d(m, l)
function m.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
end
function m.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_RANDOM] = { -1, -1 },
	}
end
function m.prototype.OnAbilityBuy(self, n)
	local o = n.heroclass.playerID
	if self:PRD(self.chance, "city_5_" .. tostring(o)) then
		local p = AbilityShop:getRandomAbility(o, 1, { isAbilityShop = false })
		e(p, function(q, r, s)
			local t
			local u
			u = r.aid
			t = r.rarity
			n.heroclass:learnAbility(u, true)
			Notification:combatToPlayer(
				o,
				{
					message = "notify_artifact_ability_" .. t,
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self._city_name,
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. u,
				}
			)
			CityEffect:addCityEffectAbilites(o, u, s == #p - 1)
		end)
	end
end
function m.prototype.OnAbilityRandom(self, v)
	local o = v and v.playerID
	if type(o) == "number" then
		if self:PRD(self.chance, "city_5_" .. tostring(o)) then
			local p = AbilityShop:getRandomAbility(o, 1, { isAbilityShop = false })
			local w = PlayerData:getHero(o)
			if w then
				e(p, function(q, r, s)
					local t
					local u
					u = r.aid
					t = r.rarity
					w:learnAbility(u, true)
					Notification:combatToPlayer(
						o,
						{
							message = "notify_artifact_ability_" .. t,
							string_itemname_artifact = "DOTA_Tooltip_ability_" .. self._city_name,
							string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. u,
						}
					)
					CityEffect:addCityEffectAbilites(o, u, s == #p - 1)
				end)
			end
		end
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
h.modifier_city_5 = m
return h