--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_myth_023"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.PrivilegeValue
local j = g.RegisterPrivilege
local k = c()
k.name = "privilege_myth_023"
d(k, h)
function k.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.factor = 1
end
function k.prototype.GetCircleRadius(self, l)
	if l == nil then
		l = self:GetCaster()
	end
	if not IsValid(l) then
		return 0
	end
	self.factor = l:IsRangedAttacker() and 0.6 or 1
	return l:Script_GetAttackRange() * self.factor
end
function k.prototype.EventListener(self)
	return {
		potion_heal = function(m, n)
			local l = self:GetCaster()
			if n.caster == l then
				l:PoisionBottle(
					self.value,
					self:GetSpecialValueFor("poison_stacks"),
					self:GetCircleRadius(l),
					self:GetSpecialValueFor("speed")
				)
			end
		end,
	}
end
e({ i(nil) }, k.prototype, "value", nil)
k = e({ j(nil) }, k)
return f