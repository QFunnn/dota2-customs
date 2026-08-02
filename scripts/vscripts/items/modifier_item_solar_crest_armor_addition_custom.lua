--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_item_solar_crest_armor_addition_custom = class({})

function modifier_item_solar_crest_armor_addition_custom:OnCreated()
	self.armor = self:GetAbility():GetSpecialValueFor("target_armor")
	self.movespeed = self:GetAbility():GetSpecialValueFor("target_movement_speed")
	self.attack_speed = self:GetAbility():GetSpecialValueFor("target_attack_speed")
end

function modifier_item_solar_crest_armor_addition_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_item_solar_crest_armor_addition_custom:GetModifierPhysicalArmorBonus()
	return self.armor
end

function modifier_item_solar_crest_armor_addition_custom:GetModifierMoveSpeedBonus_Percentage()
	return self.movespeed
end

function modifier_item_solar_crest_armor_addition_custom:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed
end