--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_gem_004"
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
k.name = "privilege_gem_004"
d(k, h)
function k.prototype.EventListener(self)
	return {
		damage_event = function(l, m)
			local n = self:GetCaster()
			if m.attacker == n and m.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
				local o = self.value * m.target:GetBleedStack(n) * 0.01
				if o > 0 then
					n:DealDamage(m.target, nil, o, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, EOM_DAMAGE_FLAGS.BLEEDING_DAMAGE)
				end
			end
		end,
	}
end
e({ i(nil) }, k.prototype, "value", nil)
k = e({ j(nil) }, k)
return f