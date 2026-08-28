--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_poison_dodge"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_poison_dodge"
d(j, h)
function j.prototype.EventListener(self)
	return {
		dash_end = function(k, l)
			if l.caster == self:GetCaster() then
				local m = self:GetCaster()
				local n = self:GetSpecialValueFor("radius")
				local o = self:GetSpecialValueFor("poison")
				local p = self:GetSpecialValueFor("duration")
				local q = FindUnitsInRadiusWithAbility(m, m:GetAbsOrigin(), n, self)
				for r, s in ipairs(q) do
					m:Poison(s, o)
				end
				local t = ParticleManager:CreateParticle(
					"particles/units/benediction/viper_nose_dive_aoe.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControl(t, 0, m:GetAbsOrigin())
				ParticleManager:SetParticleControl(t, 1, Vector(n, 0, 0))
				ParticleManager:ReleaseParticleIndex(t)
				m:EmitSound("Hero_Viper.NoseDive.Impact")
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f