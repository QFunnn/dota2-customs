--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_satyr_shockwave",
	"abilities/creeps_neutral/neutral_satyr_shockwave",
	LUA_MODIFIER_MOTION_NONE
)

neutral_satyr_shockwave = class({})

function neutral_satyr_shockwave:Precache(context)
	PrecacheResource("particle", "particles/neutral_fx/satyr_hellcaller.vpcf", context)
end

function neutral_satyr_shockwave:GetIntrinsicModifierName()
	if not self:GetCaster():IsCreep() then
		return
	end
	return "modifier_satyr_shockwave"
end

function neutral_satyr_shockwave:OnProjectileHit(target, location)
	if not IsServer() then
		return
	end
	if not target then
		return
	end

	local damage = self.damage + target:GetMaxHealth() * self.damage_health / 100

	target:SendNumber(4, damage)
	target:AddNewModifier(
		self.caster,
		self,
		"modifier_generic_silence",
		{ duration = self.silence * (1 - target:GetStatusResistance()) }
	)

	DoDamage({
		victim = target,
		attacker = self.caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	})
	target:EmitSound("n_creep_SatyrHellcaller.Shockwave.Damage")
end

modifier_satyr_shockwave = class(mod_hidden)
function modifier_satyr_shockwave:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.silence = self.ability:GetSpecialValueFor("silence")
	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.damage_health = self.ability:GetSpecialValueFor("damage_health")
	self.ability.speed = self.ability:GetSpecialValueFor("speed")
	self.ability.distance = self.ability:GetSpecialValueFor("distance")
	self.ability.radius = self.ability:GetSpecialValueFor("radius")
end

function modifier_satyr_shockwave:StartCast(target)
	if not IsServer() then
		return
	end

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_neutral_cast",
		{
			target = target and target:entindex() or nil,
			duration = 0.8,
			anim_speed = 0.8,
			anim = ACT_DOTA_CAST_ABILITY_1,
			effect = 1,
			parent_mod = self:GetName(),
		}
	)
end

function modifier_satyr_shockwave:EndCast()
	if not IsServer() then
		return
	end
	local direction = self.parent:GetForwardVector()
	direction.z = 0

	self.parent:EmitSound("n_creep_SatyrHellcaller.Shockwave")

	local info = {
		EffectName = "particles/neutral_fx/satyr_hellcaller.vpcf",
		Ability = self.ability,
		vSpawnOrigin = self.parent:GetAbsOrigin(),
		fStartRadius = 70,
		fEndRadius = self.ability.radius,
		vVelocity = direction * self.ability.speed,
		fDistance = self.ability.distance,
		Source = self.parent,
		bDeleteOnHit = false,
		fExpireTime = GameRules:GetGameTime() + 4,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	}
	ProjectileManager:CreateLinearProjectile(info)
end