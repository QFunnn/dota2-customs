--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/courier/courier_600017"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.EOMAbility
local l = j.registerEOMAbility
local m = require("abilities.courier.courier_base")
local n = m.CourierModifierBase
local o = m.CourierBuffConfig
local p = m.CourierMainConfig
local q = c()
q.name = "courier_600017"
d(q, k)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_courier_600017"
end
q = e({ l(nil) }, q)
local r = c()
r.name = "modifier_courier_600017"
d(r, n)
function r.prototype.GetBuffModifierName(self)
	return "modifier_courier_600017_buff"
end
r = e({ i(a, p) }, r)
local s = c()
s.name = "modifier_courier_600017_buff"
d(s, h)
function s.prototype.GetAbilitySpecialValue(self)
	self.bonus_attack = self:GetAbilitySpecialValueFor("bonus_attack")
	self.bonus_health = self:GetAbilitySpecialValueFor("bonus_health")
end
function s.prototype.EventListener(self)
	return {
		item_added = function(t, u)
			if u.unit == self:GetParent() and KeyValues.artifact[u.item:GetName()] ~= nil then
				self:IncrementStackCount()
			end
		end,
		item_consumed = function(t, u)
			if u.unit == self:GetParent() and KeyValues.artifact[u.item:GetName()] ~= nil then
				self:DecrementStackCount()
			end
		end,
		dungeon_start = function(t, v)
			self:SetStackCount(0)
		end,
	}
end
function s.prototype.StaticProperty(self)
	return {
		[PropertyFunction.ATTACK] = self.bonus_attack * self:GetStackCount(),
		[PropertyFunction.HEALTH] = self.bonus_health * self:GetStackCount(),
	}
end
s = e({ i(a, o) }, s)
return f