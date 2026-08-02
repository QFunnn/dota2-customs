--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_002"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_002"
d(j, h)
function j.prototype.EventListener(self)
	return {
		dungeon_room_clear = function(k, l)
			if l.room:GetRoomType() ~= RoomType.BOSS then
				return
			end
			local m = self:GetSpecialValueFor("count")
			do
				local n = 0
				while n < m do
					l.room:DropPomReward(l.position + RandomVector(100))
					n = n + 1
				end
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f