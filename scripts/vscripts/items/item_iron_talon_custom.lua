--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_iron_talon_custom", "items/item_iron_talon_custom", LUA_MODIFIER_MOTION_NONE)

item_iron_talon_custom = class({})

function item_iron_talon_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorPosition()
	if self:GetCursorTarget().CutDown then
		self:GetCursorTarget():CutDown(self:GetCaster():GetTeamNumber())
	end
	GridNav:DestroyTreesAroundPoint(target, 10, true)
end

function item_iron_talon_custom:GetIntrinsicModifierName()
	return "modifier_item_iron_talon_custom"
end

modifier_item_iron_talon_custom = class({})

function modifier_item_iron_talon_custom:IsHidden() return true end

function modifier_item_iron_talon_custom:IsPurgable() return false end
function modifier_item_iron_talon_custom:IsPurgeException() return false end

function modifier_item_iron_talon_custom:OnCreated()
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.bonus_armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_item_iron_talon_custom:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end

function modifier_item_iron_talon_custom:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end

function modifier_item_iron_talon_custom:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end