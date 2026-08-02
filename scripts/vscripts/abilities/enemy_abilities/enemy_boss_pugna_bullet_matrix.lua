--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_boss_pugna_bullet_matrix"
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
k.name = "enemy_boss_pugna_bullet_matrix"
d(k, h)
function k.prototype.GetLinearStartWidth(self)
	return self:GetSpecialValueFor("width")
end
function k.prototype.OnAbilityPhaseStart(self)
	local l = self:GetCaster()
	local m = l:GetAbsOrigin()
	local n = self:GetCursorPosition()
	self.direction = CalcDirection(n, m)
	local o = self:GetSpecialValueFor("distance")
	self:CreateLinerWarningParticle(m, m + self.direction * o)
	l:EmitSound("Hero_Pugna.LifeDrain.Cast")
	return true
end
function k.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticle()
end
function k.prototype.OnSpellStart(self)
	self:DestroyWarningParticle()
	local l = self:GetCaster()
	local p = 4
	local o = self:GetSpecialValueFor("distance")
	local q = self:GetSpecialValueFor("speed")
	local r = self:GetSpecialValueFor("width")
	local s = self:GetSpecialValueFor("angular_velocity")
	local t = self:GetSpecialValueFor("bounce_count")
	local u = self:GetSpecialValueFor("blast_times")
	local v = "particles/econ/items/rubick/rubick_arcana/rbck_arc_skeletonking_hellfireblast.vpcf"
	local function w(x, y, z)
		return {
			caster = l,
			direction = y,
			ability = self,
			ignoreBlock = true,
			effectName = v,
			spawnOrigin = z,
			moveSpeed = q,
			radius = r,
			lifeTime = o / q,
			angularVelocity = s,
			bounce = t,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			flagFilter = DOTA_UNIT_TARGET_FLAG_NONE,
			OnBulletHit = function(A, n, B)
				l:DealDamage(A, self, self:GetSpecialValueFor("damage"))
			end,
		}
	end
	local C = 45
	local D = 3
	local E = 0.2
	local function F(self, B, G)
		if G >= D then
			return
		end
		local m = B.__position
		EmitSoundOnLocationWithCaster(m, "Hero_SkeletonKing.Hellfire_BlastImpact", l)
		local H = Rotation2D(B.__velocity:Normalized(), C, true)
		local I = ParticleManager:CreateParticle(
			"particles/econ/items/rubick/rubick_arcana/rbck_arc_skeletonking_hellfireblast_explosion.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(I, 0, m)
		ParticleManager:ReleaseParticleIndex(I)
		local J = {}
		local K = {}
		Bullet:SplitAction(H, p, 360 / p, function(x, L)
			J[#J + 1] = L
			local M = ParticleManager:CreateParticle("particles/warning/linear.vpcf", PATTACH_WORLDORIGIN, l)
			ParticleManager:SetParticleControl(M, 0, m)
			ParticleManager:SetParticleControl(M, 1, m + L * o)
			ParticleManager:SetParticleControl(M, 2, Vector(r, E, 0))
			K[#K + 1] = M
		end)
		l:GameTimer(E, function()
			if not IsValid(l) then
				return
			end
			for x, N in ipairs(K) do
				ParticleManager:DestroyParticle(N, true)
				ParticleManager:ReleaseParticleIndex(N)
			end
			for x, L in ipairs(J) do
				local O = w(nil, L, m)
				if u >= 2 then
					O.OnBulletDestroy = function(P)
						return F(nil, P, G + 1)
					end
				end
				Bullet:CreateGuidedBullet(O)
			end
		end)
	end
	local Q = w(nil, self.direction, l:GetAbsOrigin() + self.direction * l:GetHullRadius())
	if u >= 1 then
		Q.OnBulletDestroy = function(B)
			return F(nil, B, 1)
		end
	end
	Bullet:CreateGuidedBullet(Q)
	local M = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_skeletonking/skeletonking_hellfireblast_warmup.vpcf",
		PATTACH_CUSTOMORIGIN,
		l
	)
	ParticleManager:SetParticleControlEnt(M, 0, l, PATTACH_POINT_FOLLOW, "attach_attack2", l:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(M)
	l:EmitSound("Hero_SkeletonKing.Hellfire_Blast")
end
k = e({ j(nil) }, k)
return f