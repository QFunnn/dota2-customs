--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_gem_suit_019"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_gem_suit_019"
d(j, h)
function j.prototype.StaticProperty(self)
	return { [PropertyFunction.SPELL_DAMAGE_MULTIPLIER] = self:GetSpecialValueFor("value") }
end
function j.prototype.OnRefresh(self)
	h.prototype.OnRefresh(self)
	self:RefreshStaticProperty()
end
j = e({ i(nil) }, j)
return f