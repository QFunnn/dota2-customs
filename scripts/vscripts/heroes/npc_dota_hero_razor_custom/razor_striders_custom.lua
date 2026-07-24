--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_razor_striders_custom", "heroes/npc_dota_hero_razor_custom/razor_striders_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_striders_custom_thinker", "heroes/npc_dota_hero_razor_custom/razor_striders_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_razor_striders_custom_thinker_debuff", "heroes/npc_dota_hero_razor_custom/razor_striders_custom", LUA_MODIFIER_MOTION_NONE)

razor_striders_custom = class({})

function razor_striders_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/razor_custom/striders_thinker.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/razor/razor_arcana/razor_arcana_phase_boots.vpcf", context )
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_weaver.vsndevts", context )
end

function razor_striders_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    self:GetCaster():EmitSound("Hero_Weaver.TI8_taunt")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_razor_striders_custom", {duration = duration})
end

modifier_razor_striders_custom = class({})

function modifier_razor_striders_custom:OnCreated()
    if not IsServer() then return end
    self.origin = self:GetParent():GetOrigin()
    self.distance = 0
    self.radius = self:GetAbility():GetSpecialValueFor("radius") / 2
    self:StartIntervalThink(FrameTime())
    local particle = ParticleManager:CreateParticle("particles/econ/items/razor/razor_arcana/razor_arcana_phase_boots.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_razor_striders_custom:OnIntervalThink()
    if not IsServer() then return end
    local distance_check = (self.origin - self:GetParent():GetOrigin()):Length2D()
    if distance_check > 100 then
        self.origin = self:GetParent():GetOrigin()
        return 
    end
    self.distance = self.distance + distance_check
    self.origin = self:GetParent():GetOrigin()
    if self.distance >= self.radius then
        CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_razor_striders_custom_thinker", {duration = self:GetAbility():GetSpecialValueFor("duration")}, self:GetParent():GetOrigin(), self:GetParent():GetTeamNumber(), false)
        self.distance = 0
    end
end

modifier_razor_striders_custom_thinker = class({})

function modifier_razor_striders_custom_thinker:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/razor_custom/striders_thinker.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 2, Vector(self:GetDuration(), 0, 0))
    ParticleManager:SetParticleControl(particle, 3, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 4, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 5, self:GetParent():GetAbsOrigin())
    self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_razor_striders_custom_thinker:IsAura()
    return true
end

function modifier_razor_striders_custom_thinker:GetModifierAura()
    return "modifier_razor_striders_custom_thinker_debuff"
end

function modifier_razor_striders_custom_thinker:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_razor_striders_custom_thinker:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_razor_striders_custom_thinker:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_razor_striders_custom_thinker:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

modifier_razor_striders_custom_thinker_debuff = class({})

function modifier_razor_striders_custom_thinker_debuff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_razor_striders_custom_thinker_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_razor_striders_custom_thinker_debuff:OnCreated()
    if not IsServer() then return end
    self.damage = self:GetAbility():GetSpecialValueFor("damage") * 0.5
    self:StartIntervalThink(0.5)
end

function modifier_razor_striders_custom_thinker_debuff:OnIntervalThink()
    if not IsServer() then return end
    ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
end