--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_17"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{ ["7"] = 1, ["8"] = 1, ["9"] = 3, ["10"] = 3, ["11"] = 3, ["12"] = 3, ["13"] = 4, ["14"] = 5, ["15"] = 4 }
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_17 = c()
local i = f.card_effect_17
i.name = "card_effect_17"
d(i, h)
function i.prototype.spawn(self)
	AbilityShop:refreshShop(self:getPlayerID())
end
return f