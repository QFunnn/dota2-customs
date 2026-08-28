--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_009"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_009"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.start = false
end
function j.prototype.EventListener(self)
	return {
		dungeon_start = function(k, l)
			self.start = true
		end,
		dungeon_room_start = function(k, l)
			if self.start == false then
				return
			end
			self.start = false
			local m = self:GetCaster()
			if IsValid(m) and self:PRD(self:GetSpecialValueFor("chance")) then
				l.room:DropPomReward(m:GetAbsOrigin() + RandomVector(100))
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f