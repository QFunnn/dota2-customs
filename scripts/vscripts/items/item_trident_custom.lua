--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_trident_custom", "items/item_trident_custom", LUA_MODIFIER_MOTION_NONE)

item_trident_custom = class({})

function item_trident_custom:GetIntrinsicModifierName()
	return "modifier_item_trident_custom"
end

modifier_item_trident_custom = class({})

function modifier_item_trident_custom:IsHidden() return true end
function modifier_item_trident_custom:IsPurgable() return false end
function modifier_item_trident_custom:IsPurgeException() return false end
function modifier_item_trident_custom:RemoveOnDeath() return false end

function modifier_item_trident_custom:OnCreated(table)
	self.ability = self:GetAbility()
	self.bonus_strength            = self.ability:GetSpecialValueFor("bonus_strength")
	self.bonus_agility             = self.ability:GetSpecialValueFor("bonus_agility")
	self.bonus_intellect           = self.ability:GetSpecialValueFor("bonus_intellect")
	self.bonus_status_resistance   = self.ability:GetSpecialValueFor("bonus_status_resistance")
	self.bonus_attack_speed        = self.ability:GetSpecialValueFor("bonus_attack_speed")
	self.bonus_movement_speed_pct  = self.ability:GetSpecialValueFor("bonus_movement_speed_pct")
	self.bonus_health_amp_pct      = self.ability:GetSpecialValueFor("bonus_health_amp_pct")
	self.bonus_spell_amp_pct       = self.ability:GetSpecialValueFor("bonus_spell_amp_pct")
	self.bonus_mana_regen_amp_pct  = self.ability:GetSpecialValueFor("bonus_mana_regen_amp_pct")
	self.bonus_magical_attack      = self.ability:GetSpecialValueFor("bonus_magical_attack")
end

function modifier_item_trident_custom:OnRefresh(table)
	self:OnCreated(table)
end

function modifier_item_trident_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL,
	}
end

function modifier_item_trident_custom:GetModifierBonusStats_Strength()
	return self.bonus_strength
end

function modifier_item_trident_custom:GetModifierBonusStats_Agility()
	return self.bonus_agility
end

function modifier_item_trident_custom:GetModifierBonusStats_Intellect()
	return self.bonus_intellect
end

function modifier_item_trident_custom:GetModifierStatusResistanceStacking()
	return self.bonus_status_resistance
end

function modifier_item_trident_custom:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attack_speed
end

function modifier_item_trident_custom:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus_movement_speed_pct
end

function modifier_item_trident_custom:GetModifierHPRegenAmplify_Percentage()
	return self.bonus_health_amp_pct
end

function modifier_item_trident_custom:GetModifierSpellAmplify_Percentage()
	return self.bonus_spell_amp_pct
end

function modifier_item_trident_custom:GetModifierMPRegenAmplify_Percentage()
	return self.bonus_mana_regen_amp_pct
end

function modifier_item_trident_custom:GetModifierProcAttack_BonusDamage_Magical()
	return self.bonus_magical_attack
end