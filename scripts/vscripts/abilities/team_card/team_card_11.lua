--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/team_card/team_card_11"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringSplit
local f = b.__TS__New
local g = b.__TS__ArraySome
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 4,
		["15"] = 4,
		["16"] = 4,
		["17"] = 4,
		["18"] = 6,
		["19"] = 7,
		["20"] = 8,
		["21"] = 9,
		["22"] = 10,
		["23"] = 11,
		["24"] = 12,
		["25"] = 13,
		["27"] = 15,
		["29"] = 17,
		["30"] = 18,
		["31"] = 19,
		["32"] = 20,
		["33"] = 20,
		["34"] = 20,
		["35"] = 20,
		["36"] = 21,
		["39"] = 24,
		["40"] = 25,
		["41"] = 26,
		["43"] = 6,
	}
)
local i = {}
local j = require("class.weight_pool")
local k = j.CWeightPool
local l = require("abilities.card_effect.card_effect_base")
local m = l.CardEffectBase
i.team_card_11 = c()
local n = i.team_card_11
n.name = "team_card_11"
d(n, m)
function n.prototype.spawn(self)
	if IsServer() then
		local o = GroupTeam:GetTeammatePlayerID(self.playerID)
		local p = PlayerData:getHero(o)
		local q = AbilityShop:GetRecommendSectByHeroName(p.unitName)
		local r
		if q ~= "sect_none" then
			r = e(q, "|")
		else
			r = PickList(AbilityShop.pickList, 1, false)
		end
		self.recommendSect = r[RandomInt(0, #r - 1) + 1]
		local s = f(k, {})
		for t, u in pairs(KeyValues.AbilityUpgradesKvs) do
			if
				u.rarity == "n"
				and (string.find(u.sect, "|", nil, true) or 0) - 1 == -1
				and self.recommendSect == u.sect
				and g(AbilityShop.pickList, function(v, w)
					return (string.find(u.sect, w, nil, true) or 0) - 1 ~= -1
				end)
			then
				s:add(t, 1)
			end
		end
		local x = s:random()
		PlayerData:getHero(o):learnAbility(x, true)
		Notification:combatToPlayer(
			o,
			{
				message = "notify_artifact_ability_n",
				string_itemname_artifact = "DOTA_Tooltip_ability_team_card_11",
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. x,
			}
		)
	end
end
return i