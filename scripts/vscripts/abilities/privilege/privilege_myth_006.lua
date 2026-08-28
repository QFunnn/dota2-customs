--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_myth_006"
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
k.name = "privilege_myth_006"
d(k, h)
function k.prototype.EventListener(self)
	return {
		frozen_burst = function(l, m)
			local n = self:GetCaster()
			if m.caster == n and self:IsCooldownReady() and self:PRD(self.value, "privilege_myth_006") then
				self:StartCooldown(self.cd)
				for o, p in ipairs(m.targets) do
					n:AddExpose(p, self:GetSpecialValueFor("shock_stacks"))
				end
			end
		end,
	}
end
e({ i(nil) }, k.prototype, "value", nil)
e({ i(nil) }, k.prototype, "cd", nil)
k = e({ j(nil) }, k)
return f