--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_enhancement_crude_custom",
	"abilities/items/neutral/item_enhancement_crude_custom",
	LUA_MODIFIER_MOTION_NONE
)

item_enhancement_crude_custom = class({})

function item_enhancement_crude_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_item_enhancement_crude_custom"
end

modifier_item_enhancement_crude_custom = class(mod_hidden)
function modifier_item_enhancement_crude_custom:RemoveOnDeath()
	return false
end
function modifier_item_enhancement_crude_custom:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self:OnRefresh()
end

function modifier_item_enhancement_crude_custom:OnRefresh()
	self.armor = self.ability:GetSpecialValueFor("armor")
	self.resist = self.ability:GetSpecialValueFor("resist")
	self.movespeed = self.ability:GetSpecialValueFor("movespeed")
end

function modifier_item_enhancement_crude_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_item_enhancement_crude_custom:GetModifierPhysicalArmorBonus()
	return self.armor
end

function modifier_item_enhancement_crude_custom:GetModifierMagicalResistanceBonus()
	return self.resist
end

function modifier_item_enhancement_crude_custom:GetModifierMoveSpeedBonus_Constant()
	return self.movespeed
end