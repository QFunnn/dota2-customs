--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_third_eye_custom", "items/item_third_eye_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_third_eye_custom_buff", "items/item_third_eye_custom", LUA_MODIFIER_MOTION_NONE)

item_third_eye_custom = class({})

function item_third_eye_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_third_eye_custom_buff", {duration = duration})
end

function item_third_eye_custom:GetIntrinsicModifierName()
	return "modifier_item_third_eye_custom"
end

modifier_item_third_eye_custom = class({})

function modifier_item_third_eye_custom:IsHidden() return true end

function modifier_item_third_eye_custom:IsPurgable() return false end
function modifier_item_third_eye_custom:IsPurgeException() return false end

function modifier_item_third_eye_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end

function modifier_item_third_eye_custom:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_third_eye_custom:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_third_eye_custom:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

modifier_item_third_eye_custom_buff = class({})

function modifier_item_third_eye_custom_buff:IsPurgable() return false end

function modifier_item_third_eye_custom_buff:CheckState()
	return {
		[MODIFIER_STATE_FORCED_FLYING_VISION] = true,
	}
end