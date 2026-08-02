--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_wind_shield"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_wind_shield"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.distanceRecord = 0
end
function j.prototype.OnCreated(self)
	local k = self:GetCaster()
	self.position = k:GetAbsOrigin()
	local l = self:GetSpecialValueFor("distance")
	local m = self:GetSpecialValueFor("shield")
	self:StartThink(0, function()
		local n = k:GetAbsOrigin()
		local o = n:__sub(self.position):Length2D()
		self.distanceRecord = self.distanceRecord + o
		self.position = n
		if self.distanceRecord >= l then
			self.distanceRecord = 0
			k:AddShield(m, "item_wind_shield")
			self:SetStackCount(k:GetShield("item_wind_shield"))
		end
	end)
end
function j.prototype.OnDestroy(self)
	self:GetCaster():RemoveShield("item_wind_shield")
end
function j.prototype.EventListener(self)
	return {
		damage_event = function(p, q)
			if q.target == self:GetCaster() then
				self:SetStackCount(self:GetCaster():GetShield("item_wind_shield"))
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f