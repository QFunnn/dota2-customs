--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_nyx_assassin_burrow_custom", "heroes/npc_dota_hero_nyx_assassin_custom/nyx_assassin_burrow_custom", LUA_MODIFIER_MOTION_NONE)

nyx_assassin_burrow_custom = class({})

function nyx_assassin_burrow_custom:OnAbilityPhaseStart()
    self:GetCaster():EmitSound("Hero_NyxAssassin.Burrow.In")
    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(self.particle, 0, self:GetCaster():GetAbsOrigin())
    return true
end

function nyx_assassin_burrow_custom:OnAbilityPhaseInterrupted()
    self:GetCaster():StopSound("Hero_NyxAssassin.Burrow.In")
    if self.particle then
        ParticleManager:DestroyParticle(self.particle, false)
        ParticleManager:ReleaseParticleIndex(self.particle)
    end
end

function nyx_assassin_burrow_custom:OnSpellStart()
    if not IsServer() then return end
    if self.particle then
        ParticleManager:DestroyParticle(self.particle, false)
        ParticleManager:ReleaseParticleIndex(self.particle)
    end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_nyx_assassin_burrow_custom", hModifierTable)
end

modifier_nyx_assassin_burrow_custom = class({})
function modifier_nyx_assassin_burrow_custom:IsPurgable() return false end
function modifier_nyx_assassin_burrow_custom:IsPurgeException() return false end

function modifier_nyx_assassin_burrow_custom:OnCreated()
    if not IsServer() then return end
    self:GetCaster():SwapAbilities("nyx_assassin_burrow_custom", "nyx_assassin_unburrow_custom", false, true)
end

function modifier_nyx_assassin_burrow_custom:OnDestroy()
    if not IsServer() then return end
    self:GetCaster():SwapAbilities("nyx_assassin_unburrow_custom", "nyx_assassin_burrow_custom", false, true)
    self:GetParent():EmitSound("Hero_NyxAssassin.Burrow.Out")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow_exit.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())

    local particle_ground = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow_inground.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(particle_ground, 0, self:GetCaster():GetAbsOrigin())

    if particle_ground then
        ParticleManager:DestroyParticle(particle_ground, false)
        ParticleManager:ReleaseParticleIndex(particle_ground)
    end

    self:GetCaster():StartGesture(ACT_DOTA_CAST_BURROW_END)

    if particle then
        ParticleManager:ReleaseParticleIndex(particle)
    end
end

function modifier_nyx_assassin_burrow_custom:CheckState()
    return
    {
        [MODIFIER_STATE_DISARMED] = true,
    }
end

function modifier_nyx_assassin_burrow_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
        MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,
        MODIFIER_PROPERTY_MODEL_CHANGE,
        MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
        MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE
    }
end

function modifier_nyx_assassin_burrow_custom:GetModifierPercentageCooldown()
    return self:GetAbility():GetSpecialValueFor("cooldown_reduction")
end

function modifier_nyx_assassin_burrow_custom:GetModifierCastRangeBonusStacking()
    return self:GetAbility():GetSpecialValueFor("bonus_cast_range")
end

function modifier_nyx_assassin_burrow_custom:GetModifierMoveSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("movespeed")
end

function modifier_nyx_assassin_burrow_custom:GetModifierIncomingDamage_Percentage()
    return self:GetAbility():GetSpecialValueFor("incoming_damage")
end

function modifier_nyx_assassin_burrow_custom:GetModifierHealthRegenPercentage()
    return self:GetAbility():GetSpecialValueFor("health_regen")
end

function modifier_nyx_assassin_burrow_custom:GetModifierTotalPercentageManaRegen()
    return self:GetAbility():GetSpecialValueFor("mana_regen")
end

function modifier_nyx_assassin_burrow_custom:GetModifierModelChange()
    return "models/heroes/nerubian_assassin/mound.vmdl"
end

nyx_assassin_unburrow_custom = class({})

function nyx_assassin_unburrow_custom:OnSpellStart()
    if not IsServer() then return end
    local modifier_nyx_assassin_burrow_custom = self:GetCaster():FindModifierByName("modifier_nyx_assassin_burrow_custom")
    if modifier_nyx_assassin_burrow_custom then
        modifier_nyx_assassin_burrow_custom:Destroy()
    end
end






