--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_26"
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
		["18"] = 8,
		["19"] = 8,
		["20"] = 8,
		["21"] = 8,
		["22"] = 8,
		["23"] = 9,
		["24"] = 4,
		["25"] = 11,
		["26"] = 12,
		["27"] = 13,
		["28"] = 14,
		["29"] = 3,
		["30"] = 11,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_26 = c()
local i = f.card_effect_26
i.name = "card_effect_26"
d(i, h)
function i.prototype.spawn(self)
	local j = self:getPlayerID()
	local k = PlayerResource:GetSelectedHeroEntity(j)
	local l = self:getSpecialValueFor("chance")
	local m = k:AddNewModifier(k, k:GetDummyAbility(), "modifier_card_effect_26", {})
	m:SetStackCount(l * 10)
end
function i.prototype.dispose(self)
	local j = self:getPlayerID()
	local k = PlayerResource:GetSelectedHeroEntity(j)
	k:RemoveModifierByName("modifier_card_effect_26")
	h.prototype.dispose(self)
end
return f