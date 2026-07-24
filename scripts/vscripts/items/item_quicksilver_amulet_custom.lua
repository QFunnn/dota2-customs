--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_quicksilver_amulet_custom", "items/item_quicksilver_amulet_custom", LUA_MODIFIER_MOTION_NONE)

item_quicksilver_amulet_custom = class({})

function item_quicksilver_amulet_custom:GetIntrinsicModifierName()
	return "modifier_item_quicksilver_amulet_custom"
end

modifier_item_quicksilver_amulet_custom = class({})

function modifier_item_quicksilver_amulet_custom:IsHidden() return true end

function modifier_item_quicksilver_amulet_custom:IsPurgable() return false end
function modifier_item_quicksilver_amulet_custom:IsPurgeException() return false end

function modifier_item_quicksilver_amulet_custom:OnCreated()
	self.bonus_movespeed = self:GetAbility():GetSpecialValueFor("bonus_movespeed")
	self.bonus_attackspeed = self:GetAbility():GetSpecialValueFor("bonus_attackspeed")
	self.bonus_anim = self:GetAbility():GetSpecialValueFor("bonus_anim")
	self.bonus_projectilespeed = self:GetAbility():GetSpecialValueFor("bonus_projectilespeed")
end

function modifier_item_quicksilver_amulet_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACK_ANIM_TIME_PERCENTAGE,
		MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS_PERCENTAGE,
	}
end

function modifier_item_quicksilver_amulet_custom:GetModifierMoveSpeedBonus_Constant()
	return self.bonus_movespeed
end

function modifier_item_quicksilver_amulet_custom:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attackspeed
end

function modifier_item_quicksilver_amulet_custom:GetModifierPercentageAttackAnimTime()
	return self.bonus_anim
end

function modifier_item_quicksilver_amulet_custom:GetModifierProjectileSpeedBonusPercentage()
	return self.bonus_projectilespeed
end