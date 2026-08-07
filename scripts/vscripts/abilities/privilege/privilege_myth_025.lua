--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_myth_025"
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
k.name = "privilege_myth_025"
d(k, h)
function k.prototype.EventListener(self)
	return {
		attack_event = function(l, m)
			local n = self:GetCaster()
			if m.attacker == n then
				if n:GetManaPercent() >= 50 then
					self.spendMana = n:GetMaxMana() * self.value * 0.01
					n:SpendMana(self.spendMana, CLIENT_ABILITY)
				else
					self.spendMana = nil
				end
			end
		end,
		damage_event = function(l, m)
			local n = self:GetCaster()
			if
				self.spendMana
				and m.attacker == n
				and m.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK
				and m.target:IsAlive()
			then
				n:Bleed(m.target, math.floor(self.spendMana))
			end
		end,
	}
end
e({ i(nil) }, k.prototype, "value", nil)
k = e({ j(nil) }, k)
return f