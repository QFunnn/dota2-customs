--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_30"
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
		["13"] = 5,
		["14"] = 6,
		["15"] = 5,
		["16"] = 8,
		["17"] = 9,
		["20"] = 12,
		["21"] = 13,
		["22"] = 14,
		["23"] = 15,
		["24"] = 16,
		["26"] = 22,
		["27"] = 23,
		["28"] = 24,
		["30"] = 8,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_30 = c()
local i = f.card_effect_30
i.name = "card_effect_30"
d(i, h)
function i.prototype.spawn(self)
	self.id = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END, self.OnBattleEnd)
end
function i.prototype.OnBattleEnd(self, j)
	if j.isNeutral ~= nil then
		return
	end
	local k = self:getPlayerID()
	if j.winPlayerID == k and j.illusionPlayerID ~= j.winPlayerID then
		local l = self:getSpecialValueFor("gold")
		PlayerData:modifyGold(k, l)
		Notification:combatToPlayer(
			k,
			{ message = "notify_bonus_gold", string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.cardName, int_gold = l }
		)
	end
	local m = j.illusionPlayerID ~= k and (k == j.winPlayerID or k == j.losePlayerID)
	if m then
		self:RemoveModifierEvent(self.id)
	end
end
return f