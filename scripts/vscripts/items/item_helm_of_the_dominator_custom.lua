--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_helm_of_the_dominator_custom", "items/item_helm_of_the_dominator_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_helm_of_the_overlord_custom", "items/item_helm_of_the_dominator_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_helm_of_the_dominator_custom_aura", "items/item_helm_of_the_dominator_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_helm_of_the_overlord_custom_vladmir", "items/item_helm_of_the_dominator_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_helm_of_the_overlord_custom_vladmir_aura", "items/item_helm_of_the_dominator_custom", LUA_MODIFIER_MOTION_NONE )

item_helm_of_the_dominator_custom = class({})

function item_helm_of_the_dominator_custom:GetIntrinsicModifierName() 
	return "modifier_item_helm_of_the_dominator_custom"
end

modifier_item_helm_of_the_dominator_custom = class({})

function modifier_item_helm_of_the_dominator_custom:IsHidden()
	return true
end

function modifier_item_helm_of_the_dominator_custom:IsPurgable() return false end
function modifier_item_helm_of_the_dominator_custom:IsPurgeException() return false end

function modifier_item_helm_of_the_dominator_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_helm_of_the_dominator_custom:DeclareFunctions()
return 	{
			MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
			MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
			MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
			MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
			MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		}
end

function modifier_item_helm_of_the_dominator_custom:GetModifierBonusStats_Strength()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_stats")
	end
end

function modifier_item_helm_of_the_dominator_custom:GetModifierBonusStats_Agility()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_stats")
	end
end

function modifier_item_helm_of_the_dominator_custom:GetModifierBonusStats_Intellect()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_stats")
	end
end

function modifier_item_helm_of_the_dominator_custom:GetModifierConstantHealthRegen()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_regen")
	end
end

function modifier_item_helm_of_the_dominator_custom:GetModifierPhysicalArmorBonus()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_armor")
	end
end

function modifier_item_helm_of_the_dominator_custom:IsAura() return true end

function modifier_item_helm_of_the_dominator_custom:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_helm_of_the_dominator_custom:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_item_helm_of_the_dominator_custom:GetAuraEntityReject(hTarget)
    if not IsServer() then return end
    local modifier_illusion = hTarget:FindModifierByName("modifier_illusion")
    if modifier_illusion and modifier_illusion:GetCaster() == self:GetCaster() then
        return false
    end
    if hTarget:GetOwner() == self:GetCaster() and hTarget ~= self:GetCaster() then
        return false
    end
    return true
end

function modifier_item_helm_of_the_dominator_custom:GetModifierAura()
    return "modifier_item_helm_of_the_dominator_custom_aura"
end

function modifier_item_helm_of_the_dominator_custom:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_item_helm_of_the_dominator_custom:GetAuraRadius()
    return -1
end

item_helm_of_the_overlord_custom = class({})

function item_helm_of_the_overlord_custom:GetIntrinsicModifierName() 
	return "modifier_item_helm_of_the_overlord_custom"
end

modifier_item_helm_of_the_overlord_custom = class({})

function modifier_item_helm_of_the_overlord_custom:IsHidden()
	return true
end

function modifier_item_helm_of_the_overlord_custom:IsPurgable()
    return false
end

function modifier_item_helm_of_the_overlord_custom:OnCreated()
	if not IsServer() then return end
	self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_item_helm_of_the_overlord_custom_vladmir", {})
end

function modifier_item_helm_of_the_overlord_custom:OnDestroy()
	if not IsServer() then return end
	self:GetCaster():RemoveModifierByName("modifier_item_helm_of_the_overlord_custom_vladmir")
end

function modifier_item_helm_of_the_overlord_custom:DeclareFunctions()
return 	{
			MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
			MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
			MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
			MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
			MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		}
end

function modifier_item_helm_of_the_overlord_custom:GetModifierBonusStats_Strength()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_stats")
	end
end

function modifier_item_helm_of_the_overlord_custom:GetModifierBonusStats_Agility()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_stats")
	end
end

function modifier_item_helm_of_the_overlord_custom:GetModifierBonusStats_Intellect()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_stats")
	end
end

function modifier_item_helm_of_the_overlord_custom:GetModifierConstantHealthRegen()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_regen")
	end
end

function modifier_item_helm_of_the_overlord_custom:GetModifierPhysicalArmorBonus()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("bonus_armor")
	end
end

function modifier_item_helm_of_the_overlord_custom:IsAura() return true end

function modifier_item_helm_of_the_overlord_custom:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_helm_of_the_overlord_custom:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_item_helm_of_the_overlord_custom:GetAuraEntityReject(hTarget)
    if not IsServer() then return end
    local modifier_illusion = hTarget:FindModifierByName("modifier_illusion")
    if modifier_illusion and modifier_illusion:GetCaster() == self:GetCaster() then
        return false
    end
    if hTarget:GetOwner() == self:GetCaster() and hTarget ~= self:GetCaster() then
        return false
    end
    return true
end

function modifier_item_helm_of_the_overlord_custom:GetModifierAura()
    return "modifier_item_helm_of_the_dominator_custom_aura"
end

function modifier_item_helm_of_the_overlord_custom:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_item_helm_of_the_overlord_custom:GetAuraRadius()
    return -1
end

modifier_item_helm_of_the_overlord_custom_vladmir = class({})

function modifier_item_helm_of_the_overlord_custom_vladmir:IsPurgable() return false end
function modifier_item_helm_of_the_overlord_custom_vladmir:RemoveOnDeath() return false end
function modifier_item_helm_of_the_overlord_custom_vladmir:IsHidden() return true end

function modifier_item_helm_of_the_overlord_custom_vladmir:IsAura()
    return true
end

function modifier_item_helm_of_the_overlord_custom_vladmir:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("aura_radius")
end

function modifier_item_helm_of_the_overlord_custom_vladmir:GetModifierAura()
    return "modifier_item_helm_of_the_overlord_custom_vladmir_aura"
end
   
function modifier_item_helm_of_the_overlord_custom_vladmir:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_helm_of_the_overlord_custom_vladmir:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_item_helm_of_the_overlord_custom_vladmir:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_item_helm_of_the_overlord_custom_vladmir_aura = class({})

function modifier_item_helm_of_the_overlord_custom_vladmir_aura:IsPurgable() return false end

function modifier_item_helm_of_the_overlord_custom_vladmir_aura:DeclareFunctions()
	return {MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,MODIFIER_PROPERTY_PHYSICAL_LIFESTEAL}
end

function modifier_item_helm_of_the_overlord_custom_vladmir_aura:GetModifierConstantManaRegen()
	return self:GetAbility():GetSpecialValueFor("mana_regen_aura")
end

function modifier_item_helm_of_the_overlord_custom_vladmir_aura:GetModifierBaseDamageOutgoing_Percentage()
	return self:GetAbility():GetSpecialValueFor("damage_aura")
end

function modifier_item_helm_of_the_overlord_custom_vladmir_aura:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("armor_aura")
end

function modifier_item_helm_of_the_overlord_custom_vladmir_aura:GetModifierProperty_PhysicalLifesteal(params)
    return self:GetAbility():GetSpecialValueFor("lifesteal_aura")
end

modifier_item_helm_of_the_dominator_custom_aura = class({})

function modifier_item_helm_of_the_dominator_custom_aura:OnCreated()
	if not IsServer() then return end
	self:SetHasCustomTransmitterData(true)
	self.creep_bonus_damage = self:GetAbility():GetSpecialValueFor("creep_bonus_damage")
	self.creep_bonus_armor = self:GetAbility():GetSpecialValueFor("creep_bonus_armor")
	self.creep_bonus_hp_regen = self:GetAbility():GetSpecialValueFor("creep_bonus_hp_regen")
	self.creep_bonus_mp_regen = self:GetAbility():GetSpecialValueFor("creep_bonus_mp_regen")
	self:StartIntervalThink(1)
end

function modifier_item_helm_of_the_dominator_custom_aura:OnIntervalThink()
	if not IsServer() then return end
	self:OnCreated()
end

function modifier_item_helm_of_the_dominator_custom_aura:DeclareFunctions()
	return 	
	{
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
end

function modifier_item_helm_of_the_dominator_custom_aura:AddCustomTransmitterData() return {
    creep_bonus_damage = self.creep_bonus_damage,
	creep_bonus_armor = self.creep_bonus_armor,
	creep_bonus_hp_regen = self.creep_bonus_hp_regen,
	creep_bonus_mp_regen = self.creep_bonus_mp_regen,
} end

function modifier_item_helm_of_the_dominator_custom_aura:HandleCustomTransmitterData(data)
    self.creep_bonus_damage = data.creep_bonus_damage
	self.creep_bonus_armor = data.creep_bonus_armor
	self.creep_bonus_hp_regen = data.creep_bonus_hp_regen
	self.creep_bonus_mp_regen = data.creep_bonus_mp_regen
end

function modifier_item_helm_of_the_dominator_custom_aura:GetModifierPhysicalArmorBonus()
	return self.creep_bonus_armor
end

function modifier_item_helm_of_the_dominator_custom_aura:GetModifierConstantManaRegen()
	return self.creep_bonus_mp_regen
end

function modifier_item_helm_of_the_dominator_custom_aura:GetModifierPreAttack_BonusDamage()
	return self.creep_bonus_damage
end

function modifier_item_helm_of_the_dominator_custom_aura:GetModifierConstantHealthRegen()
	return self.creep_bonus_hp_regen
end