--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_grave_shoulder", "items/d_items/item_grave_shoulder", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
item_grave_shoulder = item_grave_shoulder or class({})
item_grave_shoulder2 = item_grave_shoulder or class({})
item_grave_shoulder3 = item_grave_shoulder or class({})
item_grave_shoulder4 = item_grave_shoulder or class({})
item_grave_shoulder5 = item_grave_shoulder or class({})

function item_grave_shoulder:GetIntrinsicModifierName()
	return "modifier_item_grave_shoulder"
end

function item_grave_shoulder:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_grave_shoulder:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_grave_shoulder:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end

	return self.BaseClass.IsMuted(self)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

modifier_item_grave_shoulder = class({})

function modifier_item_grave_shoulder:IsHidden()
	return true
end

function modifier_item_grave_shoulder:IsPurgable()
	return false
end

function modifier_item_grave_shoulder:OnCreated(kv)
	self.damage_block = self:GetAbility():GetSpecialValueFor("damage_block")
	self.bonus_all_stats = self:GetAbility():GetSpecialValueFor("bonus_all_stats")
	self.bonus_hp_regen = self:GetAbility():GetSpecialValueFor("bonus_hp_regen")
end

function modifier_item_grave_shoulder:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK_UNAVOIDABLE_PRE_ARMOR,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_item_grave_shoulder:GetModifierMoveSpeedBonus_Special_Boots(params)
	return self.bonus_movement_speed
end

function modifier_item_grave_shoulder:GetModifierBonusStats_Strength(params)
	return self.bonus_all_stats
end

function modifier_item_grave_shoulder:GetModifierBonusStats_Agility(params)
	return self.bonus_all_stats
end

function modifier_item_grave_shoulder:GetModifierBonusStats_Intellect(params)
	return self.bonus_all_stats
end

function modifier_item_grave_shoulder:GetModifierConstantHealthRegen(params)
	return self.bonus_hp_regen
end

function modifier_item_grave_shoulder:GetModifierPhysical_ConstantBlockUnavoidablePreArmor(params)
	return self.damage_block
end