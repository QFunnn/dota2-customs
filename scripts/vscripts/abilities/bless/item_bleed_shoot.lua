--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_bleed_shoot"
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
k.name = "item_bleed_shoot"
d(k, j)
function k.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.ballCount = 0
end
function k.prototype.OnCreated(self)
	self:StartThink(0.15, function()
		if self.ballCount > 0 then
			local l = self:GetCaster()
			local m = FindUnitsInRadiusWithAbility(l, l:GetAbsOrigin(), 900, self)
			local n = GetRandomElement(m)
			if IsValid(n) and n:IsAlive() then
				l:ThrowBloodSpear(n, self, self:GetSpecialValueFor("damage"))
				self.ballCount = self.ballCount - 1
			end
		end
	end)
end
function k.prototype.EventListener(self)
	return {
		ability_cast_complete = function(o, p)
			local l = self:GetCaster()
			if l == p.caster and p.abilityTag == AbilityTag.Ultimate then
				self.ballCount = self:GetSpecialValueFor("count")
			end
		end,
	}
end
k = e({ h(nil) }, k)
return f