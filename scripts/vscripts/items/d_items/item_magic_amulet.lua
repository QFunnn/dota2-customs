--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_magic_amulet", "items/d_items/item_magic_amulet", LUA_MODIFIER_MOTION_NONE)

item_magic_amulet = item_magic_amulet or class({})
item_magic_amulet2 = item_magic_amulet or class({})
item_magic_amulet3 = item_magic_amulet or class({})
item_magic_amulet4 = item_magic_amulet or class({})
item_magic_amulet5 = item_magic_amulet or class({})

function item_magic_amulet:GetIntrinsicModifierName()
	return "modifier_item_magic_amulet"
end

function item_magic_amulet:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_magic_amulet:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_magic_amulet:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end

	return self.BaseClass.IsMuted(self)
end

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

modifier_item_magic_amulet = class({})

function modifier_item_magic_amulet:IsHidden()
	return true
end

function modifier_item_magic_amulet:IsPurgable()
	return false
end

function modifier_item_magic_amulet:OnCreated(kv)
	self.bonus_mana = self:GetAbility():GetSpecialValueFor("bonus_mana")
	self.cooldown_reduction_pct = self:GetAbility():GetSpecialValueFor("cooldown_reduction_pct")
	self.mana_cost_reduction_pct = self:GetAbility():GetSpecialValueFor("mana_cost_reduction_pct")
end

function modifier_item_magic_amulet:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
		MODIFIER_PROPERTY_UNIT_STATS_NEEDS_REFRESH,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_item_magic_amulet:GetModifierPercentageCooldown(params)
	return self.cooldown_reduction_pct
end

function modifier_item_magic_amulet:GetModifierPercentageManacostStacking(params)
	return self.mana_cost_reduction_pct
end

function modifier_item_magic_amulet:GetModifierUnitStatsNeedsRefresh(params)
	return 1
end

function modifier_item_magic_amulet:GetModifierManaBonus(params)
	return self.bonus_mana
end