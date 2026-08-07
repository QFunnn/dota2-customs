--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_weapon_018"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_weapon_018"
d(j, h)
function j.prototype.EventListener(self)
	return {
		dungeon_room_clear = function(k, l)
			local m = l.room
			if m == nil or m:GetRoomType() ~= RoomType.BOSS then
				return
			end
			local n = self:GetCaster()
			if not IsValid(n) then
				return
			end
			local o = n:GetPlayerID()
			local p = PlayerResource:GetSelectedHeroEntity(o)
			if IsValid(p) then
				p:AddItemByName("item_ball_attack_single")
				Notification:CombatToPlayer(
					o,
					{ message = "Notify_privilege_weapon_018", item_name = "item_ball_attack" }
				)
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f