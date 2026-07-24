--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_dragon_knight_breathe_fire_custom", "heroes/npc_dota_hero_dragon_knight_custom/dragon_knight_breathe_fire_custom", LUA_MODIFIER_MOTION_NONE )

dragon_knight_breathe_fire_custom = class({})

dragon_knight_breathe_fire_custom.modifier_dragon_knight_9_cast_range = {150,300}
dragon_knight_breathe_fire_custom.modifier_dragon_knight_10_slow = -20

dragon_knight_breathe_fire_custom.modifier_dragon_knight_15_cooldown_reduce = {0,0,0}
dragon_knight_breathe_fire_custom.modifier_dragon_knight_16_bonus_damage = {70,140}

function dragon_knight_breathe_fire_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_dragon_knight/dragon_knight_breathe_fire.vpcf', context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_dragon_knight.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_dragon_knight.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_dragon_knight.vpcf", context)
end

function dragon_knight_breathe_fire_custom:GetCastRange( vLocation, hTarget )
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_dragon_knight_9") then
        bonus = self.modifier_dragon_knight_9_cast_range[self:GetCaster():GetTalentLevel("modifier_dragon_knight_9")]
    end
    return self.BaseClass.GetCastRange( self, vLocation, hTarget ) + bonus
end

function dragon_knight_breathe_fire_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_dragon_knight_15") then
		bonus = self.modifier_dragon_knight_15_cooldown_reduce[self:GetCaster():GetTalentLevel("modifier_dragon_knight_15")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function dragon_knight_breathe_fire_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	if point == self:GetCaster():GetAbsOrigin() then
		point = point + self:GetCaster():GetForwardVector()
	end

	local projectile_distance = self:GetSpecialValueFor( "range" ) + self:GetCaster():GetCastRangeBonus()
	local projectile_start_radius = self:GetSpecialValueFor( "start_radius" )
	local projectile_end_radius = self:GetSpecialValueFor( "end_radius" )
	local projectile_speed = self:GetSpecialValueFor( "speed" )

	if self:GetCaster():HasModifier("modifier_dragon_knight_9") then
		projectile_distance = projectile_distance + self.modifier_dragon_knight_9_cast_range[self:GetCaster():GetTalentLevel("modifier_dragon_knight_9")]
	end

	local projectile_direction = point - caster:GetOrigin()
	projectile_direction.z = 0
	projectile_direction = projectile_direction:Normalized()

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),
	    bDeleteOnHit = false,
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	    EffectName = "particles/units/heroes/hero_dragon_knight/dragon_knight_breathe_fire.vpcf",
	    fDistance = projectile_distance,
	    fStartRadius = projectile_start_radius,
	    fEndRadius =projectile_end_radius,
		vVelocity = projectile_direction * projectile_speed,
	}

	ProjectileManager:CreateLinearProjectile(info)

	self:GetCaster():EmitSound("Hero_DragonKnight.BreathFire")
end

function dragon_knight_breathe_fire_custom:OnProjectileHit( target, location )
	if not target then return end
	local damage = self:GetSpecialValueFor( "damage" )

	if self:GetCaster():HasModifier("modifier_dragon_knight_16") then
		damage = damage + self.modifier_dragon_knight_16_bonus_damage[self:GetCaster():GetTalentLevel("modifier_dragon_knight_16")]
	end

	local duration = self:GetSpecialValueFor( "duration" )
	ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = damage, damage_type = self:GetAbilityDamageType(), ability = self })
	target:AddNewModifier( self:GetCaster(), self, "modifier_dragon_knight_breathe_fire_custom", { duration = duration * ( 1 - target:GetStatusResistance()) } )
end

modifier_dragon_knight_breathe_fire_custom = class({})

function modifier_dragon_knight_breathe_fire_custom:OnCreated( kv )
	self.reduction = self:GetAbility():GetSpecialValueFor( "reduction" )
end

function modifier_dragon_knight_breathe_fire_custom:OnRefresh( kv )
	self.reduction = self:GetAbility():GetSpecialValueFor( "reduction" )	
end

function modifier_dragon_knight_breathe_fire_custom:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_dragon_knight_breathe_fire_custom:GetModifierDamageOutgoing_Percentage()
	return self.reduction
end

function modifier_dragon_knight_breathe_fire_custom:GetModifierMoveSpeedBonus_Percentage()
	if not self:GetCaster():HasModifier("modifier_dragon_knight_10") then return 0 end
	return self:GetAbility().modifier_dragon_knight_10_slow
end
