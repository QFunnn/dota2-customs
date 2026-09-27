--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_neutral_frog_tendrils",
	"abilities/creeps_neutral/neutral_frog_tendrils",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_neutral_frog_tendrils_stun",
	"abilities/creeps_neutral/neutral_frog_tendrils",
	LUA_MODIFIER_MOTION_NONE
)

neutral_frog_tendrils = class({})

function neutral_frog_tendrils:Precache(context)
	PrecacheResource("particle", "particles/neutral_fx/frogmen_arm_of_the_deep_projectile.vpcf", context)
	PrecacheResource("particle", "particles/neutral_fx/frogmen_arm_of_the_deep_hit.vpcf", context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_stunned.vpcf", context)
end

function neutral_frog_tendrils:GetIntrinsicModifierName()
	return "modifier_neutral_frog_tendrils"
end

function neutral_frog_tendrils:OnProjectileHit(target, location)
	if not IsServer() then
		return
	end
	if not target then
		return
	end
	if target:HasModifier("modifier_neutral_frog_tendrils_stun") then
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
		"modifier_neutral_frog_tendrils_stun",
		{ duration = self.stun * (1 - target:GetStatusResistance()) }
	)
end

neutral_frog_tendrils_2 = class(neutral_frog_tendrils)
neutral_frog_tendrils_3 = class(neutral_frog_tendrils)

modifier_neutral_frog_tendrils = class(mod_hidden)
function modifier_neutral_frog_tendrils:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability:SetLevel(1)

	self.ability.toss_duration = self.ability:GetSpecialValueFor("toss_duration")
	self.ability.speed = self.ability:GetSpecialValueFor("speed")
	self.ability.distance = self.ability:GetSpecialValueFor("distance")
	self.ability.width = self.ability:GetSpecialValueFor("width")
	self.ability.shared_cd = self.ability:GetSpecialValueFor("shared_cd")
	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.damage_health = self.ability:GetSpecialValueFor("damage_health")
	self.ability.stun = self.ability:GetSpecialValueFor("stun")
	self.ability.count = self.ability:GetSpecialValueFor("count")
end

function modifier_neutral_frog_tendrils:StartCast(target)
	if not IsServer() then
		return
	end

	for _, ally in pairs(self.parent:FindFriends(1000)) do
		if ally ~= self.parent then
			local ability = ally:FindAbilityByName(self.ability:GetAbilityName())
			if ability then
				local cd = ally:FindModifierByName("modifier_neutral_cast_cd")
				if not cd or cd:GetRemainingTime() < self.ability.shared_cd then
					ally:AddNewModifier(
						ally,
						ability,
						"modifier_neutral_cast_cd",
						{ duration = self.ability.shared_cd }
					)
				end
			end
		end
	end

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_neutral_cast",
		{
			target = target and target:entindex() or nil,
			duration = 1,
			anim_speed = 0.5,
			anim = ACT_DOTA_CAST_ABILITY_5,
			effect = 1,
			parent_mod = self:GetName(),
		}
	)
end

function modifier_neutral_frog_tendrils:EndCast()
	if not IsServer() then
		return
	end
	local direction = self.parent:GetForwardVector()
	direction.z = 0

	self.parent:EmitSound("n_frogs.ArmOfTheDeep")

	for i = 1, self.ability.count do
		local info = {
			Source = self.parent,
			Ability = self.ability,
			EffectName = "particles/neutral_fx/frogmen_arm_of_the_deep_projectile.vpcf",
			vSpawnOrigin = self.parent:GetAbsOrigin(),
			fDistance = self.ability.distance,
			fStartRadius = self.ability.width,
			fEndRadius = self.ability.width,
			vVelocity = RotatePosition(Vector(0, 0, 0), QAngle(0, (i - 1) * 360 / self.ability.count, 0), direction)
				* self.ability.speed,
			bDeleteOnHit = false,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		}
		ProjectileManager:CreateLinearProjectile(info)
	end
end

modifier_neutral_frog_tendrils_stun = class(mod_visible)
function modifier_neutral_frog_tendrils_stun:IsPurgeException()
	return true
end
function modifier_neutral_frog_tendrils_stun:IsStunDebuff()
	return true
end
function modifier_neutral_frog_tendrils_stun:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end
function modifier_neutral_frog_tendrils_stun:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_neutral_frog_tendrils_stun:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not self.parent:IsDebuffImmune() then
		self.parent:InterruptMotionControllers(false)
	end

	self.knockback = self.parent:AddNewModifier(self.caster, self.ability, "modifier_knockback", {
		center_x = self.parent:GetAbsOrigin().x,
		center_y = self.parent:GetAbsOrigin().y,
		center_z = self.parent:GetAbsOrigin().z,
		knockback_distance = 0,
		knockback_height = 350,
		duration = self.ability.toss_duration,
		knockback_duration = self.ability.toss_duration,
		should_stun = true,
	})

	self.parent:StartGesture(ACT_DOTA_FLAIL)
	self:StartIntervalThink(self.ability.toss_duration)
end

function modifier_neutral_frog_tendrils_stun:OnIntervalThink()
	if not IsServer() then
		return
	end
	self.parent:RemoveGesture(ACT_DOTA_FLAIL)
	self.parent:StartGesture(ACT_DOTA_DISABLED)
	self:StartIntervalThink(-1)
end

function modifier_neutral_frog_tendrils_stun:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
	}
end

function modifier_neutral_frog_tendrils_stun:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:RemoveGesture(ACT_DOTA_DISABLED)
	self.parent:RemoveGesture(ACT_DOTA_FLAIL)
end