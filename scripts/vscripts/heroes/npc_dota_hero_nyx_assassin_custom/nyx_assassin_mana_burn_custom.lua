--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_nyx_assassin_mana_burn_custom", "heroes/npc_dota_hero_nyx_assassin_custom/nyx_assassin_mana_burn_custom", LUA_MODIFIER_MOTION_NONE)

nyx_assassin_mana_burn_custom = class({})
nyx_assassin_mana_burn_custom.modifier_nyx_assassin_19 = {2,4}

function nyx_assassin_mana_burn_custom:GetIntrinsicModifierName()
    return "modifier_nyx_assassin_mana_burn_custom"
end

modifier_nyx_assassin_mana_burn_custom = class({})
function modifier_nyx_assassin_mana_burn_custom:IsHidden() return true end
function modifier_nyx_assassin_mana_burn_custom:IsPurgable() return false end
function modifier_nyx_assassin_mana_burn_custom:IsPurgeException() return false end
function modifier_nyx_assassin_mana_burn_custom:RemoveOnDeath() return false end
function modifier_nyx_assassin_mana_burn_custom:OnTakeDamage(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.unit:GetTeamNumber() == self:GetParent():GetTeamNumber() then return end
    if params.unit:IsOther() then return end
    local mana_burn_pct = self:GetAbility():GetSpecialValueFor("mana_burn_pct")
    if self:GetCaster():HasModifier("modifier_nyx_assassin_19") then
        mana_burn_pct = mana_burn_pct + self:GetAbility().modifier_nyx_assassin_19[self:GetCaster():GetTalentLevel("modifier_nyx_assassin_19")]
    end
    local mana = params.damage / 100 * mana_burn_pct
    local manaburn_pfx = ParticleManager:CreateParticle("particles/generic_gameplay/generic_manaburn.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.unit)
    ParticleManager:SetParticleControl(manaburn_pfx, 0, params.unit:GetAbsOrigin() )
    ParticleManager:ReleaseParticleIndex(manaburn_pfx)
    params.unit:Script_ReduceMana(mana, self:GetAbility())
end