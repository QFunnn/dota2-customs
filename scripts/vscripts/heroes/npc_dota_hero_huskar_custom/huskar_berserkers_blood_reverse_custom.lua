--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_huskar_berserkers_blood_reverse_custom", "heroes/npc_dota_hero_huskar_custom/huskar_berserkers_blood_reverse_custom", LUA_MODIFIER_MOTION_NONE)

huskar_berserkers_blood_reverse_custom = class({})

huskar_berserkers_blood_reverse_custom.modifier_huskar_9 = {20,40,60}

function huskar_berserkers_blood_reverse_custom:GetIntrinsicModifierName()
    return "modifier_huskar_berserkers_blood_reverse_custom"
end

function huskar_berserkers_blood_reverse_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_berserkers_blood.vpcf", context )
end

modifier_huskar_berserkers_blood_reverse_custom = class({})
function modifier_huskar_berserkers_blood_reverse_custom:IsPurgable() return false end
function modifier_huskar_berserkers_blood_reverse_custom:IsPurgeException() return false end
function modifier_huskar_berserkers_blood_reverse_custom:RemoveOnDeath() return false end

function modifier_huskar_berserkers_blood_reverse_custom:OnCreated()
    self.maximum_attack_speed = self:GetAbility():GetSpecialValueFor("maximum_attack_speed")
    self.maximum_health_regen = self:GetAbility():GetSpecialValueFor("maximum_health_regen")
    self.maximum_magic_resist = self:GetAbility():GetSpecialValueFor("maximum_magic_resist")
    self.max_size = 35
    self.percent = 0
    self.hp_threshold_max = self:GetAbility():GetSpecialValueFor("hp_threshold_max")
    self.range = 100 - self.hp_threshold_max
    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_huskar/huskar_berserkers_blood.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    self:AddParticle(self.particle, false, false, -1, false, false)
    self:StartIntervalThink(0.1)
end

function modifier_huskar_berserkers_blood_reverse_custom:OnRefresh()
    self.maximum_attack_speed = self:GetAbility():GetSpecialValueFor("maximum_attack_speed")
    self.maximum_health_regen = self:GetAbility():GetSpecialValueFor("maximum_health_regen")
    self.maximum_magic_resist = self:GetAbility():GetSpecialValueFor("maximum_magic_resist")
    self.hp_threshold_max = self:GetAbility():GetSpecialValueFor("hp_threshold_max")
end

function modifier_huskar_berserkers_blood_reverse_custom:OnIntervalThink()
    local health_percentage = self:GetParent():GetHealthPercent()
    if health_percentage >= self.hp_threshold_max then
        self.percent = 1
    else
        self.percent = math.max(0, math.min(1, health_percentage / self.hp_threshold_max))
    end
end

function modifier_huskar_berserkers_blood_reverse_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_MODEL_SCALE,
    }
end

function modifier_huskar_berserkers_blood_reverse_custom:GetModifierAttackSpeedBonus_Constant()
    if self:GetParent():PassivesDisabled() then return end
    local maximum_attackspeed = self.maximum_attack_speed
    if self:GetCaster():HasModifier("modifier_huskar_9") then
        maximum_attackspeed = maximum_attackspeed + self:GetAbility().modifier_huskar_9[self:GetCaster():GetTalentLevel("modifier_huskar_9")]
    end
    return maximum_attackspeed * self.percent
end

function modifier_huskar_berserkers_blood_reverse_custom:GetModifierConstantHealthRegen()
    if self:GetParent():PassivesDisabled() then return end
    return self:GetCaster():GetAgility() / 100 * (self.maximum_health_regen * self.percent)
end

function modifier_huskar_berserkers_blood_reverse_custom:GetModifierMagicalResistanceBonus()
    if self:GetParent():PassivesDisabled() then return end
    return self.maximum_magic_resist * self.percent
end

function modifier_huskar_berserkers_blood_reverse_custom:GetModifierModelScale()
    if not IsServer() then return end
    if self.particle then
        ParticleManager:SetParticleControl(self.particle, 1, Vector(self.percent * 100, 0, 0))
    end
    self:GetParent():SetRenderColor(255, 255 * (1-self.percent), 255 * (1-self.percent))
    return self.max_size * self.percent
end
