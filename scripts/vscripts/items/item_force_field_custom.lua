--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_force_field_custom", "items/item_force_field_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_force_field_custom_buff", "items/item_force_field_custom", LUA_MODIFIER_MOTION_NONE)

item_force_field_custom = class({})

function item_force_field_custom:GetIntrinsicModifierName()
	return "modifier_item_force_field_custom"
end

function item_force_field_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_force_field_custom_buff", {duration = duration})
	self:GetCaster():EmitSound("Item.ForceField.Cast")
end

modifier_item_force_field_custom = class({})

function modifier_item_force_field_custom:IsHidden() return true end

function modifier_item_force_field_custom:IsPurgable() return false end
function modifier_item_force_field_custom:IsPurgeException() return false end

function modifier_item_force_field_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
end

function modifier_item_force_field_custom:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_item_force_field_custom:GetModifierMagicalResistanceBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_mag_resist")
end

modifier_item_force_field_custom_buff = class({})

function modifier_item_force_field_custom_buff:IsPurgable() return false end

function modifier_item_force_field_custom_buff:DeclareFunctions()
	return {
		 
	}
end

function modifier_item_force_field_custom_buff:OnTakeDamage(params)
	if params.unit ~= self:GetParent() then return end
	if params.attacker == self:GetParent() then return end
	if params.attacker:IsMagicImmune() then return end
	local damage_type = params.damage_type
	local damage = params.damage
	local end_damage = params.damage / 100 * self:GetAbility():GetSpecialValueFor("reflect")

	if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) ~= DOTA_DAMAGE_FLAG_HPLOSS and bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) ~= DOTA_DAMAGE_FLAG_REFLECTION then
		ApplyDamage({ victim = params.attacker, attacker = self:GetParent(), damage = end_damage, damage_type = damage_type, ability = self:GetAbility(), damage_flags = DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION })
	end
end

function modifier_item_force_field_custom_buff:GetEffectName()
	return "particles/items5_fx/force_field.vpcf"
end

function modifier_item_force_field_custom_buff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end