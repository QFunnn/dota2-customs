--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_myth_034"
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
k.name = "privilege_myth_034"
d(k, h)
function k.prototype.EventListener(self)
	return {
		give_mana = function(l, m)
			local n = self:GetCaster()
			if self:IsCooldownReady() and n == m.unit then
				self:IncrementStackCount(m.manaAmount)
				if self:GetStackCount() >= self.value then
					self:StartCooldown(self.interval)
					n:CallSword(1)
					self:SetStackCount(0)
				end
			end
		end,
	}
end
e({ i(nil) }, k.prototype, "value", nil)
e({ i(nil) }, k.prototype, "interval", nil)
k = e({ j(nil) }, k)
return f