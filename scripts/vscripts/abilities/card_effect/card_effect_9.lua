--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_9"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{ ["7"] = 1, ["8"] = 1, ["9"] = 3, ["10"] = 3, ["11"] = 3, ["12"] = 3, ["13"] = 5, ["14"] = 6, ["15"] = 6, ["16"] = 6, ["17"] = 6, ["18"] = 5 }
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_9 = c()
local i = f.card_effect_9
i.name = "card_effect_9"
d(i, h)
function i.prototype.spawn(self)
	AbilityShop:setPlayerAbilityShopFreeCount(self:getPlayerID(), 1)
end
return f