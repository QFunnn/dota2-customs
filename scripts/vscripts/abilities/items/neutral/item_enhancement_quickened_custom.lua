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
LinkLuaModifier(
	"modifier_item_enhancement_quickened_custom_slow",
	"abilities/items/neutral/item_enhancement_quickened_custom",
	LUA_MODIFIER_MOTION_NONE
)

item_enhancement_quickened_custom = class({})

function item_enhancement_quickened_custom:GetIntrinsicModifierName()
	return "modifier_item_enhancement_quickened_custom"
end

function item_enhancement_quickened_custom:Spawn()
	self.movement_speed = self:GetSpecialValueFor("movement_speed")
	self.duration = self:GetSpecialValueFor("duration")
	self.range = self:GetSpecialValueFor("range")
	self.slow = self:GetSpecialValueFor("slow")
end

modifier_item_enhancement_quickened_custom = class(mod_hidden)
function modifier_item_enhancement_quickened_custom:RemoveOnDeath()
	return false
end
function modifier_item_enhancement_quickened_custom:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.movement_speed = self.ability.movement_speed
	self.duration = self.ability.duration
	self.range = self.ability.range

	if not self.parent:IsRealHero() then
		return
	end
	self.parent:AddDamageEvent_out(self, true)
end

function modifier_item_enhancement_quickened_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	}
end

function modifier_item_enhancement_quickened_custom:GetModifierMoveSpeedBonus_Constant()
	return self.movement_speed
end

function modifier_item_enhancement_quickened_custom:DamageEvent_out(params)
	if not IsServer() then
		return
	end
	if not IsValid(self.ability) then
		return
	end
	if self.parent ~= params.attacker then
		return
	end
	if not params.unit:IsUnit() then
		return
	end
	if (self.parent:GetAbsOrigin() - params.unit:GetAbsOrigin()):Length2D() > self.range then
		return
	end

	params.unit:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_item_enhancement_quickened_custom_slow",
		{ duration = self.duration }
	)
end

modifier_item_enhancement_quickened_custom_slow = class(mod_hidden)
function modifier_item_enhancement_quickened_custom_slow:IsPurgable()
	return true
end
function modifier_item_enhancement_quickened_custom_slow:OnCreated()
	self.ability = self:GetAbility()

	self.slow = self.ability.slow
end

function modifier_item_enhancement_quickened_custom_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	}
end

function modifier_item_enhancement_quickened_custom_slow:GetModifierMoveSpeedBonus_Constant()
	return self.slow
end