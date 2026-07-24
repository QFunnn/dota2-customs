--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_chaos_knight_berserk_eclipse", "heroes/npc_dota_hero_chaos_knight_custom/chaos_knight_berserk_eclipse", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_chaos_knight_berserk_eclipse_debuff", "heroes/npc_dota_hero_chaos_knight_custom/chaos_knight_berserk_eclipse", LUA_MODIFIER_MOTION_NONE)

chaos_knight_berserk_eclipse = class({})

function chaos_knight_berserk_eclipse:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_luna/chaos_eclipse.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_luna/chaos_moon_overhead.vpcf", context)
    PrecacheResource("particle", "particles/econ/items/necrolyte/necro_ti9_immortal/chaos_immortal_shroud.vpcf", context)
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_luna.vsndevts", context )
end

function chaos_knight_berserk_eclipse:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_chaos_knight_berserk_eclipse", {duration = duration})
end

modifier_chaos_knight_berserk_eclipse = class({})
function modifier_chaos_knight_berserk_eclipse:IsPurgable() return false end
function modifier_chaos_knight_berserk_eclipse:IsPurgeException() return false end
function modifier_chaos_knight_berserk_eclipse:IsAura() return true end
function modifier_chaos_knight_berserk_eclipse:GetModifierAura() return "modifier_chaos_knight_berserk_eclipse_debuff" end
function modifier_chaos_knight_berserk_eclipse:GetAuraRadius() return self.radius end
function modifier_chaos_knight_berserk_eclipse:GetAuraDuration() return 0.5 end
function modifier_chaos_knight_berserk_eclipse:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES end
function modifier_chaos_knight_berserk_eclipse:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_chaos_knight_berserk_eclipse:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_chaos_knight_berserk_eclipse:OnCreated()
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    if not IsServer() then return end
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_luna/chaos_eclipse.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 0, 0 ) )
    self:AddParticle(effect_cast,false,false,-1,false,false)
    local ghost = ParticleManager:CreateParticle( "particles/econ/items/necrolyte/necro_ti9_immortal/chaos_immortal_shroud.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    self:AddParticle(ghost,false,false,-1,false,false)

    self.effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_chaos_knight/chaos_knight_phantasm.vpcf", PATTACH_ABSORIGIN, self:GetParent() )
    ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetAbsOrigin() )
    
    Timers:CreateTimer(0.5, function()
        if self.effect_cast then
            ParticleManager:DestroyParticle(self.effect_cast, false)
            ParticleManager:ReleaseParticleIndex(self.effect_cast)
        end
    end)

    EmitSoundOn( "Hero_Luna.Eclipse.Cast", self:GetParent() )
end

modifier_chaos_knight_berserk_eclipse_debuff = class({})

function modifier_chaos_knight_berserk_eclipse_debuff:OnCreated()
    self.magical_resistance = self:GetAbility():GetSpecialValueFor("magical_resistance")
    if not IsServer() then return end
    if self:GetParent():IsHero() then
        local pfx_head = ParticleManager:CreateParticle( "particles/units/heroes/hero_luna/chaos_moon_overhead.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
        self:AddParticle(pfx_head, false, false, -1, false, false)
    end
end

function modifier_chaos_knight_berserk_eclipse_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DIRECT_MODIFICATION
    }
end

function modifier_chaos_knight_berserk_eclipse_debuff:GetModifierMagicalResistanceDirectModification()
    return self.magical_resistance
end