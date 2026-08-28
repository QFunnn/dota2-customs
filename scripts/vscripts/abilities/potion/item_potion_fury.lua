--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/potion/item_potion_fury"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.registerAbility
local i = require("abilities.eom_ability")
local j = i.EOMItem
local k = c()
k.name = "item_potion_fury"
d(k, j)
function k.prototype.OnCreated(self)
	self:SetStackCount(self:GetSpecialValueFor("charge"))
end
function k.prototype.UseCharge(self)
	if self:GetStackCount() > 0 then
		self:DecrementStackCount()
		if self:GetStackCount() <= 0 then
			self:GetCaster():RemoveItem(self)
		end
	end
end
function k.prototype.Effect(self)
	self:GetCaster():GiveMana(self:GetSpecialValueFor("value"))
end
function k.prototype.EventListener(self)
	return {
		ability_cast_complete = function(l, m)
			if m.caster == self:GetCaster() and m.abilityTag == AbilityTag.Ultimate then
				self:Effect()
			end
		end,
		dungeon_room_clear = function(l, m)
			self:UseCharge()
		end,
	}
end
k = e({ h(nil) }, k)
return f