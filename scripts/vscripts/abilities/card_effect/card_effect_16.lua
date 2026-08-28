--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_16"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{ ["7"] = 1, ["8"] = 1, ["9"] = 3, ["10"] = 3, ["11"] = 3, ["12"] = 3, ["13"] = 4, ["14"] = 5, ["15"] = 6, ["16"] = 7, ["17"] = 8, ["18"] = 4 }
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_16 = c()
local i = f.card_effect_16
i.name = "card_effect_16"
d(i, h)
function i.prototype.spawn(self)
	local j = self:getPlayerID()
	local k = self:getSpecialValueFor("count")
	PlayerData:ModifyFreeRefresh(j, k)
	PlayerData:ModifyFreeRefreshByKey(j, "card_effect_15", k)
end
return f