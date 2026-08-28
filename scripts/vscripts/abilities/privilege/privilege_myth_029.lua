--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_myth_029"
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
k.name = "privilege_myth_029"
d(k, h)
function k.prototype.EventListener(self)
	return {
		spent_mana = function(l, m)
			local n = self:GetCaster()
			if n ~= m.unit then
				return
			end
			self:IncrementStackCount(m.cost)
			if self:GetStackCount() >= self.value then
				Timer:GameTimer(0.2, function()
					if not IsValid(n) and self ~= nil then
						return
					end
					local o = n:GetAbilityByTag(AbilityTag.Ultimate)
					if IsValid(o) then
						o:EndCooldown()
						o:RestoreCharges()
					end
				end)
				self:SetStackCount(0)
			end
		end,
	}
end
e({ i(nil) }, k.prototype, "value", nil)
k = e({ j(nil) }, k)
return f