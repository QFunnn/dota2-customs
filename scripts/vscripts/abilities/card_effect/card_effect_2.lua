--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_2"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__Delete
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
		["22"] = 13,
		["23"] = 14,
		["26"] = 17,
		["28"] = 18,
		["29"] = 18,
		["30"] = 19,
		["31"] = 20,
		["32"] = 21,
		["33"] = 22,
		["35"] = 18,
		["38"] = 4,
	}
)
local g = {}
local h = require("abilities.card_effect.card_effect_base")
local i = h.CardEffectBase
g.card_effect_2 = c()
local j = g.card_effect_2
j.name = "card_effect_2"
d(j, i)
function j.prototype.spawn(self)
	local k = self:getPlayerID()
	local l = PlayerData:getplayerData(k)
	local m = PlayerData:getHero(k)
	local n = self:getSpecialValueFor("count")
	local o = AbilityShop:getAbilityPoolNew("n", nil, { l.bannedSect })
	for p, n in pairs(o.tList) do
		m:getAbilityUpgradeLevel(tostring(p))
		if m:getAbilityUpgradeLevel(tostring(p)) >= SECT_ABILITY_LEVEL[KeyValues.AbilityUpgradesKvs[p].rarity] then
			e(o.tList, p)
		end
	end
	o:update()
	do
		local q = 0
		while q < n do
			local r = o:random()
			if r then
				m:learnAbility(r, true)
				Notification:combatToPlayer(
					k,
					{
						message = "notify_artifact_ability_n",
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.cardName,
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. r,
					}
				)
			end
			q = q + 1
		end
	end
end
return g