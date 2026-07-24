--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua.lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier("modifier_morphling_adaptive_strike_str_custom", "heroes/npc_dota_hero_morphling_custom/morphling_adaptive_strike_str_custom", LUA_MODIFIER_MOTION_NONE )

morphling_adaptive_strike_str_custom = class({})

function morphling_adaptive_strike_str_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_adaptive_strike_str_proj.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_adaptive_strike_str.vpcf", context )
end

morphling_adaptive_strike_str_custom.modifier_morphling_7 = -2.5

function morphling_adaptive_strike_str_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_morphling_7") then
		bonus = self.modifier_morphling_7
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function morphling_adaptive_strike_str_custom:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_morphling_9") then
		return "morphling_9"
	end
	return "morphling_adaptive_strike_str"
end

function morphling_adaptive_strike_str_custom:GetIntrinsicModifierName()
	return "modifier_morphling_adaptive_strike_str_custom"
end

function morphling_adaptive_strike_str_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()

	self:GetCaster():EmitSound("Hero_Morphling.AdaptiveStrikeStr.Cast")

	local WaterProj = 
	{
		Target = target,
		Source = self:GetCaster(),
		Ability = self,
		EffectName = "particles/units/heroes/hero_morphling/morphling_adaptive_strike_str_proj.vpcf",
		iMoveSpeed = self:GetSpecialValueFor("projectile_speed"),
		bDodgeable = true, 
		bVisibleToEnemies = true,
		bReplaceExisting = false,
		bProvidesVision = false,  
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2,                          
	}

	ProjectileManager:CreateTrackingProjectile(WaterProj)

	if not self:GetCaster():HasModifier("modifier_morphling_7") then
		local morphling_adaptive_strike_agi_custom = self:GetCaster():FindAbilityByName("morphling_adaptive_strike_agi_custom")
		if morphling_adaptive_strike_agi_custom then
			morphling_adaptive_strike_agi_custom:StartCooldown(self:GetSpecialValueFor("shared_cooldown"))
		end
	end
end

function morphling_adaptive_strike_str_custom:OnProjectileHit(target, vLocation)
	if not IsServer() then return end
	if target == nil then return end

	if target:TriggerSpellAbsorb(self) then return end

	if target:IsMagicImmune() then return end

	target:EmitSound("Hero_Morphling.AdaptiveStrikeStr.Target")

	local stun_min = self:GetSpecialValueFor("stun_min")
	local stun_max = self:GetSpecialValueFor("stun_max")

	local knockback_min = self:GetSpecialValueFor("knockback_min")
	local knockback_max = self:GetSpecialValueFor("knockback_max")

	local stun_duration = stun_min
	local knockback_distance = knockback_min

	local str_check = self:GetCaster():GetStrength()
	local agil_check = self:GetCaster():GetAgility()

	if self:GetCaster():HasModifier("modifier_morphling_9") then
		str_check = self:GetCaster():GetAgility()
		agil_check = self:GetCaster():GetStrength()
	end

	if str_check * 0.5 > agil_check then
		stun_duration = stun_max
		knockback_distance = knockback_max
	end

	local direction = (target:GetAbsOrigin() - self:GetCaster():GetAbsOrigin())
	direction.z = 0
	direction = direction:Normalized()

	local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_morphling/morphling_adaptive_strike_str.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( nFXIndex, 0, self:GetCaster():GetAbsOrigin() )
	ParticleManager:SetParticleControl( nFXIndex, 1, target:GetAbsOrigin() )
	ParticleManager:SetParticleControlEnt( nFXIndex, 2, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetCaster():GetAbsOrigin(), true )
	ParticleManager:ReleaseParticleIndex( nFXIndex )

	target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", { duration = stun_duration * (1-target:GetStatusResistance()) })
	local knockback = target:AddNewModifier(self:GetCaster(), self, "modifier_generic_knockback_lua", { duration = knockback_distance / 1000, height = 0, distance = knockback_distance, IsStun = true, direction_x = direction.x, direction_y = direction.y } )
end

modifier_morphling_adaptive_strike_str_custom = class({})

function modifier_morphling_adaptive_strike_str_custom:IsPurgable() return false end
function modifier_morphling_adaptive_strike_str_custom:IsHidden() return true end

function modifier_morphling_adaptive_strike_str_custom:RemoveOnDeath()
	return false
end

function modifier_morphling_adaptive_strike_str_custom:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(self:GetCaster():GetBaseStrength() + 1)
	self:StartIntervalThink(FrameTime())
end

function modifier_morphling_adaptive_strike_str_custom:OnIntervalThink()
	if not IsServer() then return end
	self:SetStackCount(self:GetCaster():GetBaseStrength() + 1)
end

function modifier_morphling_adaptive_strike_str_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
	}
end

function modifier_morphling_adaptive_strike_str_custom:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_attributes")
end



