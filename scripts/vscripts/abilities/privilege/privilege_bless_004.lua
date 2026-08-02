--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_bless_004"
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
l.name = "privilege_bless_004"
d(l, j)
function l.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.inBossRoom = false
	self.hasDied = false
end
function l.prototype.EventListener(self)
	return {
		dungeon_room_start = function(m, n)
			local o = self:GetCaster()
			if not IsValid(o) then
				return
			end
			local p = o:GetPlayerOwnerID()
			if n.room:IsBossRoom() then
				self.inBossRoom = true
				self.hasDied = false
				Player:ModifyHeart(p, 1)
			end
		end,
		entity_killed = function(m, n)
			if not self.inBossRoom then
				return
			end
			local o = self:GetCaster()
			if not IsValid(o) then
				return
			end
			local q = n.victim
			if q == o then
				self.hasDied = true
			end
		end,
		dungeon_room_complete = function(m, n)
			local o = self:GetCaster()
			if not IsValid(o) then
				return
			end
			local p = o:GetPlayerOwnerID()
			if n.room:IsBossRoom() then
				if not self.hasDied then
					Player:ModifyHeart(p, -1)
				end
				self.inBossRoom = false
				self.hasDied = false
			end
		end,
	}
end
l = e({ h, k(nil) }, l)
return f