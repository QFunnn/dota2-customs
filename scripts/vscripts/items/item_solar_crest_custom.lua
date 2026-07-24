--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_solar_crest_custom", "items/item_solar_crest_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_solar_crest_custom_buff", "items/item_solar_crest_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_solar_crest_custom_debuff", "items/item_solar_crest_custom.lua", LUA_MODIFIER_MOTION_NONE)

item_solar_crest_custom = class({})

function item_solar_crest_custom:GetIntrinsicModifierName()
	return "modifier_item_solar_crest_custom"
end

function item_solar_crest_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	   
    local target = self:GetCursorTarget()

    self:GetCaster():EmitSound("DOTA_Item.MedallionOfCourage.Activate")

    if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
        target:AddNewModifier(self:GetCaster(), self, "modifier_item_solar_crest_custom_buff", {duration = duration})
    else
        target:AddNewModifier(self:GetCaster(), self, "modifier_item_solar_crest_custom_debuff", {duration = duration * (1 - target:GetStatusResistance())})
    end
end

modifier_item_solar_crest_custom = class({})

function modifier_item_solar_crest_custom:IsHidden() return true end
function modifier_item_solar_crest_custom:IsPurgable() return false end
function modifier_item_solar_crest_custom:IsPurgeException() return false end
function modifier_item_solar_crest_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_solar_crest_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end

function modifier_item_solar_crest_custom:GetModifierPhysicalArmorBonus()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_armor")
    end
end

function modifier_item_solar_crest_custom:GetModifierConstantManaRegen()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
    end
end

function modifier_item_solar_crest_custom:GetModifierMoveSpeedBonus_Constant()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("movespeed_bonus")
    end
end

function modifier_item_solar_crest_custom:GetModifierBonusStats_Strength()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
    end
end

function modifier_item_solar_crest_custom:GetModifierBonusStats_Agility()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
    end
end

function modifier_item_solar_crest_custom:GetModifierBonusStats_Intellect()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
    end
end

modifier_item_solar_crest_custom_buff = class({})

function modifier_item_solar_crest_custom_buff:DeclareFunctions()
    local decFuncs = {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
    return decFuncs
end

function modifier_item_solar_crest_custom_buff:GetModifierPhysicalArmorBonus()
    return self:GetAbility():GetSpecialValueFor("armor_active")
end

function modifier_item_solar_crest_custom_buff:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("attack_speed_active")
end

function modifier_item_solar_crest_custom_buff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movespeed_active")
end

function modifier_item_solar_crest_custom_buff:GetEffectName()
    return "particles/items3_fx/star_emblem_friend.vpcf" end

function modifier_item_solar_crest_custom_buff:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW end

modifier_item_solar_crest_custom_debuff = class({})

function modifier_item_solar_crest_custom_debuff:DeclareFunctions()
    local decFuncs = {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
    return decFuncs
end

function modifier_item_solar_crest_custom_debuff:GetModifierPhysicalArmorBonus()
    return self:GetAbility():GetSpecialValueFor("armor_active") * -1
end

function modifier_item_solar_crest_custom_debuff:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("attack_speed_active") * -1
end

function modifier_item_solar_crest_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movespeed_active") * -1
end

function modifier_item_solar_crest_custom_debuff:GetEffectName()
    return "particles/items3_fx/star_emblem.vpcf" end

function modifier_item_solar_crest_custom_debuff:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW end