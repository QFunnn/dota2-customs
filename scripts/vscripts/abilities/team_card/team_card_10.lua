--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/team_card/team_card_10"
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
		["14"] = 5,
		["15"] = 6,
		["16"] = 7,
		["17"] = 8,
		["18"] = 9,
		["19"] = 10,
		["20"] = 11,
		["21"] = 12,
		["23"] = 14,
		["25"] = 16,
		["26"] = 17,
		["27"] = 18,
		["28"] = 19,
		["29"] = 20,
		["31"] = 5,
	}
)
local g = {}
local h = require("abilities.card_effect.card_effect_base")
local i = h.CardEffectBase
g.team_card_10 = c()
local j = g.team_card_10
j.name = "team_card_10"
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
		self.recommendSect = n[RandomInt(0, #n - 1) + 1]
		local o = AbilityShop:getAbilityPoolNew("n", self.recommendSect, AbilityShop.banList, false)
		local p = o:random()
		l:learnAbility(p, true)
		Notification:combatToPlayer(
			k,
			{
				message = "notify_artifact_ability_n",
				string_itemname_artifact = "DOTA_Tooltip_ability_team_card_10",
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. p,
			}
		)
	end
end
return g