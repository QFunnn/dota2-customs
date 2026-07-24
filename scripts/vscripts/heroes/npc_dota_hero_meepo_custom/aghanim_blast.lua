--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


aghanim_blast = class({})

function aghanim_blast:OnSpellStart()
    if not IsServer() then return end
    
    local point = self:GetCaster():GetAbsOrigin()

    local stun_duration = self:GetSpecialValueFor("stun_duration")
    local radius = self:GetSpecialValueFor("radius")

    local effect_cast = ParticleManager:CreateParticle( "particles/aghanim_lesh_tormented.vpcf", PATTACH_WORLDORIGIN, self:GetCaster() )
    ParticleManager:SetParticleControl( effect_cast, 0, point )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, 0, 0 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )

    EmitSoundOnLocationWithCaster( point, "Hero_Leshrac.Split_Earth", self:GetCaster() )

    local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), point, self:GetCaster(), radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, 0, false )
    local creeps = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), point, self:GetCaster(), radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, 0, 0, false )

    for _,enemy in pairs( enemies ) do
        enemy:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = stun_duration * (1 - enemy:GetStatusResistance())})
        local aghanim_shard = self:GetCaster():FindAbilityByName("aghanim_shard")
        if aghanim_shard and aghanim_shard:GetLevel() > 0 then
            aghanim_shard:ApplyEffect(enemy)
        end
    end

    for _,creep in pairs( creeps ) do
        creep:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = stun_duration * (1 - creep:GetStatusResistance())})
        local aghanim_shard = self:GetCaster():FindAbilityByName("aghanim_shard")
        if aghanim_shard and aghanim_shard:GetLevel() > 0 then
            aghanim_shard:ApplyEffect(creep)
        end
    end
end