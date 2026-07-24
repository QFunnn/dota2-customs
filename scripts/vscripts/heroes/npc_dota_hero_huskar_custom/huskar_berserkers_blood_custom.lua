--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_huskar_berserkers_blood_custom", "heroes/npc_dota_hero_huskar_custom/huskar_berserkers_blood_custom", LUA_MODIFIER_MOTION_NONE)

huskar_berserkers_blood_custom = class({})

huskar_berserkers_blood_custom.modifier_huskar_2 = 15
huskar_berserkers_blood_custom.modifier_huskar_2_cooldown = 30

function huskar_berserkers_blood_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_huskar_2") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    end
    return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function huskar_berserkers_blood_custom:GetCooldown(iLevel)
    if self:GetCaster():HasModifier("modifier_huskar_2") then
        return self.modifier_huskar_2_cooldown
    end
end

function huskar_berserkers_blood_custom:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():EmitSound("DOTA_Item.Satanic.Activate")
    local health = self:GetCaster():GetMaxHealth() / 100 * self.modifier_huskar_2
    self:GetCaster():SetHealth(health)
    local particle = ParticleManager:CreateParticle("particles/items2_fx/soul_ring.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControl(particle, 1, Vector(1, 0, 0))
    ParticleManager:ReleaseParticleIndex(particle)
    self:GetCaster():Purge(false, true, false, false, false)
end

function huskar_berserkers_blood_custom:GetIntrinsicModifierName()
    return "modifier_huskar_berserkers_blood_custom"
end

function huskar_berserkers_blood_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_berserkers_blood.vpcf", context )
end

modifier_huskar_berserkers_blood_custom = class({})
function modifier_huskar_berserkers_blood_custom:IsPurgable() return false end
function modifier_huskar_berserkers_blood_custom:IsPurgeException() return false end
function modifier_huskar_berserkers_blood_custom:RemoveOnDeath() return false end

function modifier_huskar_berserkers_blood_custom:OnCreated()
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

function modifier_huskar_berserkers_blood_custom:OnRefresh()
    self.maximum_attack_speed = self:GetAbility():GetSpecialValueFor("maximum_attack_speed")
    self.maximum_health_regen = self:GetAbility():GetSpecialValueFor("maximum_health_regen")
    self.maximum_magic_resist = self:GetAbility():GetSpecialValueFor("maximum_magic_resist")
    self.hp_threshold_max = self:GetAbility():GetSpecialValueFor("hp_threshold_max")
end

function modifier_huskar_berserkers_blood_custom:OnIntervalThink()
    local health_percentage = self:GetParent():GetHealthPercent()
    if health_percentage <= self.hp_threshold_max then
        self.percent = 1
    else
        self.percent = math.max(0, 1 - (health_percentage - self.hp_threshold_max) / (100 - self.hp_threshold_max))
    end
end

function modifier_huskar_berserkers_blood_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_MODEL_SCALE,
    }
end

function modifier_huskar_berserkers_blood_custom:GetModifierAttackSpeedBonus_Constant()
    if self:GetParent():PassivesDisabled() then return end
    return self.maximum_attack_speed * self.percent
end

function modifier_huskar_berserkers_blood_custom:GetModifierConstantHealthRegen()
    if self:GetParent():PassivesDisabled() then return end
    return self:GetCaster():GetStrength() / 100 * (self.maximum_health_regen * self.percent)
end

function modifier_huskar_berserkers_blood_custom:GetModifierMagicalResistanceBonus()
    if self:GetParent():PassivesDisabled() then return end
    return self.maximum_magic_resist * self.percent
end

function modifier_huskar_berserkers_blood_custom:GetModifierModelScale()
    if not IsServer() then return end
    if self.particle then
        ParticleManager:SetParticleControl(self.particle, 1, Vector(self.percent * 100, 0, 0))
    end
    self:GetParent():SetRenderColor(255, 255 * (1-self.percent), 255 * (1-self.percent))
    return self.max_size * self.percent
end
