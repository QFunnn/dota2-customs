--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_enhancement_universal_custom",
	"abilities/items/neutral/item_enhancement_universal_custom",
	LUA_MODIFIER_MOTION_NONE
)

item_enhancement_universal_custom = class({})

function item_enhancement_universal_custom:GetIntrinsicModifierName()
	return "modifier_item_enhancement_universal_custom"
end

modifier_item_enhancement_universal_custom = class(mod_hidden)
function modifier_item_enhancement_universal_custom:RemoveOnDeath()
	return false
end
function modifier_item_enhancement_universal_custom:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self:OnRefresh()
end

function modifier_item_enhancement_universal_custom:OnRefresh()
	self.stats = self.ability:GetSpecialValueFor("stats")
end

function modifier_item_enhancement_universal_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
end

function modifier_item_enhancement_universal_custom:GetModifierBonusStats_Agility()
	return self.stats
end

function modifier_item_enhancement_universal_custom:GetModifierBonusStats_Strength()
	return self.stats
end

function modifier_item_enhancement_universal_custom:GetModifierBonusStats_Intellect()
	return self.stats
end