--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_suit_018"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.tstl-utils")
local h = g.reloadable
local i = require("abilities.eom_privilege")
local j = i.EOMPrivilege
local k = i.RegisterPrivilege
local l = c()
l.name = "privilege_suit_018"
d(l, j)
function l.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.EXPOSE_KEEP_CHANCE] = function(m, n)
			if
				n
				and n.attacker == self:GetCaster()
				and n.is_crit
				and n.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK
			then
				return self:GetSpecialValueFor("expose_keep_chance")
			end
		end,
	}
end
l = e({ h, k(nil) }, l)
return f