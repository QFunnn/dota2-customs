--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/courier/courier_600002"
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
q.name = "courier_600002"
d(q, k)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_courier_600002"
end
q = e({ l(nil) }, q)
local r = c()
r.name = "modifier_courier_600002"
d(r, n)
function r.prototype.GetBuffModifierName(self)
	return "modifier_courier_600002_buff"
end
r = e({ i(a, p) }, r)
local s = c()
s.name = "modifier_courier_600002_buff"
d(s, h)
function s.prototype.GetAbilitySpecialValue(self)
	self.damage_pct = self:GetAbilitySpecialValueFor("damage_pct")
end
function s.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.DAMAGE_BOOST_MULT] = function(t, u)
			if u ~= nil and IsValid(u.target) and u.target:GetHealthPercent() >= 100 then
				return self.damage_pct
			end
		end,
	}
end
s = e({ i(a, o) }, s)
return f