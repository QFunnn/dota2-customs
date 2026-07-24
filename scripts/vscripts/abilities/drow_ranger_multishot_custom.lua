--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_drow_ranger_multishot_custom", "abilities/drow_ranger_multishot_custom", LUA_MODIFIER_MOTION_NONE )

drow_ranger_multishot_custom = class({})

function drow_ranger_multishot_custom:Precache(context)
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_multishot_proj_linear_proj.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_base_attack_linear_proj.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/drow/drow_arcana/drow_arcana_shard_hypothermia_death.vpcf", context )
end

function drow_ranger_multishot_custom:GetChannelTime()
	return self.BaseClass.GetChannelTime(self)
end

drow_ranger_multishot_custom.targets = {}

function drow_ranger_multishot_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local duration = self:GetChannelTime()
	if self:GetCaster():HasModifier("modifier_drow_ranger_14") then
		return
	end
	self.targets = {}
	self.modifier = caster:AddNewModifier( caster, self, "modifier_drow_ranger_multishot_custom",  { duration = duration, x = point.x, y = point.y, z = point.z, } )
end

function drow_ranger_multishot_custom:OnProjectileHit_ExtraData( target, location, data )
	if not target then return end

	if self.targets[ target ] == data.wave then return false end

	self.targets[ target ] = data.wave

	local pct = self:GetSpecialValueFor( "arrow_damage_pct" )

	local damage = self:GetCaster():GetAverageTrueAttackDamage(nil) / 100 * pct

	local slow = self:GetSpecialValueFor( "arrow_slow_duration" )

	if data.frost==1 then
		local ability = self:GetCaster():FindAbilityByName( "drow_ranger_frost_arrows_custom" )
		if ability and ability:GetLevel() > 0 then
			target:AddNewModifier( self:GetCaster(), ability, "modifier_drow_ranger_frost_arrows_custom", { duration = slow } )
			damage = damage + ability:GetSpecialValueFor("damage")
		end
	end

	if not target:IsAttackImmune() then
		ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self })
	end

	target:EmitSound("Hero_DrowRanger.ProjectileImpact")
	return true
end

function drow_ranger_multishot_custom:OnChannelFinish( bInterrupted )
	if self.modifier and not self.modifier:IsNull() then self.modifier:Destroy() end
end

modifier_drow_ranger_multishot_custom = class({})

function modifier_drow_ranger_multishot_custom:IsHidden()
	return false
end

function modifier_drow_ranger_multishot_custom:IsDebuff()
	return false
end

function modifier_drow_ranger_multishot_custom:IsStunDebuff()
	return false
end

function modifier_drow_ranger_multishot_custom:IsPurgable()
	return false
end

function modifier_drow_ranger_multishot_custom:OnCreated( kv )
	local count = self:GetAbility():GetSpecialValueFor( "arrow_count_per_wave" )
	
	if self:GetCaster():HasModifier("modifier_drow_ranger_glacier_hilltop") then
		count = count + 1
	end

	local range = self:GetAbility():GetSpecialValueFor( "arrow_range_multiplier" )
	local width = self:GetAbility():GetSpecialValueFor( "arrow_width" )
	self.speed = self:GetAbility():GetSpecialValueFor( "arrow_speed" )
	self.angle = 33.33

	if not IsServer() then return end

	local vision = 100
	local delay = 0.1
	local wave = 3
	local wave_interval = 0.55
	self.arrow_delay = 0.033

	self.arrows = self:GetAbility():GetSpecialValueFor("arrow_count_per_wave")
	self.wave_delay = wave_interval - self.arrow_delay*(self.arrows-1)

	local point = Vector(kv.x, kv.y, kv.z)
	self.direction = point-self:GetCaster():GetOrigin()
	self.direction.z = 0
	self.direction = self.direction:Normalized()

	self.state = STATE_SALVO
	self.current_arrows = 0
	self.current_wave = 0
	self.frost = false

	local ability = self:GetCaster():FindAbilityByName( "drow_ranger_frost_arrows_custom" )

	if ability and ability:GetLevel()>0 then
		self.frost = true
	end

	local caster = self:GetCaster()

	local projectile_name

	if self.frost then
		projectile_name = "particles/units/heroes/hero_drow/drow_multishot_proj_linear_proj.vpcf"
	else
		projectile_name = "particles/units/heroes/hero_drow/drow_base_attack_linear_proj.vpcf"
	end

	self.info = {
		Source = caster,
		Ability = self:GetAbility(),
		vSpawnOrigin = caster:GetAttachmentOrigin( caster:ScriptLookupAttachment( "attach_attack1" ) ),
	    bDeleteOnHit = true,
	    iUnitTargetTeam = self:GetAbility():GetAbilityTargetTeam(),
	    iUnitTargetType = self:GetAbility():GetAbilityTargetType(),
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
	    EffectName = projectile_name,
	    fDistance = caster:Script_GetAttackRange() * range,
	    fStartRadius = width,
	    fEndRadius = width,
		bProvidesVision = true,
		iVisionRadius = vision,
		iVisionTeamNumber = caster:GetTeamNumber()
	}

	self:StartIntervalThink( delay )
	self:GetCaster():EmitSound("Hero_DrowRanger.Multishot.Channel")
end

function modifier_drow_ranger_multishot_custom:OnDestroy()
	if not IsServer() then return end
	self:GetCaster():StopSound("Hero_DrowRanger.Multishot.Channel")
end

function modifier_drow_ranger_multishot_custom:OnIntervalThink()

	if self.current_arrows<self.arrows then
		self:StartIntervalThink( self.arrow_delay )
	else
		self.current_arrows = 0
		self.current_wave = self.current_wave+1

		self:StartIntervalThink( self.wave_delay )
		return
	end

	local step = self.angle/(self.arrows-1)
	local angle = -self.angle/2 + self.current_arrows*step

	local projectile_direction = RotatePosition( Vector(0,0,0), QAngle( 0, angle, 0 ), self.direction )

	self.info.vVelocity = projectile_direction * self.speed
	self.info.ExtraData = {
		arrow = self.current_arrows,
		wave = self.current_wave,
		frost = self.frost,
	}

	ProjectileManager:CreateLinearProjectile(self.info)
	self:PlayEffects()
	self.current_arrows = self.current_arrows+1
end

function modifier_drow_ranger_multishot_custom:PlayEffects()

	local sound_cast

	if self.frost then
		sound_cast = "Hero_DrowRanger.Multishot.FrostArrows"
	else
		sound_cast = "Hero_DrowRanger.Multishot.Attack"
	end

	self:GetCaster():EmitSound(sound_cast)
end