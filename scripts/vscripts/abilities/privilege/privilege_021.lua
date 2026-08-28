--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_021"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_021"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.consumedCount = 0
end
function j.prototype.EventListener(self)
	return {
		hero_respawn = function(k, l)
			local m = self:GetCaster()
			if m ~= l.unit then
				return
			end
			local n = self:GetSpecialValueFor("respawn_count")
			if self.consumedCount >= n then
				return
			end
			self.consumedCount = self.consumedCount + 1
			m:SetHealth(m:GetMaxHealth())
			m:SetMana(m:GetMaxMana())
		end,
	}
end
j = e({ i(nil) }, j)
return f