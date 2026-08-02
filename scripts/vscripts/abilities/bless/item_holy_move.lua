--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_holy_move"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.AbilityValue
local i = g.EOMItem
local j = g.registerEOMAbility
local k = c()
k.name = "item_holy_move"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.distanceRecord = 0
end
function k.prototype.OnCreated(self)
	local l = self:GetCaster()
	self.position = l:GetAbsOrigin()
	self:StartThink(0, function()
		local m = l:GetAbsOrigin()
		local n = m:__sub(self.position):Length2D()
		if n < 2000 then
			self.distanceRecord = self.distanceRecord + n
		end
		self.position = m
		if self.distanceRecord >= self.distance then
			self.distanceRecord = 0
			local o = LASER_LENGTH + GetBulletRange(l)
			local p = FindUnitsInRadiusWithAbility(l, l:GetAbsOrigin(), o, self)
			local q = GetRandomElement(p)
			local r = IsValid(q) and q:GetAbsOrigin() or l:GetAbsOrigin() + RandomVector(300)
			l:Laser(CalcDirection2D(r, l), self:GetSpecialValueFor("damage"))
		end
	end)
end
e({ h(nil) }, k.prototype, "distance", nil)
k = e({ j(nil) }, k)
return f