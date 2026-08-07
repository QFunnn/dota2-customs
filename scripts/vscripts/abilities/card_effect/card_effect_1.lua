--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["7"] = 1,
		["8"] = 1,
		["9"] = 3,
		["10"] = 3,
		["11"] = 3,
		["12"] = 3,
		["13"] = 4,
		["14"] = 5,
		["15"] = 6,
		["16"] = 7,
		["17"] = 28,
		["18"] = 33,
		["19"] = 34,
		["20"] = 35,
		["21"] = 36,
		["22"] = 36,
		["23"] = 37,
		["24"] = 38,
		["26"] = 39,
		["27"] = 39,
		["28"] = 40,
		["29"] = 41,
		["30"] = 41,
		["31"] = 41,
		["32"] = 41,
		["33"] = 41,
		["34"] = 41,
		["35"] = 41,
		["36"] = 41,
		["37"] = 39,
		["41"] = 4,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_1 = c()
local i = f.card_effect_1
i.name = "card_effect_1"
d(i, h)
function i.prototype.spawn(self)
	local j = self:getPlayerID()
	local k = PlayerData:getHero(j)
	local l = k:getAbilityUpgradeData()
	local m = AbilityShop:getRandomAbility(
		j,
		1,
		{ isAbilityShop = false, specifyRarity = "n", specifyRarityIgnoreRule = true }
	)
	if m[1] then
		local n = m[1].aid
		local o = KeyValues.AbilityUpgradesKvs[n]
		local p = l[n]
		local q = p and p.level or 0
		local r = SECT_ABILITY_LEVEL[o.rarity]
		local s = r - q
		do
			local t = 0
			while t < s do
				k:learnAbility(n, true)
				Notification:combatToPlayer(
					j,
					{
						message = "notify_artifact_ability_" .. tostring(o.rarity),
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.cardName,
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. n,
					}
				)
				t = t + 1
			end
		end
	end
end
return f