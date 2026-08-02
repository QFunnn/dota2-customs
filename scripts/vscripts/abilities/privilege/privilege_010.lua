--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_010"
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
l.name = "privilege_010"
d(l, j)
function l.prototype.EventListener(self)
	return {
		resource_change = function(m, n)
			if n.playerID ~= self.playerID then
				return
			end
			if n.resourceType ~= "gold" then
				return
			end
			if n.value >= 0 then
				return
			end
			local o = DungeonManager:GetCurrentRoom()
			local p = self:GetCaster()
			self:IncrementStackCount(-n.value)
			if o ~= nil and IsValid(p) then
				local q = self:GetSpecialValueFor("cost_gold")
				while self:GetStackCount() >= q do
					self:DecrementStackCount(q)
					o:DropPomReward(p:GetAbsOrigin() + RandomVector(100))
				end
			end
		end,
	}
end
l = e({ h, k(nil) }, l)
return f