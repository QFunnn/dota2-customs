--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_ocean_heart_custom", "items/item_ocean_heart_custom", LUA_MODIFIER_MOTION_NONE)

item_ocean_heart_custom = class({})

function item_ocean_heart_custom:GetIntrinsicModifierName()
	return "modifier_item_ocean_heart_custom"
end

modifier_item_ocean_heart_custom = class({})

function modifier_item_ocean_heart_custom:IsHidden() return true end

function modifier_item_ocean_heart_custom:IsPurgable() return false end
function modifier_item_ocean_heart_custom:IsPurgeException() return false end

function modifier_item_ocean_heart_custom:OnCreated()
	self.bonus_armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
	self.hp_regen = self:GetAbility():GetSpecialValueFor("hp_regen")
end

function modifier_item_ocean_heart_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
end

function modifier_item_ocean_heart_custom:GetModifierConstantHealthRegen()
    if self:GetParent():GetAbsOrigin().z > 0 then return end
	return self.hp_regen
end

function modifier_item_ocean_heart_custom:GetModifierPhysicalArmorBonus()
    if self:GetParent():GetAbsOrigin().z > 0 then return end
	return self.bonus_armor
end



