--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_doom_spear", "items/d_items/item_doom_spear", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_doom_spear_effect", "items/d_items/item_doom_spear", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------

item_doom_spear = item_doom_spear or class({})
item_doom_spear2 = item_doom_spear or class({})
item_doom_spear3 = item_doom_spear or class({})
item_doom_spear4 = item_doom_spear or class({})
item_doom_spear5 = item_doom_spear or class({})

function item_doom_spear:GetIntrinsicModifierName()
	return "modifier_item_doom_spear"
end

function item_doom_spear:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_doom_spear:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_doom_spear:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end
	return self.BaseClass.IsMuted(self)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

modifier_item_doom_spear = class({})

function modifier_item_doom_spear:IsHidden()
	return true
end

function modifier_item_doom_spear:IsPurgable()
	return false
end

function modifier_item_doom_spear:IsAura()
	return true
end

function modifier_item_doom_spear:GetModifierAura()
	return "modifier_item_doom_spear_effect"
end

function modifier_item_doom_spear:GetTexture()
	return "spear"
end

function modifier_item_doom_spear:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_doom_spear:GetAuraSearchType()
	return DOTA_UNIT_TARGET_ALL
end

function modifier_item_doom_spear:GetAuraRadius()
	return self.radius
end

function modifier_item_doom_spear:OnCreated(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("AbilityCastRange")
	self.bonus_agility = self:GetAbility():GetSpecialValueFor("bonus_agility")
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_doom_spear:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_ATTRIBUTE_NONE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
	return funcs
end

function modifier_item_doom_spear:GetModifierBonusStats_Agility(params)
	return self.bonus_agility
end

function modifier_item_doom_spear:GetModifierPreAttack_BonusDamage(params)
	return self.bonus_damage
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

modifier_item_doom_spear_effect = class({})

function modifier_item_doom_spear_effect:GetTexture()
	return "spear"
end

function modifier_item_doom_spear_effect:OnCreated(kv)
	self.bonus_move_speed_pct = self:GetAbility():GetSpecialValueFor("bonus_move_speed_pct")
	self.attack_speed = self:GetAbility():GetSpecialValueFor("attack_speed")
end

function modifier_item_doom_spear_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_item_doom_spear_effect:GetModifierMoveSpeedBonus_Percentage(params)
	return self.bonus_move_speed_pct
end

function modifier_item_doom_spear_effect:GetModifierAttackSpeedBonus_Constant(params)
	return self.attack_speed
end