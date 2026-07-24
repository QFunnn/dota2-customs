--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_illusion_custom = class({})
function modifier_illusion_custom:IsPurgable() return false end
function modifier_illusion_custom:IsPurgeException() return false end
function modifier_illusion_custom:IsHidden() return true end
function modifier_illusion_custom:RemoveOnDeath() return false end
function modifier_illusion_custom:GetStatusEffectName()
    if self:GetParent():HasModifier("modifier_status_effect_thinker_custom") then return end
    if self:GetParent():GetTeamNumber() ~= GetLocalPlayerTeam(GetLocalPlayerID()) then
        return
    end
    return "particles/status_fx/status_effect_illusion.vpcf"
end
function modifier_illusion_custom:StatusEffectPriority()
    return MODIFIER_PRIORITY_SUPER_ULTRA
end