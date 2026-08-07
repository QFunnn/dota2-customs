--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_weapon_014"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_weapon_014"
d(j, h)
function j.prototype.OnCreated(self)
	local k = self:GetCaster()
	if not IsValid(k) then
		return
	end
	AbilityUpgrade:AddAbilityUpgrade(k, "vexis_4_upgrade_6", self.level, "privilege_weapon_014")
	AbilityUpgrade:AddAbilityUpgrade(k, "vexis_4_upgrade_7", self.level, "privilege_weapon_014")
end
function j.prototype.OnDestroy(self)
	local k = self:GetCaster()
	if not IsValid(k) then
		return
	end
	AbilityUpgrade:RemoveAbilityUpgrade(k, "vexis_4_upgrade_6", "privilege_weapon_014")
	AbilityUpgrade:RemoveAbilityUpgrade(k, "vexis_4_upgrade_7", "privilege_weapon_014")
end
j = e({ i(nil) }, j)
return f