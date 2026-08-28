--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_84"
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
		["18"] = 4,
		["19"] = 10,
		["20"] = 11,
		["21"] = 12,
		["22"] = 13,
		["23"] = 3,
		["24"] = 10,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_84 = c()
local i = f.card_effect_84
i.name = "card_effect_84"
d(i, h)
function i.prototype.spawn(self)
	local j = PlayerResource:GetSelectedHeroEntity(self:getPlayerID())
	if IsValid(j) then
		j:AddNewModifier(j, nil, "modifier_" .. self.cardName, {})
	end
end
function i.prototype.dispose(self)
	local k = self:getPlayerID()
	local j = PlayerResource:GetSelectedHeroEntity(k)
	j:RemoveModifierByName("modifier_" .. self.cardName)
	h.prototype.dispose(self)
end
return f