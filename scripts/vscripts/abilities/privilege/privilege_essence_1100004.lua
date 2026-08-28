--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_essence_1100004"
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
k.name = "privilege_essence_1100004"
d(k, h)
function k.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.BLEED_DAMAGE_BOOST2] = function()
			return Bless:GetSuitLevel(self:GetPlayerID(), "bleed") * self.damage * 0.01
		end,
	}
end
e({ i(nil) }, k.prototype, "damage", nil)
k = e({ j(nil) }, k)
return f