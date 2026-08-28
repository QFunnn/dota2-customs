--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_myth_011"
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
k.name = "privilege_myth_011"
d(k, h)
function k.prototype.OnCreated(self)
	self.nextTime = 0
	self.interval = self:GetSpecialValueFor("interval")
end
function k.prototype.EventListener(self)
	return {
		expose_effect = function(l, m)
			local n = GameRules:GetGameTime()
			local o = self:GetCaster()
			if IsValid(o) and m.attacker == o and n >= self.nextTime and self:PRD(self.value, k.name) then
				self.nextTime = n + self.interval
				o:AddShield(self:GetSpecialValueFor("shield"))
			end
		end,
	}
end
e({ i(nil) }, k.prototype, "value", nil)
k = e({ j(nil) }, k)
return f