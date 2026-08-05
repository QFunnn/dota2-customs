--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


item_book_of_knowledge = class({})
LinkLuaModifier("modifier_item_book_of_knowledge", "items/d_items/item_book_of_knowledge", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------

function item_book_of_knowledge:GetIntrinsicModifierName()
	return "modifier_item_book_of_knowledge"
end

function item_book_of_knowledge:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_book_of_knowledge:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_book_of_knowledge:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end

	return self.BaseClass.IsMuted(self)
end

----------------------------------------------------------------------------------------------------------

modifier_item_book_of_knowledge = class({})

function modifier_item_book_of_knowledge:IsHidden()
	return true
end

function modifier_item_book_of_knowledge:IsPurgable()
	return false
end

function modifier_item_book_of_knowledge:OnCreated(kv)
	self.bonus_xp = self:GetAbility():GetSpecialValueFor("bonus_xp")
	self.bonus_strength = self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_book_of_knowledge:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EXP_RATE_BOOST,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_item_book_of_knowledge:GetModifierPercentageExpRateBoost(params)
	return self.bonus_xp
end

function modifier_item_book_of_knowledge:GetModifierBonusStats_Strength(params)
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_book_of_knowledge:GetModifierBonusStats_Agility(params)
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_book_of_knowledge:GetModifierBonusStats_Intellect(params)
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_book_of_knowledge:GetAttributes()
	return MODIFIER_ATTRIBUTE_NONE
end