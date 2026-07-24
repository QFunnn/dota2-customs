--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_dragon_knight_ice_ball", "heroes/npc_dota_hero_dragon_knight_custom/dragon_knight_ice_ball", LUA_MODIFIER_MOTION_NONE )

dragon_knight_ice_ball = class({})

function dragon_knight_ice_ball:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/econ/items/drow/drow_arcana/drow_arcana_frost_arrow_debuff.vpcf', context )
    PrecacheResource( "particle", 'particles/dragon_knight_shard_fireball_2.vpcf', context )
end

function dragon_knight_ice_ball:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function dragon_knight_ice_ball:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	if point == self:GetCaster():GetAbsOrigin() then
		point = point + self:GetCaster():GetForwardVector()
	end

	local vector = point-caster:GetOrigin()

	local projectile_speed = 2000

	local projectile_distance = vector:Length2D()

	local projectile_direction = vector

	projectile_direction.z = 0

	projectile_direction = projectile_direction:Normalized()


	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_NONE,
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	    iUnitTargetType = DOTA_UNIT_TARGET_NONE,
	    EffectName = projectile_name,
	    fDistance = projectile_distance,
	    fStartRadius = 0,
	    fEndRadius = 0,
		vVelocity = projectile_direction * projectile_speed,
	}

	ProjectileManager:CreateLinearProjectile(info)

	self:PlayEffects( point )
end

function dragon_knight_ice_ball:OnProjectileHit( target, location )
	if target then return false end
	local duration = self:GetSpecialValueFor( "duration" )
	CreateModifierThinker( self:GetCaster(), self, "modifier_dragon_knight_ice_ball", { duration = duration }, location, self:GetCaster():GetTeamNumber(), false )
end

function dragon_knight_ice_ball:PlayEffects( point )
	local effect_cast = ParticleManager:CreateParticle( "dragon_knight_shard_fireball_projectile", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true )
	ParticleManager:SetParticleControl( effect_cast, 1, point )
	ParticleManager:SetParticleControl( effect_cast, 3, self:GetCaster():GetAbsOrigin() )
end

modifier_dragon_knight_ice_ball = class({})

function modifier_dragon_knight_ice_ball:IsPurgable()
	return true
end

function modifier_dragon_knight_ice_ball:OnCreated( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.owner = kv.isProvidedByAura~=1

	if not IsServer() then return end

	if not self.owner then
		self:StartIntervalThink( 1 )
	else
		self:PlayEffects()
	end
end

function modifier_dragon_knight_ice_ball:OnRefresh( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
end

function modifier_dragon_knight_ice_ball:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_dragon_knight_ice_ball:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("movespeed_slow")
end

function modifier_dragon_knight_ice_ball:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("attack_speed_slow")
end

function modifier_dragon_knight_ice_ball:OnDestroy()
	if not IsServer() then return end
	if not self.owner then return end
	UTIL_Remove( self:GetParent() )
end

function modifier_dragon_knight_ice_ball:OnIntervalThink()
	if not IsServer() then return end
	if self:GetParent():IsMagicImmune() then self:Destroy() return end
	local damage = self:GetAbility():GetSpecialValueFor("damage") + ( self:GetCaster():GetIntellect(false) / 100 * self:GetAbility():GetSpecialValueFor("intellect_mult") )
	ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, damage_type = self:GetAbility():GetAbilityDamageType(), ability = self:GetAbility() })
end

function modifier_dragon_knight_ice_ball:IsAura()
	return self.owner
end

function modifier_dragon_knight_ice_ball:GetModifierAura()
	return "modifier_dragon_knight_ice_ball"
end

function modifier_dragon_knight_ice_ball:GetAuraRadius()
	return self.radius
end

function modifier_dragon_knight_ice_ball:GetAuraDuration()
	return 2
end

function modifier_dragon_knight_ice_ball:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_dragon_knight_ice_ball:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_dragon_knight_ice_ball:GetEffectName()
	if not self.owner then
		return "particles/econ/items/drow/drow_arcana/drow_arcana_frost_arrow_debuff.vpcf"
	end
end

function modifier_dragon_knight_ice_ball:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_dragon_knight_ice_ball:PlayEffects()
	self.pfx = ParticleManager:CreateParticle("particles/dragon_knight_shard_fireball_2.vpcf", PATTACH_POINT, self:GetParent())
	ParticleManager:SetParticleControl(self.pfx, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(self.pfx, 1, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(self.pfx, 2, Vector(self:GetAbility():GetSpecialValueFor("duration"), 0, 0))
	ParticleManager:SetParticleControl(self.pfx, 3, self:GetParent():GetAbsOrigin())
	self:AddParticle(self.pfx, false, false, 1, false, false)
end