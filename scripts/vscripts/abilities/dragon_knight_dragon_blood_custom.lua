--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_dragon_knight_dragon_blood_custom", "abilities/dragon_knight_dragon_blood_custom", LUA_MODIFIER_MOTION_NONE)

dragon_knight_dragon_blood_custom = class({})

function dragon_knight_dragon_blood_custom:GetIntrinsicModifierName()
    return "modifier_dragon_knight_dragon_blood_custom"
end

modifier_dragon_knight_dragon_blood_custom = class({})

function modifier_dragon_knight_dragon_blood_custom:IsHidden() return true end
function modifier_dragon_knight_dragon_blood_custom:IsPurgable() return false end
function modifier_dragon_knight_dragon_blood_custom:IsPurgeException() return false end
function modifier_dragon_knight_dragon_blood_custom:RemoveOnDeath() return false end

function modifier_dragon_knight_dragon_blood_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
    }
end

function modifier_dragon_knight_dragon_blood_custom:GetModifierConstantHealthRegen()
    return self:GetAbility():GetSpecialValueFor("bonus_health_regen")
end

function modifier_dragon_knight_dragon_blood_custom:GetModifierPhysicalArmorBonus()
    return self:GetAbility():GetSpecialValueFor("bonus_armor")
end