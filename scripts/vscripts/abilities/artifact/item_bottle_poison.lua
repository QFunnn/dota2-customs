--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_bottle_poison"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_bottle_poison"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.ballCount = 0
end
function j.prototype.OnCreated(self)
	if IsServer() then
		self:StartThink(self:GetSpecialValueFor("interval"), "interval", function()
			self.ballCount = self:GetSpecialValueFor("count")
			return self:GetSpecialValueFor("interval")
		end)
		self:StartThink(0.15, "bullet", function()
			if self.ballCount > 0 then
				local k = self:GetCaster()
				local l = FindEnemiesInRadius(k, k:GetAbsOrigin(), 900)
				local m = GetRandomElement(l)
				if IsValid(m) and m:IsAlive() then
					local n = m:GetAbsOrigin() + RandomVector(RandomInt(0, 200))
					k:ThrowPoisonBottle(n, self, self:GetSpecialValueFor("poison"))
					self.ballCount = self.ballCount - 1
				end
			end
		end)
	end
end
j = e({ i(nil) }, j)
return f