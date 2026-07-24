--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_aghanims_scepter_custom", "items/item_aghanims_scepter_custom", LUA_MODIFIER_MOTION_NONE )

item_aghanims_scepter_custom = class({})

function item_aghanims_scepter_custom:GetIntrinsicModifierName()
    return "modifier_item_aghanims_scepter_custom"
end

modifier_item_aghanims_scepter_custom = class({})

function modifier_item_aghanims_scepter_custom:IsHidden() return true end
function modifier_item_aghanims_scepter_custom:IsPurgable() return false end
function modifier_item_aghanims_scepter_custom:IsPurgeException() return false end

function modifier_item_aghanims_scepter_custom:DeclareFunctions() 
  return 
  {
      MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
      MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
      MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
      MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
      MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
      MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
  } 
end

function modifier_item_aghanims_scepter_custom:GetModifierBonusStats_Strength()
    return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_aghanims_scepter_custom:GetModifierBonusStats_Agility()
    return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_aghanims_scepter_custom:GetModifierBonusStats_Intellect()
    return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_aghanims_scepter_custom:GetModifierIncomingDamage_Percentage()
    if self:GetParent():HasModifier("modifier_item_moon_aghanim_buff") then return end
    if self:GetParent():HasModifier("modifier_item_moon_aghanim") then return end
    local count = self:GetParent():GetStrength() / self:GetAbility():GetSpecialValueFor("str_to_bonus")
    count = math.min(count, 5)
    return self:GetAbility():GetSpecialValueFor("str_damage_reduce") * count * -1
end

function modifier_item_aghanims_scepter_custom:GetModifierTotalDamageOutgoing_Percentage()
    if self:GetParent():HasModifier("modifier_item_moon_aghanim_buff") then return end
    if self:GetParent():HasModifier("modifier_item_moon_aghanim") then return end
    local count = self:GetParent():GetAgility() / self:GetAbility():GetSpecialValueFor("agi_to_bonus")
    count = math.min(count, 5)
    return self:GetAbility():GetSpecialValueFor("agi_damage_bonus") * count
end

function modifier_item_aghanims_scepter_custom:GetModifierSpellAmplify_Percentage()
    if self:GetParent():HasModifier("modifier_item_moon_aghanim_buff") then return end
    if self:GetParent():HasModifier("modifier_item_moon_aghanim") then return end
    local count = self:GetParent():GetIntellect(false) / self:GetAbility():GetSpecialValueFor("int_to_bonus")
    count = math.min(count, 25)
    return self:GetAbility():GetSpecialValueFor("int_damage_amplify") * count
end