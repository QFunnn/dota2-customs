--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_winter_wyvern_frozen_cemetery", "heroes/npc_dota_hero_winter_wyvern_custom/winter_wyvern_frozen_cemetery", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_winter_wyvern_frozen_cemetery_debuff", "heroes/npc_dota_hero_winter_wyvern_custom/winter_wyvern_frozen_cemetery", LUA_MODIFIER_MOTION_NONE)

winter_wyvern_frozen_cemetery = class({})

function winter_wyvern_frozen_cemetery:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function winter_wyvern_frozen_cemetery:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/wyvern_spell.vpcf", context)
    PrecacheResource("particle", "particles/legion_magical_ring.vpcf", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_ancient_apparition.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_crystal_maiden.vsndevts", context)
end

function winter_wyvern_frozen_cemetery:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local duration = self:GetSpecialValueFor("duration")
    EmitSoundOnLocationWithCaster(point, "hero_Crystal.frostbite", self:GetCaster())
    EmitSoundOnLocationWithCaster(point, "hero_Crystal.frostbite", self:GetCaster())
    CreateModifierThinker(self:GetCaster(), self, "modifier_winter_wyvern_frozen_cemetery", {duration = duration}, point, self:GetCaster():GetTeamNumber(), false)
end

modifier_winter_wyvern_frozen_cemetery = class({})

function modifier_winter_wyvern_frozen_cemetery:OnCreated()
    if not IsServer() then return end
    local radius = self:GetAbility():GetSpecialValueFor("radius")
    local ground_fx = ParticleManager:CreateParticle("particles/wyvern_spell.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(ground_fx, 1, Vector(radius,radius,radius))
    ParticleManager:SetParticleControl(ground_fx, 2, Vector(radius,radius,radius))
    self:AddParticle(ground_fx, false, false, -1, false, false)

    local particle = ParticleManager:CreateParticle("particles/legion_magical_ring.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, Vector(radius, radius, radius))
    self:AddParticle(particle, false, false, -1, false, false)

    self:GetParent():EmitSound("Hero_Ancient_Apparition.IceVortex.lp")
end

function modifier_winter_wyvern_frozen_cemetery:OnDestroy()
    if not IsServer() then return end
    self:GetParent():StopSound("Hero_Ancient_Apparition.IceVortex.lp")
end

function modifier_winter_wyvern_frozen_cemetery:IsAura()
    return true
end

function modifier_winter_wyvern_frozen_cemetery:GetModifierAura()
    return "modifier_winter_wyvern_frozen_cemetery_debuff"
end

function modifier_winter_wyvern_frozen_cemetery:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_winter_wyvern_frozen_cemetery:GetAuraDuration()
    return 0
end

function modifier_winter_wyvern_frozen_cemetery:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_winter_wyvern_frozen_cemetery:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_winter_wyvern_frozen_cemetery:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

modifier_winter_wyvern_frozen_cemetery_debuff = class({})

function modifier_winter_wyvern_frozen_cemetery_debuff:OnCreated()
    self.damage_percent = self:GetAbility():GetSpecialValueFor("damage_percent")
    if not IsServer() then return end
    self:StartIntervalThink(1)
end

function modifier_winter_wyvern_frozen_cemetery_debuff:GetStatusEffectName()
    return "particles/status_fx/status_effect_wyvern_curse_buff.vpcf"
end

function modifier_winter_wyvern_frozen_cemetery_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_winter_wyvern_frozen_cemetery_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -1000
end

function modifier_winter_wyvern_frozen_cemetery_debuff:OnIntervalThink()
    if not IsServer() then return end
    local damage = self:GetCaster():Script_GetMagicalArmorValue(nil) * self.damage_percent
    damage = damage * (1 - (self:GetParent():Script_GetMagicalArmorValue(nil)))
    ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
end