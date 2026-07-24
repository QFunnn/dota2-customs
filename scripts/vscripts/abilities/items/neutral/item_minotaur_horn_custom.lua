--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_minotaur_horn_custom_active", "abilities/items/neutral/item_minotaur_horn_custom", LUA_MODIFIER_MOTION_NONE)

item_minotaur_horn_custom = class({})

function item_minotaur_horn_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items5_fx/minotaur_horn.vpcf", context )
end

function item_minotaur_horn_custom:OnSpellStart()
local caster = self:GetCaster()

caster:EmitSound("DOTA_Item.MinotaurHorn.Cast")
caster:Purge(false, true, false, false, false)
local duration = self:GetSpecialValueFor("duration")
local heal = (caster:GetMaxHealth() - caster:GetHealth())*self:GetSpecialValueFor("heal")/100
caster:GenericHeal(heal, self)

caster:AddNewModifier(caster, self, "modifier_item_minotaur_horn_custom_active", {duration = duration})
caster:AddNewModifier(caster, self, "modifier_generic_debuff_immune", {magic_damage = self:GetSpecialValueFor("magic_resist"), duration = duration})
end


modifier_item_minotaur_horn_custom_active = class({})
function modifier_item_minotaur_horn_custom_active:IsPurgable() return false end
function modifier_item_minotaur_horn_custom_active:IsHidden() return false end

function modifier_item_minotaur_horn_custom_active:GetEffectName()
return "particles/items5_fx/minotaur_horn.vpcf"
end

function modifier_item_minotaur_horn_custom_active:OnCreated(table)
self.model_scale = self:GetAbility():GetSpecialValueFor("model_scale")
end

function modifier_item_minotaur_horn_custom_active:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_MODEL_SCALE,
}
end

function modifier_item_minotaur_horn_custom_active:GetModifierModelScale()
return self.model_scale
end

function modifier_item_minotaur_horn_custom_active:GetStatusEffectName()
return "particles/status_fx/status_effect_avatar.vpcf"
end

function modifier_item_minotaur_horn_custom_active:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA
end

