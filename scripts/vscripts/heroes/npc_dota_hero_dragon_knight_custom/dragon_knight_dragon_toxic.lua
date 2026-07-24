--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_dragon_knight_dragon_toxic", "heroes/npc_dota_hero_dragon_knight_custom/dragon_knight_dragon_toxic", LUA_MODIFIER_MOTION_NONE )

dragon_knight_dragon_toxic = class({})

function dragon_knight_dragon_toxic:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_viper.vsndevts", context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_viper/viper_nethertoxin_proj.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_viper/viper_nethertoxin_debuff.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_viper/viper_nethertoxin.vpcf', context )
end

function dragon_knight_dragon_toxic:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function dragon_knight_dragon_toxic:OnSpellStart()
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

function dragon_knight_dragon_toxic:OnProjectileHit( target, location )
	if target then return false end
	local duration = self:GetSpecialValueFor( "duration" )
	CreateModifierThinker( self:GetCaster(), self, "modifier_dragon_knight_dragon_toxic", { duration = duration }, location, self:GetCaster():GetTeamNumber(), false )
end

function dragon_knight_dragon_toxic:PlayEffects( point )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_viper/viper_nethertoxin_proj.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( 2000, 0, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 5, point )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	self:GetCaster():EmitSound("Hero_Viper.Nethertoxin.Cast")
end

modifier_dragon_knight_dragon_toxic = class({})

function modifier_dragon_knight_dragon_toxic:IsPurgable()
	return false
end

function modifier_dragon_knight_dragon_toxic:OnCreated( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.owner = kv.isProvidedByAura~=1

	if not IsServer() then return end

	if not self.owner then
		self:StartIntervalThink( 1 )
	else
		self:PlayEffects()
	end
end

function modifier_dragon_knight_dragon_toxic:OnRefresh( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
end

function modifier_dragon_knight_dragon_toxic:OnDestroy()
	if not IsServer() then return end
	if not self.owner then return end
	UTIL_Remove( self:GetParent() )
end

function modifier_dragon_knight_dragon_toxic:CheckState()
	local state = {
		[MODIFIER_STATE_PASSIVES_DISABLED] = true,
	}
	return state
end

function modifier_dragon_knight_dragon_toxic:OnIntervalThink()
	local damage = self:GetCaster():GetAgility() / 100 * self:GetAbility():GetSpecialValueFor("damage_agility")
	ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, damage_type = self:GetAbility():GetAbilityDamageType(), ability = self:GetAbility() })
	self:GetParent():EmitSound("Hero_Viper.NetherToxin.Damage")
end

function modifier_dragon_knight_dragon_toxic:IsAura()
	return self.owner
end

function modifier_dragon_knight_dragon_toxic:GetModifierAura()
	return "modifier_dragon_knight_dragon_toxic"
end

function modifier_dragon_knight_dragon_toxic:GetAuraRadius()
	return self.radius
end

function modifier_dragon_knight_dragon_toxic:GetAuraDuration()
	return 0.5
end

function modifier_dragon_knight_dragon_toxic:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_dragon_knight_dragon_toxic:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_dragon_knight_dragon_toxic:GetEffectName()
	if not self.owner then
		return "particles/units/heroes/hero_viper/viper_nethertoxin_debuff.vpcf"
	end
end

function modifier_dragon_knight_dragon_toxic:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_dragon_knight_dragon_toxic:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_viper/viper_nethertoxin.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
	self:AddParticle( effect_cast, false,  false,  -1, false,  false )
	self:GetParent():EmitSound("Hero_Viper.NetherToxin")
end