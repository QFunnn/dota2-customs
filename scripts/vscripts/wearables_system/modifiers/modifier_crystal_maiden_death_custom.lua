--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_crystal_maiden_death_custom = class({})
function modifier_crystal_maiden_death_custom:IsHidden() return true end
function modifier_crystal_maiden_death_custom:IsPurgable() return false end
function modifier_crystal_maiden_death_custom:IsPurgeException() return false end
function modifier_crystal_maiden_death_custom:RemoveOnDeath() return false end

function modifier_crystal_maiden_death_custom:OnCreated(table)
    self:GetParent():AddDeathEvent(self)
end

function modifier_crystal_maiden_death_custom:DeathEvent(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if not self:GetParent():IsRealHero() then return end
    local particle_name = "particles/cm_death_custom/maiden_death.vpcf"
    if self:GetParent():GetModelName() == "models/heroes/crystal_maiden_persona/crystal_maiden_persona.vmdl" then
        particle_name = "particles/cm_death_custom/cm_persona_death.vpcf"
    end
    if self:GetParent():GetModelName() == "models/heroes/crystal_maiden/crystal_maiden_arcana.vmdl" then
        particle_name = "particles/cm_death_custom/maiden_death_arcana.vpcf"
    end
    local particle = ParticleManager:CreateParticle(particle_name, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControlForward(particle, 1, self:GetParent():GetForwardVector())
    ParticleManager:ReleaseParticleIndex(particle)
end