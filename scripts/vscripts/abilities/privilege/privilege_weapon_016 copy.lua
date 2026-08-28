--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_weapon_016 copy"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["12"] = 6,
		["13"] = 6,
		["14"] = 7,
		["15"] = 8,
		["16"] = 9,
		["17"] = 10,
		["20"] = 12,
		["21"] = 13,
		["22"] = 14,
		["23"] = 8,
		["24"] = 16,
		["25"] = 17,
		["26"] = 18,
		["29"] = 20,
		["30"] = 21,
		["31"] = 22,
		["32"] = 16,
		["33"] = 7,
		["34"] = 6,
		["35"] = 7,
	}
)
local g = {}
local h = require("abilities.eom_privilege")
local i = h.EOMPrivilege
local j = h.RegisterPrivilege
local k = c()
k.name = "privilege_weapon_016"
d(k, i)
function k.prototype.OnCreated(self)
	local l = self:GetCaster()
	if not IsValid(l) then
		return
	end
	AbilityUpgrade:AddAbilityServiceUpgrade(l, "seraphon_4_upgrade_6")
	AbilityUpgrade:AddAbilityServiceUpgrade(l, "seraphon_4_upgrade_7")
	AbilityUpgrade:AddAbilityServiceUpgrade(l, "seraphon_4_upgrade_8")
end
function k.prototype.OnDestroy(self)
	local l = self:GetCaster()
	if not IsValid(l) then
		return
	end
	AbilityUpgrade:RemoveAbilityUpgrade(l, "seraphon_4_upgrade_6")
	AbilityUpgrade:RemoveAbilityUpgrade(l, "seraphon_4_upgrade_7")
	AbilityUpgrade:RemoveAbilityUpgrade(l, "seraphon_4_upgrade_8")
end
k = e({ j(nil) }, k)
return g