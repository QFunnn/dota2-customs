--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_item_repalce"
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
		["19"] = 6,
		["20"] = 13,
		["21"] = 14,
		["22"] = 15,
		["23"] = 16,
		["24"] = 17,
		["26"] = 3,
		["27"] = 13,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_item_repalce = c()
local i = f.card_effect_item_repalce
i.name = "card_effect_item_repalce"
d(i, h)
function i.prototype.spawn(self)
	local j = self:getPlayerID()
	local k = PlayerData:getHero(j)
	self.item_name = "item_equipment_" .. tostring(self:getSpecialValueFor("item"))
	self.level = self:getSpecialValueFor("level")
	k:modifyOverrideItem(self.item_name, self.level)
end
function i.prototype.dispose(self)
	local j = self:getPlayerID()
	local k = PlayerData:getHero(j)
	if k then
		k:modifyOverrideItem(self.item_name, self.level, true)
	end
	h.prototype.dispose(self)
end
return f