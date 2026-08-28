--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_74"
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
		["14"] = 7,
		["15"] = 8,
		["16"] = 9,
		["18"] = 5,
		["19"] = 12,
		["20"] = 13,
		["21"] = 14,
		["23"] = 3,
		["24"] = 12,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_74 = c()
local i = f.card_effect_74
i.name = "card_effect_74"
d(i, h)
function i.prototype.spawn(self)
	local j = PlayerResource:GetSelectedHeroEntity(self:getPlayerID())
	if IsValid(j) then
		self.buff = j:AddNewModifier(j, nil, "modifier_" .. self.cardName, {})
	end
end
function i.prototype.dispose(self)
	if IsValid(self.buff) then
		self.buff:Destroy()
	end
	h.prototype.dispose(self)
end
return f