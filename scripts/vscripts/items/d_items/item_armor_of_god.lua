--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_armor_of_god", "items/d_items/item_armor_of_god", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
item_armor_of_god = item_armor_of_god or class({})
item_armor_of_god2 = item_armor_of_god or class({})
item_armor_of_god3 = item_armor_of_god or class({})
item_armor_of_god4 = item_armor_of_god or class({})
item_armor_of_god5 = item_armor_of_god or class({})

function item_armor_of_god:GetIntrinsicModifierName()
	return "modifier_item_armor_of_god"
end

function item_armor_of_god:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_armor_of_god:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_armor_of_god:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end

	return self.BaseClass.IsMuted(self)
end

--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

modifier_item_armor_of_god = class({})

function modifier_item_armor_of_god:IsHidden()
	return true
end

function modifier_item_armor_of_god:IsPurgable()
	return false
end

function modifier_item_armor_of_god:OnCreated(kv)
	self.bonus_armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
	self.magic_resistance = self:GetAbility():GetSpecialValueFor("magic_resistance")
	self.bonus_hp = self:GetAbility():GetSpecialValueFor("bonus_hp")
	self.bonus_mana = self:GetAbility():GetSpecialValueFor("bonus_mana")
end

function modifier_item_armor_of_god:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_item_armor_of_god:GetModifierHealthBonus(params)
	return self.bonus_hp
end

function modifier_item_armor_of_god:GetModifierManaBonus(params)
	return self.bonus_mana
end

function modifier_item_armor_of_god:GetModifierPhysicalArmorBonus(params)
	return self.bonus_armor
end

function modifier_item_armor_of_god:GetModifierMagicalResistanceBonus(params)
	return self.magic_resistance
end