--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_enhancement_fleetfooted_custom",
	"abilities/items/neutral/item_enhancement_fleetfooted_custom",
	LUA_MODIFIER_MOTION_NONE
)

item_enhancement_fleetfooted_custom = class({})

function item_enhancement_fleetfooted_custom:GetIntrinsicModifierName()
	return "modifier_item_enhancement_fleetfooted_custom"
end

function item_enhancement_fleetfooted_custom:Spawn()
	self.movespeed = self:GetSpecialValueFor("movespeed")
	self.slow_resist = self:GetSpecialValueFor("slow_resist")
end

modifier_item_enhancement_fleetfooted_custom = class(mod_hidden)
function modifier_item_enhancement_fleetfooted_custom:RemoveOnDeath()
	return false
end
function modifier_item_enhancement_fleetfooted_custom:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.movespeed = self.ability.movespeed
	self.slow_resist = self.ability.slow_resist
end

function modifier_item_enhancement_fleetfooted_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING,
	}
end

function modifier_item_enhancement_fleetfooted_custom:GetModifierSlowResistance_Stacking()
	return self.slow_resist
end

function modifier_item_enhancement_fleetfooted_custom:GetModifierMoveSpeedBonus_Constant()
	return self.movespeed
end