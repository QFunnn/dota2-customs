--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_custom_tranquil", "items/custom_items/item_tranquil_boots_lua", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------

item_tranquil_lua1 = item_tranquil_lua1 or class({})
item_tranquil_lua2 = item_tranquil_lua1 or class({})
item_tranquil_lua3 = item_tranquil_lua1 or class({})

function item_tranquil_lua1:GetIntrinsicModifierName()
	return "modifier_item_custom_tranquil"
end

-------------------------------------------------------------------------------

modifier_item_custom_tranquil = class({})

function modifier_item_custom_tranquil:IsHidden()
	return true
end

function modifier_item_custom_tranquil:IsPurgable()
	return false
end

function modifier_item_custom_tranquil:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_custom_tranquil:OnCreated(kv)
	self.bonus_speed = self:GetAbility():GetSpecialValueFor("bonus_speed")
	self.bonus_hp_reg = self:GetAbility():GetSpecialValueFor("bonus_hp_reg")
	self.bonus_all = self:GetAbility():GetSpecialValueFor("bonus_all")
end

function modifier_item_custom_tranquil:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
	return funcs
end

function modifier_item_custom_tranquil:GetModifierMoveSpeedBonus_Special_Boots(params)
	return self.bonus_speed
end

function modifier_item_custom_tranquil:GetModifierConstantHealthRegen(params)
	return self.bonus_hp_reg
end

function modifier_item_custom_tranquil:GetModifierBonusStats_Strength(params)
	return self.bonus_all
end

function modifier_item_custom_tranquil:GetModifierBonusStats_Agility(params)
	return self.bonus_all
end

function modifier_item_custom_tranquil:GetModifierBonusStats_Intellect(params)
	return self.bonus_all
end