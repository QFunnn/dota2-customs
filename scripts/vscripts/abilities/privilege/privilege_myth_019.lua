--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_myth_019"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.PrivilegeValue
local g = require("abilities.eom_privilege")
local i = g.EOMPrivilege
local j = g.RegisterPrivilege
local k = c()
k.name = "privilege_myth_019"
d(k, i)
function k.prototype.EventListener(self)
	return {
		frozen_burst = function(l, m)
			local n = self:GetCaster()
			if n == m.caster and self:PRD(self.value) then
				for o, p in ipairs(m.targets) do
					p:TriggerPoison(n)
				end
			end
		end,
	}
end
e({ h(nil) }, k.prototype, "value", nil)
k = e({ j(nil) }, k)
return f