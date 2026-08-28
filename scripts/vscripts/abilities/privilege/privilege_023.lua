--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_023"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_023"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.consumedCount = 0
end
function j.prototype.EventListener(self)
	return {
		item_added = function(k, l)
			local m = l.unit
			local n = self:GetCaster()
			if not IsValid(n) or m ~= n then
				return
			end
			local o = n:GetPlayerID()
			if o == nil then
				return
			end
			local p = PlayerResource:GetSelectedHeroEntity(o)
			if not IsValid(p) then
				return
			end
			local q = l.item
			local r = q:GetName()
			if r ~= "item_ball_health_single" then
				return
			end
			local s = self:GetSpecialValueFor("extra_health")
			local t = self:GetSpecialValueFor("extra_count")
			if self.consumedCount >= t then
				return
			end
			self.consumedCount = self.consumedCount + 1
			p:AddProperty(PropertyFunction.HEALTH, s)
			Notification:CombatToPlayer(
				o,
				{ message = "Notify_privilege_023", item_name = "item_ball_health", int_extra_health = s }
			)
		end,
	}
end
j = e({ i(nil) }, j)
return f