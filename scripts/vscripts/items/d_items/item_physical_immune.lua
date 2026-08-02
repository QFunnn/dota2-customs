--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_physical_immune", "items/d_items/item_physical_immune", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_physical_immune_active", "items/d_items/item_physical_immune", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_physical_immune_delay", "items/d_items/item_physical_immune", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------

item_physical_immune = item_physical_immune or class({})
item_physical_immune2 = item_physical_immune or class({})
item_physical_immune3 = item_physical_immune or class({})
item_physical_immune4 = item_physical_immune or class({})
item_physical_immune5 = item_physical_immune or class({})

function item_physical_immune:GetIntrinsicModifierName()
	return "modifier_physical_immune"
end

function item_physical_immune:OnSpellStart()
	local caster = self:GetCaster()
	local original_target = self:GetCursorTarget()
	if PlayerResource:IsDisableHelpSetForPlayerID(caster:GetPlayerOwnerID(), original_target:GetPlayerOwnerID()) then
		return
	end
	if self:GetCaster():HasModifier("modifier_physical_immune_delay") then
		return
	end
	original_target:AddNewModifier(
		caster,
		self,
		"modifier_physical_immune_active",
		{ duration = self:GetSpecialValueFor("duration") }
	)
	original_target:AddNewModifier(
		caster,
		self,
		"modifier_physical_immune_delay",
		{ duration = self:GetSpecialValueFor("tooltip_reapply_time") }
	)
end

function item_physical_immune:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_physical_immune:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_physical_immune:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end

	return self.BaseClass.IsMuted(self)
end

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

modifier_physical_immune_delay = class({})

function modifier_physical_immune_delay:IsHidden()
	return false
end

function modifier_physical_immune_delay:IsPurgable()
	return false
end
function modifier_physical_immune_delay:IsDebuff()
	return true
end

function modifier_physical_immune_delay:GetTexture()
	return "physical_immune"
end

-------------------------------------------------------------------------------------------------

modifier_physical_immune_active = class({})

function modifier_physical_immune_active:IsHidden()
	return false
end

function modifier_physical_immune_active:GetTexture()
	return "physical_immune"
end
function modifier_physical_immune_active:RemoveOnDeath()
	return true
end

function modifier_physical_immune_active:DestroyOnExpire()
	return true
end

function modifier_physical_immune_active:OnCreated(kv)
	self.bonus_as = self:GetAbility():GetSpecialValueFor("bonus_as")
end

function modifier_physical_immune_active:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_physical_immune_active:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
	}
	return funcs
end

function modifier_physical_immune_active:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_physical_immune_active:GetModifierAttackSpeedBonus_Constant(params)
	return self.bonus_as
end

function modifier_physical_immune_active:GetStatusEffectName()
	return "particles/status_fx/status_effect_blur.vpcf"
end

-------------------------------------------------------------------------------------------------

modifier_physical_immune = class({})

function modifier_physical_immune:IsHidden()
	return true
end

function modifier_physical_immune:IsPurgable()
	return false
end

function modifier_physical_immune:DestroyOnExpire()
	return false
end

function modifier_physical_immune:OnCreated(kv)
	self.bonus_all = self:GetAbility():GetSpecialValueFor("bonus_all")
end

function modifier_physical_immune:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_physical_immune:GetModifierBonusStats_Strength(params)
	return self.bonus_all
end

function modifier_physical_immune:GetModifierBonusStats_Agility(params)
	return self.bonus_all
end

function modifier_physical_immune:GetModifierBonusStats_Intellect(params)
	return self.bonus_all
end