--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_weapon_028"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_weapon_028"
d(j, h)
function j.prototype.EventListener(self)
	return {
		item_consumed = function(k, l)
			if l.item:GetName() == "item_beer" and l.unit == self:GetCaster() then
				local m = self:GetSpecialValueFor("damage")
				l.unit:AddProperty(PropertyFunction.ATTACK_DAMAGE_AMPLIFY, m)
				local n = self:GetPlayerID()
				Notification:CombatToPlayer(
					n,
					{ message = "Notify_privilege_weapon_028", item_name = "item_beer", int_value = m }
				)
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f