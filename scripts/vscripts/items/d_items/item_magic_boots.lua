--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_magic_boots", "items/d_items/item_magic_boots", LUA_MODIFIER_MOTION_NONE)
--------------------------------------------------------------------------------
item_magic_boots = item_magic_boots or class({})
item_magic_boots2 = item_magic_boots or class({})
item_magic_boots3 = item_magic_boots or class({})
item_magic_boots4 = item_magic_boots or class({})
item_magic_boots5 = item_magic_boots or class({})

function item_magic_boots:GetIntrinsicModifierName()
	return "modifier_item_magic_boots"
end

function item_magic_boots:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_magic_boots:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_magic_boots:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end

	return self.BaseClass.IsMuted(self)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

modifier_item_magic_boots = class({})

function modifier_item_magic_boots:IsHidden()
	return true
end

function modifier_item_magic_boots:IsPurgable()
	return false
end

function modifier_item_magic_boots:OnCreated(kv)
	self.bonus_intelligence = self:GetAbility():GetSpecialValueFor("bonus_intelligence")
	self.bonus_hp = self:GetAbility():GetSpecialValueFor("helth")
end

function modifier_item_magic_boots:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_item_magic_boots:GetModifierHealthBonus(params)
	return self.bonus_hp
end

function modifier_item_magic_boots:GetModifierBonusStats_Intellect(params)
	return self.bonus_intelligence
end

function modifier_item_magic_boots:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end