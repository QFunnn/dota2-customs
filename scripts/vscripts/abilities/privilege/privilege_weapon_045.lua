--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_weapon_045"
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
l.name = "privilege_weapon_045"
d(l, j)
function l.prototype.OnCreated(self)
	local m = self:GetCaster()
	if not IsValid(m) then
		return
	end
	AbilityUpgrade:AddAbilityUpgrade(m, "seraphon_1_upgrade_wp45", self.level, "privilege_weapon_045")
end
function l.prototype.OnDestroy(self)
	local m = self:GetCaster()
	if not IsValid(m) then
		return
	end
	AbilityUpgrade:RemoveAbilityUpgrade(m, "seraphon_1_upgrade_wp45", "privilege_weapon_045")
end
l = e({ h, k(nil) }, l)
return f