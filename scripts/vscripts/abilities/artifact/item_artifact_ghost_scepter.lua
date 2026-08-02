--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_ghost_scepter"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_artifact_ghost_scepter"
d(j, h)
function j.prototype.DeclareState(self)
	return {
		[StateEnum.NO_CRIT] = function()
			return self:GetStackCount() > 0
		end,
	}
end
function j.prototype.OnCreated(self)
	self:SetStackCount(self:GetSpecialValueFor("duration_rooms"))
end
function j.prototype.EventListener(self)
	return {
		dungeon_room_complete = function(k, l)
			if self:GetStackCount() > 0 then
				self:DecrementStackCount()
			end
		end,
	}
end
function j.prototype.StaticProperty(self)
	return { [PropertyFunction.CRIT_DAMAGE] = self:GetStackCount() > 0 and 0 or self:GetSpecialValueFor("crit_damage") }
end
j = e({ i(nil) }, j)
return f