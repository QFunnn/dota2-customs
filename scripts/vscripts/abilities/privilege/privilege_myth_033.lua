--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_myth_033"
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
k.name = "privilege_myth_033"
d(k, h)
function k.prototype.EventListener(self)
	return {
		call_sword = function(l, m)
			local n = self:GetCaster()
			if
				self:IsCooldownReady()
				and n == m.caster
				and not m.extra
				and self:PRD(self.value, "privilege_myth_033")
			then
				n:CallSword(1, nil, nil, true)
				self:StartCooldown(self:GetSpecialValueFor("interval"))
			end
		end,
	}
end
e({ i(nil) }, k.prototype, "value", nil)
k = e({ j(nil) }, k)
return f