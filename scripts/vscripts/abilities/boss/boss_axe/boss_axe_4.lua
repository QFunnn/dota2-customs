--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_axe/boss_axe_4"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.AbilityValue
local i = g.EOMAbility
local j = g.registerEOMAbility
local k = c()
k.name = "boss_axe_4"
d(k, i)
function k.prototype.OnAbilityPhaseStart(self)
	local l = self:GetCaster()
	local m = self:GetCursorPosition()
	local n = l:GetAbsOrigin()
	local o = CalcDirection2D(m, n)
	local p = n + o * 600
	self:CircleWarning(m, self.radius, self:GetCastPoint() + 0.35)
	local q = 1200
	local r = 150
	self:LineWarning(m, m + Rotation2D(o, 90, true) * q, r, self:GetCastPoint())
	self:LineWarning(m, m + Rotation2D(o, -90, true) * q, r, self:GetCastPoint())
	return true
end
function k.prototype.OnSpellStart(self)
	local l = self:GetCaster()
	local m = self:GetCursorPosition()
	local n = l:GetAbsOrigin()
	local o = CalcDirection2D(m, n)
	local p = n + o * 600
	local s = self:GetSpecialValueFor("damage")
	l:SimulateCast({
		castPoint = 0.15,
		castAnimation = ACT_SCRIPT_CUSTOM_6,
		duration = 1,
		OnSpellStart = function()
			local t = FindEnemiesInRadius(l, m, self.radius)
			l:DealDamage(t, self, s)
			l:EmitSound("Hero_Axe.Culling_Blade_Success")
			local u = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_axe/axe_culling_blade_kill.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControlTransformForward(u, 3, p, o)
			ParticleManager:SetParticleControlTransformForward(u, 4, p, o)
			self:ShockWave(m, Rotation2D(o, 90, true))
			self:ShockWave(m, Rotation2D(o, -90, true))
			l:EmitSound("Hero_Magnataur.ShockWave.Particle.Anvil")
		end,
	})
	l:Dash(o, CalcDistance(m, l) - 250, 200, 0.25)
end
function k.prototype.ShockWave(self, n, o)
	local l = self:GetCaster()
	local s = self:GetSpecialValueFor("wave_damage")
	Bullet:CreateLinearBullet({
		caster = l,
		spawnOrigin = n,
		moveSpeed = 1800,
		direction = o,
		distance = 1200,
		radius = 150,
		reflectable = true,
		effectName = "particles/econ/items/magnataur/shock_of_the_anvil/magnataur_shockanvil.vpcf",
		OnBulletHit = function(v, m, w)
			l:DealDamage(v, self, s)
		end,
	})
end
e({ h(nil) }, k.prototype, "radius", nil)
k = e({ j(nil) }, k)
return f