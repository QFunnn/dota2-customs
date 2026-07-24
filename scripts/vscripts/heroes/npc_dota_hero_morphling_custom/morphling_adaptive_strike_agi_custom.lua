--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua.lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier("modifier_morphling_adaptive_strike_agi_custom_debuff", "heroes/npc_dota_hero_morphling_custom/morphling_adaptive_strike_agi_custom", LUA_MODIFIER_MOTION_NONE)

morphling_adaptive_strike_agi_custom = class({})

function morphling_adaptive_strike_agi_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_adaptive_strike.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_adaptive_strike_agi_proj.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_adaptive_strike_str.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_morphling.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_morphling.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_morphling.vpcf", context)
end

morphling_adaptive_strike_agi_custom.modifier_morphling_3 = 300
morphling_adaptive_strike_agi_custom.modifier_morphling_4 = {0.3,0.6,0.9}
morphling_adaptive_strike_agi_custom.modifier_morphling_7 = -2
morphling_adaptive_strike_agi_custom.attribute_ratio = 1.5
morphling_adaptive_strike_agi_custom.modifier_morphling_6_duration = 3
morphling_adaptive_strike_agi_custom.modifier_morphling_6 = {-10,-20}

local function GetLinearAttributeValue(primary, secondary, min_value, max_value, ratio_limit)
	if primary <= 0 then return min_value end
	if secondary <= 0 then return max_value end
	local ratio = primary / secondary
	local min_ratio = 1 / ratio_limit
	local max_ratio = ratio_limit
	if ratio <= min_ratio then return min_value end
	if ratio >= max_ratio then return max_value end
	return min_value + (max_value - min_value) * ((ratio - min_ratio) / (max_ratio - min_ratio))
end

function morphling_adaptive_strike_agi_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_morphling_7") then
		bonus = self.modifier_morphling_7
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function morphling_adaptive_strike_agi_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_morphling_7") then
        return 0
    end
end

function morphling_adaptive_strike_agi_custom:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_morphling_2") then
		return "morphling_2"
	end
	return "morphling_adaptive_strike_agi"
end

function morphling_adaptive_strike_agi_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()

	self:GetCaster():EmitSound("Hero_Morphling.AdaptiveStrikeAgi.Cast")

	local WaterProj = 
	{
		Target = target,
		Source = self:GetCaster(),
		Ability = self,
		EffectName = "particles/units/heroes/hero_morphling/morphling_adaptive_strike_agi_proj.vpcf",
		iMoveSpeed = self:GetSpecialValueFor("projectile_speed"),
		bDodgeable = true, 
		bVisibleToEnemies = true,
		bReplaceExisting = false,
		bProvidesVision = false,  
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2,                          
	}

	ProjectileManager:CreateTrackingProjectile(WaterProj)

	if self:GetCaster():HasModifier("modifier_morphling_3") then
		local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, self.modifier_morphling_3, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, 0, false )
		for _, enemy in pairs(enemies) do
			if enemy ~= target then
				WaterProj.Target = enemy
				ProjectileManager:CreateTrackingProjectile(WaterProj)
			end
		end
	end
end

function morphling_adaptive_strike_agi_custom:OnProjectileHit(target, vLocation)
	if not IsServer() then return end
	if target == nil then return end
	if target:TriggerSpellAbsorb(self) then return end
	if target:IsMagicImmune() then return end

	local damage_base = self:GetSpecialValueFor("damage_base")
	local damage_min = self:GetSpecialValueFor("damage_min")
	local damage_max = self:GetSpecialValueFor("damage_max")
    local stun_min = self:GetSpecialValueFor("stun_min")
	local stun_max = self:GetSpecialValueFor("stun_max")
    local knockback_min = self:GetSpecialValueFor("knockback_min")
	local knockback_max = self:GetSpecialValueFor("knockback_max")
	if self:GetCaster():HasModifier("modifier_morphling_4") then
        damage_min = damage_min + self.modifier_morphling_4[self:GetCaster():GetTalentLevel("modifier_morphling_4")]
		damage_max = damage_max + self.modifier_morphling_4[self:GetCaster():GetTalentLevel("modifier_morphling_4")]
	end

	local agil_check = self:GetCaster():GetAgility()
	local str_check = self:GetCaster():GetStrength()

	local damage_attribute = agil_check
	local damage_opposing_attribute = str_check
	if self:GetCaster():HasModifier("modifier_morphling_2") then
		damage_attribute = str_check
		damage_opposing_attribute = agil_check
	end

	local control_attribute = str_check
	local control_opposing_attribute = agil_check
	if self:GetCaster():HasModifier("modifier_morphling_9") then
		control_attribute = agil_check
		control_opposing_attribute = str_check
	end

	local damage_factor = GetLinearAttributeValue(damage_attribute, damage_opposing_attribute, damage_min, damage_max, self.attribute_ratio)
	local stun_duration = GetLinearAttributeValue(control_attribute, control_opposing_attribute, stun_min, stun_max, self.attribute_ratio)
	local knockback_distance = GetLinearAttributeValue(control_attribute, control_opposing_attribute, knockback_min, knockback_max, self.attribute_ratio)
    
	ApplyDamage({attacker = self:GetCaster(), victim = target, ability = self, damage = damage_base + damage_attribute * damage_factor, damage_type = DAMAGE_TYPE_MAGICAL})
	
    if str_check > agil_check then
        local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_morphling/morphling_adaptive_strike_str.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
        ParticleManager:SetParticleControl( nFXIndex, 0, self:GetCaster():GetAbsOrigin() )
        ParticleManager:SetParticleControl( nFXIndex, 1, target:GetAbsOrigin() )
        ParticleManager:SetParticleControlEnt( nFXIndex, 2, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetCaster():GetAbsOrigin(), true )
        ParticleManager:ReleaseParticleIndex( nFXIndex )
        target:EmitSound("Hero_Morphling.AdaptiveStrikeStr.Target")
    else
        local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_morphling/morphling_adaptive_strike.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
        ParticleManager:SetParticleControl( nFXIndex, 0, self:GetCaster():GetAbsOrigin() )
        ParticleManager:SetParticleControl( nFXIndex, 1, target:GetAbsOrigin() )
        ParticleManager:ReleaseParticleIndex( nFXIndex )
    end
    target:EmitSound("Hero_Morphling.AdaptiveStrikeAgi.Target")

    if self:GetCaster():HasModifier("modifier_morphling_6") then
        target:AddNewModifier(self:GetCaster(), self, "modifier_morphling_adaptive_strike_agi_custom_debuff", {duration = self.modifier_morphling_6_duration})
    end

    -- str
    local direction = (target:GetAbsOrigin() - self:GetCaster():GetAbsOrigin())
	direction.z = 0
	direction = direction:Normalized()
	target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", { duration = stun_duration * (1-target:GetStatusResistance()) })
	local knockback = target:AddNewModifier(self:GetCaster(), self, "modifier_generic_knockback_lua", { duration = knockback_distance / 1000, height = 0, distance = knockback_distance, IsStun = true, direction_x = direction.x, direction_y = direction.y } )
end

modifier_morphling_adaptive_strike_agi_custom_debuff = class({})

function modifier_morphling_adaptive_strike_agi_custom_debuff:GetTexture() return "morphling_6" end

function modifier_morphling_adaptive_strike_agi_custom_debuff:OnCreated()
	self.debuff = self:GetAbility().modifier_morphling_6
end

function modifier_morphling_adaptive_strike_agi_custom_debuff:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
	}
	return funcs
end

function modifier_morphling_adaptive_strike_agi_custom_debuff:GetModifierPropertyRestorationAmplification()
	return self.debuff[self:GetCaster():GetTalentLevel("modifier_morphling_6")]
end