--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_myth_036"
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
k.name = "privilege_myth_036"
d(k, h)
function k.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.DAMAGE_REDUCTION] = function(l, m)
			local n = self:GetCaster()
			local o = self:GetSpecialValueFor("shield_threshold")
			if IsValid(n) and n:GetShield() >= n:GetMaxHealth() * o * 0.01 then
				return self.value
			end
		end,
	}
end
e({ i(nil) }, k.prototype, "value", nil)
k = e({ j(nil) }, k)
return f