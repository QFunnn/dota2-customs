--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_neutral_frog_tendrils_active_stun",
	"abilities/creeps_neutral_active/neutral_frog_tendrils_active",
	LUA_MODIFIER_MOTION_NONE
)

neutral_frog_tendrils_active = class({})

function neutral_frog_tendrils_active:Precache(context)
	PrecacheResource("particle", "particles/neutral_fx/frogmen_arm_of_the_deep_projectile.vpcf", context)
	PrecacheResource("particle", "particles/neutral_fx/frogmen_arm_of_the_deep_hit.vpcf", context)
end

function neutral_frog_tendrils_active:GetPlaybackRateOverride()
	return 0.6
end

function neutral_frog_tendrils_active:OnSpellStart()
	local point = self:GetCursorPosition()
	local origin = self.caster:GetAbsOrigin()

	if point == origin then
		point = origin + self.caster:GetForwardVector() * 10
	end

	local direction = point - origin
	direction.z = 0
	direction = direction:Normalized()

	self.damage = self:GetSpecialValueFor("damage")
	self.damage_health = self:GetSpecialValueFor("damage_health")
	self.stun = self:GetSpecialValueFor("stun")
	self.count = self:GetSpecialValueFor("count")
	self.speed = self:GetSpecialValueFor("speed")
	self.distance = self:GetSpecialValueFor("distance")
	self.width = self:GetSpecialValueFor("width")

	self.caster:EmitSound("n_frogs.ArmOfTheDeep")

	for i = 1, self.count do
		local info = {
			Source = self.caster,
			Ability = self,
			EffectName = "particles/neutral_fx/frogmen_arm_of_the_deep_projectile.vpcf",
			vSpawnOrigin = origin,
			fDistance = self.distance,
			fStartRadius = self.width,
			fEndRadius = self.width,
			vVelocity = RotatePosition(Vector(0, 0, 0), QAngle(0, (i - 1) * 360 / self.count, 0), direction)
				* self.speed,
			bDeleteOnHit = false,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		}
		ProjectileManager:CreateLinearProjectile(info)
	end
end

function neutral_frog_tendrils_active:OnProjectileHit(target, location)
	if not IsServer() then
		return
	end
	if not target then
		return
	end
	if target:HasModifier("modifier_neutral_frog_tendrils_active_stun") then
		return
	end

	target:EmitSound("n_frogs.ArmOfTheDeep.Stun")

	local particle = ParticleManager:CreateParticle(
		"particles/neutral_fx/frogmen_arm_of_the_deep_hit.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(particle, 0, GetGroundPosition(target:GetAbsOrigin(), nil))
	ParticleManager:ReleaseParticleIndex(particle)

	DoDamage({
		victim = target,
		attacker = self.caster,
		damage = self.damage + target:GetMaxHealth() * self.damage_health / 100,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	})
	target:AddNewModifier(
		self.caster,
		self,
		"modifier_neutral_frog_tendrils_active_stun",
		{ duration = self.stun * (1 - target:GetStatusResistance()) }
	)
end

neutral_frog_tendrils_2_active = class(neutral_frog_tendrils_active)
neutral_frog_tendrils_3_active = class(neutral_frog_tendrils_active)

modifier_neutral_frog_tendrils_active_stun = class(mod_visible)
function modifier_neutral_frog_tendrils_active_stun:IsPurgeException()
	return true
end
function modifier_neutral_frog_tendrils_active_stun:IsStunDebuff()
	return true
end
function modifier_neutral_frog_tendrils_active_stun:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end
function modifier_neutral_frog_tendrils_active_stun:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_neutral_frog_tendrils_active_stun:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.toss_duration = self.ability:GetSpecialValueFor("toss_duration")

	if not self.parent:IsDebuffImmune() then
		self.parent:InterruptMotionControllers(false)
	end

	self.knockback = self.parent:AddNewModifier(self.caster, self.ability, "modifier_knockback", {
		center_x = self.parent:GetAbsOrigin().x,
		center_y = self.parent:GetAbsOrigin().y,
		center_z = self.parent:GetAbsOrigin().z,
		knockback_distance = 0,
		knockback_height = 350,
		duration = self.toss_duration,
		knockback_duration = self.toss_duration,
		should_stun = true,
	})

	self.parent:StartGesture(ACT_DOTA_FLAIL)
	self:StartIntervalThink(self.toss_duration)
end

function modifier_neutral_frog_tendrils_active_stun:OnIntervalThink()
	if not IsServer() then
		return
	end
	self.parent:RemoveGesture(ACT_DOTA_FLAIL)
	self.parent:StartGesture(ACT_DOTA_DISABLED)
	self:StartIntervalThink(-1)
end

function modifier_neutral_frog_tendrils_active_stun:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
	}
end

function modifier_neutral_frog_tendrils_active_stun:OnDestroy()
	if not IsServer() then
		return
	end
	if IsValid(self.knockback) then
		self.knockback:Destroy()
	end

	self.parent:FadeGesture(ACT_DOTA_DISABLED)
end