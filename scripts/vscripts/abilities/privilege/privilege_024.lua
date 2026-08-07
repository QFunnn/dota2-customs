--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_024"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_024"
d(j, h)
function j.prototype.EventListener(self)
	return {
		dungeon_room_start = function(k, l)
			local m = l.room
			if m == nil or m:GetRoomType() ~= RoomType.SHOP then
				return
			end
			local n = self:GetCaster()
			if not IsValid(n) then
				return
			end
			local o = n:GetPlayerID()
			if o == nil then
				return
			end
			local p = "item_ball_health_single"
			n:AddItemByName(p)
			Notification:CombatToPlayer(o, { message = "Notify_privilege_024", item_name = p })
		end,
	}
end
j = e({ i(nil) }, j)
return f