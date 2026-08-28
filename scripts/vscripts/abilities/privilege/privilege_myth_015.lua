--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_myth_015"
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
k.name = "privilege_myth_015"
d(k, h)
function k.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.LIGHTNING_CLOUD_HIT_COUNT] = function(l, m)
			if self:PRD(self.value) then
				return 1
			end
		end,
	}
end
e({ i(nil) }, k.prototype, "value", nil)
k = e({ j(nil) }, k)
return f