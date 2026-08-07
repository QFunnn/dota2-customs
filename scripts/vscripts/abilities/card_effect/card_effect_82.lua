--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_82"
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
		["13"] = 6,
		["14"] = 7,
		["15"] = 8,
		["16"] = 9,
		["17"] = 10,
		["18"] = 11,
		["19"] = 12,
		["20"] = 17,
		["21"] = 6,
		["22"] = 19,
		["23"] = 20,
		["24"] = 21,
		["25"] = 22,
		["26"] = 3,
		["27"] = 19,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_82 = c()
local i = f.card_effect_82
i.name = "card_effect_82"
d(i, h)
function i.prototype.spawn(self)
	local j = self:getPlayerID()
	local k = PlayerData:getHero(j)
	self.level = self:getSpecialValueFor("level")
	local l = PlayerData:getEquipmentPoolWithLevel(j, self.level)
	self.item_name = l:random()
	Notification:combatToPlayer(
		j,
		{
			message = "notify_card_effect",
			string_card1 = "DOTA_Tooltip_ability_card_effect_82",
			string_card2 = "DOTA_Tooltip_ability_" .. self.item_name,
		}
	)
	k:modifyOverrideItem(self.item_name, self.level)
end
function i.prototype.dispose(self)
	local j = self:getPlayerID()
	local k = PlayerData:getHero(j)
	k:modifyOverrideItem(self.item_name, self.level, true)
	h.prototype.dispose(self)
end
return f