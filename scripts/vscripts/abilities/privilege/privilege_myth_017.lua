--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_myth_017"
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
k.name = "privilege_myth_017"
d(k, h)
function k.prototype.EventListener(self)
	return {
		lightning_strike = function(l, m)
			local n = self:GetCaster()
			if n == m.caster and self:IsCooldownReady() and self:PRD(self.value, "privilege_myth_017") then
				self:StartCooldown(self.cd)
				n:Poison(m.target, Bless:GetSuitLevel(n:GetPlayerOwnerID(), "poison"))
			end
		end,
	}
end
e({ i(nil) }, k.prototype, "value", nil)
e({ i(nil) }, k.prototype, "cd", nil)
k = e({ j(nil) }, k)
return f