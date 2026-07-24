--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ogre_magi_ignite_custom", "heroes/hero_ogre_magi/ogre_magi_ignite_custom", LUA_MODIFIER_MOTION_NONE )

ogre_magi_ignite_custom = class({})

function ogre_magi_ignite_custom:GetAOERadius()
	return self:GetSpecialValueFor("aoe_radius")
end

function ogre_magi_ignite_custom:OnSpellStart(new_target)
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local info = {
		Target = target,
		Source = self:GetCaster(),
		Ability = self,	
		EffectName = "particles/units/heroes/hero_ogre_magi/ogre_magi_ignite.vpcf",
		iMoveSpeed = self:GetSpecialValueFor( "projectile_speed" ),
		bDodgeable = true,
		ExtraData = {}
	}

	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, self:GetSpecialValueFor("aoe_radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	
	for _,enemy in pairs(enemies) do 
		info.Target = enemy
		ProjectileManager:CreateTrackingProjectile(info)
	end

	self:GetCaster():EmitSound("Hero_OgreMagi.Ignite.Cast")
end

function ogre_magi_ignite_custom:OnProjectileHit_ExtraData( target, location, data)
	if not target then return end
	if target:TriggerSpellAbsorb( self ) then return end
	if target:IsMagicImmune() then return end

	local duration = self:GetSpecialValueFor( "duration" )
	target:AddNewModifier( self:GetCaster(), self, "modifier_ogre_magi_ignite_custom", { duration = duration } )
	self:GetCaster():EmitSound("Hero_OgreMagi.Ignite.Target")
end

modifier_ogre_magi_ignite_custom = class({})

function modifier_ogre_magi_ignite_custom:IsPurgable() return true end

function modifier_ogre_magi_ignite_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_ogre_magi_ignite_custom:OnCreated( kv )
	if not self:GetAbility() then self:Destroy() return end
	self.slow = self:GetAbility():GetSpecialValueFor( "slow_movement_speed_pct" )
	self.damage = self:GetAbility():GetSpecialValueFor( "burn_damage" )
	if not IsServer() then return end
	self:StartIntervalThink( 1 )
end

function modifier_ogre_magi_ignite_custom:OnRefresh( kv )	
	self:OnCreated(kv)
end

function modifier_ogre_magi_ignite_custom:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_ogre_magi_ignite_custom:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_ogre_magi_ignite_custom:OnIntervalThink()
	if not IsServer() then return end
	ApplyDamage( { victim = self:GetParent(), attacker = self:GetCaster(), damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() } )
	self:GetParent():EmitSound("Hero_OgreMagi.Ignite.Damage")
end

function modifier_ogre_magi_ignite_custom:GetEffectName()
	return "particles/units/heroes/hero_ogre_magi/ogre_magi_ignite_debuff.vpcf"
end

function modifier_ogre_magi_ignite_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end