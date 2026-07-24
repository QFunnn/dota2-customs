--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

woda_neutral_smash = class({})

function woda_neutral_smash:Precache(context)
    PrecacheResource( "particle", "particles/generic_gameplay/generic_has_quest.vpcf", context )
    PrecacheResource( "particle", "particles/neutral_fx/ogre_bruiser_smash.vpcf", context )
end

function woda_neutral_smash:OnAbilityPhaseStart()
    self:GetCaster():EmitSound("n_creep_OgreBruiser.Smash.Charge")
    return true
end

function woda_neutral_smash:OnSpellStart()
	if not IsServer() then return end

    self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 0.5)
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_neutral_cast", {})
    self.sign = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_has_quest.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetCaster())

    local radius = 200
    local stun_duration = self:GetSpecialValueFor("stun_duration")

    Timers:CreateTimer(2, function()
        if self.sign then
            ParticleManager:DestroyParticle(self.sign, true)
        end
        if not self:GetCaster():IsAlive() then return end
        local origin = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector()*200
        local nFXIndex = ParticleManager:CreateParticle( "particles/neutral_fx/ogre_bruiser_smash.vpcf", PATTACH_WORLDORIGIN,  self:GetCaster()  )
        ParticleManager:SetParticleControl( nFXIndex, 0, origin )
        ParticleManager:SetParticleControl( nFXIndex, 1, Vector(radius, radius, radius ) )
        ParticleManager:ReleaseParticleIndex( nFXIndex )
        self:GetCaster():EmitSound("n_creep_OgreBruiser.Smash.Stun")
        local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), origin, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
        for _,enemy in pairs( enemies ) do
            enemy:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = stun_duration * (1 - enemy:GetStatusResistance())})
        end
        self:GetCaster():RemoveModifierByName("modifier_neutral_cast")
    end)
end

woda_neutral_smash_hop = class({})

function woda_neutral_smash_hop:Precache(context)
    PrecacheResource( "particle", "particles/generic_gameplay/generic_has_quest.vpcf", context )
    PrecacheResource( "particle", "particles/neutral_fx/ogre_bruiser_smash.vpcf", context )
end

function woda_neutral_smash_hop:OnAbilityPhaseStart()
    self:GetCaster():EmitSound("n_creep_OgreBruiser.Smash.Charge")
    return true
end

function woda_neutral_smash_hop:OnSpellStart()
	if not IsServer() then return end

    self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 0.7)
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_neutral_cast", {duration = 2.2})
    self.sign = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_has_quest.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetCaster())

    local radius = 200
    local stun_duration = self:GetSpecialValueFor("stun_duration")

    Timers:CreateTimer(2, function()
        if self.sign then
            ParticleManager:DestroyParticle(self.sign, true)
        end
        if not self:GetCaster():IsAlive() then return end
        local origin = self:GetCaster():GetAbsOrigin()
        local nFXIndex = ParticleManager:CreateParticle( "particles/act_2/ogre_seal_suprise.vpcf", PATTACH_WORLDORIGIN,  self:GetCaster()  )
        ParticleManager:SetParticleControl( nFXIndex, 0, origin )
        ParticleManager:SetParticleControl( nFXIndex, 1, Vector(radius, radius, radius ) )
        ParticleManager:ReleaseParticleIndex( nFXIndex )
        self:GetCaster():EmitSound("Hero_Centaur.HoofStomp")
        local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), origin, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
        for _,enemy in pairs( enemies ) do
            enemy:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = stun_duration * (1 - enemy:GetStatusResistance())})
        end
    end)
end