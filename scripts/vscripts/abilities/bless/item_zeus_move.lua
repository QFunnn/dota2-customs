--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_zeus_move"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_zeus_move"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.distanceRecord = 0
end
function j.prototype.OnCreated(self)
	local k = self:GetCaster()
	self.position = k:GetAbsOrigin()
	local l = self:GetSpecialValueFor("distance")
	self:StartThink(0, function()
		local m = k:GetAbsOrigin()
		local n = CalcDistance(m, self.position)
		if n < 2000 then
			self.distanceRecord = self.distanceRecord + n
		end
		self.position = m
		if self.distanceRecord >= l then
			self.distanceRecord = 0
			local o = self:GetSpecialValueFor("stack")
			local p = FindEnemiesInRadius(k, k:GetAbsOrigin(), 1200)
			for q, r in ipairs(p) do
				k:AddExpose(r, o)
			end
			k:EmitSound("Hero_Disruptor.KineticField.End")
		end
	end)
end
j = e({ i(nil) }, j)
return f