--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_28"
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
		["15"] = 7,
		["16"] = 8,
		["17"] = 9,
		["18"] = 10,
		["19"] = 11,
		["20"] = 12,
		["21"] = 13,
		["22"] = 5,
		["23"] = 15,
		["24"] = 16,
		["25"] = 17,
		["26"] = 18,
		["27"] = 3,
		["28"] = 15,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_28 = c()
local i = f.card_effect_28
i.name = "card_effect_28"
d(i, h)
function i.prototype.spawn(self)
	local j = self:getPlayerID()
	local k = PlayerData:getHero(j)
	local l = IsTurboMode(nil) and NEUTRAL_ROUND_TURBO or NEUTRAL_ROUND
	local m = IsTurboMode(nil) and NEUTRAL_LEVEL_TURBO or NEUTRAL_LEVEL
	local n = NEUTRAL_DROP_ITEM_LEVEL[m[table.remove(shallowcopy(l))]]
	local o = PlayerData:getEquipmentPoolWithLevel(j, n)
	self.item_name = o:random()
	k:modifyOverrideItem(self.item_name, 1)
end
function i.prototype.dispose(self)
	local j = self:getPlayerID()
	local k = PlayerData:getHero(j)
	k:modifyOverrideItem(self.item_name, 1, true)
	h.prototype.dispose(self)
end
return f