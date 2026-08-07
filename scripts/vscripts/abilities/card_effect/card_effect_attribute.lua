--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_attribute"
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
		["14"] = 6,
		["15"] = 7,
		["17"] = 9,
		["19"] = 5,
		["20"] = 12,
		["21"] = 13,
		["22"] = 14,
		["23"] = 15,
		["24"] = 15,
		["25"] = 15,
		["26"] = 15,
		["27"] = 16,
		["28"] = 17,
		["29"] = 18,
		["31"] = 12,
		["32"] = 21,
		["33"] = 22,
		["34"] = 23,
		["35"] = 24,
		["36"] = 25,
		["37"] = 25,
		["38"] = 25,
		["39"] = 25,
		["41"] = 3,
		["42"] = 21,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_attribute = c()
local i = f.card_effect_attribute
i.name = "card_effect_attribute"
d(i, h)
function i.prototype.spawn(self)
	if GameState:getStateName() == "GameState_Battle" then
		self.id = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE, self.OnPrepare)
	else
		self:OnPrepare({})
	end
end
function i.prototype.OnPrepare(self, j)
	local k = self:getPlayerID()
	local l = PlayerData:getHero(k)
	l:addProperty(self:getSpecialValueFor("attribute"), self:getSpecialValueFor("value"))
	if self.id then
		self:RemoveModifierEvent(self.id)
		self.id = nil
	end
end
function i.prototype.dispose(self)
	local k = self:getPlayerID()
	local l = PlayerData:getHero(k)
	if l then
		l:removeProperty(self:getSpecialValueFor("attribute"), self:getSpecialValueFor("value"))
	end
	h.prototype.dispose(self)
end
return f