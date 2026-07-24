--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_drum_of_hyperstone", "items/item_drum_of_hyperstone", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_drum_of_hyperstone_buff", "items/item_drum_of_hyperstone", LUA_MODIFIER_MOTION_NONE)

item_drum_of_hyperstone = class({})

function item_drum_of_hyperstone:GetIntrinsicModifierName()
	return "modifier_item_drum_of_hyperstone"
end

modifier_item_drum_of_hyperstone = class({})

function modifier_item_drum_of_hyperstone:IsHidden() return true end
function modifier_item_drum_of_hyperstone:IsPurgable() return false end
function modifier_item_drum_of_hyperstone:IsPurgeException() return false end
function modifier_item_drum_of_hyperstone:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_drum_of_hyperstone:IsAura()
	return not self:GetCaster():IsIllusion()
end

function modifier_item_drum_of_hyperstone:GetAuraRadius()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("radius")
	end
end

function modifier_item_drum_of_hyperstone:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_drum_of_hyperstone:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_item_drum_of_hyperstone:GetModifierAura()
	return "modifier_item_drum_of_hyperstone_buff"
end

function modifier_item_drum_of_hyperstone:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end

function modifier_item_drum_of_hyperstone:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_str")
end

function modifier_item_drum_of_hyperstone:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_int")
end

function modifier_item_drum_of_hyperstone:GetAuraDuration()
	return 0
end

function modifier_item_drum_of_hyperstone:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

modifier_item_drum_of_hyperstone_buff = class({})

function modifier_item_drum_of_hyperstone_buff:OnCreated()
	if not IsServer() then return end
	
end

function modifier_item_drum_of_hyperstone_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
	}
end

function modifier_item_drum_of_hyperstone_buff:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end

function modifier_item_drum_of_hyperstone_buff:GetModifierMoveSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
end