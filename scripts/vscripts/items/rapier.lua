--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_rapier_custom", "items/rapier", LUA_MODIFIER_MOTION_NONE)

item_rapier_custom = class({})

function item_rapier_custom:GetAbilityTextureName()
    if self:GetToggleState() then
        return "item_rapier_alt"
    end
    return "item_rapier"
end

function item_rapier_custom:GetIntrinsicModifierName() return "modifier_item_rapier_custom" end
function item_rapier_custom:ResetToggleOnRespawn() return false end

function item_rapier_custom:OnToggle()
    if not IsServer() then return end
    self:UseResources(false, false, false, true)
end

modifier_item_rapier_custom = class({})

function modifier_item_rapier_custom:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_rapier_custom:IsPurgable() return false end
function modifier_item_rapier_custom:IsHidden() return true end

function modifier_item_rapier_custom:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
    }
end

function modifier_item_rapier_custom:GetModifierPreAttack_BonusDamage()
    if self:GetAbility():GetToggleState() then
        return self:GetAbility():GetSpecialValueFor("bonus_damage")
    end
    return self:GetAbility():GetSpecialValueFor("bonus_damage_active")
end

function modifier_item_rapier_custom:GetModifierSpellAmplify_Percentage()
	if self:GetAbility():GetToggleState() then
        return self:GetAbility():GetSpecialValueFor("bonus_spell")
    end
end