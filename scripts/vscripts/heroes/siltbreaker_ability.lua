--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_siltbreaker_ability", "heroes/siltbreaker_ability", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_siltbreaker_ability_buff", "heroes/siltbreaker_ability", LUA_MODIFIER_MOTION_NONE)

siltbreaker_ability = class({})

function siltbreaker_ability:GetIntrinsicModifierName()
	return "modifier_siltbreaker_ability"
end

modifier_siltbreaker_ability = class({})

function modifier_siltbreaker_ability:IsHidden()
	return true
end

function modifier_siltbreaker_ability:IsDebuff()
	return false
end

function modifier_siltbreaker_ability:IsPurgable()
	return false
end

function modifier_siltbreaker_ability:IsAura()
	if self:GetParent():PassivesDisabled() then return false end
	return true
end

function modifier_siltbreaker_ability:GetModifierAura()
	return "modifier_siltbreaker_ability_buff"
end

function modifier_siltbreaker_ability:GetAuraRadius()
	return self.radius
end

function modifier_siltbreaker_ability:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_siltbreaker_ability:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC
end

function modifier_siltbreaker_ability:GetAuraSearchFlags()
	return 0
end

function modifier_siltbreaker_ability:GetAuraDuration()
	return 2
end

function modifier_siltbreaker_ability:OnCreated( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
end

function modifier_siltbreaker_ability:OnRefresh( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
end


modifier_siltbreaker_ability_buff = class({})

function modifier_siltbreaker_ability_buff:IsHidden()
	return true
end

function modifier_siltbreaker_ability_buff:IsDebuff()
	return true
end

function modifier_siltbreaker_ability_buff:IsPurgable()
	return false
end

function modifier_siltbreaker_ability_buff:OnCreated( kv )
	self.evasion = self:GetAbility():GetSpecialValueFor( "evasion" )
end

function modifier_siltbreaker_ability_buff:OnRefresh( kv )
	self.evasion = self:GetAbility():GetSpecialValueFor( "evasion" )
end

function modifier_siltbreaker_ability_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EVASION_CONSTANT,
	}

	return funcs
end

function modifier_siltbreaker_ability_buff:GetModifierEvasion_Constant()
	return self.evasion
end