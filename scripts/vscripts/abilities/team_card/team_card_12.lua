--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/team_card/team_card_12"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringSplit
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 3,
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
		["14"] = 4,
		["15"] = 5,
		["16"] = 6,
		["17"] = 7,
		["18"] = 8,
		["19"] = 9,
		["20"] = 10,
		["21"] = 11,
		["23"] = 13,
		["25"] = 15,
		["26"] = 16,
		["27"] = 21,
		["28"] = 22,
		["29"] = 23,
		["30"] = 24,
		["32"] = 30,
		["35"] = 4,
	}
)
local g = {}
local h = require("abilities.card_effect.card_effect_base")
local i = h.CardEffectBase
g.team_card_12 = c()
local j = g.team_card_12
j.name = "team_card_12"
d(j, i)
function j.prototype.spawn(self)
	if IsServer() then
		local k = GroupTeam:GetTeammatePlayerID(self.playerID)
		local l = PlayerData:getHero(k)
		local m = AbilityShop:GetRecommendSectByHeroName(l.unitName)
		local n
		if m ~= "sect_none" then
			n = e(m, "|")
		else
			n = PickList(AbilityShop.pickList, 1, false)
		end
		local o = n[RandomInt(0, #n - 1) + 1]
		local p = AbilityShop:getRandomAbility(
			k,
			1,
			{ specifySect = { o }, isAbilityShop = false, specifyRarityIgnoreRule = true }
		)
		local q = p[1]
		if q then
			PlayerData:getHero(k):learnAbility(q.aid, true)
			Notification:combatToPlayer(
				k,
				{
					message = "notify_artifact_ability_" .. q.rarity,
					string_itemname_artifact = "DOTA_Tooltip_ability_team_card_12",
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. q.aid,
				}
			)
		else
			Notification:combatToPlayer(
				k,
				{
					message = "notify_enemy_ability_self_none",
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.cardName,
				}
			)
		end
	end
end
return g