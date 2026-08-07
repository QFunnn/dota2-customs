--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/courier/courier_600020"
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
q.name = "courier_600020"
d(q, k)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_courier_600020"
end
q = e({ l(nil) }, q)
local r = c()
r.name = "modifier_courier_600020"
d(r, n)
function r.prototype.GetBuffModifierName(self)
	return "modifier_courier_600020_buff"
end
r = e({ i(a, p) }, r)
local s = c()
s.name = "modifier_courier_600020_buff"
d(s, h)
function s.prototype.GetAbilitySpecialValue(self)
	self.crit_damage_pct = self:GetAbilitySpecialValueFor("crit_damage_pct")
end
function s.prototype.OnCreated(self, t)
	if IsServer() then
		PropertySystem:AddStaticProperty(
			self:GetParent():entindex(),
			"crit_damage_mult",
			self:GetName(),
			self.crit_damage_pct
		)
	end
end
function s.prototype.OnDestroy(self)
	if IsServer() then
		local u = self:GetParent()
		if not IsValid(u) then
			return
		end
		PropertySystem:RemoveStaticPropertyEx(self:GetName(), u:GetPlayerOwnerID(), u:entindex(), "crit_damage_mult")
	end
end
s = e({ i(a, o) }, s)
return f