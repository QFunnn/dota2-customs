--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_witch_doctor_gris_gris_custom", "heroes/npc_dota_hero_witch_doctor_custom/witch_doctor_gris_gris_custom", LUA_MODIFIER_MOTION_NONE)

witch_doctor_gris_gris_custom = class({})

function witch_doctor_gris_gris_custom:GetIntrinsicModifierName()
    return "modifier_witch_doctor_gris_gris_custom"
end

modifier_witch_doctor_gris_gris_custom = class({})
function modifier_witch_doctor_gris_gris_custom:IsHidden() return true end
function modifier_witch_doctor_gris_gris_custom:IsPurgable() return false end
function modifier_witch_doctor_gris_gris_custom:IsPurgeException() return false end
function modifier_witch_doctor_gris_gris_custom:RemoveOnDeath() return false end
function modifier_witch_doctor_gris_gris_custom:OnCreated()
    if not IsServer() then return end
    if self:GetParent():IsIllusion() then return end
    if self:GetAbility().inited then return end
    self:GetAbility().inited = true
    local item_grisgris = self:GetParent():AddItemByName("item_grisgris")
    if item_grisgris then
        --self:GetParent():AddNewModifier(self:GetParent(), item_grisgris, "modifier_item_grisgris", {})
    end
end

-- modifier_item_grisgris_counter