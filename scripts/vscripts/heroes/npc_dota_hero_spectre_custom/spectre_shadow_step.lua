--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_spectre_haunt_custom", "heroes/npc_dota_hero_spectre_custom/spectre_haunt_custom", LUA_MODIFIER_MOTION_NONE )

spectre_shadow_step = class({})

function spectre_shadow_step:OnSpellStart()
    if not IsServer() then return end
    local origin = self:GetCaster():GetAbsOrigin()
    local incoming_damage = self:GetSpecialValueFor("incoming_damage") - 100
    local outgoing_damage = self:GetSpecialValueFor("illusion_damage") - 100
    local duration = self:GetSpecialValueFor("duration")
    local range = self:GetSpecialValueFor("range")

    local particle = ParticleManager:CreateParticle("particles/spectre_step.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, origin)
    local new_point = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * range
    if not self:GetCaster():IsRooted() then
        FindClearSpaceForUnit(self:GetCaster(), new_point, true)
    end
    local particle2 = ParticleManager:CreateParticle("particles/spectre_step.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle2, 0, self:GetCaster():GetAbsOrigin())
    local illusions = CreateIllusions( self:GetCaster(), self:GetCaster(), { outgoing_damage = outgoing_damage, incoming_damage = incoming_damage, duration = duration }, 1, 150, false, true )
    FindClearSpaceForUnit(illusions[1], origin, true)
    EmitSoundOnLocationWithCaster(new_point, "Hero_Spectre.Reality", self:GetCaster())
end