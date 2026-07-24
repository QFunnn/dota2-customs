--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_oracle_prognosticate_custom", "heroes/npc_dota_hero_oracle_custom/oracle_prognosticate_custom", LUA_MODIFIER_MOTION_NONE)

oracle_prognosticate_custom = class({})

function oracle_prognosticate_custom:GetIntrinsicModifierName()
    return "modifier_oracle_prognosticate_custom"
end

modifier_oracle_prognosticate_custom = class({})
function modifier_oracle_prognosticate_custom:IsHidden() return true end
function modifier_oracle_prognosticate_custom:IsPurgable() return false end
function modifier_oracle_prognosticate_custom:IsPurgeException() return false end
function modifier_oracle_prognosticate_custom:RemoveOnDeath() return false end
function modifier_oracle_prognosticate_custom:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.25)
end
function modifier_oracle_prognosticate_custom:OnIntervalThink()
    if not IsServer() then return end
    local all_runes = Entities:FindAllByClassname("dota_item_rune")
    for _, rune in pairs(all_runes) do
        if rune and not rune:IsNull() then
            AddFOWViewer(self:GetParent():GetTeamNumber(), rune:GetAbsOrigin(), 10, 0.3, true)
        end
    end
end