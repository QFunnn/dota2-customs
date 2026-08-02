--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/courier/courier_600018"
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
q.name = "courier_600018"
d(q, k)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_courier_600018"
end
q = e({ l(nil) }, q)
local r = c()
r.name = "modifier_courier_600018"
d(r, n)
function r.prototype.GetBuffModifierName(self)
	return "modifier_courier_600018_buff"
end
r = e({ i(a, p) }, r)
local s = c()
s.name = "modifier_courier_600018_buff"
d(s, h)
function s.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.attack_damage_amp = 0
	self.isActive = false
end
function s.prototype.GetAbilitySpecialValue(self)
	self.attack_damage_amp = self:GetAbilitySpecialValueFor("attack_damage_amp")
end
function s.prototype.EventListener(self)
	return {
		avoid_damage = function(t, u)
			if u.unit == self:GetParent() then
				self.isActive = true
				if self.pid ~= nil then
					ParticleManager:DestroyParticle(self.pid, true)
					ParticleManager:ReleaseParticleIndex(self.pid)
				end
				self.pid = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_marci/marci_sidekick_buff_hands.vpcf",
					PATTACH_POINT_FOLLOW,
					self:GetParent()
				)
			end
		end,
		attack_event = function(t, u)
			if u.attacker == self:GetParent() then
				self.isActive = false
				if self.pid ~= nil then
					ParticleManager:DestroyParticle(self.pid, true)
					ParticleManager:ReleaseParticleIndex(self.pid)
				end
			end
		end,
	}
end
function s.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.ATTACK_DAMAGE_AMPLIFY] = function()
			return self.isActive and self.attack_damage_amp or 0
		end,
	}
end
s = e({ i(a, o) }, s)
return f