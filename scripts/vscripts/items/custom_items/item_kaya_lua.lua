--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


item_kaya_lua1 = item_kaya_lua1 or class({})
item_kaya_lua2 = item_kaya_lua1 or class({})
item_kaya_lua3 = item_kaya_lua1 or class({})

LinkLuaModifier("modifier_item_kaya_lua", "items/custom_items/item_kaya_lua", LUA_MODIFIER_MOTION_NONE)

function item_kaya_lua1:GetIntrinsicModifierName()
	return "modifier_item_kaya_lua"
end

-----------------------------------------------------------------------------

modifier_item_kaya_lua = class({})

function modifier_item_kaya_lua:IsHidden()
	return true
end

function modifier_item_kaya_lua:IsPurgable()
	return false
end

function modifier_item_kaya_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_kaya_lua:OnCreated(kv)
	self.bonus_dmg = self:GetAbility():GetSpecialValueFor("spell_amp")
	self.spell_lifesteal_amp = self:GetAbility():GetSpecialValueFor("spell_lifesteal_amp")
	self.bonus_int = self:GetAbility():GetSpecialValueFor("bonus_intellect")
	self.mana_regen_multiplier = self:GetAbility():GetSpecialValueFor("mana_regen_multiplier")

	self.particle_name = "particles/items3_fx/octarine_core_lifesteal.vpcf"
end

--------------------------------------------------------------------------------

function modifier_item_kaya_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_LIFESTEAL_AMPLIFY_PERCENTAGE,
	}
	return funcs
end

--------------------------------------------------------------------------------

function modifier_item_kaya_lua:GetModifierSpellAmplify_Percentage(params)
	return self.bonus_dmg
end

function modifier_item_kaya_lua:GetModifierBonusStats_Intellect(params)
	return self.bonus_int
end

function modifier_item_kaya_lua:GetModifierSpellLifestealRegenAmplify_Percentage(params)
	return self.spell_lifesteal_amp
end

function modifier_item_kaya_lua:GetModifierMPRegenAmplify_Percentage(params)
	return self.mana_regen_multiplier
end