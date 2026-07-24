--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_viper_viper_strike_custom", "heroes/hero_viper/viper_viper_strike_custom", LUA_MODIFIER_MOTION_NONE )

viper_viper_strike_custom = class({})

function viper_viper_strike_custom:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function viper_viper_strike_custom:GetCastRange( vLocation, hTarget )
	if self:GetCaster():HasScepter() then
		return 900
	end

	return self.BaseClass.GetCastRange( self, vLocation, hTarget )
end

function viper_viper_strike_custom:GetCooldown( level )
	if self:GetCaster():HasScepter() then
		return 10
	end

	return self.BaseClass.GetCooldown( self, level )
end

function viper_viper_strike_custom:GetManaCost( level )
	if self:GetCaster():HasScepter() then
		return 125
	end

	return self.BaseClass.GetManaCost( self, level )
end

function viper_viper_strike_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	local projectile_speed = self:GetSpecialValueFor( "projectile_speed" )
	local radius = self:GetSpecialValueFor("radius")

	local targets = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	for _,enemy in pairs(targets) do
		local effect = self:PlayEffects( enemy )
		local info = {
			Target = enemy,
			Source = self:GetCaster(),
			Ability = self,	
			EffectName = "",
			iMoveSpeed = 1200,
			bDodgeable = false,
			ExtraData = {
				effect = effect,
			}
		}
		ProjectileManager:CreateTrackingProjectile(info)
	end
end

function viper_viper_strike_custom:OnProjectileHit_ExtraData( target, location, ExtraData )
	self:StopEffects( ExtraData.effect )
	if not target then return end
	if target:TriggerSpellAbsorb( self ) then return end
	local duration = self:GetSpecialValueFor( "duration" )
	target:AddNewModifier( self:GetCaster(), self, "modifier_viper_viper_strike_custom", { duration = duration } )
	target:EmitSound("hero_viper.viperStrikeImpact")
end

function viper_viper_strike_custom:PlayEffects( target )
	local projectile_speed = self:GetSpecialValueFor( "projectile_speed" )
	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_viper/viper_viper_strike_beam.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( particle, 6, Vector( projectile_speed, 0, 0 ) )
	ParticleManager:SetParticleControlEnt( particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControlEnt( particle, 2, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControlEnt( particle, 3, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true )
	ParticleManager:SetParticleControlEnt( particle, 4, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack2", Vector(0,0,0), true )
	ParticleManager:SetParticleControlEnt( particle, 5, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack3", Vector(0,0,0), true )
	target:EmitSound("hero_viper.viperStrike")
	return particle
end

function viper_viper_strike_custom:StopEffects( particle )
	ParticleManager:DestroyParticle( particle, true )
	ParticleManager:ReleaseParticleIndex( particle )
end

modifier_viper_viper_strike_custom = class({})

function modifier_viper_viper_strike_custom:IsPurgable()
	return false
end

function modifier_viper_viper_strike_custom:IsPurgeException()
	return false
end

function modifier_viper_viper_strike_custom:CheckState()
    return
    {
        [MODIFIER_STATE_PASSIVES_DISABLED] = true,
    }
end

function modifier_viper_viper_strike_custom:OnCreated( kv )
	self.as_slow = self:GetAbility():GetSpecialValueFor( "bonus_attack_speed" )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.start_time = GameRules:GetGameTime()
	self.duration = kv.duration
	if not IsServer() then return end
	self:StartIntervalThink( 1 )
	self:OnIntervalThink()
end

function modifier_viper_viper_strike_custom:OnRefresh( kv )
	self.as_slow = self:GetAbility():GetSpecialValueFor( "bonus_attack_speed" )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.start_time = GameRules:GetGameTime()
	self.duration = kv.duration
	if not IsServer() then return end
	self:StartIntervalThink( 1 )
	self:OnIntervalThink()
end

function modifier_viper_viper_strike_custom:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_viper_viper_strike_custom:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow * ( 1 - ( GameRules:GetGameTime()-self.start_time ) / self.duration )
end
function modifier_viper_viper_strike_custom:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow * ( 1 - ( GameRules:GetGameTime()-self.start_time ) / self.duration )
end

function modifier_viper_viper_strike_custom:OnIntervalThink()
	if not IsServer() then return end
	ApplyDamage({ victim = self:GetParent(), damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, attacker = self:GetCaster(), ability = self:GetAbility() })
end

function modifier_viper_viper_strike_custom:GetEffectName()
	return "particles/units/heroes/hero_viper/viper_viper_strike_debuff.vpcf"
end

function modifier_viper_viper_strike_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_viper_viper_strike_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_poison_viper.vpcf"
end

function modifier_viper_viper_strike_custom:StatusEffectPriority()
	return MODIFIER_PRIORITY_HIGH
end