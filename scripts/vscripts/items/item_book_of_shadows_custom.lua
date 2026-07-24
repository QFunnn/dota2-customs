--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_book_of_shadows_custom", "items/item_book_of_shadows_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_book_of_shadows_custom_buff", "items/item_book_of_shadows_custom", LUA_MODIFIER_MOTION_NONE)

item_book_of_shadows_custom = class({})

function item_book_of_shadows_custom:GetIntrinsicModifierName()
	return "modifier_item_book_of_shadows_custom"
end

function item_book_of_shadows_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_book_of_shadows_custom_buff", {duration = duration})
	self:GetCaster():EmitSound("Item.BookOfShadows.Target")
	self:GetCaster():Purge(false, true, false, false, false)
end

modifier_item_book_of_shadows_custom = class({})

function modifier_item_book_of_shadows_custom:IsHidden() return true end

function modifier_item_book_of_shadows_custom:IsPurgable() return false end
function modifier_item_book_of_shadows_custom:IsPurgeException() return false end

function modifier_item_book_of_shadows_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
end

function modifier_item_book_of_shadows_custom:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_book_of_shadows_custom:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_book_of_shadows_custom:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

modifier_item_book_of_shadows_custom_buff = class({})

function modifier_item_book_of_shadows_custom_buff:CheckState()
	return 
	{
		[MODIFIER_STATE_UNTARGETABLE_ENEMY] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}
end

function modifier_item_book_of_shadows_custom_buff:GetEffectName()
	return "particles/units/heroes/hero_dark_willow/dark_willow_shadow_realm.vpcf"
end

