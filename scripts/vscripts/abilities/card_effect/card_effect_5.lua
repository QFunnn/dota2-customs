--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_5"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringSplit
local f = b.__TS__ArrayForEach
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
		["14"] = 3,
		["15"] = 4,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 9,
		["21"] = 10,
		["22"] = 11,
		["23"] = 12,
		["25"] = 14,
		["27"] = 16,
		["28"] = 17,
		["29"] = 18,
		["30"] = 20,
		["31"] = 23,
		["34"] = 26,
		["35"] = 26,
		["36"] = 26,
		["37"] = 27,
		["38"] = 28,
		["39"] = 26,
		["40"] = 26,
		["42"] = 4,
	}
)
local h = {}
local i = require("abilities.card_effect.card_effect_base")
local j = i.CardEffectBase
h.card_effect_5 = c()
local k = h.card_effect_5
k.name = "card_effect_5"
d(k, j)
function k.prototype.spawn(self)
	local l = self:getPlayerID()
	local m = PlayerData:getplayerData(l)
	local n = m.hero
	local o = {}
	local p = AbilityShop:GetRecommendSectByHeroName(n.unitName)
	local q = {}
	if p == "sect_none" then
		q = AbilityShop.pickList
	else
		q = e(p, "|")
	end
	local r = q[RandomInt(0, #q - 1) + 1]
	if r ~= nil then
		for s, t in pairs(KeyValues.AbilityUpgradesKvs) do
			if t.rarity == "n" and t.sect == r then
				o[#o + 1] = s
			end
		end
		f(o, function(u, v)
			n:learnAbility(v, true)
			Notification:combatToPlayer(
				l,
				{
					message = "notify_artifact_ability_n",
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.cardName,
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. v,
				}
			)
		end)
	end
end
return h