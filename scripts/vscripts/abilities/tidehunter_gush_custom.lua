--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_tidehunter_gush_custom", "abilities/tidehunter_gush_custom", LUA_MODIFIER_MOTION_NONE )

tidehunter_gush_custom = class({})

function tidehunter_gush_custom:Precache(context)
    PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_gush_upgrade.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_gush.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_gush_splash.vpcf", context )
end

function tidehunter_gush_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	if point == self:GetCaster():GetAbsOrigin() then
		point = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector()
	end
    local speed = self:GetSpecialValueFor("speed_scepter")
    local radius = self:GetSpecialValueFor("aoe_scepter")
    local range = self:GetCastRange( point, self:GetCaster() ) + self:GetCaster():GetCastRangeBonus()
    local direction = point-caster:GetOrigin()
    direction.z = 0
    direction = direction:Normalized()

    local info = 
    {
        Source = caster,
        Ability = self,
        vSpawnOrigin = caster:GetAbsOrigin(),
        bDeleteOnHit = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        EffectName = "particles/units/heroes/hero_tidehunter/tidehunter_gush_upgrade.vpcf",
        fDistance = range,
        fStartRadius = radius,
        fEndRadius = radius,
        vVelocity = direction * speed,
        ExtraData = 
        {
            scepter = 1,
        }
    }
    
    ProjectileManager:CreateLinearProjectile( info )
	self:GetCaster():EmitSound("Ability.GushCast")
end

function tidehunter_gush_custom:OnProjectileHit_ExtraData( target, location, data )
	if not target then return end
	if data.scepter==1 then
		local vision = 200
		local duration = 2
		AddFOWViewer( self:GetCaster():GetTeamNumber(), target:GetOrigin(), vision, duration, true )
	end
	local damage = self:GetSpecialValueFor("gush_damage")
	local duration = self:GetDuration()
	target:AddNewModifier( self:GetCaster(), self, "modifier_tidehunter_gush_custom", { duration = duration } )

	local damageTable = 
    {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	}
	ApplyDamage(damageTable)
	target:EmitSound("Ability.GushImpact")
	return false
end

function tidehunter_gush_custom:PlayEffects( target )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_tidehunter/tidehunter_gush_splash.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( effect_cast, 3, target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

modifier_tidehunter_gush_custom = class({})

function modifier_tidehunter_gush_custom:IsHidden()
	return false
end

function modifier_tidehunter_gush_custom:IsDebuff()
	return true
end

function modifier_tidehunter_gush_custom:IsStunDebuff()
	return false
end

function modifier_tidehunter_gush_custom:IsPurgable()
	return true
end

function modifier_tidehunter_gush_custom:OnCreated( kv )
	self.slow = self:GetAbility():GetSpecialValueFor( "movement_speed" )
	self.armor = -self:GetAbility():GetSpecialValueFor( "negative_armor" )
end

function modifier_tidehunter_gush_custom:OnRefresh( kv )
	self.slow = self:GetAbility():GetSpecialValueFor( "movement_speed" )
	self.armor = -self:GetAbility():GetSpecialValueFor( "negative_armor" )
end

function modifier_tidehunter_gush_custom:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_tidehunter_gush_custom:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_tidehunter_gush_custom:GetModifierPhysicalArmorBonus()
	return self.armor
end

function modifier_tidehunter_gush_custom:GetEffectName()
	return "particles/units/heroes/hero_tidehunter/tidehunter_gush_slow.vpcf"
end

function modifier_tidehunter_gush_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end