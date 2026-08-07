--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_void_gate"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_artifact_void_gate"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.enable = false
end
function j.prototype.OnCreated(self)
	self:SetStackCount(self:GetSpecialValueFor("duration_rooms"))
end
function j.prototype.EventListener(self)
	return {
		dungeon_room_start = function(k, l)
			if self:GetStackCount() > 0 and l.room:IsCombatRoom() and not l.room:IsBossRoom() then
				self:DecrementStackCount()
				self.enable = true
			else
				self.enable = false
			end
		end,
	}
end
function j.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.MIN_HEALTH] = function()
			if self.enable then
				return 1
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f