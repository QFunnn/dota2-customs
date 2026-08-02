--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_weapon_032"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_weapon_032"
d(j, h)
function j.prototype.OnCreated(self)
	self.threshold = self:GetSpecialValueFor("threshold")
	self.heal_amplify = self:GetSpecialValueFor("heal_amplify")
end
function j.prototype.OnRefresh(self)
	self.threshold = self:GetSpecialValueFor("threshold")
end
function j.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.POTION_HEAL_RESTORE] = function()
			local k = self:GetCaster()
			if IsValid(k) and k:GetHealthPercent() <= self.threshold then
				return self.heal_amplify
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f