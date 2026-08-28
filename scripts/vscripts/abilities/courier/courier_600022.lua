--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/courier/courier_600022"
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
q.name = "courier_600022"
d(q, k)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_courier_600022"
end
q = e({ l(nil) }, q)
local r = c()
r.name = "modifier_courier_600022"
d(r, n)
function r.prototype.GetBuffModifierName(self)
	return "modifier_courier_600022_buff"
end
r = e({ i(a, p) }, r)
local s = c()
s.name = "modifier_courier_600022_buff"
d(s, h)
function s.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function s.prototype.EventListener(self)
	return {
		dash_start = function(t, u)
			local v = self:GetParent()
			if u.caster ~= v then
				return
			end
			v:AddNewModifier(v, self:GetAbility(), "modifier_courier_600022_effect", { duration = self.duration })
		end,
	}
end
s = e({ i(a, o) }, s)
local w = c()
w.name = "modifier_courier_600022_effect"
d(w, h)
function w.prototype.GetAbilitySpecialValue(self)
	self.damage_up_pct = self:GetAbilitySpecialValueFor("damage_up_pct")
end
function w.prototype.StaticProperty(self)
	return { [PropertyFunction.SKILL_DAMAGE_AMPLIFY] = self.damage_up_pct }
end
w = e({ i(a, o) }, w)
return f