--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_helm_of_the_undying_custom", "items/item_helm_of_the_undying_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_helm_of_the_undying_custom_buff", "items/item_helm_of_the_undying_custom", LUA_MODIFIER_MOTION_NONE)

item_helm_of_the_undying_custom = class({})

function item_helm_of_the_undying_custom:GetIntrinsicModifierName()
	return "modifier_item_helm_of_the_undying_custom"
end

modifier_item_helm_of_the_undying_custom = class({})

function modifier_item_helm_of_the_undying_custom:IsHidden() return true end

function modifier_item_helm_of_the_undying_custom:IsPurgable() return false end
function modifier_item_helm_of_the_undying_custom:IsPurgeException() return false end

function modifier_item_helm_of_the_undying_custom:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MIN_HEALTH,
	}
end

function modifier_item_helm_of_the_undying_custom:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_item_helm_of_the_undying_custom:GetMinHealth()
	if self:GetParent():IsIllusion() then return end
	if self:GetParent():HasModifier("modifier_phoenix_supernova_custom_death") then return end
	if not self:GetAbility():IsCooldownReady() then return end
	return 1
end

function modifier_item_helm_of_the_undying_custom:OnTakeDamage(params)
	if not IsServer() then return end
	if params.unit ~= self:GetParent() then return end
	if self:GetParent():GetHealth() > 1 then return end
	if not self:GetAbility():IsCooldownReady() then return end
	if self:GetParent():HasModifier("modifier_item_helm_of_the_undying_custom_buff") then return end
    if self:GetParent():HasModifier("modifier_phoenix_supernova_custom_death") then return end
	local duration = self:GetAbility():GetSpecialValueFor("duration")
	self:GetParent():EmitSound("Item.Brooch.Cast")
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_helm_of_the_undying_custom_buff", {duration = duration})
	self:GetAbility():UseResources(false, false, false, true)
end

modifier_item_helm_of_the_undying_custom_buff = class({})

function modifier_item_helm_of_the_undying_custom_buff:GetEffectName() return "particles/helm_of_the_undying_custom.vpcf" end
function modifier_item_helm_of_the_undying_custom_buff:IsHidden() return false end
function modifier_item_helm_of_the_undying_custom_buff:IsPurgable() return false end

function modifier_item_helm_of_the_undying_custom_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MIN_HEALTH,
	}
end

function modifier_item_helm_of_the_undying_custom_buff:GetMinHealth()
	return 1
end