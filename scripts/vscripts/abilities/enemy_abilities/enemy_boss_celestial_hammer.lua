--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/enemy_abilities/enemy_boss_celestial_hammer"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIndexOf
local g = b.__TS__ArraySplice
local h = {}
local i = require("modifiers.eom_modifier.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = require("abilities.bt_ability_ai")
local m = l.EOMBTAbilityAI
local n = require("abilities.eom_ability")
local o = n.registerEOMAbility
local p = c()
p.name = "enemy_boss_celestial_hammer"
d(p, m)
function p.prototype.GetLinearStartWidth(self)
	return self:GetSpecialValueFor("width")
end
function p.prototype.OnAbilityPhaseStart(self)
	self.dir = {}
	local q = self:GetCaster()
	local r = q:GetHealthPercent() > 50 and 1 or 2
	local s = self:GetLevelSpecialValueFor("hammer_count", r)
	local t = self:GetCursorPosition()
	local u = q:GetAbsOrigin()
	local v = CalcDirection(t, u)
	local w = self:GetCastRange(vec3_zero, nil)
	Bullet:SplitAction(v, s, 30, function(x, y)
		local z = u + y * w
		self:CreateLinerWarningParticle(u, z)
		local A = self.dir
		A[#A + 1] = y
	end)
	return true
end
function p.prototype.OnAbilityPhaseInterrupted(self)
	self.dir = {}
	self:DestroyWarningParticle()
end
function p.prototype.OnSpellStart(self)
	self:DestroyWarningParticle()
	local q = self:GetCaster()
	local B = self:GetSpecialValueFor("speed")
	local C = self:GetLinearStartWidth()
	local D = self:GetSpecialValueFor("damage")
	local E = self:GetCastRange(vec3_zero, nil)
	local F = q:AddNewModifier(q, self, "modifier_enemy_boss_celestial_hammer", { duration = 10 })
	for x, y in ipairs(self.dir) do
		local G = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_dawnbreaker/dawnbreaker_celestial_hammer_projectile.vpcf",
			PATTACH_POINT,
			q
		)
		local H = y * B
		Bullet:CreateGuidedBullet({
			ability = self,
			caster = q,
			spawnOrigin = q:GetAttachmentPosition("attach_attack1"),
			direction = y,
			moveSpeed = B,
			radius = C,
			lifeTime = E / B,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			OnBulletHit = function(I, J, K)
				q:DealDamage(I, self, D)
				local L = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_dawnbreaker/dawnbreaker_celestial_hammer_aoe_impact.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					I
				)
				ParticleManager:SetParticleControl(L, 1, Vector(C, C, C))
				ParticleManager:ReleaseParticleIndex(L)
				q:EmitSound("Hero_Dawnbreaker.Celestial_Hammer.Damage")
			end,
			OnBulletDestroy = function(K)
				ParticleManager:DestroyParticle(G, true)
				ParticleManager:ReleaseParticleIndex(G)
				if IsValid(F) then
					F:CreateHammer(K.__position)
				end
			end,
		})
		ParticleManager:SetParticleControl(G, 1, H)
		ParticleManager:SetParticleControl(G, 4, Vector(3, 0, 0))
	end
	q:EmitSound("Hero_Dawnbreaker.Celestial_Hammer.Cast")
end
p = e({ o(nil) }, p)
local M = c()
M.name = "modifier_enemy_boss_celestial_hammer_dash"
d(M, j)
function M.prototype.OnCreated(self, N)
	if IsServer() then
		local O = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_dawnbreaker/dawnbreaker_converge_trail.vpcf",
			PATTACH_ABSORIGIN,
			self.parent
		)
		ParticleManager:SetParticleControlEnt(
			O,
			1,
			self.parent,
			PATTACH_ABSORIGIN_FOLLOW,
			"attach_hitloc",
			Vector(0, 0, 0),
			true
		)
		ParticleManager:SetParticleControlForward(O, 0, self.parent:GetForwardVector())
		self:AddParticle(O, false, false, -1, false, false)
	end
end
M = e(
	{ k(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	M
)
local P = c()
P.name = "modifier_enemy_boss_celestial_hammer"
d(P, j)
function P.prototype.GetAbilitySpecialValue(self)
	self.speed = self:GetAbilitySpecialValueFor("speed")
	self.return_speed = self:GetAbilitySpecialValueFor("return_speed")
	self.width = self:GetAbilitySpecialValueFor("width")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.hammer_stu_time = self:GetAbilitySpecialValueFor("hammer_stu_time")
	self.stagger_duration = self:GetAbilitySpecialValueFor("stagger_duration")
end
function P.prototype.OnCreated(self, N)
	self.hammerParticleId = {}
	self.bulletParticleId = {}
	self.hammerPos = {}
	self["return"] = false
end
function P.prototype.OnDestroy(self)
	if IsServer() then
		for x, G in ipairs(self.bulletParticleId) do
			ParticleManager:DestroyParticle(G, true)
		end
		self.bulletParticleId = {}
		for x, Q in ipairs(self.hammerParticleId) do
			ParticleManager:DestroyParticle(Q, true)
		end
		self.hammerParticleId = {}
	end
end
function P.prototype.OnIntervalThink(self)
	if IsServer() then
		self:StartIntervalThink(-1)
		self["return"] = true
		self:ReturnHammer()
	end
end
function P.prototype.CreateHammer(self, R)
	if self["return"] == true then
		return
	end
	local Q = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_dawnbreaker/dawnbreaker_celestial_hammer_grounded.vpcf",
		PATTACH_POINT,
		self.parent
	)
	ParticleManager:SetParticleControl(Q, 0, R)
	ParticleManager:SetParticleControlForward(Q, 0, CalcDirection(R, self.parent))
	local S = self.hammerParticleId
	S[#S + 1] = Q
	local T = self.hammerPos
	T[#T + 1] = R
	self:StartIntervalThink(self.hammer_stu_time)
	self.parent:EmitSound("Hero_Dawnbreaker.Celestial_Hammer.Impact")
end
function P.prototype.ReturnHammer(self)
	for x, Q in ipairs(self.hammerParticleId) do
		ParticleManager:DestroyParticle(Q, true)
	end
	self.hammerParticleId = {}
	local U = self.parent:GetAbsOrigin().x
	local V = self.parent:GetAbsOrigin().y
	local W = self.parent:GetAbsOrigin().z
	for x, X in ipairs(self.hammerPos) do
		U = U + X.x
		V = V + X.y
		W = W + X.z
	end
	local s = #self.hammerPos + 1
	local Y = Vector(U / s, V / s, W / s)
	self.parent:EmitSound("Hero_Dawnbreaker.Converge.Cast")
	local O = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_dawnbreaker/dawnbreaker_converge.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(
		O,
		3,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:ReleaseParticleIndex(O)
	for x, R in ipairs(self.hammerPos) do
		local E = CalcDistance(Y, R)
		local v = CalcDirection(Y, R)
		self.parent:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_enemy_boss_celestial_hammer_dash",
			{ duration = E / self.return_speed }
		)
		self.parent:Dash(v * -1, E, 0, E / self.return_speed)
		local G = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_dawnbreaker/dawnbreaker_celestial_hammer_return.vpcf",
			PATTACH_POINT,
			self.parent
		)
		Bullet:CreateGuidedBullet({
			ability = self.ability,
			caster = self.parent,
			effectName = "",
			spawnOrigin = R,
			direction = v,
			moveSpeed = self.return_speed,
			radius = self.width,
			lifeTime = E / self.return_speed,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			OnBulletHit = function(I, J, K)
				self.parent:DealDamage(I, self.ability, self.damage)
				I:EmitSound("Hero_Dawnbreaker.Celestial_Hammer.Damage")
			end,
			OnBulletDestroy = function(K)
				ParticleManager:DestroyParticle(G, true)
				local Z = f(self.bulletParticleId, G)
				if Z > -1 then
					g(self.bulletParticleId, Z, 1)
				end
				if #self.bulletParticleId == 0 then
					self:Destroy()
				end
			end,
		})
		ParticleManager:SetParticleControl(G, 0, R)
		ParticleManager:SetParticleControl(G, 1, self.parent:GetAttachmentPosition("attach_attack1"))
		ParticleManager:SetParticleControl(G, 2, Vector(self.return_speed, 0, 0))
		ParticleManager:SetParticleControl(G, 4, Vector(3, 0, 0))
		local _ = self.bulletParticleId
		_[#_ + 1] = G
	end
end
function P.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_SILENCED] = true }
end
function P.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DISABLE_TURNING, MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function P.prototype.GetModifierDisableTurning(self)
	return 1
end
function P.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_DEFEAT
end
function P.prototype.GetActivityTranslationModifiers(self)
	return "no_hammer"
end
P = e(
	{ k(
		a,
		{ IsHidden = false, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	P
)
return h