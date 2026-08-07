--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_buff"
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
		["13"] = 6,
		["14"] = 7,
		["15"] = 6,
		["16"] = 10,
		["17"] = 14,
		["18"] = 14,
		["19"] = 15,
		["22"] = 18,
		["23"] = 19,
		["24"] = 10,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_buff = c()
local i = f.card_effect_buff
i.name = "card_effect_buff"
d(i, h)
function i.prototype.spawn(self)
	self.id = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_CONFIRM_BATTLE, self.OnConfirmBattle)
end
function i.prototype.OnConfirmBattle(self, j)
	local k = PlayerData:getHero(self:getPlayerID())
	local l = k and k.hero
	if not IsValid(l) then
		return
	end
	l:AddNewModifier(l, nil, "modifier_" .. self.cardName, {})
	self:RemoveModifierEvent(self.id)
end
return f