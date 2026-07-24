--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_omniknight_degen_aura_custom_original", "heroes/hero_omniknight/omniknight_degen_aura_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_omniknight_degen_aura_custom", "heroes/hero_omniknight/omniknight_degen_aura_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_omniknight_degen_aura_custom_2", "heroes/hero_omniknight/omniknight_degen_aura_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_omniknight_degen_aura_custom_debuff", "heroes/hero_omniknight/omniknight_degen_aura_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_omniknight_degen_aura_custom_debuff_2", "heroes/hero_omniknight/omniknight_degen_aura_custom", LUA_MODIFIER_MOTION_NONE)

omniknight_degen_aura_custom = class({})

function omniknight_degen_aura_custom:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_omniknight/omniknight_degen_aura.vpcf", context)
end

function omniknight_degen_aura_custom:GetIntrinsicModifierName()
	return "modifier_omniknight_degen_aura_custom_original"
end

modifier_omniknight_degen_aura_custom_original = class({})

function modifier_omniknight_degen_aura_custom_original:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(1)
end

function modifier_omniknight_degen_aura_custom_original:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetCaster():HasModifier("modifier_omniknight_degen_aura_custom") then
		self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_omniknight_degen_aura_custom", {})
	end
	if not self:GetCaster():HasModifier("modifier_omniknight_degen_aura_custom_2") then
		self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_omniknight_degen_aura_custom_2", {})
	end
end

function modifier_omniknight_degen_aura_custom_original:OnDestroy()
	if not IsServer() then return end
	self:GetCaster():RemoveModifierByName("modifier_omniknight_degen_aura_custom")
	self:GetCaster():RemoveModifierByName("modifier_omniknight_degen_aura_custom_2")
end

modifier_omniknight_degen_aura_custom = class({})

function modifier_omniknight_degen_aura_custom:IsHidden()
	return true
end

function modifier_omniknight_degen_aura_custom:IsDebuff()
	return false
end

function modifier_omniknight_degen_aura_custom:IsPurgable()
	return false
end

function modifier_omniknight_degen_aura_custom:IsAura()
	if self:GetParent():PassivesDisabled() then return false end
	return true
end

function modifier_omniknight_degen_aura_custom:GetModifierAura()
	return "modifier_omniknight_degen_aura_custom_debuff"
end

function modifier_omniknight_degen_aura_custom:GetAuraRadius()
	return self.radius
end

function modifier_omniknight_degen_aura_custom:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_omniknight_degen_aura_custom:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_omniknight_degen_aura_custom:GetAuraSearchFlags()
	return 0
end

function modifier_omniknight_degen_aura_custom:GetAuraDuration()
	return 2
end

function modifier_omniknight_degen_aura_custom:OnCreated( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value
	if IsServer() then
		--self:PlayEffects()
	end
end

function modifier_omniknight_degen_aura_custom:OnRefresh( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value
end

function modifier_omniknight_degen_aura_custom:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_omniknight/omniknight_degen_aura.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
	self:AddParticle( effect_cast, false, false, -1, false, false )
end





modifier_omniknight_degen_aura_custom_2 = class({})

function modifier_omniknight_degen_aura_custom_2:IsHidden()
	return true
end

function modifier_omniknight_degen_aura_custom_2:IsDebuff()
	return false
end

function modifier_omniknight_degen_aura_custom_2:IsPurgable()
	return false
end

function modifier_omniknight_degen_aura_custom_2:IsAura()
	if self:GetParent():PassivesDisabled() then return false end
	return true
end

function modifier_omniknight_degen_aura_custom_2:GetModifierAura()
	return "modifier_omniknight_degen_aura_custom_debuff_2"
end

function modifier_omniknight_degen_aura_custom_2:GetAuraRadius()
	return self.radius
end

function modifier_omniknight_degen_aura_custom_2:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_omniknight_degen_aura_custom_2:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_omniknight_degen_aura_custom_2:GetAuraSearchFlags()
	return 0
end

function modifier_omniknight_degen_aura_custom_2:GetAuraDuration()
	return 2
end

function modifier_omniknight_degen_aura_custom_2:OnCreated( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius_2" ) -- special value
	if IsServer() then
		--self:PlayEffects()
	end
end

function modifier_omniknight_degen_aura_custom_2:OnRefresh( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius_2" ) -- special value
end

function modifier_omniknight_degen_aura_custom_2:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_omniknight/omniknight_degen_aura.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
	self:AddParticle( effect_cast, false, false, -1, false, false )
end



























modifier_omniknight_degen_aura_custom_debuff = class({})

function modifier_omniknight_degen_aura_custom_debuff:IsHidden()
	return false
end

function modifier_omniknight_degen_aura_custom_debuff:IsDebuff()
	return true
end

function modifier_omniknight_degen_aura_custom_debuff:IsPurgable()
	return false
end

function modifier_omniknight_degen_aura_custom_debuff:OnCreated( kv )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "speed_bonus" )
end

function modifier_omniknight_degen_aura_custom_debuff:OnRefresh( kv )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "speed_bonus" )
end

function modifier_omniknight_degen_aura_custom_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_omniknight_degen_aura_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end

function modifier_omniknight_degen_aura_custom_debuff:GetEffectName()
	return "particles/units/heroes/hero_omniknight/omniknight_degen_aura_debuff.vpcf"
end

function modifier_omniknight_degen_aura_custom_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end




modifier_omniknight_degen_aura_custom_debuff_2 = class({})

function modifier_omniknight_degen_aura_custom_debuff_2:IsHidden()
	return false
end

function modifier_omniknight_degen_aura_custom_debuff_2:IsDebuff()
	return true
end

function modifier_omniknight_degen_aura_custom_debuff_2:IsPurgable()
	return false
end

function modifier_omniknight_degen_aura_custom_debuff_2:OnCreated( kv )
	self.as_slow = self:GetAbility():GetSpecialValueFor( "speed_bonus_2" )
end

function modifier_omniknight_degen_aura_custom_debuff_2:OnRefresh( kv )
	self.as_slow = self:GetAbility():GetSpecialValueFor( "speed_bonus_2" )
end

function modifier_omniknight_degen_aura_custom_debuff_2:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_omniknight_degen_aura_custom_debuff_2:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

function modifier_omniknight_degen_aura_custom_debuff_2:GetEffectName()
	return "particles/units/heroes/hero_omniknight/omniknight_degen_aura_debuff.vpcf"
end

function modifier_omniknight_degen_aura_custom_debuff_2:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end