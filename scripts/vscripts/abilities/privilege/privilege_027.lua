--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_027"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringSplit
local f = b.__TS__ParseInt
local g = b.__TS__DecorateLegacy
local h = {}
local i = require("abilities.eom_privilege")
local j = i.EOMPrivilege
local k = i.RegisterPrivilege
local l = c()
l.name = "privilege_027"
d(l, j)
function l.prototype.EventListener(self)
	return {
		dungeon_room_clear = function(m, n)
			local o = n.room
			if o == nil or o:GetRoomType() ~= RoomType.BOSS then
				return
			end
			local p = self:GetCaster()
			if not IsValid(p) then
				return
			end
			local q = o:GetRoomKey()
			local r, s = unpack(e(q, "-"), 1, 2)
			local t = f(r)
			if t ~= 1 then
				return
			end
			local u = p:GetPlayerID()
			Bless:DrawBlessSelection(u, 3)
			local v = PlayerResource:GetSelectedHeroEntity(u)
			if IsValid(v) then
				v:EmitSoundParams("ui.badge_levelup", 0, 0.5, 0)
			end
		end,
	}
end
l = g({ k(nil) }, l)
return h