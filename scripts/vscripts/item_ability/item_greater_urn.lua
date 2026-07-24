--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_greater_urn", "item_ability/item_greater_urn.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_greater_urn_buff_damage", "item_ability/item_greater_urn.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_greater_urn_buff_evasion", "item_ability/item_greater_urn.lua", LUA_MODIFIER_MOTION_NONE)

--Abilities
if item_greater_urn == nil then
	item_greater_urn = class({})
end
function item_greater_urn:OnSpellStart()
	print("N2O", "???")
	self:SpendCharge()
end
function item_greater_urn:GetIntrinsicModifierName()
	return "modifier_item_greater_urn"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_greater_urn == nil then
	modifier_item_greater_urn = class({})
end
function modifier_item_greater_urn:IsHidden()
	return false
end
function modifier_item_greater_urn:IsDebuff()
	return false
end
function modifier_item_greater_urn:IsPurgable()
	return false
end
function modifier_item_greater_urn:IsPurgeException()
	return false
end
function modifier_item_greater_urn:RemoveOnDeath()
	return false
end
function modifier_item_greater_urn:OnCreated(params)
	self.bonus_agi = self:GetAbilitySpecialValueFor("bonus_agi")
	self.bonus_str = self:GetAbilitySpecialValueFor("bonus_str")
	self.bonus_int = self:GetAbilitySpecialValueFor("bonus_int")
	self.bonus_health_regen = self:GetAbilitySpecialValueFor("bonus_health_regen")
	self.bonus_mana_regen = self:GetAbilitySpecialValueFor("bonus_mana_regen")
	self.bonus_armor = self:GetAbilitySpecialValueFor("bonus_armor")
	self.bonus_health = self:GetAbilitySpecialValueFor("bonus_health")
	self.bonus_mana = self:GetAbilitySpecialValueFor("bonus_mana")
	self.bonus_movement_speed = self:GetAbilitySpecialValueFor("bonus_movement_speed")
	if IsServer() then
		AddModifierEvents(MODIFIER_EVENT_ON_DEATH, self, self:GetParent())
	end
end
function modifier_item_greater_urn:OnRefresh(params)
	self.bonus_agi = self:GetAbilitySpecialValueFor("bonus_agi")
	self.bonus_str = self:GetAbilitySpecialValueFor("bonus_str")
	self.bonus_int = self:GetAbilitySpecialValueFor("bonus_int")
	self.bonus_health_regen = self:GetAbilitySpecialValueFor("bonus_health_regen")
	self.bonus_mana_regen = self:GetAbilitySpecialValueFor("bonus_mana_regen")
	self.bonus_armor = self:GetAbilitySpecialValueFor("bonus_armor")
	self.bonus_health = self:GetAbilitySpecialValueFor("bonus_health")
	self.bonus_mana = self:GetAbilitySpecialValueFor("bonus_mana")
	self.bonus_movement_speed = self:GetAbilitySpecialValueFor("bonus_movement_speed")
	if IsServer() then
	end
end
function modifier_item_greater_urn:OnRemoved(bDeath)
	if IsServer() then
	end
end
function modifier_item_greater_urn:OnDestroy()
	if IsServer() then
		RemoveModifierEvents(MODIFIER_EVENT_ON_DEATH, self, self:GetParent())
	end
end
function modifier_item_greater_urn:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
	}
end
function modifier_item_greater_urn:GetModifierBonusStats_Agility(params)
	return self.bonus_agi
end
function modifier_item_greater_urn:GetModifierBonusStats_Strength(params)
	return self.bonus_str
end
function modifier_item_greater_urn:GetModifierBonusStats_Intellect(params)
	return self.bonus_int
end
function modifier_item_greater_urn:GetModifierConstantHealthRegen(params)
	return self.bonus_health_regen
end
function modifier_item_greater_urn:GetModifierConstantManaRegen(params)
	return self.bonus_mana_regen
end
function modifier_item_greater_urn:GetModifierPhysicalArmorBonus(params)
	return self.bonus_armor
end
function modifier_item_greater_urn:GetModifierHealthBonus(params)
	return self.bonus_health
end
function modifier_item_greater_urn:GetModifierManaBonus(params)
	return self.bonus_mana
end
function modifier_item_greater_urn:GetModifierMoveSpeedBonus_Special_Boots(params)
	return self.bonus_movement_speed
end
function modifier_item_greater_urn:OnDeath(params)
	local hTarget = params.unit
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()
	if IsValid(hAbility) and IsValid(hTarget) and IsValid(hParent) and hTarget:GetTeamNumber() ~= hParent:GetTeamNumber() then
		hAbility:SetCurrentCharges(hAbility:GetCurrentCharges() + 1)
	end
end