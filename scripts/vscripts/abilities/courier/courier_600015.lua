--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/courier/courier_600015"
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
q.name = "courier_600015"
d(q, k)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_courier_600015"
end
q = e({ l(nil) }, q)
local r = c()
r.name = "modifier_courier_600015"
d(r, n)
function r.prototype.GetBuffModifierName(self)
	return "modifier_courier_600015_buff"
end
r = e({ i(a, p) }, r)
local s = c()
s.name = "modifier_courier_600015_buff"
d(s, h)
function s.prototype.EventListener(self)
	return {
		damage_event = function(t, u)
			if u == nil or not IsValid(u.ability) or u.damage_category ~= DOTA_DAMAGE_CATEGORY_SPELL then
				return
			end
			if not IsValid(self.ability) then
				return
			end
			local v = u.target
			if not IsValid(v) or not v:IsAlive() then
				return
			end
			if not self.ability:IsCooldownReady() then
				return
			end
			local w = self:GetParent()
			if not IsValid(w) then
				return
			end
			self.ability:StartCooldown(self:GetAbilitySpecialValueFor("cd"))
			w:Attack(v, { baseDamage = self:GetAbilitySpecialValueFor("bonus_spell_damage", self:GetParent()) })
		end,
	}
end
s = e({ i(a, o) }, s)
return f