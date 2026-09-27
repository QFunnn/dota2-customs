--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_tinker_warp_grenade_custom_silence",
	"abilities/tinker/tinker_warp_grenade_custom",
	LUA_MODIFIER_MOTION_NONE
)

tinker_warp_grenade_custom = class({})
function tinker_warp_grenade_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/units/heroes/hero_tinker/tinker_shard_warp_flare.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_tinker/tinker_shard_warp_start_b.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_tinker/tinker_shard_warp_debuff.vpcf", context)
end

function tinker_warp_grenade_custom:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	if IsServer() then
		self:SetLevel(1)
	end

	self.damage = self:GetLevelSpecialValueFor("damage", 1)
	self.silence = self:GetLevelSpecialValueFor("silence", 1)
	self.slow = self:GetLevelSpecialValueFor("slow", 1)
	self.speed = self:GetLevelSpecialValueFor("speed", 1)
	self.max_range = self:GetLevelSpecialValueFor("max_range", 1)
	self.knock_range = self:GetLevelSpecialValueFor("knock_range", 1)
	self.rearm_cd = self:GetLevelSpecialValueFor("rearm_cd", 1) / 100
end

function tinker_warp_grenade_custom:OnSpellStart()
	local target = self:GetCursorTarget()
	local info = {
		EffectName = "particles/units/heroes/hero_tinker/tinker_shard_warp_flare.vpcf",
		Ability = self,
		iMoveSpeed = self.speed,
		Source = self.caster,
		bDodgeable = true,
		Target = target,
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
	}
	self.caster:EmitSound("Hero_Tinker.Warp.Cast")
	ProjectileManager:CreateTrackingProjectile(info)
end

function tinker_warp_grenade_custom:OnProjectileHit(target, vLocation)
	if not target then
		return
	end
	if target:TriggerSpellAbsorb(self) then
		return
	end
	if target:IsInvulnerable() then
		return
	end

	target:EmitSound("Hero_Tinker.Warp.Target")

	local dir = target:GetAbsOrigin() - self.caster:GetAbsOrigin()
	if dir:Length2D() > self.max_range then
		dir = self.caster:GetAbsOrigin() - target:GetAbsOrigin()
	end
	dir.z = 0

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_tinker/tinker_shard_warp_start_b.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
	ParticleManager:SetParticleControlForward(particle, 0, dir:Normalized())
	ParticleManager:ReleaseParticleIndex(particle)

	DoDamage({
		victim = target,
		attacker = self.caster,
		damage = self.damage,
		ability = self,
		damage_type = DAMAGE_TYPE_MAGICAL,
	})

	local point = target:GetAbsOrigin() + dir:Normalized() * self.knock_range
	if not target:IsDebuffImmune() then
		FindClearSpaceForUnit(target, point, true)
	end

	target:AddNewModifier(
		self.caster,
		self,
		"modifier_tinker_warp_grenade_custom_silence",
		{ duration = (1 - target:GetStatusResistance()) * self.silence }
	)
end

modifier_tinker_warp_grenade_custom_silence = class(mod_hidden)
function modifier_tinker_warp_grenade_custom_silence:IsPurgable()
	return true
end
function modifier_tinker_warp_grenade_custom_silence:GetEffectName()
	return "particles/generic_gameplay/generic_silenced.vpcf"
end
function modifier_tinker_warp_grenade_custom_silence:ShouldUseOverheadOffset()
	return true
end
function modifier_tinker_warp_grenade_custom_silence:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_tinker_warp_grenade_custom_silence:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end
	self.parent:GenericParticle("particles/units/heroes/hero_tinker/tinker_shard_warp_debuff.vpcf", self)
end

function modifier_tinker_warp_grenade_custom_silence:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_tinker_warp_grenade_custom_silence:GetModifierMoveSpeedBonus_Percentage()
	return self.ability.slow
end

function modifier_tinker_warp_grenade_custom_silence:CheckState()
	return {
		[MODIFIER_STATE_SILENCED] = true,
	}
end