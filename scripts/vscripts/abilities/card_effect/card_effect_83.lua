--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_83"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__New
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 2,
		["11"] = 2,
		["12"] = 4,
		["13"] = 4,
		["14"] = 4,
		["15"] = 4,
		["16"] = 7,
		["17"] = 8,
		["18"] = 9,
		["19"] = 10,
		["20"] = 11,
		["21"] = 12,
		["22"] = 13,
		["23"] = 14,
		["24"] = 15,
		["27"] = 18,
		["28"] = 19,
		["29"] = 20,
		["30"] = 21,
		["31"] = 22,
		["35"] = 18,
		["36"] = 27,
		["37"] = 28,
		["38"] = 29,
		["39"] = 30,
		["40"] = 30,
		["41"] = 30,
		["42"] = 30,
		["43"] = 30,
		["44"] = 30,
		["45"] = 30,
		["46"] = 30,
		["48"] = 36,
		["50"] = 7,
	}
)
local g = {}
local h = require("class.weight_pool")
local i = h.CWeightPool
local j = require("abilities.card_effect.card_effect_base")
local k = j.CardEffectBase
g.card_effect_83 = c()
local l = g.card_effect_83
l.name = "card_effect_83"
d(l, k)
function l.prototype.spawn(self)
	local m = self:getPlayerID()
	local n = PlayerData:getHero(m)
	local o = e(i, {})
	local p = {}
	local q = n:getAbilityUpgradeData()
	for r, s in pairs(q) do
		if s.level == SECT_ABILITY_LEVEL[KeyValues.AbilityUpgradesKvs[r].rarity] then
			p[r] = true
		end
	end
	PlayerData:eachAlivePlayerHero(function(t, u, v)
		if v ~= m then
			for w, s in pairs(u:getAbilityUpgradeData()) do
				if not p[w] then
					o:add(w, s.level)
				end
			end
		end
	end)
	local r = o:random()
	if r then
		n:learnAbility(r, true)
		Notification:combatToPlayer(
			m,
			{
				message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[r].rarity),
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.cardName,
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. r,
			}
		)
	else
		Notification:combatToPlayer(
			m,
			{ message = "notify_enemy_ability_none", string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.cardName }
		)
	end
end
return g