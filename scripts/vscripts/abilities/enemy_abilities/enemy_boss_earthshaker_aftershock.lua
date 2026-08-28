--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_boss_earthshaker_aftershock"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.bt_ability_ai")
local h = g.EOMBTAbilityAI
local i = require("abilities.eom_ability")
local j = i.registerEOMAbility
local k = c()
k.name = "enemy_boss_earthshaker_aftershock"
d(k, h)
function k.prototype.GetAOERadius(self)
	return self:GetCastRange(vec3_zero, nil)
end
function k.prototype.OnAbilityPhaseStart(self)
	self:CreateRadiusWarningParticle()
	return true
end
function k.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticle()
end
function k.prototype.OnSpellStart(self)
	self:DestroyWarningParticle()
	local l = self:GetCaster()
	local m = self:GetAOERadius()
	local n = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_earthshaker/earthshaker_aftershock.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(n, 0, GetGroundPosition(l:GetAbsOrigin(), l))
	ParticleManager:SetParticleControl(n, 1, Vector(m, m, m))
	ParticleManager:ReleaseParticleIndex(n)
	local o = FindUnitsInRadiusWithAbility(l, l:GetAbsOrigin(), self:GetAOERadius(), self)
	local p = self:GetSpecialValueFor("damage")
	l:DealDamage(o, self, p)
	local q = self:GetSpecialValueFor("stagger_duration")
	l:EmitSound("Hero_EarthShaker.Totem")
	l:AddNewModifier(l, self, "modifier_stagger", { animation = ACT_DOTA_ATTACK, duration = q })
end
k = e({ j(nil) }, k)
return f