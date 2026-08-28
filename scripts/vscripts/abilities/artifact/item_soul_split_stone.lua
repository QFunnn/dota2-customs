--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_soul_split_stone"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.AbilityValue
local i = g.EOMItem
local j = g.registerEOMAbility
local k = c()
k.name = "item_soul_split_stone"
d(k, i)
function k.prototype.OnCreated(self)
	self:SetStackCount(self.duration)
end
function k.prototype.EventListener(self)
	return {
		dungeon_room_complete = function(l, m)
			if m.room:IsCombatRoom() then
				self:DecrementStackCount()
				if self:GetStackCount() <= 0 then
					Notification:CombatToPlayer(
						self:GetCaster():GetPlayerOwnerID(),
						{ message = "Notify_item_disappear", item_name = self:GetAbilityName() }
					)
					self:GetCaster():RemoveItem(self)
				end
			end
		end,
	}
end
e({ h(nil) }, k.prototype, "duration", nil)
k = e({ j(nil) }, k)
return f