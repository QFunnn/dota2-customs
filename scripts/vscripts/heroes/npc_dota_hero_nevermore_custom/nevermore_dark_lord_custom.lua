--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_nevermore_dark_lord_custom_aura", "heroes/npc_dota_hero_nevermore_custom/nevermore_dark_lord_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_dark_lord_custom_debuff", "heroes/npc_dota_hero_nevermore_custom/nevermore_dark_lord_custom", LUA_MODIFIER_MOTION_NONE)

nevermore_dark_lord_custom = class({})
nevermore_dark_lord_custom.modifier_nevermore_15 = {-5,-10,-15}

function nevermore_dark_lord_custom:GetIntrinsicModifierName()
	return "modifier_nevermore_dark_lord_custom_aura"
end

modifier_nevermore_dark_lord_custom_aura = class({})

function modifier_nevermore_dark_lord_custom_aura:IsHidden() return true end
function modifier_nevermore_dark_lord_custom_aura:IsPurgable() return false end
function modifier_nevermore_dark_lord_custom_aura:IsDebuff() return false end

function modifier_nevermore_dark_lord_custom_aura:GetAuraEntityReject(target)
	if not target:CanEntityBeSeenByMyTeam(self:GetCaster()) or (self:GetCaster():GetTeam() == target:GetTeam() and self:GetCaster() ~= target) then
		return true 
	end
	return false
end

function modifier_nevermore_dark_lord_custom_aura:GetAuraDuration()
	return 0
end

function modifier_nevermore_dark_lord_custom_aura:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("presence_radius")
end

function modifier_nevermore_dark_lord_custom_aura:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE
end

function modifier_nevermore_dark_lord_custom_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_nevermore_dark_lord_custom_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO 
end

function modifier_nevermore_dark_lord_custom_aura:GetModifierAura()
	return "modifier_nevermore_dark_lord_custom_debuff"
end

function modifier_nevermore_dark_lord_custom_aura:IsAura()
	if self:GetCaster():PassivesDisabled() then
		return false
	end
	return true
end

modifier_nevermore_dark_lord_custom_debuff =  class({})

function modifier_nevermore_dark_lord_custom_debuff:IsHidden() return false end
function modifier_nevermore_dark_lord_custom_debuff:IsPurgable() return false end

function modifier_nevermore_dark_lord_custom_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
  	}
end

function modifier_nevermore_dark_lord_custom_debuff:GetModifierPhysicalArmorBonus()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("presence_armor_reduction")
	end
end

function modifier_nevermore_dark_lord_custom_debuff:GetModifierMagicalResistanceBonus()
	return self:GetAbility().modifier_nevermore_15[self:GetCaster():GetTalentLevel("modifier_nevermore_15")]
end