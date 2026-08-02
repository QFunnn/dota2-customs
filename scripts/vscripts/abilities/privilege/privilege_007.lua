--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_007"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_007"
d(j, h)
function j.prototype.EventListener(self)
	return {
		dungeon_room_complete = function(k, l)
			local m = self:GetSpecialValueFor("value")
			Player:ModifyGold(self.playerID, m)
			print("[privilege_007] dungeon_room_complete, value:", m)
		end,
	}
end
j = e({ i(nil) }, j)
return f