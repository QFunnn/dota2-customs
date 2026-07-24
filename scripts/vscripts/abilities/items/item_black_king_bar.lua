--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_black_king_bar_custom", "abilities/items/item_black_king_bar", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_black_king_bar_custom_active", "abilities/items/item_black_king_bar", LUA_MODIFIER_MOTION_NONE)

item_black_king_bar_custom = class({})

function item_black_king_bar_custom:GetIntrinsicModifierName() 
return "modifier_item_black_king_bar_custom" 
end

function item_black_king_bar_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items_fx/black_king_bar_avatar.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_avatar.vpcf", context )
end

function item_black_king_bar_custom:GetCooldown(level)
return self.BaseClass.GetCooldown( self, level )/self:GetCaster():GetCooldownReduction()
end

function item_black_king_bar_custom:OnSpellStart()
local caster = self:GetCaster()

local duration = self:GetSpecialValueFor("duration")

if not IsSoloMode() then
    duration = self:GetSpecialValueFor("duration_duo")
end

caster:EmitSound("DOTA_Item.BlackKingBar.Activate")
caster:Purge(false, true, false, false, false)
caster:AddNewModifier(caster, self, "modifier_item_black_king_bar_custom_active", {duration = duration})
caster:AddNewModifier(caster, self, "modifier_generic_debuff_immune", {magic_damage = self:GetSpecialValueFor("magic_resist"), duration = duration})
self:EndCd(0)
self:StartCooldown(self:GetSpecialValueFor("AbilityCooldown"))
end

modifier_item_black_king_bar_custom = class({})

function modifier_item_black_king_bar_custom:IsHidden() return true end
function modifier_item_black_king_bar_custom:IsPurgable() return false end
function modifier_item_black_king_bar_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE  end

function modifier_item_black_king_bar_custom:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    }
end

function modifier_item_black_king_bar_custom:GetModifierBonusStats_Strength() 
    if self:GetAbility() then return self:GetAbility():GetSpecialValueFor("bonus_strength") end 
end

function modifier_item_black_king_bar_custom:GetModifierPreAttack_BonusDamage() 
    if self:GetAbility() then return self:GetAbility():GetSpecialValueFor("bonus_damage") end 
end

modifier_item_black_king_bar_custom_active = class({})

function modifier_item_black_king_bar_custom_active:IsPurgable() return false end

function modifier_item_black_king_bar_custom_active:OnCreated()
self.parent = self:GetParent()
if not IsServer() then return end

if not self:GetAbility() then 
    self:Destroy() 
end

self.RemoveForDuel = true
end

function modifier_item_black_king_bar_custom_active:OnRefresh()
    if not IsServer() then return end
    self:OnCreated()
end

function modifier_item_black_king_bar_custom_active:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_item_black_king_bar_custom_active:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end



function modifier_item_black_king_bar_custom_active:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MODEL_SCALE,
    }
end

function modifier_item_black_king_bar_custom_active:GetModifierModelScale()
if self.parent:HasModifier("modifier_primal_beast_innate_custom") then return end
if self:GetAbility() then 
    return self:GetAbility():GetSpecialValueFor("model_scale") 
end

end

function modifier_item_black_king_bar_custom_active:GetStatusEffectName()
    return "particles/status_fx/status_effect_avatar.vpcf"
end

function modifier_item_black_king_bar_custom_active:StatusEffectPriority()
    return MODIFIER_PRIORITY_ULTRA 
end

