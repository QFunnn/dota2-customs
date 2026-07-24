--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_ring_of_aquila_custom", "items/item_ring_of_aquila_custom", LUA_MODIFIER_MOTION_NONE)

item_ring_of_aquila_custom = class({})

function item_ring_of_aquila_custom:GetIntrinsicModifierName()
	return "modifier_item_ring_of_aquila_custom"
end

modifier_item_ring_of_aquila_custom = class({})

function modifier_item_ring_of_aquila_custom:IsHidden() return true end

function modifier_item_ring_of_aquila_custom:IsPurgable() return false end
function modifier_item_ring_of_aquila_custom:IsPurgeException() return false end

function modifier_item_ring_of_aquila_custom:OnCreated()
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.bonus_strength = self:GetAbility():GetSpecialValueFor("bonus_strength")
	self.bonus_agility = self:GetAbility():GetSpecialValueFor("bonus_agility")
	self.bonus_intellect = self:GetAbility():GetSpecialValueFor("bonus_intellect")
	self.mana_regen = self:GetAbility():GetSpecialValueFor("mana_regen")
	self.bonus_armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_item_ring_of_aquila_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
end

function modifier_item_ring_of_aquila_custom:GetModifierBonusStats_Strength()
	return self.bonus_strength
end

function modifier_item_ring_of_aquila_custom:GetModifierBonusStats_Agility()
	return self.bonus_agility
end

function modifier_item_ring_of_aquila_custom:GetModifierBonusStats_Intellect()
	return self.bonus_intellect
end

function modifier_item_ring_of_aquila_custom:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_item_ring_of_aquila_custom:GetModifierConstantManaRegen()
	return self.mana_regen
end

function modifier_item_ring_of_aquila_custom:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end