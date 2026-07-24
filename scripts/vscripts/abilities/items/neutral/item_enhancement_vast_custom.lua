--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_enhancement_vast_custom", "abilities/items/neutral/item_enhancement_vast_custom", LUA_MODIFIER_MOTION_NONE)

item_enhancement_vast_custom = class({})

function item_enhancement_vast_custom:GetIntrinsicModifierName()
return "modifier_item_enhancement_vast_custom"
end


modifier_item_enhancement_vast_custom = class({})
function modifier_item_enhancement_vast_custom:IsHidden() return true end
function modifier_item_enhancement_vast_custom:IsPurgable() return false end
function modifier_item_enhancement_vast_custom:RemoveOnDeath() return false end
function modifier_item_enhancement_vast_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.ranged_range = self.ability:GetSpecialValueFor("attack_range")
self.melle_range = self.ability:GetSpecialValueFor("attack_range_melle")
self.cast_range = self.ability:GetSpecialValueFor("cast_range")
end

function modifier_item_enhancement_vast_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
    MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
}
end

function modifier_item_enhancement_vast_custom:GetModifierAttackRangeBonus() 
if self.parent:IsRangedAttacker() then
    return self.ranged_range
else
    return self.melle_range
end

end

function modifier_item_enhancement_vast_custom:GetModifierCastRangeBonusStacking()
return self.cast_range
end