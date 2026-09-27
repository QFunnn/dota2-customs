--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


npc_boar_spit = class({})

function npc_boar_spit:Precache(context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_has_quest.vpcf", context)
	PrecacheResource("particle", "particles/creatures/quill_beast/test_model_cluster_linear_projectile.vpcf", context)
end

function npc_boar_spit:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.damage = self:GetLevelSpecialValueFor("damage", 1)
	self.duration = self:GetLevelSpecialValueFor("duration", 1)
	self.speed = self:GetLevelSpecialValueFor("speed", 1)
	self.distance = self:GetLevelSpecialValueFor("distance", 1)
	self.radius = self:GetLevelSpecialValueFor("radius", 1)
end

function npc_boar_spit:OnAbilityPhaseStart()
	self.sign = ParticleManager:CreateParticle(
		"particles/generic_gameplay/generic_has_quest.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self.caster
	)
	self.caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 0.6)
	return true
end

function npc_boar_spit:OnAbilityPhaseInterrupted()
	ParticleManager:Delete(self.sign, 2)
	self.caster:RemoveGesture(ACT_DOTA_ATTACK)
end

function npc_boar_spit:OnSpellStart()
	ParticleManager:Delete(self.sign, 2)

	local dir = self.caster:CastPosition(self:GetCursorPosition()) - self.caster:GetAbsOrigin()
	dir.z = 0

	self.caster:EmitSound("Hero_Bristleback.ViscousGoo.Cast")

	local info = {
		EffectName = "particles/creatures/quill_beast/test_model_cluster_linear_projectile.vpcf",
		Ability = self,
		vSpawnOrigin = self.caster:GetOrigin(),
		fStartRadius = self.radius,
		fEndRadius = self.radius,
		vVelocity = dir:Normalized() * self.speed,
		fDistance = self.distance,
		Source = self.caster,
		bDeleteOnHit = true,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	}

	ProjectileManager:CreateLinearProjectile(info)
end

function npc_boar_spit:OnProjectileHit(target, location)
	if not target then
		return true
	end

	self.caster:EmitSound("Hero_Bristleback.ViscousGoo.Target")
	target:AddNewModifier(
		self.caster,
		self,
		"modifier_stunned",
		{ duration = self.duration * (1 - target:GetStatusResistance()) }
	)
	DoDamage({
		victim = target,
		attacker = self.caster,
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	})
	return true
end