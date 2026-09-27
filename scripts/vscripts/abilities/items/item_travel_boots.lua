--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_travel_boots_custom", "abilities/items/item_travel_boots", LUA_MODIFIER_MOTION_NONE)

item_travel_boots_custom = class({})

function item_travel_boots_custom:GetIntrinsicModifierName()
	return "modifier_item_travel_boots_custom"
end

function item_travel_boots_custom:Spawn()
	self.bonus_movement_speed = self:GetSpecialValueFor("bonus_movement_speed")
	self.bounty_bonus = self:GetSpecialValueFor("bounty_bonus")
end

function item_travel_boots_custom:GetAbilityTextureName()
	if not self or not self:GetCaster() then
		return
	end
	return wearables_system:GetAbilityIconReplacement(self:GetCaster(), "item_travel_boots", self)
end

modifier_item_travel_boots_custom = class(mod_hidden)
function modifier_item_travel_boots_custom:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.speed = self.ability.bonus_movement_speed
	self.bounty_bonus = self.ability.bounty_bonus / 100
end

function modifier_item_travel_boots_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
	}
end

function modifier_item_travel_boots_custom:GetModifierMoveSpeedBonus_Special_Boots()
	return self.speed
end

LinkLuaModifier("modifier_item_travel_boots_2_custom", "abilities/items/item_travel_boots", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_travel_boots_2_perma", "abilities/items/item_travel_boots", LUA_MODIFIER_MOTION_NONE)

item_travel_boots_2_custom = class({})

function item_travel_boots_2_custom:GetIntrinsicModifierName()
	return "modifier_item_travel_boots_2_custom"
end

function item_travel_boots_2_custom:Spawn()
	self.bonus_movement_speed = self:GetSpecialValueFor("bonus_movement_speed")
	self.bounty_bonus = self:GetSpecialValueFor("bounty_bonus")
	self.perma_bonus = self:GetSpecialValueFor("perma_bonus")
end

function item_travel_boots_2_custom:OnAbilityPhaseStart()
	if not IsServer() then
		return
	end
	if self:GetCaster():HasModifier("modifier_item_travel_boots_2_perma") then
		self:GetCaster():SendError("#essence_speed")
		return false
	end
	return true
end

function item_travel_boots_2_custom:OnSpellStart()
	local caster = self:GetCaster()

	if caster:HasModifier("modifier_item_travel_boots_2_perma") then
		return
	end

	caster:EmitSound("Item.MoonShard.Consume")
	caster:AddNewModifier(caster, self, "modifier_item_travel_boots_2_perma", {})
	self:Destroy()
end

modifier_item_travel_boots_2_custom = class(mod_hidden)
function modifier_item_travel_boots_2_custom:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.speed = self.ability.bonus_movement_speed
	self.bounty_bonus = self.ability.bounty_bonus / 100
end

function modifier_item_travel_boots_2_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
	}
end

function modifier_item_travel_boots_2_custom:GetModifierMoveSpeedBonus_Special_Boots()
	return self.speed
end

modifier_item_travel_boots_2_perma = class(mod_visible)
function modifier_item_travel_boots_2_perma:GetTexture()
	return "item_travel_boots_2"
end
function modifier_item_travel_boots_2_perma:RemoveOnDeath()
	return false
end
function modifier_item_travel_boots_2_perma:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.StackOnIllusion = true
	if not self.ability then
		self.speed = 50
	else
		self.speed = self.ability.perma_bonus
		self.bounty_bonus = self.ability.bounty_bonus / 100
	end
end

function modifier_item_travel_boots_2_perma:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
	}
end

function modifier_item_travel_boots_2_perma:GetModifierMoveSpeedBonus_Special_Boots()
	return self.speed
end