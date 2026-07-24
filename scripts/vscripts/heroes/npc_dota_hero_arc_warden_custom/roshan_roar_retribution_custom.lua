--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_roshan_roar_retribution_custom", "heroes/npc_dota_hero_arc_warden_custom/roshan_roar_retribution_custom", LUA_MODIFIER_MOTION_NONE)

roshan_roar_retribution_custom = class({})

function roshan_roar_retribution_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/roshan_roar_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/roshan_roar_mouths.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_beastmaster/beastmaster_primal_roar.vpcf", context )
end

function roshan_roar_retribution_custom:OnSpellStart()
    if not IsServer() then return end
    local radius = self:GetSpecialValueFor("radius")
    local duration = self:GetSpecialValueFor("duration")
    AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), radius, duration, false)
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
    for _, unit in pairs(units) do
        unit:AddNewModifier(self:GetCaster(), self, "modifier_roshan_roar_retribution_custom", {duration = duration+FrameTime()})
    end
    EmitGlobalSound("Roshan.RevengeRoar")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_beastmaster/beastmaster_primal_roar.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, self:GetCaster():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)

    local particle_roar = ParticleManager:CreateParticle("particles/roshan_roar_mouths.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControlEnt(particle_roar, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(particle_roar, 1, self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * 300)
    ParticleManager:ReleaseParticleIndex(particle_roar)
end

modifier_roshan_roar_retribution_custom = class({})

function modifier_roshan_roar_retribution_custom:IsPurgable() return false end

function modifier_roshan_roar_retribution_custom:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(1)
end

function modifier_roshan_roar_retribution_custom:OnIntervalThink()
    if not IsServer() then return end
    local damage_strength = self:GetAbility():GetSpecialValueFor("damage_strength")
    local damage = self:GetCaster():GetStrength() / 100 * damage_strength
    ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
end

function modifier_roshan_roar_retribution_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
    }
end

function modifier_roshan_roar_retribution_custom:GetModifierIncomingDamage_Percentage()
    return self:GetAbility():GetSpecialValueFor("incoming_damage")
end

function modifier_roshan_roar_retribution_custom:GetEffectName()
    return "particles/roshan_roar_debuff.vpcf"
end

function modifier_roshan_roar_retribution_custom:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end