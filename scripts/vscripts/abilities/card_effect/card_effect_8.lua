--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_8"
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
		["19"] = 9,
		["20"] = 9,
		["21"] = 9,
		["22"] = 9,
		["23"] = 9,
		["24"] = 9,
		["25"] = 4,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_8 = c()
local i = f.card_effect_8
i.name = "card_effect_8"
d(i, h)
function i.prototype.spawn(self)
	local j = self:getPlayerID()
	local k = self:getSpecialValueFor("regen")
	PlayerData:modifyHealth(j, k)
	local l = PlayerResource:GetSelectedHeroEntity(j)
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, l, k, l:GetPlayerOwner())
end
return f