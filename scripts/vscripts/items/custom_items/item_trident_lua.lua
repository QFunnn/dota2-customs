--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


item_trident_lua1 = item_trident_lua1 or class({})
item_trident_lua2 = item_trident_lua1 or class({})
item_trident_lua3 = item_trident_lua1 or class({})

LinkLuaModifier("modifier_item_trident_lua", "items/custom_items/item_trident_lua", LUA_MODIFIER_MOTION_NONE)

modifier_item_trident_lua = class({})

function item_trident_lua1:GetIntrinsicModifierName()
	return "modifier_item_trident_lua"
end

function modifier_item_trident_lua:IsHidden()
	return true
end

function modifier_item_trident_lua:IsPurgable()
	return false
end

function modifier_item_trident_lua:DestroyOnExpire()
	return false
end

function modifier_item_trident_lua:RemoveOnDeath()
	return false
end

function modifier_item_trident_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_trident_lua:OnCreated()
	self.status_resistance = self:GetAbility():GetSpecialValueFor("status_resistance")
	self.movement_speed_percent_bonus = self:GetAbility():GetSpecialValueFor("movement_speed_percent_bonus")
	self.spell_amp = self:GetAbility():GetSpecialValueFor("spell_amp")
	self.mana_regen_multiplier = self:GetAbility():GetSpecialValueFor("mana_regen_multiplier")
	self.hp_regen_amp = self:GetAbility():GetSpecialValueFor("hp_regen_amp")
	self.spell_lifesteal_amp = self:GetAbility():GetSpecialValueFor("spell_lifesteal_amp")
	self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")

	if not IsServer() then
		return
	end

	self.bonus_strength = self:GetAbility():GetSpecialValueFor("bonus_strength")
	self.bonus_intellect = self:GetAbility():GetSpecialValueFor("bonus_intellect")
	self.bonus_agility = self:GetAbility():GetSpecialValueFor("bonus_agility")
end

function modifier_item_trident_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_MP_RESTORE_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_LIFESTEAL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_item_trident_lua:GetModifierBonusStats_Strength()
	return self.bonus_strength
end

function modifier_item_trident_lua:GetModifierBonusStats_Intellect()
	return self.bonus_intellect
end

function modifier_item_trident_lua:GetModifierBonusStats_Agility()
	return self.bonus_agility
end

function modifier_item_trident_lua:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attack_speed
end

function modifier_item_trident_lua:GetModifierStatusResistanceStacking()
	return self.status_resistance
end

function modifier_item_trident_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.movement_speed_percent_bonus
end

function modifier_item_trident_lua:GetModifierMPRestoreAmplify_Percentage()
	return self.mana_regen_multiplier
end

function modifier_item_trident_lua:GetModifierMPRegenAmplify_Percentage()
	return self.mana_regen_multiplier
end

function modifier_item_trident_lua:GetModifierSpellAmplify_Percentage()
	return self.spell_amp
end

function modifier_item_trident_lua:GetModifierHPRegenAmplify_Percentage()
	return self.hp_regen_amp
end

function modifier_item_trident_lua:GetModifierSpellLifestealRegenAmplify_Percentage()
	return self.spell_lifesteal_amp
end