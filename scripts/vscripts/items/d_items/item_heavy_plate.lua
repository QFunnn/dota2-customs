--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_heavy_plate", "items/d_items/item_heavy_plate", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
item_heavy_plate = item_heavy_plate or class({})
item_heavy_plate2 = item_heavy_plate or class({})
item_heavy_plate3 = item_heavy_plate or class({})
item_heavy_plate4 = item_heavy_plate or class({})
item_heavy_plate5 = item_heavy_plate or class({})

function item_heavy_plate:GetIntrinsicModifierName()
	return "modifier_item_heavy_plate"
end

function item_heavy_plate:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_heavy_plate:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_heavy_plate:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end

	return self.BaseClass.IsMuted(self)
end

--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
modifier_item_heavy_plate = class({})

function modifier_item_heavy_plate:IsHidden()
	return true
end

function modifier_item_heavy_plate:IsPurgable()
	return false
end

function modifier_item_heavy_plate:OnCreated(kv)
	self.bonus_armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
	self.bonus_strength = self:GetAbility():GetSpecialValueFor("bonus_strength")
	self.bonus_hp_regen = self:GetAbility():GetSpecialValueFor("bonus_hp_regen")
end

function modifier_item_heavy_plate:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_ATTRIBUTE_NONE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
	return funcs
end

function modifier_item_heavy_plate:GetModifierPhysicalArmorBonus(params)
	return self.bonus_armor
end

function modifier_item_heavy_plate:GetModifierBonusStats_Strength(params)
	return self.bonus_strength
end

function modifier_item_heavy_plate:GetModifierConstantHealthRegen(params)
	return self.bonus_hp_regen
end