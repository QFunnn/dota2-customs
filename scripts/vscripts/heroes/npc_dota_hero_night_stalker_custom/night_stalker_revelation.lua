--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_night_stalker_revelation", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_revelation", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_night_stalker_revelation_thinker", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_revelation", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_night_stalker_revelation_thinker_debuff", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_revelation", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_night_stalker_revelation_thinker_night", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_revelation", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_night_stalker_revelation_thinker_night_buff", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_revelation", LUA_MODIFIER_MOTION_NONE)

night_stalker_revelation = class({})
night_stalker_revelation.modifier_night_stalker_10 = {-10,-20,-30}
night_stalker_revelation.modifier_night_stalker_10_radius = 450
night_stalker_revelation.modifier_night_stalker_10_duration = 5
night_stalker_revelation.modifier_night_stalker_10_lifesteal = {10,20,30}

function night_stalker_revelation:OnSpellStart()
    if not IsServer() then return end
    local heal = self:GetSpecialValueFor("heal")
    self:GetCaster():HealWithParams(heal, self, false, true, self:GetCaster(), false)
    self:GetCaster():EmitSound("Hero_Nightstalker.Void")
    local duration = self:GetSpecialValueFor("duration_night")
    if GameRules:IsDaytime() or self:GetCaster():HasModifier("modifier_night_stalker_revelation_thinker_night_buff") or self:GetCaster():HasModifier("modifier_night_stalker_day_walker") or self:GetCaster():HasModifier("modifier_night_stalker_14") then 
        duration = self:GetSpecialValueFor("duration_day") 
    end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_night_stalker_revelation", {duration = duration})
    
    if self:GetCaster():HasModifier("modifier_night_stalker_10") then
        CreateModifierThinker(self:GetCaster(), self, "modifier_night_stalker_revelation_thinker", {duration = self.modifier_night_stalker_10_duration}, self:GetCaster():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
        CreateModifierThinker(self:GetCaster(), self, "modifier_night_stalker_revelation_thinker_night", {duration = self.modifier_night_stalker_10_duration}, self:GetCaster():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
    end
end

modifier_night_stalker_revelation = class({})

function modifier_night_stalker_revelation:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
end

function modifier_night_stalker_revelation:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movement_speed")
end

function modifier_night_stalker_revelation:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("attack_speed")
end 

function modifier_night_stalker_revelation:GetEffectName()
	return "particles/units/heroes/hero_night_stalker/nightstalker_void_day.vpcf"
end

function modifier_night_stalker_revelation:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_night_stalker_revelation:CheckState()
    if GameRules:IsDaytime() or self:GetCaster():HasModifier("modifier_night_stalker_revelation_thinker_night_buff") or self:GetCaster():HasModifier("modifier_night_stalker_day_walker") or self:GetCaster():HasModifier("modifier_night_stalker_14") then 
        return
        {
            [MODIFIER_STATE_UNSLOWABLE] = true,
        }
    end
end


modifier_night_stalker_revelation_thinker = class({})

function modifier_night_stalker_revelation_thinker:OnCreated()
    if not IsServer() then return end
    self.targets = {}
    self.radius = self:GetAbility().modifier_night_stalker_10_radius
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_night_stalker/night_stalker_void_zone_day.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 1, Vector(self.radius,1,1))
    self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_night_stalker_revelation_thinker:IsAura()
    return true
end

function modifier_night_stalker_revelation_thinker:GetModifierAura()
    return "modifier_night_stalker_revelation_thinker_debuff"
end

function modifier_night_stalker_revelation_thinker:GetAuraRadius()
    return self.radius
end

function modifier_night_stalker_revelation_thinker:GetAuraDuration()
    return 0
end

function modifier_night_stalker_revelation_thinker:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_night_stalker_revelation_thinker:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_night_stalker_revelation_thinker:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

modifier_night_stalker_revelation_thinker_debuff = class({})
function modifier_night_stalker_revelation_thinker_debuff:IsPurgable() return false end
function modifier_night_stalker_revelation_thinker_debuff:GetTexture() return "night_stalker_10" end
function modifier_night_stalker_revelation_thinker_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    }
end

function modifier_night_stalker_revelation_thinker_debuff:GetModifierSpellAmplify_Percentage()
    return self:GetAbility().modifier_night_stalker_10[self:GetCaster():GetTalentLevel("modifier_night_stalker_10")]
end


modifier_night_stalker_revelation_thinker_night = class({})

function modifier_night_stalker_revelation_thinker_night:OnCreated()
    if not IsServer() then return end
    self.radius = self:GetAbility().modifier_night_stalker_10_radius
end

function modifier_night_stalker_revelation_thinker_night:IsAura()
    return true
end

function modifier_night_stalker_revelation_thinker_night:GetModifierAura()
    return "modifier_night_stalker_revelation_thinker_night_buff"
end

function modifier_night_stalker_revelation_thinker_night:GetAuraRadius()
    return self.radius
end

function modifier_night_stalker_revelation_thinker_night:GetAuraDuration()
    return 0
end

function modifier_night_stalker_revelation_thinker_night:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_night_stalker_revelation_thinker_night:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO
end

function modifier_night_stalker_revelation_thinker_night:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_night_stalker_revelation_thinker_night:GetAuraEntityReject(target)
    if target == self:GetCaster() then
        return false
    end
    return true
end

modifier_night_stalker_revelation_thinker_night_buff = class({})
function modifier_night_stalker_revelation_thinker_night_buff:IsPurgable() return false end
function modifier_night_stalker_revelation_thinker_night_buff:GetTexture() return "night_stalker_10" end
function modifier_night_stalker_revelation_thinker_night_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PHYSICAL_LIFESTEAL,
    }
end
function modifier_night_stalker_revelation_thinker_night_buff:GetModifierProperty_PhysicalLifesteal()
    return self:GetAbility().modifier_night_stalker_10_lifesteal[self:GetCaster():GetTalentLevel("modifier_night_stalker_10")]
end