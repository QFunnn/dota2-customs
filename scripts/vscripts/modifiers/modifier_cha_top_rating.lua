--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_cha_top_rating = class({})
function modifier_cha_top_rating:IsHidden() return true end
function modifier_cha_top_rating:IsPurgable() return false end
function modifier_cha_top_rating:RemoveOnDeath() return false end
function modifier_cha_top_rating:AllowIllusionDuplicate() return true end
function modifier_cha_top_rating:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/leader/leader/leader_overhead.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
    self:AddParticle(particle, false, false, -1, false, true)

    local particle_wings = ParticleManager:CreateParticle("particles/items_fx/avianas_feather.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(particle_wings, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    self:AddParticle(particle_wings, false, false, -1, false, true)
end