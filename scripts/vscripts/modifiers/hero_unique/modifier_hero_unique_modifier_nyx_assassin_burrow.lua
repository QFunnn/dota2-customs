--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_nyx_assassin_burrow = class({})
function modifier_hero_unique_modifier_nyx_assassin_burrow:IsPurgable() return false end
function modifier_hero_unique_modifier_nyx_assassin_burrow:IsHidden() return true end
function modifier_hero_unique_modifier_nyx_assassin_burrow:IsPurgeException() return false end
function modifier_hero_unique_modifier_nyx_assassin_burrow:RemoveOnDeath() return false end
function modifier_hero_unique_modifier_nyx_assassin_burrow:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end
function modifier_hero_unique_modifier_nyx_assassin_burrow:OnIntervalThink()
    if not IsServer() then return end
    if self:GetParent():PassivesDisabled() and self:GetParent():HasModifier("modifier_nyx_assassin_burrow") then
        local modifier_nyx_assassin_burrow = self:GetParent():FindModifierByName("modifier_nyx_assassin_burrow")
        if modifier_nyx_assassin_burrow then
            local nyx_assassin_unburrow = self:GetParent():FindAbilityByName("nyx_assassin_unburrow")
            if nyx_assassin_unburrow then
                nyx_assassin_unburrow:OnSpellStart()
            end
            if modifier_nyx_assassin_burrow and not modifier_nyx_assassin_burrow:IsNull() then
                modifier_nyx_assassin_burrow:Destroy()
            end
        end
    end
end