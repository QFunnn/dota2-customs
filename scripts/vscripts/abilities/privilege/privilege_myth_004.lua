--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_myth_004"
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
k.name = "privilege_myth_004"
d(k, h)
function k.prototype.OnCreated(self)
	self.interval = self:GetSpecialValueFor("interval")
	self.nextTime = 0
end
function k.prototype.EventListener(self)
	return {
		frozen_burst = function(l, m)
			local n = self:GetCaster()
			local o = GameRules:GetGameTime()
			if m.caster == n and not m.extra and o >= self.nextTime and self:PRD(self.value, "privilege_myth_004") then
				self.nextTime = o + self.interval
				n:FrozenBurst(self:GetSpecialValueFor("damage"), m.base_frozen_stack, m.position, true)
			end
		end,
	}
end
e({ i(nil) }, k.prototype, "value", nil)
k = e({ j(nil) }, k)
return f