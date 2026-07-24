--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_skywrath_mage_concussive_shot_custom", "heroes/npc_dota_hero_skywrath_mage_custom/skywrath_mage_concussive_shot_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_concussive_shot_custom_14", "heroes/npc_dota_hero_skywrath_mage_custom/skywrath_mage_concussive_shot_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_concussive_shot_custom_15", "heroes/npc_dota_hero_skywrath_mage_custom/skywrath_mage_concussive_shot_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_concussive_shot_custom_15_stack", "heroes/npc_dota_hero_skywrath_mage_custom/skywrath_mage_concussive_shot_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_concussive_shot_custom_friendly_15", "heroes/npc_dota_hero_skywrath_mage_custom/skywrath_mage_concussive_shot_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_concussive_shot_custom_friendly_15_stack", "heroes/npc_dota_hero_skywrath_mage_custom/skywrath_mage_concussive_shot_custom", LUA_MODIFIER_MOTION_NONE )

skywrath_mage_concussive_shot_custom = class({})

skywrath_mage_concussive_shot_custom.modifier_skywrath_mage_13 = {3,6}
skywrath_mage_concussive_shot_custom.modifier_skywrath_mage_14_count = {7,6,5}

function skywrath_mage_concussive_shot_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot_cast.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot_failure.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot_slow_debuff.vpcf", context )
end

function skywrath_mage_concussive_shot_custom:GetCooldown(level)
	local cooldown = self.BaseClass.GetCooldown( self, level )
	if self:GetCaster():HasModifier("modifier_skywrath_mage_13") then
		cooldown = cooldown - self.modifier_skywrath_mage_13[self:GetCaster():GetTalentLevel("modifier_skywrath_mage_13")]
	end
    return cooldown
end

function skywrath_mage_concussive_shot_custom:GetIntrinsicModifierName()
	return "modifier_skywrath_mage_concussive_shot_custom_14"
end

function skywrath_mage_concussive_shot_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local search_radius = self:GetSpecialValueFor( "launch_radius" )
	local projectile_speed = self:GetSpecialValueFor( "speed" )
	local projectile_vision = self:GetSpecialValueFor( "shot_vision" )

	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetOrigin(), nil, search_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, false )

	local target = nil
	for _,enemy in pairs(enemies) do
		if enemy:IsHero() and enemy:IsRealHero() and not enemy:IsIllusion() then
			target = enemy
			break
		end
	end

	if not target then
		target = enemies[1]
	end

	if not target then
		self:PlayEffects2()
		return
	end

	local info = {
		Target = target,
		Source = caster,
		Ability = self,	
		EffectName = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot.vpcf",
		iMoveSpeed = projectile_speed,
		bDodgeable = true,
		bVisibleToEnemies = true,
		bProvidesVision = true,
		iVisionRadius = 400,
		iVisionTeamNumber = caster:GetTeamNumber(),
	}

	ProjectileManager:CreateTrackingProjectile(info)	

	self:PlayEffects1( target )

	if caster:HasScepter() then
		local scepter_radius = self:GetSpecialValueFor( "scepter_radius" )
		
		local enemies = FindUnitsInRadius( caster:GetTeamNumber(), target:GetOrigin(), nil, scepter_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, 0, false )

		local target_2 = nil

		for _,enemy in pairs(enemies) do
			if enemy~=target and enemy:IsHero() and enemy:IsRealHero() and not enemy:IsIllusion() then
				target_2 = enemy
				break
			end
		end

		if not target_2 then
			target_2 = enemies[1]
			if target_2==target then
				target_2 = enemies[2]
			end
		end

		if target_2 and (not target_2:IsMagicImmune()) then
			info.Target = target_2
			ProjectileManager:CreateTrackingProjectile(info)
			self:PlayEffects1( target_2 )
		end
	end
end

function skywrath_mage_concussive_shot_custom:OnProjectileHit( target, location )
	if not target then return end
	local radius = self:GetSpecialValueFor( "slow_radius" )
	local damage = self:GetSpecialValueFor( "damage" )
	local duration = self:GetSpecialValueFor( "slow_duration" )
	local creep_mult = self:GetSpecialValueFor( "creep_damage_pct" )
	local vision = self:GetSpecialValueFor( "shot_vision" )
	local vision_duration = self:GetSpecialValueFor( "vision_duration" )

	local damageTable = 
	{
		attacker = self:GetCaster(),
		damage_type = self:GetAbilityDamageType(),
		ability = self,
	}

	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )

	for _,enemy in pairs(enemies) do
		damageTable.victim = enemy
		damageTable.damage = damage

		if enemy:IsCreep() then
			damageTable.damage = damage * (creep_mult/100)
		end

		ApplyDamage( damageTable )

		if self:GetCaster():HasModifier("modifier_skywrath_mage_9") then
			self:GetCaster():PerformAttack(enemy, true, true, true, false, false, false, true)
		end
		enemy:AddNewModifier( self:GetCaster(), self, "modifier_skywrath_mage_concussive_shot_custom", { duration = duration } )
	end

	AddFOWViewer( self:GetCaster():GetTeamNumber(), target:GetOrigin(), vision, vision_duration, false )

	target:EmitSound("Hero_SkywrathMage.ConcussiveShot.Target")
end

function skywrath_mage_concussive_shot_custom:PlayEffects1( target )
	local projectile_speed = self:GetSpecialValueFor( "speed" )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( projectile_speed, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	self:GetCaster():EmitSound("Hero_SkywrathMage.ConcussiveShot.Cast")
end

function skywrath_mage_concussive_shot_custom:PlayEffects2()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot_failure.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

modifier_skywrath_mage_concussive_shot_custom = class({})

function modifier_skywrath_mage_concussive_shot_custom:IsHidden()
	return false
end

function modifier_skywrath_mage_concussive_shot_custom:IsDebuff()
	return true
end

function modifier_skywrath_mage_concussive_shot_custom:IsStunDebuff()
	return false
end

function modifier_skywrath_mage_concussive_shot_custom:IsPurgable()
	return true
end

function modifier_skywrath_mage_concussive_shot_custom:OnCreated( kv )
	self.slow = -self:GetAbility():GetSpecialValueFor( "movement_speed_pct" )
end

function modifier_skywrath_mage_concussive_shot_custom:OnRefresh( kv )
	self.slow = -self:GetAbility():GetSpecialValueFor( "movement_speed_pct" )
end

function modifier_skywrath_mage_concussive_shot_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_skywrath_mage_concussive_shot_custom:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_skywrath_mage_concussive_shot_custom:GetEffectName()
	return "particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot_slow_debuff.vpcf"
end

function modifier_skywrath_mage_concussive_shot_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_skywrath_mage_concussive_shot_custom_14 = class({})

function modifier_skywrath_mage_concussive_shot_custom_14:IsHidden() return not self:GetCaster():HasModifier("modifier_skywrath_mage_14") end
function modifier_skywrath_mage_concussive_shot_custom_14:IsPurgable() return false end
function modifier_skywrath_mage_concussive_shot_custom_14:DeclareFunctions()
	return 
	{
		 
	}
end

function modifier_skywrath_mage_concussive_shot_custom_14:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(0)
end

function modifier_skywrath_mage_concussive_shot_custom_14:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if params.target == self:GetParent() then return end
	if not self:GetParent():HasModifier("modifier_skywrath_mage_14") then return end
	if params.no_attack_cooldown then return end

	self:IncrementStackCount()
	if self:GetStackCount() >= self:GetAbility().modifier_skywrath_mage_14_count[self:GetCaster():GetTalentLevel("modifier_skywrath_mage_14")] then
		self:GetAbility():OnSpellStart()
		self:SetStackCount(0)
	end
end