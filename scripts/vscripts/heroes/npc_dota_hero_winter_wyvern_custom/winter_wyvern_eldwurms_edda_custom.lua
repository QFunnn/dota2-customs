--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_winter_wyvern_eldwurms_edda_custom", "heroes/npc_dota_hero_winter_wyvern_custom/winter_wyvern_eldwurms_edda_custom", LUA_MODIFIER_MOTION_NONE)

winter_wyvern_eldwurms_edda_custom = class({})

function winter_wyvern_eldwurms_edda_custom:GetIntrinsicModifierName()
    return "modifier_winter_wyvern_eldwurms_edda_custom"
end

modifier_winter_wyvern_eldwurms_edda_custom = class({})
function modifier_winter_wyvern_eldwurms_edda_custom:IsPurgable() return false end
function modifier_winter_wyvern_eldwurms_edda_custom:IsPurgeException() return false end
function modifier_winter_wyvern_eldwurms_edda_custom:IsHidden() return true end
function modifier_winter_wyvern_eldwurms_edda_custom:RemoveOnDeath() return false end
function modifier_winter_wyvern_eldwurms_edda_custom:OnCreated()
    if not IsServer() then return end
    if self:GetParent():IsIllusion() then return end
    if self:GetAbility().inited then return end
    self:GetAbility().inited = true
    local item_eldwurms_edda = self:GetParent():AddItemByName("item_eldwurms_edda")
    if item_eldwurms_edda then
        item_eldwurms_edda:EndCooldown()
        item_eldwurms_edda:StartCooldown(self:GetAbility():GetSpecialValueFor("tooltip_seconds"))
    end
end