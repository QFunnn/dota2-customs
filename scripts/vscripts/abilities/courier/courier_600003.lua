--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/courier/courier_600003"
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
local q = "modifier_courier_600003_buff"
local r = c()
r.name = "courier_600003"
d(r, k)
function r.prototype.GetIntrinsicModifierName(self)
	return "modifier_courier_600003"
end
r = e({ l(nil) }, r)
local s = c()
s.name = "modifier_courier_600003"
d(s, n)
function s.prototype.GetBuffModifierName(self)
	return "modifier_courier_600003_buff"
end
s = e({ i(a, p) }, s)
local t = c()
t.name = "modifier_courier_600003_buff"
d(t, h)
function t.prototype.GetAbilitySpecialValue(self)
	self.damage_up_pct = self:GetAbilitySpecialValueFor("damage_up_pct")
end
function t.prototype.OnCreated(self, u)
	self.take_damage = false
end
function t.prototype.EventListener(self)
	return {
		dungeon_room_start = function(v, w)
			self.take_damage = false
		end,
		damage_event = function(v, w)
			if w.target == self:GetParent() then
				local x = w.damage or 0
				if x > 0 then
					self.take_damage = true
				end
			end
		end,
		dungeon_room_complete = function(v, w)
			if self.take_damage == false then
				self:IncrementStackCount()
				PropertySystem:AddStaticProperty(
					self:GetParent():entindex(),
					"damage_boost_mult",
					q,
					self.damage_up_pct * self:GetStackCount()
				)
			end
		end,
	}
end
t = e({ i(a, o) }, t)
return f