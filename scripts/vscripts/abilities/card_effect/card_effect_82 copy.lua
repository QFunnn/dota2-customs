--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/abilities/card_effect/card_effect_82 copy.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__Class
local e = c.__TS__ClassExtends
local f = c.__TS__SourceMapTraceBack
f(
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
		["19"] = 13,
		["20"] = 6,
		["21"] = 15,
		["22"] = 16,
		["23"] = 17,
		["24"] = 18,
		["25"] = 15,
	}
)
local g = {}
local h = require("abilities.card_effect.card_effect_base")
local i = h.CardEffectBase
g.card_effect_82 = d()
local j = g.card_effect_82
j.name = "card_effect_82"
e(j, i)
function j.prototype.spawn(self)
	local k = self:getPlayerID()
	local l = PlayerData:getHero(k)
	self.level = self:getSpecialValueFor("level")
	local m = PlayerData:getEquipmentPoolWithLevel(k, self.level)
	self.item_name = m:random()
	l:modifyOverrideItem(self.item_name, self.level)
end
function j.prototype.dispose(self)
	local k = self:getPlayerID()
	local l = PlayerData:getHero(k)
	l:modifyOverrideItem(self.item_name, self.level, true)
end
return g