--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_heavy_shield", "items/d_items/item_heavy_shield", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
item_heavy_shield = item_heavy_shield or class({})
item_heavy_shield2 = item_heavy_shield or class({})
item_heavy_shield3 = item_heavy_shield or class({})
item_heavy_shield4 = item_heavy_shield or class({})
item_heavy_shield5 = item_heavy_shield or class({})

function item_heavy_shield:GetIntrinsicModifierName()
	return "modifier_item_heavy_shield"
end

function item_heavy_shield:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_heavy_shield:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_heavy_shield:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end

	return self.BaseClass.IsMuted(self)
end

-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------

modifier_item_heavy_shield = class({})

function modifier_item_heavy_shield:IsHidden()
	return true
end

function modifier_item_heavy_shield:IsPurgable()
	return false
end

function modifier_item_heavy_shield:GetAttributes()
	return MODIFIER_ATTRIBUTE_NONE
end

function modifier_item_heavy_shield:OnCreated(kv)
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("dmg")
	self.bonus_move_speed = self:GetAbility():GetSpecialValueFor("ms") / 100
	self.bonus_str = self:GetAbility():GetSpecialValueFor("str")
	self.bonus_agi = self:GetAbility():GetSpecialValueFor("agi")
	self.bonus_int = self:GetAbility():GetSpecialValueFor("int")
	self.bonus_hp_regen = self:GetAbility():GetSpecialValueFor("hpr")
	self.armor = self:GetAbility():GetSpecialValueFor("arm")
end

function modifier_item_heavy_shield:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_item_heavy_shield:GetModifierPreAttack_BonusDamage(params)
	return self.bonus_damage
end

function modifier_item_heavy_shield:GetModifierMoveSpeedBonus_Percentage(params)
	return self.bonus_move_speed
end

function modifier_item_heavy_shield:GetModifierBonusStats_Strength(params)
	return self.bonus_str
end

function modifier_item_heavy_shield:GetModifierBonusStats_Agility(params)
	return self.bonus_agi
end

function modifier_item_heavy_shield:GetModifierBonusStats_Intellect(params)
	return self.bonus_int
end

function modifier_item_heavy_shield:GetModifierConstantHealthRegen(params)
	return self.bonus_hp_regen
end

function modifier_item_heavy_shield:GetModifierPhysicalArmorBonus()
	return self.armor
end