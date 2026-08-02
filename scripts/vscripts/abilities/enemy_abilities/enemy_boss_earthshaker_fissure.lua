--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_boss_earthshaker_fissure"
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
k.name = "enemy_boss_earthshaker_fissure"
d(k, h)
function k.prototype.GetLinearStartWidth(self)
	return self:GetSpecialValueFor("fissure_radius")
end
function k.prototype.OnAbilityPhaseStart(self)
	self.endPosition = {}
	local l = self:GetCaster()
	local m = l:GetAbsOrigin()
	local n = self:GetCursorPosition()
	local o = self:GetSpecialValueFor("count")
	local p = self:GetSpecialValueFor("angle")
	local q = CalcDirection(n, m)
	local r = self:GetCastRange(vec3_zero, nil)
	Bullet:SplitAction(q, o, p, function(s, t)
		local u = m + t * r
		self:CreateLinerWarningParticle(m, u)
		local v = self.endPosition
		v[#v + 1] = u
	end)
	return true
end
function k.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticle()
end
function k.prototype.OnSpellStart(self)
	self:DestroyWarningParticle()
	local l = self:GetCaster()
	local w = self:GetLinearStartWidth()
	local m = l:GetAbsOrigin()
	for s, u in ipairs(self.endPosition) do
		local x = FindUnitsInLineWithAbility(l, m, u, w, self)
		local y = self:GetSpecialValueFor("damage")
		local z = self:GetSpecialValueFor("stun_duration")
		l:DealDamage(x, self, y)
		local A = self:GetSpecialValueFor("fissure_duration")
		local B = "particles/units/heroes/hero_earthshaker/earthshaker_fissure.vpcf"
		local C = "Hero_EarthShaker.Fissure"
		local D = ParticleManager:CreateParticle(B, PATTACH_WORLDORIGIN, l)
		ParticleManager:SetParticleControl(D, 0, m)
		ParticleManager:SetParticleControl(D, 1, u)
		ParticleManager:SetParticleControl(D, 2, Vector(A, 0, 0))
		ParticleManager:ReleaseParticleIndex(D)
		EmitSoundOnLocationWithCaster(m, C, l)
		EmitSoundOnLocationWithCaster(u, C, l)
	end
end
k = e({ j(nil) }, k)
return f