--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_gu", "items/d_items/item_gu", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------

item_gu = item_gu or class({})
item_gu2 = item_gu or class({})
item_gu3 = item_gu or class({})
item_gu4 = item_gu or class({})
item_gu5 = item_gu or class({})

function item_gu:GetIntrinsicModifierName()
	return "modifier_item_gu"
end

function item_gu:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_gu:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_gu:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end

	return self.BaseClass.IsMuted(self)
end

-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------

modifier_item_gu = class({})

function modifier_item_gu:IsHidden()
	return true
end

function modifier_item_gu:IsPurgable()
	return false
end

function modifier_item_gu:GetAttributes()
	return MODIFIER_ATTRIBUTE_NONE
end

function modifier_item_gu:OnCreated(kv)
	if self:GetParent():IsHero() and self:GetAbility() then
		self.mana_regen_sec = self:GetAbility():GetSpecialValueFor("mana_regen_sec")
		self.bonus_move_speed = self:GetAbility():GetSpecialValueFor("ms")
		self.bonus_cast = self:GetAbility():GetSpecialValueFor("SAT")
	end

	if
		self:GetParent():IsHero()
		and self:GetParent():FindAbilityByName("faceless_void_time_walk") ~= nil
		and self:GetAbility()
	then
		self.mana_regen_sec = self:GetAbility():GetSpecialValueFor("mana_regen_sec")
		self.bonus_move_speed = self:GetAbility():GetSpecialValueFor("ms")
		self.bonus_cast = 0
	end
end

function modifier_item_gu:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_item_gu:GetModifierMoveSpeedBonus_Constant(params)
	return self.bonus_move_speed
end

function modifier_item_gu:GetModifierConstantManaRegen(params)
	return self.mana_regen_sec
end

function modifier_item_gu:GetModifierCastRangeBonusStacking(params)
	return self.bonus_cast
end