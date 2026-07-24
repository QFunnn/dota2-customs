--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_invoker_persona_custom = class({})
function modifier_invoker_persona_custom:IsHidden() return true end
function modifier_invoker_persona_custom:IsPurgable() return false end
function modifier_invoker_persona_custom:IsPurgeException() return false end
function modifier_invoker_persona_custom:RemoveOnDeath() return false end

function modifier_invoker_persona_custom:OnCreated()
    self.parent = self:GetParent()
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end

function modifier_invoker_persona_custom:OnIntervalThink()
    if not IsServer() then return end
    local exort_count = self:GetParent():FindAllModifiersByName("modifier_invoker_exort_custom")
    local wex_count = self:GetParent():FindAllModifiersByName("modifier_invoker_wex_custom")
    local quas_count = self:GetParent():FindAllModifiersByName("modifier_invoker_quas_custom")
    if (#quas_count > #wex_count) and (#quas_count > #exort_count) then
        self.parent:SetRangedProjectileName("particles/units/heroes/hero_invoker_kid/invoker_kid_base_attack_quas.vpcf")
    elseif (#wex_count > #quas_count) and (#wex_count > #exort_count) then
        self.parent:SetRangedProjectileName("particles/units/heroes/hero_invoker_kid/invoker_kid_base_attack_wex.vpcf")
    elseif (#exort_count > #quas_count) and (#exort_count > #wex_count) then
        self.parent:SetRangedProjectileName("particles/units/heroes/hero_invoker_kid/invoker_kid_base_attack_exort.vpcf")
    else
        self.parent:SetRangedProjectileName("particles/units/heroes/hero_invoker_kid/invoker_kid_base_attack_all.vpcf")
    end
end

function modifier_invoker_persona_custom:OnDestroy()
    if not IsServer() then return end
    if self.parent.original_projectile_name and self.parent.original_projectile_name ~= "" then
        self.parent:SetRangedProjectileName(self.parent.original_projectile_name)
    end
end