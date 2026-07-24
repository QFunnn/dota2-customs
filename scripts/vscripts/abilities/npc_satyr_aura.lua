--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_satyr_aura_self", "abilities/npc_satyr_aura.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_satyr_aura", "abilities/npc_satyr_aura.lua", LUA_MODIFIER_MOTION_NONE)


npc_satyr_aura = class({})


function npc_satyr_aura:GetIntrinsicModifierName() return "modifier_satyr_aura_self" end

function npc_satyr_aura:GetCastRange(vLocation, hTarget) return 900 end 

modifier_satyr_aura_self = class({})

function modifier_satyr_aura_self:IsHidden() return true end

function modifier_satyr_aura_self:IsPurgable() return false end

function modifier_satyr_aura_self:IsAura() return true end

function modifier_satyr_aura_self:GetAuraDuration() return 0.1 end

function modifier_satyr_aura_self:GetAuraRadius() return 900 end

function modifier_satyr_aura_self:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end

function modifier_satyr_aura_self:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end

function modifier_satyr_aura_self:GetModifierAura() return "modifier_satyr_aura" end

modifier_satyr_aura = class({})

function modifier_satyr_aura:GetTexture() return "satyr_hellcaller_unholy_aura" end

function modifier_satyr_aura:IsPurgable() return false end

function modifier_satyr_aura:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_TOOLTIP,
        MODIFIER_PROPERTY_TOOLTIP2
    }
end


function modifier_satyr_aura:OnTooltip()
return self:GetAbility():GetSpecialValueFor("armor")
end

function modifier_satyr_aura:OnTooltip2()
return self:GetAbility():GetSpecialValueFor("magic")
end

function modifier_satyr_aura:OnCreated(table)
    self.armor = self:GetAbility():GetSpecialValueFor("armor")
    self.magic = self:GetAbility():GetSpecialValueFor("magic")
end

function modifier_satyr_aura:GetModifierPhysicalArmorBonus() return self.armor end
function modifier_satyr_aura:GetModifierMagicalResistanceBonus() return self.magic end


