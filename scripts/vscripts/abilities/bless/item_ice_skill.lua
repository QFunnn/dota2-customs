--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_ice_skill"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_ice_skill"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.ballCount = 0
end
function j.prototype.OnCreated(self)
	self:StartThink(0.15, function()
		if self.ballCount > 0 then
			local k = self:GetCaster()
			local l = FindUnitsInRadiusWithAbility(k, k:GetAbsOrigin(), 900, self)
			local m = GetRandomElement(l)
			if IsValid(m) and m:IsAlive() then
				k:ThrowSnowball(m, self, self:GetSpecialValueFor("frozen"), self:GetSpecialValueFor("damage"))
				self.ballCount = self.ballCount - 1
			end
		end
	end)
end
function j.prototype.EventListener(self)
	return {
		ability_cast_complete = function(n, o)
			local k = self:GetCaster()
			if k == o.caster and o.abilityTag == AbilityTag.Skill then
				self.ballCount = self:GetSpecialValueFor("count")
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f