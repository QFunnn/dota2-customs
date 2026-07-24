--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_phoenix_dying_light_custom", "heroes/npc_dota_hero_phoenix_custom/phoenix_dying_light_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phoenix_dying_light_custom_debuff", "heroes/npc_dota_hero_phoenix_custom/phoenix_dying_light_custom", LUA_MODIFIER_MOTION_NONE)

phoenix_dying_light_custom = class({})
phoenix_dying_light_custom.modifier_phoenix_1 = {1,2}

function phoenix_dying_light_custom:GetIntrinsicModifierName()
    return "modifier_phoenix_dying_light_custom"
end

modifier_phoenix_dying_light_custom=class({})
function modifier_phoenix_dying_light_custom:IsHidden() return true end
function modifier_phoenix_dying_light_custom:IsPurgable() return false end
function modifier_phoenix_dying_light_custom:IsPurgeException() return false end
function modifier_phoenix_dying_light_custom:RemoveOnDeath() return false end
function modifier_phoenix_dying_light_custom:IsAura()
    return (self:GetParent():GetHealth() < self:GetParent():GetMaxHealth()) or self:GetParent():HasModifier("modifier_phoenix_supernova_custom_buff")
end

function modifier_phoenix_dying_light_custom:GetModifierAura()
    return "modifier_phoenix_dying_light_custom_debuff"
end

function modifier_phoenix_dying_light_custom:GetAuraRadius()
    local radius = self:GetAbility():GetSpecialValueFor("radius")
    local bonus = {150,300}
    if self:GetCaster():HasModifier("modifier_phoenix_2") then
        radius = radius + bonus[self:GetCaster():GetTalentLevel("modifier_phoenix_2")]
    end
    return self:GetCaster():GetAoeBonus(radius)
end

function modifier_phoenix_dying_light_custom:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_phoenix_dying_light_custom:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_phoenix_dying_light_custom_debuff = class({})

function modifier_phoenix_dying_light_custom_debuff:OnCreated()
    if not IsServer() then return end
    self.damage_pct = self:GetAbility():GetSpecialValueFor("damage_pct")
    if self:GetCaster():HasModifier("modifier_phoenix_1") then
        self.damage_pct = self.damage_pct + self:GetAbility().modifier_phoenix_1[self:GetCaster():GetTalentLevel("modifier_phoenix_1")]
    end
    self:StartIntervalThink(1)
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_phoenix/phoenix_outburst_target.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControlEnt(particle, 1, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, "", self:GetCaster():GetAbsOrigin(), true )
    self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_phoenix_dying_light_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    local damage_perc = self.damage_pct
    local damage = self:GetCaster():GetMaxHealth() - self:GetCaster():GetHealth()
    if self:GetCaster():HasModifier("modifier_phoenix_supernova_custom_buff") then
        damage = self:GetCaster():GetMaxHealth()
    end
    damage = damage * damage_perc / 100
    local damageTable = { victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()}
    ApplyDamage(damageTable)
end