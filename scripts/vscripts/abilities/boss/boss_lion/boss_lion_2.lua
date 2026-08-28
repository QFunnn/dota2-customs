--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_lion/boss_lion_2"
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
k.name = "boss_lion_2"
d(k, i)
function k.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticles()
end
function k.prototype.OnAbilityPhaseStart(self)
	if IsServer() then
		local l = self:GetCaster()
		local m = self:GetCursorPosition()
		l:SetForwardVector(CalcDirection2D(m, l))
		l:FaceTowards(m)
		local n = self:GetCastRange(vec3_zero, nil)
		local o = FindEnemiesInRadius(l, m, n, FIND_CLOSEST)
		local p = self:GetCastPoint()
		local q = o[1]
		if IsValid(q) then
			local r = 30
			local s = CalcDirection2D(m, l)
			if (m - l:GetAbsOrigin()):Length2D() <= 0 then
				s = CalcDirection2D(q:GetAbsOrigin(), l)
			end
			local t = 30
			local u = (self.count - 1) * t
			Bullet:SplitAction(s, self.count, t, function(v, w, x)
				local y = -u * 0.5 + (x - 1) * t
				local z = l:GetAbsOrigin() + w * n
				local A = self:FacingSupport(z, q, r, n, p, y)
				self:LineWarning(l, A, 100, p)
			end)
			self:LockFacingTarget(q, r)
		end
	end
	return true
end
function k.prototype.CreateBullet(self, w)
	local l = self:GetCaster()
	local n = self:GetCastRange(vec3_zero, nil)
	local z = l:GetAbsOrigin() + w * 200
	Bullet:CreateLinearBullet({
		ability = self,
		caster = l,
		effectName = "particles/units/heroes/hero_lion/lion_spell_impale.vpcf",
		spawnOrigin = z,
		direction = w,
		moveSpeed = self.speed,
		distance = n,
		radius = self.width,
		teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
		typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		OnBulletHit = function(q, B, C)
			q:KnockBack(vec3_zero, 0, 350, 0.5)
			l:DealDamage(q, self, self:GetSpecialValueFor("damage"))
			local D = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_lion/lion_spell_impale_hit_spikes.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				q
			)
			ParticleManager:ReleaseParticleIndex(D)
			EmitSoundOn("Hero_Lion.ImpaleHitTarget", q)
		end,
	})
end
function k.prototype.OnSpellStart(self)
	local l = self:GetCaster()
	local E = AnglesToVector(l:GetLocalAngles())
	local t = 30
	l:SimulateCast({
		castPoint = 0.1,
		castAnimation = ACT_SCRIPT_CUSTOM_12,
		duration = 0.73,
		OnSpellStart = function()
			Bullet:SplitAction(E, self.count, t, function(v, w)
				self:CreateBullet(w)
			end)
			l:EmitSound("Hero_Lion.Impale")
		end,
	})
end
e({ h(nil) }, k.prototype, "width", nil)
e({ h(nil) }, k.prototype, "speed", nil)
e({ h(nil) }, k.prototype, "count", nil)
k = e({ j(nil) }, k)
return f