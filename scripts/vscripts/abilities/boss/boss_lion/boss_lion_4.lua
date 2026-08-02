--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_lion/boss_lion_4"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayIndexOf
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("abilities.eom_ability")
local i = h.AbilityValue
local j = h.EOMAbility
local k = h.registerEOMAbility
local l = c()
l.name = "boss_lion_4"
d(l, j)
function l.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.SPAWN_OFFSET = 150
	self.PARTICLE_HEIGHT = 75
	self.SECTOR_ANGLE = 60
end
function l.prototype.OnAbilityPhaseStart(self)
	local m = self:GetCaster()
	local n = self:GetCastRange(vec3_zero, nil)
	local o = self:GetCursorPosition()
	local p = CalcDirection2D(o, m:GetAbsOrigin())
	local q = self:GetSpawnPosition(m, p)
	local r = FindEnemiesInRadius(m, o, n, FIND_CLOSEST)
	local s = r[1]
	if IsValid(s) then
		self.target = s
	end
	self:SectorWarning(q, p, n, self.SECTOR_ANGLE, self:GetCastPoint())
	return true
end
function l.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticles(true)
end
function l.prototype.OnSpellStart(self)
	self:DestroyWarningParticles()
	local m = self:GetCaster()
	local n = self:GetCastRange(vec3_zero, nil)
	local o = self:GetCursorPosition()
	local p = CalcDirection2D(o, m:GetAbsOrigin())
	local t = self:GetSpecialValueFor("damage")
	local q = self:GetSpawnPosition(m, p)
	self:FireWave(m, q, p, n, t)
	m:SimulateCast({
		castPoint = 0.1,
		duration = 0.93,
		castAnimation = ACT_SCRIPT_CUSTOM_18,
		OnFinish = function()
			if IsValid(self.target) then
				o = self.target:GetAbsOrigin()
				p = CalcDirection2D(o, m:GetAbsOrigin())
				m:SetForwardVector(p)
				m:FaceTowards(o)
				q = self:GetSpawnPosition(m, p)
				self:SectorWarning(q, p, n, self.SECTOR_ANGLE, 0.5)
				self.target = nil
			end
			m:SimulateCast({
				castPoint = 0.45,
				duration = 1.44,
				castAnimation = ACT_SCRIPT_CUSTOM_19,
				OnSpellStart = function()
					return self:FireWave(m, q, p, n, t)
				end,
			})
		end,
	})
end
function l.prototype.FireWave(self, m, q, p, n, t)
	local u = {}
	m:EmitSound("Lion.Fire")
	Bullet:SplitAction(p, self.count, self.SECTOR_ANGLE / self.count, function(v, w)
		Bullet:CreateLinearBullet({
			caster = m,
			direction = w,
			distance = n,
			moveSpeed = self.speed,
			radius = self.width,
			reflectable = true,
			ability = self,
			spawnOrigin = q,
			ParticleCreator = function(x)
				local y = x.spawnOrigin + x.direction * x.distance
				local z = ParticleManager:CreateParticle(
					"particles/econ/items/queen_of_pain/qop_2022_immortal/queen_2022_scream_of_pain_projectile_blue.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControl(z, 0, x.spawnOrigin + Vector(0, 0, self.PARTICLE_HEIGHT))
				ParticleManager:SetParticleControl(z, 1, y + Vector(0, 0, self.PARTICLE_HEIGHT))
				ParticleManager:SetParticleControl(z, 2, Vector(self.speed, 0, 0))
				return z
			end,
			OnBulletHit = function(s, o, x)
				local A = s:entindex()
				if e(u, A) >= 0 then
					return
				end
				u[#u + 1] = A
				m:DealDamage(s, self, t)
				EmitSoundOn("Hero_Lion.ProjectileImpact", s)
			end,
		})
	end)
end
function l.prototype.GetSpawnPosition(self, m, p)
	return m:GetAbsOrigin() + p * (self:GetSpecialValueFor("width") + self.SPAWN_OFFSET)
end
f({ i(nil) }, l.prototype, "width", nil)
f({ i(nil) }, l.prototype, "count", nil)
f({ i(nil) }, l.prototype, "speed", nil)
l = f({ k(nil) }, l)
return g