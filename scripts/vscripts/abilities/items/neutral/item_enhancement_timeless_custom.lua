--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_enhancement_timeless_custom",
	"abilities/items/neutral/item_enhancement_timeless_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_enhancement_timeless_custom_aura",
	"abilities/items/neutral/item_enhancement_timeless_custom",
	LUA_MODIFIER_MOTION_NONE
)

item_enhancement_timeless_custom = class({})

function item_enhancement_timeless_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_item_enhancement_timeless_custom"
end

function item_enhancement_timeless_custom:Spawn()
	self.radius = self:GetSpecialValueFor("radius")
	self.spell_amp = self:GetSpecialValueFor("spell_amp")
	self.status_amp = self:GetSpecialValueFor("status_amp")
end

modifier_item_enhancement_timeless_custom = class(mod_hidden)
function modifier_item_enhancement_timeless_custom:RemoveOnDeath()
	return false
end
function modifier_item_enhancement_timeless_custom:GetAuraDuration()
	return 0.1
end
function modifier_item_enhancement_timeless_custom:GetAuraRadius()
	return self.radius
end
function modifier_item_enhancement_timeless_custom:GetAuraSearchFlags()
	return 0
end
function modifier_item_enhancement_timeless_custom:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_item_enhancement_timeless_custom:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end
function modifier_item_enhancement_timeless_custom:GetModifierAura()
	return "modifier_item_enhancement_timeless_custom_aura"
end
function modifier_item_enhancement_timeless_custom:IsAura()
	return true
end
function modifier_item_enhancement_timeless_custom:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.radius = self.ability.radius
	self.damage = self.ability.spell_amp
end

function modifier_item_enhancement_timeless_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_item_enhancement_timeless_custom:GetModifierSpellAmplify_Percentage()
	return self.damage
end

modifier_item_enhancement_timeless_custom_aura = class(mod_hidden)
function modifier_item_enhancement_timeless_custom_aura:OnCreated()
	self.ability = self:GetAbility()

	self.status = self.ability.status_amp
end

function modifier_item_enhancement_timeless_custom_aura:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	}
end

function modifier_item_enhancement_timeless_custom_aura:GetModifierStatusResistanceStacking()
	return self.status
end