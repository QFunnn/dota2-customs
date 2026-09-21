--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_weapon_047"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.tstl-utils")
local h = g.reloadable
local i = require("abilities.eom_privilege")
local j = i.EOMPrivilege
local k = i.RegisterPrivilege
local l = c()
l.name = "privilege_weapon_047"
d(l, j)
function l.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.triggeredCount = 0
end
function l.prototype.EventListener(self)
	return {
		dungeon_room_start = function(m, n)
			local o = n.room:GetRoomType()
			if o ~= RoomType.SHOP and o ~= RoomType.TAVERN and o ~= RoomType.SPECIAL and o ~= RoomType.STAIR then
				return
			end
			if self.triggeredCount >= self:GetSpecialValueFor("trig_count_max") then
				return
			end
			local p = self:GetCaster()
			if not IsValid(p) then
				return
			end
			local q = self:GetSpecialValueFor("attack_damage_pct")
			p:AddProperty(PropertyFunction.ATTACK_DAMAGE_AMPLIFY, q)
			self.triggeredCount = self.triggeredCount + 1
			Notification:CombatToPlayer(
				self:GetPlayerID(),
				{ message = "Notify_privilege_weapon_047", int_attr_value = q }
			)
		end,
		GameModeStarted = function()
			self.triggeredCount = 0
		end,
		GameModeExited = function()
			self.triggeredCount = 0
		end,
	}
end
l = e({ h, k(nil) }, l)
return f