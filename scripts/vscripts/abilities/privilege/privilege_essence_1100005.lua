--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_essence_1100005"
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
k.name = "privilege_essence_1100005"
d(k, h)
function k.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.SHIELD_AMPLIFY] = function()
			return Bless:GetSuitLevel(self:GetPlayerID(), "holy") * self.damage * 0.01
		end,
	}
end
e({ i(nil) }, k.prototype, "damage", nil)
k = e({ j(nil) }, k)
return f