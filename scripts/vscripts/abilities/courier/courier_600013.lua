--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/courier/courier_600013"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.AbilityValue
local l = j.EOMAbility
local m = j.registerEOMAbility
local n = require("abilities.courier.courier_base")
local o = n.CourierModifierBase
local p = n.CourierBuffConfig
local q = n.CourierMainConfig
local r = c()
r.name = "courier_600013"
d(r, l)
function r.prototype.GetIntrinsicModifierName(self)
	return "modifier_courier_600013"
end
r = e({ m(nil) }, r)
local s = c()
s.name = "modifier_courier_600013"
d(s, o)
function s.prototype.GetBuffModifierName(self)
	return "modifier_courier_600013_buff"
end
s = e({ i(a, q) }, s)
local t = c()
t.name = "modifier_courier_600013_buff"
d(t, h)
function t.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.DAMAGE_BOOST_MULT] = function(u, v)
			if
				v ~= nil
				and IsValid(v.ability)
				and (v.ability:GetAbilityTag() == AbilityTag.Attack or v.ability:GetAbilityTag() == AbilityTag.Skill)
			then
				local w = self:GetParent()
				return w:GetMoveSpeedModifier(w:GetBaseMoveSpeed(), false) / self.threshold * self.damage_pct
			end
		end,
	}
end
e({ k(nil) }, t.prototype, "damage_pct", nil)
e({ k(nil) }, t.prototype, "threshold", nil)
t = e({ i(a, p) }, t)
return f