--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_partisans_brand_custom", "items/item_partisans_brand_custom", LUA_MODIFIER_MOTION_NONE)

item_partisans_brand_custom = class({})

function item_partisans_brand_custom:GetIntrinsicModifierName()
    return "modifier_item_partisans_brand_custom"
end

modifier_item_partisans_brand_custom = class({})
function modifier_item_partisans_brand_custom:IsHidden() return true end
function modifier_item_partisans_brand_custom:IsPurgable() return false end
function modifier_item_partisans_brand_custom:IsPurgeException() return false end
function modifier_item_partisans_brand_custom:RemoveOnDeath() return false end
function modifier_item_partisans_brand_custom:OnCreated()
    self.bonus_damage_pct = self:GetAbility():GetSpecialValueFor("bonus_damage_pct")
end
function modifier_item_partisans_brand_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
    }
end
function modifier_item_partisans_brand_custom:GetModifierTotalDamageOutgoing_Percentage(params)
    if params.target and not params.target:IsHero() then
        return self.bonus_damage_pct
    end
end