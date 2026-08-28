--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_kredan_rose"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_artifact_kredan_rose"
d(j, h)
function j.prototype.OnCreated(self)
	self:SetStackCount(self:GetSpecialValueFor("duration_rooms"))
end
function j.prototype.EventListener(self)
	return {
		damage_event = function(k, l)
			if l.target == self:GetCaster() and l.damage > 0 then
				Notification:CombatToPlayer(
					self:GetCaster():GetPlayerOwnerID(),
					{ message = "Notify_item_disappear", item_name = self:GetAbilityName() }
				)
				self:GetCaster():RemoveItem(self)
			end
		end,
		dungeon_room_complete = function(k, l)
			if not l.room:IsCombatRoom() then
				return
			end
			local m = self:GetCaster()
			self:DecrementStackCount()
			if self:GetStackCount() <= 0 then
				Player:ModifyGold(m:GetPlayerOwnerID(), self:GetSpecialValueFor("gold"))
				Notification:CombatToPlayer(
					self:GetCaster():GetPlayerOwnerID(),
					{
						message = "Notify_item_artifact_kredan_rose",
						item_name = self:GetAbilityName(),
						int_value = self:GetSpecialValueFor("gold"),
					}
				)
				m:RemoveItem(self)
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f