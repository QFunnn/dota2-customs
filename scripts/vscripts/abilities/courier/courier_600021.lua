--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/courier/courier_600021"
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
q.name = "courier_600021"
d(q, k)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_courier_600021"
end
q = e({ l(nil) }, q)
local r = c()
r.name = "modifier_courier_600021"
d(r, n)
function r.prototype.GetBuffModifierName(self)
	return "modifier_courier_600021_buff"
end
r = e({ i(a, p) }, r)
local s = c()
s.name = "modifier_courier_600021_buff"
d(s, h)
function s.prototype.GetAbilitySpecialValue(self)
	self.refund_pct = self:GetAbilitySpecialValueFor("refund_pct")
end
function s.prototype.StaticProperty(self)
	return { [PropertyFunction.SHOP_REFRESH_REFUND] = self.refund_pct }
end
s = e({ i(a, o) }, s)
return f