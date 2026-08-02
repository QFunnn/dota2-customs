--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_hell_blade", "items/d_items/item_hell_blade", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------

item_hell_blade = item_hell_blade or class({})
item_hell_blade2 = item_hell_blade or class({})
item_hell_blade3 = item_hell_blade or class({})
item_hell_blade4 = item_hell_blade or class({})
item_hell_blade5 = item_hell_blade or class({})

function item_hell_blade:GetIntrinsicModifierName()
	return "modifier_item_hell_blade"
end

function item_hell_blade:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_hell_blade:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_hell_blade:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end

	return self.BaseClass.IsMuted(self)
end

----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------

modifier_item_hell_blade = class({})

function modifier_item_hell_blade:IsHidden()
	return true
end

function modifier_item_hell_blade:IsPurgable()
	return false
end

function modifier_item_hell_blade:OnCreated(kv)
	self.bonus_move_speed = self:GetAbility():GetSpecialValueFor("bonus_move_speed")
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.bonus_evasion = self:GetAbility():GetSpecialValueFor("bonus_evasion")
end

function modifier_item_hell_blade:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_item_hell_blade:GetModifierMoveSpeedBonus_Constant(params)
	return self.bonus_move_speed
end

function modifier_item_hell_blade:GetModifierPreAttack_BonusDamage(params)
	return self.bonus_damage
end

function modifier_item_hell_blade:GetModifierEvasion_Constant(params)
	return self.bonus_evasion
end