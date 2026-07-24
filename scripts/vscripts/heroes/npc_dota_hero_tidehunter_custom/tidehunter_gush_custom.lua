--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_tidehunter_gush_custom", "heroes/npc_dota_hero_tidehunter_custom/tidehunter_gush_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_arc_lua_tidehunter", "heroes/npc_dota_hero_tidehunter_custom/tidehunter_ravage_custom", LUA_MODIFIER_MOTION_BOTH )

tidehunter_gush_custom = class({})

tidehunter_gush_custom.modifier_tidehunter_15 = {50,100,150}
tidehunter_gush_custom.modifier_tidehunter_16 = {-10,-20,-30}
tidehunter_gush_custom.modifier_tidehunter_19_distance = 5
tidehunter_gush_custom.modifier_tidehunter_19_damage = 3
tidehunter_gush_custom.modifier_tidehunter_20 = {-15,-30}
tidehunter_gush_custom.modifier_tidehunter_21 = {1,2,3}

function tidehunter_gush_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_gush_upgrade.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_gush.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_gush_splash.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_tidehunter.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_tidehunter.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_tidehunter.vpcf", context)
end

function tidehunter_gush_custom:GetCooldown( level )
	return self.BaseClass.GetCooldown( self, level )
end

function tidehunter_gush_custom:GetCastRange( vLocation, hTarget )
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_tidehunter_21") then
		bonus = self:GetCaster():GetIntellect(false) * self.modifier_tidehunter_21[self:GetCaster():GetTalentLevel("modifier_tidehunter_21")]
	end
	return self.BaseClass.GetCastRange( self, vLocation, hTarget ) + bonus
end

function tidehunter_gush_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_tidehunter_17") then
		return DOTA_ABILITY_BEHAVIOR_POINT
	end

	return self.BaseClass.GetBehavior( self )
end

function tidehunter_gush_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	if point == self:GetCaster():GetAbsOrigin() then
		point = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector()
	end

	if caster:HasModifier("modifier_tidehunter_17") then
		if target then point = target:GetOrigin() end
		local speed = self:GetSpecialValueFor("speed_scepter")
		local radius = self:GetSpecialValueFor("aoe_scepter")
		local range = self:GetCastRange( point, target ) + self:GetCaster():GetCastRangeBonus()
		local direction = point-caster:GetOrigin()
		direction.z = 0
		direction = direction:Normalized()

		local info = {
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
			ExtraData = {
				scepter = 1,
			}
		}
		ProjectileManager:CreateLinearProjectile( info )
	else
		local speed = self:GetSpecialValueFor("projectile_speed")
		local info = {
			Target = target,
			Source = caster,
			Ability = self,	
			EffectName = "particles/units/heroes/hero_tidehunter/tidehunter_gush.vpcf",
			iSourceAttachment	= DOTA_PROJECTILE_ATTACHMENT_ATTACK_2, -- Need to put the mouth?
			iMoveSpeed = speed,
			bDodgeable = true,
			ExtraData = {
				scepter = 0,
			}
		}
		ProjectileManager:CreateTrackingProjectile(info)
	end

	self:GetCaster():EmitSound("Ability.GushCast")
end

function tidehunter_gush_custom:OnProjectileHit_ExtraData( target, location, data )
	if not target then return end

	if data.scepter==0 and target:TriggerSpellAbsorb( self ) then return end

	if data.scepter==1 then
		local vision = 200
		local duration = 2
		AddFOWViewer( self:GetCaster():GetTeamNumber(), target:GetOrigin(), vision, duration, true )
	end

	local damage = self:GetSpecialValueFor("gush_damage")
	local duration = self:GetDuration()

	if self:GetCaster():HasModifier("modifier_tidehunter_15") then
		damage = damage + self.modifier_tidehunter_15[self:GetCaster():GetTalentLevel("modifier_tidehunter_15")]
	end

	if self:GetCaster():HasModifier("modifier_tidehunter_19") then
		local bonus_dmg = ((target:GetAbsOrigin() - self:GetCaster():GetAbsOrigin()):Length2D() / self.modifier_tidehunter_19_distance) * self.modifier_tidehunter_19_damage
		damage = damage + bonus_dmg
	end

	target:AddNewModifier( self:GetCaster(), self, "modifier_tidehunter_gush_custom", { duration = duration } )

	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	}
	ApplyDamage(damageTable)

	if self:GetCaster():HasModifier("modifier_tidehunter_22") then
		local direction = target:GetAbsOrigin() - self:GetCaster():GetAbsOrigin()
		direction.z = 0
		direction = direction:Normalized()
		local arc = target:AddNewModifier( self:GetCaster(), self, "modifier_generic_arc_lua_tidehunter",{ dir_x = direction.x,dir_y = direction.y,duration = 0.7,distance = 450,height = 2,fix_end = false,isStun = false,isForward = true,activity = ACT_DOTA_FLAIL,})
	end

	if data.scepter==0 then
		self:PlayEffects( target )
	end

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
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
	}

	return funcs
end

function modifier_tidehunter_gush_custom:GetModifierMoveSpeedBonus_Percentage()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_tidehunter_16") then
		bonus = self:GetAbility().modifier_tidehunter_16[self:GetCaster():GetTalentLevel("modifier_tidehunter_16")]
	end
	return self.slow + bonus
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

function modifier_tidehunter_gush_custom:GetModifierPropertyRestorationAmplification()
	if not self:GetCaster():HasModifier("modifier_tidehunter_20") then return end
	return self:GetAbility().modifier_tidehunter_20[self:GetCaster():GetTalentLevel("modifier_tidehunter_20")]
end

tidehunter_gush_2_custom = tidehunter_gush_custom