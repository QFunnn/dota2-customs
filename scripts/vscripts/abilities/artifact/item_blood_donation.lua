--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_blood_donation"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_blood_donation"
d(j, h)
function j.prototype.EventListener(self)
	return {
		damage_event = function(k, l)
			if l.target == self:GetCaster() then
				local m = self:GetCaster()
				local n = m:GetMaxHealth()
				if n > 0 then
					local o = l.damage / n * 100
					local p = self:GetSpecialValueFor("gold")
					local q = math.floor(o) * p
					if q > 0 then
						Player:ModifyGold(m:GetPlayerOwnerID(), q, true, true)
						Notification:CombatToPlayer(
							m:GetPlayerOwnerID(),
							{ message = "Notify_item_blood_donation", item_name = self:GetAbilityName(), int_value = q }
						)
					end
				end
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f