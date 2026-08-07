--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_poison_plague"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_poison_plague"
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
		local n = m:__sub(self.position):Length2D()
		if n < 2000 then
			self.distanceRecord = self.distanceRecord + n
		end
		self.position = m
		if self.distanceRecord >= l then
			self.distanceRecord = 0
			local k = self:GetCaster()
			local o = self:GetSpecialValueFor("poison")
			local p = self:GetSpecialValueFor("radius")
			local q = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_venomancer/venomancer_noxious_plague_spread.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(q, 0, k:GetAbsOrigin())
			ParticleManager:SetParticleControl(q, 1, Vector(p, 0.5, p * 2))
			local r = FindUnitsInRadiusWithAbility(k, k:GetAbsOrigin(), p, self)
			for s, t in ipairs(r) do
				k:Poison(t, o)
			end
			k:EmitSound("Greevil.PoisonNovaImpact", k:GetAbsOrigin())
		end
	end)
end
j = e({ i(nil) }, j)
return f