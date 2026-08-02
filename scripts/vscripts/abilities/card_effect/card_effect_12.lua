--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_12"
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
		["18"] = 10,
		["19"] = 11,
		["20"] = 12,
		["21"] = 13,
		["22"] = 8,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_12 = c()
local i = f.card_effect_12
i.name = "card_effect_12"
d(i, h)
function i.prototype.spawn(self)
	self.id = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE, self.OnRoundChange)
end
function i.prototype.OnRoundChange(self, j)
	local k = self:getPlayerID()
	local l = self:getSpecialValueFor("count")
	PlayerData:ModifyFreeRefresh(k, l)
	PlayerData:ModifyFreeRefreshByKey(k, "card_effect_12", l)
	self:RemoveModifierEvent(self.id)
end
return f