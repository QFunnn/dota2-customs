--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


neutral_satyr_shockwave_active = class({})

function neutral_satyr_shockwave_active:Precache(context)
	PrecacheResource("particle", "particles/neutral_fx/satyr_hellcaller.vpcf", context)
end

function neutral_satyr_shockwave_active:OnSpellStart()
	self.damage = self:GetSpecialValueFor("damage")
	self.damage_health = self:GetSpecialValueFor("damage_health")
	self.silence = self:GetSpecialValueFor("silence")

	local direction = self.caster:GetForwardVector()
	direction.z = 0

	self.caster:EmitSound("n_creep_SatyrHellcaller.Shockwave")

	local info = {
		EffectName = "particles/neutral_fx/satyr_hellcaller.vpcf",
		Ability = self,
		vSpawnOrigin = self.caster:GetAbsOrigin(),
		fStartRadius = 70,
		fEndRadius = self:GetSpecialValueFor("radius"),
		vVelocity = direction * self:GetSpecialValueFor("speed"),
		fDistance = self:GetSpecialValueFor("distance"),
		Source = self.caster,
		bDeleteOnHit = false,
		fExpireTime = GameRules:GetGameTime() + 4,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	}
	ProjectileManager:CreateLinearProjectile(info)
end

function neutral_satyr_shockwave_active:OnProjectileHit(target, location)
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