--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_enhancement_quickened_custom",
	"abilities/items/neutral/item_enhancement_quickened_custom",
	LUA_MODIFIER_MOTION_NONE
)

item_enhancement_quickened_custom = class({})

function item_enhancement_quickened_custom:GetIntrinsicModifierName()
	return "modifier_item_enhancement_quickened_custom"
end

modifier_item_enhancement_quickened_custom = class(mod_hidden)
function modifier_item_enhancement_quickened_custom:RemoveOnDeath()
	return false
end
function modifier_item_enhancement_quickened_custom:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self:OnRefresh()
end

function modifier_item_enhancement_quickened_custom:OnRefresh()
	self.movement_speed = self.ability:GetSpecialValueFor("movement_speed")
	self.slow_resist = self.ability:GetSpecialValueFor("slow_resist")
end

function modifier_item_enhancement_quickened_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING,
	}
end

function modifier_item_enhancement_quickened_custom:GetModifierMoveSpeedBonus_Constant()
	return self.movement_speed
end

function modifier_item_enhancement_quickened_custom:GetModifierSlowResistance_Stacking()
	return self.slow_resist
end