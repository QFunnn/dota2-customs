--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_essence_1100001"
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
k.name = "privilege_essence_1100001"
d(k, h)
function k.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.LIGHTNING_DAMAGE_BOOST2] = function()
			local l = Bless:GetSuitLevel(self:GetPlayerID(), "zeus") * self.damage * 0.01
			return l
		end,
	}
end
e({ i(nil) }, k.prototype, "damage", nil)
k = e({ j(nil) }, k)
return f