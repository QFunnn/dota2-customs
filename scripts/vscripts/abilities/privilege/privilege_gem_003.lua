--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_gem_003"
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
k.name = "privilege_gem_003"
d(k, h)
function k.prototype.EventListener(self)
	return {
		ability_cast_complete = function(l, m)
			local n = self:GetCaster()
			if n ~= m.caster or m.abilityTag ~= AbilityTag.Ultimate then
				return
			end
			local o = 500
			local p = FindEnemiesInRadius(n, n:GetAbsOrigin(), o)
			for q, r in ipairs(p) do
				local s = r:GetPoisonStack(n)
				if s > 0 then
					local t = math.floor(s * self.value * 0.01)
					if t > 0 then
						n:Poison(r, t)
					end
				end
			end
		end,
	}
end
e({ i(nil) }, k.prototype, "value", nil)
k = e({ j(nil) }, k)
return f