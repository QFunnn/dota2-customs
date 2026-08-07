--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_bless_012"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_bless_012"
d(j, h)
function j.prototype.OnCreated(self)
	local k = self:GetSpecialValueFor("free_count")
	Privilege:SetPlayerDynamicValue("privilege_bless_012", self:GetPlayerID(), "free_count", k)
end
function j.prototype.EventListener(self)
	return {
		dungeon_room_start = function(l, m)
			local n = m.room:GetRoomType()
			if n == RoomType.SPECIAL then
				local k = self:GetSpecialValueFor("free_count")
				Privilege:SetPlayerDynamicValue("privilege_bless_012", self:GetPlayerID(), "free_count", k)
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f