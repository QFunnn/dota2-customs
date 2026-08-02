--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_48"
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
		["17"] = 11,
		["18"] = 11,
		["19"] = 12,
		["22"] = 15,
		["23"] = 16,
		["24"] = 10,
		["25"] = 19,
		["26"] = 3,
		["27"] = 21,
		["28"] = 19,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_48 = c()
local i = f.card_effect_48
i.name = "card_effect_48"
d(i, h)
function i.prototype.spawn(self)
	self.id = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_CONFIRM_BATTLE, self.OnConfirmBattle)
end
function i.prototype.OnConfirmBattle(self, j)
	local k = PlayerData:getHero(self:getPlayerID())
	local hero = k and k.hero
	if not IsValid(hero) then
		return
	end
	hero:AddNewModifier(hero, nil, "modifier_" .. self.cardName, {})
	self:RemoveModifierEvent(self.id)
end
function i.prototype.dispose(self)
	h.prototype.dispose(self)
	hero:RemoveModifierByName("modifier_" .. self.cardName)
end
return f