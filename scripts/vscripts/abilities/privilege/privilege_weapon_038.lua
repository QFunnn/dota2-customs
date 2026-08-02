--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_weapon_038"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_weapon_038"
d(j, h)
function j.prototype.EventListener(self)
	return {
		item_added = function(k, l)
			local m = l.unit
			local n = self:GetCaster()
			if not IsValid(n) or m ~= n then
				return
			end
			local o = n and n:GetPlayerID()
			if o == nil then
				return
			end
			local p = l.item
			local q = p:GetName()
			if q ~= "item_champagne" then
				return
			end
			local r = self:GetSpecialValueFor("attr_value")
			print("privilege_weapon_038 attrValue", r)
			n:AddProperty(PropertyFunction.SPELL_DAMAGE_AMPLIFY, r)
			Notification:CombatToPlayer(
				o,
				{ message = "Notify_privilege_weapon_038", item_name = "item_champagne", int_attr_value = r }
			)
		end,
	}
end
j = e({ i(nil) }, j)
return f