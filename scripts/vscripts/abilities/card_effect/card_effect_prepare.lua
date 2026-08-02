--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_prepare"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["7"] = 1,
		["8"] = 1,
		["9"] = 4,
		["10"] = 4,
		["11"] = 4,
		["12"] = 4,
		["13"] = 6,
		["14"] = 7,
		["15"] = 8,
		["17"] = 10,
		["19"] = 6,
		["20"] = 13,
		["21"] = 14,
		["22"] = 15,
		["23"] = 16,
		["25"] = 18,
		["26"] = 13,
		["27"] = 22,
		["28"] = 22,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_prepare = c()
local i = f.card_effect_prepare
i.name = "card_effect_prepare"
d(i, h)
function i.prototype.spawn(self)
	if not GameState:isCeaseFireState() then
		self.id = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END, self.OnBattleEnd)
	else
		self:effect()
	end
end
function i.prototype.OnBattleEnd(self, j)
	if self.id then
		self:RemoveModifierEvent(self.id)
		self.id = nil
	end
	self:effect()
end
function i.prototype.effect(self) end
return f