--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lina_flame_cloak_custom", "heroes/npc_dota_hero_lina_custom/lina_flame_cloak_custom", LUA_MODIFIER_MOTION_NONE)

lina_flame_cloak_custom = class({})

lina_flame_cloak_custom.modifier_lina_13 = {10,20}

function lina_flame_cloak_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_lina/lina_flame_cloak.vpcf", context)
    PrecacheResource("particle", "particles/status_fx/status_effect_lina_flame_cloak.vpcf", context)
    PrecacheResource("particle", "particles/marci_heal.vpcf", context)
end

function lina_flame_cloak_custom:OnSpellStart()
    if not IsServer() then return end
    local flame_cloak_duration = self:GetSpecialValueFor("flame_cloak_duration")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_lina_flame_cloak_custom", {duration = flame_cloak_duration})
    if self:GetCaster():HasModifier("modifier_lina_13") then
        local health_restore = self:GetCaster():GetMaxHealth() / 100 * self.modifier_lina_13[self:GetCaster():GetTalentLevel("modifier_lina_13")]
        self:GetCaster():Purge(false, true, false, false, false)
        self:GetCaster():HealWithParams(health_restore, self, false, true, self:GetCaster(), false)
        local particle = ParticleManager:CreateParticle("particles/marci_heal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
        ParticleManager:SetParticleControlEnt(particle, 1, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, "", self:GetCaster():GetAbsOrigin(), true)
        ParticleManager:ReleaseParticleIndex(particle)
    end
    local modifier_lina_fiery_soul_custom = self:GetCaster():FindModifierByName("modifier_lina_fiery_soul_custom")
    if modifier_lina_fiery_soul_custom then
        modifier_lina_fiery_soul_custom:SetMaxStacks(true)
    end
    self:GetCaster():EmitSound("Hero_Lina.FlameCloak.Cast")
end

modifier_lina_flame_cloak_custom = class({})
function modifier_lina_flame_cloak_custom:IsPurgable() return false end
function modifier_lina_flame_cloak_custom:IsPurgeException() return false end

function modifier_lina_flame_cloak_custom:OnCreated()
    self.magic_resistance = self:GetAbility():GetSpecialValueFor("magic_resistance")
    self.spell_amp = self:GetAbility():GetSpecialValueFor("spell_amp")
    self.visualzdelta = self:GetAbility():GetSpecialValueFor("visualzdelta")
    self.zchangespeed = self:GetAbility():GetSpecialValueFor("zchangespeed")
end

function modifier_lina_flame_cloak_custom:GetEffectName()
    return "particles/units/heroes/hero_lina/lina_flame_cloak.vpcf"
end

function modifier_lina_flame_cloak_custom:GetStatusEffectName()
    return "particles/status_fx/status_effect_lina_flame_cloak.vpcf"
end

function modifier_lina_flame_cloak_custom:StatusEffectPriority()
    return 2
end

function modifier_lina_flame_cloak_custom:CheckState()
    return
    {
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
    }
end

function modifier_lina_flame_cloak_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_VISUAL_Z_DELTA,
        MODIFIER_PROPERTY_VISUAL_Z_SPEED_BASE_OVERRIDE,
    }
end

function modifier_lina_flame_cloak_custom:GetModifierMagicalResistanceBonus()
    return self.magic_resistance
end

function modifier_lina_flame_cloak_custom:GetModifierSpellAmplify_Percentage()
    return self.spell_amp
end

function modifier_lina_flame_cloak_custom:GetVisualZDelta()
    return self.visualzdelta
end

function modifier_lina_flame_cloak_custom:GetVisualZSpeedBaseOverride()
    return self.zchangespeed
end