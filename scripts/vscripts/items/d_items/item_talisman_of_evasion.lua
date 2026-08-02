--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_talisman_of_evasion", "items/d_items/item_talisman_of_evasion", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_talisman_of_evasion_active",
	"items/d_items/item_talisman_of_evasion",
	LUA_MODIFIER_MOTION_NONE
)

--------------------------------------------------------------------------------

item_talisman_of_evasion_lua = item_talisman_of_evasion_lua or class({})
item_talisman_of_evasion_lua2 = item_talisman_of_evasion_lua or class({})
item_talisman_of_evasion_lua3 = item_talisman_of_evasion_lua or class({})
item_talisman_of_evasion_lua4 = item_talisman_of_evasion_lua or class({})
item_talisman_of_evasion_lua5 = item_talisman_of_evasion_lua or class({})

function item_talisman_of_evasion_lua:GetIntrinsicModifierName()
	return "modifier_talisman_of_evasion"
end

function item_talisman_of_evasion_lua:OnSpellStart()
	local caster = self:GetCaster()
	local original_target = self:GetCursorTarget()

	if PlayerResource:IsDisableHelpSetForPlayerID(caster:GetPlayerOwnerID(), original_target:GetPlayerOwnerID()) then
		return
	end

	original_target:AddNewModifier(caster, self, "modifier_talisman_of_evasion_active", {
		duration = self:GetSpecialValueFor("duration"),
	})
end

function item_talisman_of_evasion_lua:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_talisman_of_evasion_lua:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_talisman_of_evasion_lua:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end

	return self.BaseClass.IsMuted(self)
end

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

modifier_talisman_of_evasion_active = class({})

function modifier_talisman_of_evasion_active:IsHidden()
	return false
end

function modifier_talisman_of_evasion_active:RemoveOnDeath()
	return true
end

function modifier_talisman_of_evasion_active:IsDebuff()
	return false
end

function modifier_talisman_of_evasion_active:IsPurgable()
	return false
end

function modifier_talisman_of_evasion_active:DestroyOnExpire()
	return true
end

function modifier_talisman_of_evasion_active:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_talisman_of_evasion_active:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_talisman_of_evasion_active:OnCreated()
	self.evasion = self:GetAbility():GetSpecialValueFor("evasion")
	self.movespeed = self:GetAbility():GetSpecialValueFor("bonus_movespeed")
end

function modifier_talisman_of_evasion_active:GetModifierEvasion_Constant(params)
	return self.evasion
end

function modifier_talisman_of_evasion_active:GetModifierMoveSpeedBonus_Constant(params)
	return self.movespeed
end

function modifier_talisman_of_evasion_active:OnDestroy() end

function modifier_talisman_of_evasion_active:GetStatusEffectName()
	return "particles/status_fx/status_effect_blur.vpcf"
end

-------------------------------------------------------------------------------------------------

modifier_talisman_of_evasion = class({})

function modifier_talisman_of_evasion:IsHidden()
	return true
end

function modifier_talisman_of_evasion:IsPurgable()
	return false
end

function modifier_talisman_of_evasion:DestroyOnExpire()
	return false
end

function modifier_talisman_of_evasion:OnCreated(kv)
	self.armor = self:GetAbility():GetSpecialValueFor("bonus_armor") or 0
	self.agility = self:GetAbility():GetSpecialValueFor("bonus_agility") or 0
	self.movespeed = self:GetAbility():GetSpecialValueFor("bonus_movespeed") or 0
end

function modifier_talisman_of_evasion:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_talisman_of_evasion:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_ATTRIBUTE_NONE,
	}

	return funcs
end

function modifier_talisman_of_evasion:GetModifierPhysicalArmorBonus(params)
	return self.armor
end

function modifier_talisman_of_evasion:GetModifierBonusStats_Agility(params)
	return self.agility
end

function modifier_talisman_of_evasion:GetModifierMoveSpeedBonus_Constant(params)
	return self.movespeed
end