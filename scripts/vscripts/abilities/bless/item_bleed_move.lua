--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_bleed_move"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.registerAbility
local i = require("abilities.eom_ability")
local j = i.EOMItem
local k = c()
k.name = "item_bleed_move"
d(k, j)
function k.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.ballCount = 0
	self.distanceRecord = 0
end
function k.prototype.OnCreated(self)
	local l = self:GetCaster()
	self.position = l:GetAbsOrigin()
	local m = self:GetSpecialValueFor("distance")
	self:StartThink(0, "move", function()
		local n = l:GetAbsOrigin()
		local o = n:__sub(self.position):Length2D()
		if o < 2000 then
			self.distanceRecord = self.distanceRecord + o
		end
		self.position = n
		if self.distanceRecord >= m then
			self.distanceRecord = 0
			self.ballCount = self:GetSpecialValueFor("count")
		end
	end)
	self:StartThink(0.15, "fire", function()
		if self.ballCount > 0 then
			local l = self:GetCaster()
			local p = FindUnitsInRadiusWithAbility(l, l:GetAbsOrigin(), 900, self)
			local q = GetRandomElement(p)
			if IsValid(q) and q:IsAlive() then
				l:ThrowBloodSpear(q, self, self:GetSpecialValueFor("damage"))
				self.ballCount = self.ballCount - 1
			end
		end
	end)
end
k = e({ h(nil) }, k)
return f