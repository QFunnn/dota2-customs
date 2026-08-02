--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_weapon_023"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_weapon_023"
d(j, h)
function j.prototype.EventListener(self)
	return {
		avoid_damage = function(k, l)
			local m = self:GetCaster()
			if not IsValid(m) then
				return
			end
			if l.unit ~= m then
				return
			end
			local n = m:GetAbilityByTag(AbilityTag.Defense)
			if not IsValid(n) then
				return
			end
			local o = self:GetSpecialValueFor("cd_reduce")
			n:ReduceCooldown(o)
		end,
	}
end
j = e({ i(nil) }, j)
return f