--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_18"
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
		["17"] = 8,
		["18"] = 9,
		["19"] = 11,
		["20"] = 12,
		["21"] = 13,
		["23"] = 15,
		["24"] = 4,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_18 = c()
local i = f.card_effect_18
i.name = "card_effect_18"
d(i, h)
function i.prototype.spawn(self)
	local j = self:getPlayerID()
	local k = self:getSpecialValueFor("gold")
	local l = self:getSpecialValueFor("cost")
	PlayerData:modifyGold(j, k)
	local m = PlayerData.playerData[j].health
	local n = math.min(l, m - 1)
	if n > 0 then
		PlayerData:modifyHealth(j, -n, true)
	end
	Notification:combatToPlayer(
		j,
		{ message = "notify_bonus_gold", string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.cardName, int_gold = k }
	)
end
return f