--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_woodland_striders_custom", "items/item_woodland_striders_custom", LUA_MODIFIER_MOTION_NONE)

item_woodland_striders_custom = class({})

function item_woodland_striders_custom:GetIntrinsicModifierName()
    return "modifier_item_woodland_striders_custom"
end

function item_woodland_striders_custom:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_woodland_striders_active", {duration = self:GetSpecialValueFor("active_duration")})
end

modifier_item_woodland_striders_custom = class({})
function modifier_item_woodland_striders_custom:IsPurgable() return false end
function modifier_item_woodland_striders_custom:IsPurgeException() return false end
function modifier_item_woodland_striders_custom:IsHidden() return true end
function modifier_item_woodland_striders_custom:RemoveOnDeath() return false end
function modifier_item_woodland_striders_custom:CheckState()
    return
    {
        [MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = true
    }
end