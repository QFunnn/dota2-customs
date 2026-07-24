--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_phoenix_icicle_shard_debuff", "heroes/npc_dota_hero_phoenix_custom/phoenix_icicle_shard", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phoenix_icicle_shard_thinker", "heroes/npc_dota_hero_phoenix_custom/phoenix_icicle_shard", LUA_MODIFIER_MOTION_NONE)

phoenix_icicle_shard = class({})

function phoenix_icicle_shard:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function phoenix_icicle_shard:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_crystalmaiden/maiden_crystal_nova.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_snow.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf', context )
end

function phoenix_icicle_shard:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    CreateModifierThinker(self:GetCaster(), self, "modifier_phoenix_icicle_shard_thinker", {duration = 0.5}, point, self:GetCaster():GetTeamNumber(), false)
end

modifier_phoenix_icicle_shard_thinker = class({})
function modifier_phoenix_icicle_shard_thinker:IsHidden() return false end
function modifier_phoenix_icicle_shard_thinker:IsPurgable() return false end

function modifier_phoenix_icicle_shard_thinker:OnCreated(table)
    if not IsServer() then return end
    self.start_interval = 0.25
    self.damage = self:GetAbility():GetSpecialValueFor("damage")
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self.radius, self.start_interval, false)

    self.effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_snow.vpcf", PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetAbsOrigin() )
    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, self.radius, 1 ) )
    self:AddParticle( self.effect_cast, false, false, -1, false, false )

    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf", PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetAbsOrigin() )
    ParticleManager:ReleaseParticleIndex(effect_cast)
    EmitSoundOnLocationWithCaster( self:GetParent():GetAbsOrigin(), "hero_Crystal.freezingField.explosion", self:GetCaster() )
    self:OnIntervalThink()
    self:StartIntervalThink(self.start_interval - FrameTime())
end

function modifier_phoenix_icicle_shard_thinker:OnIntervalThink()
    if not IsServer() then return end
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf", PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetAbsOrigin() )
    ParticleManager:ReleaseParticleIndex(effect_cast)
    local parent = self:GetParent()
    local damage = (self.damage / 100 * self:GetCaster():GetMaxMana() / 3)
    local origin = self:GetParent():GetAbsOrigin()
    local caster = self:GetCaster()
    local radius = self.radius
    local ability = self:GetAbility()
    local slow_duration = self:GetAbility():GetSpecialValueFor("slow_duration")

    Timers:CreateTimer(0.3, function()
        EmitSoundOnLocationWithCaster( origin, "hero_Crystal.freezingField.explosion", caster)
        local enemies = FindUnitsInRadius(caster:GetTeamNumber(), origin, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
        local damageTable = {attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = ability}
        local phoenix_ice_debuff = caster:FindAbilityByName("phoenix_ice_debuff")
        for _,enemy in pairs(enemies) do
            damageTable.victim = enemy
            ApplyDamage(damageTable)
            enemy:AddNewModifier(caster, ability, "modifier_phoenix_icicle_shard_debuff", {duration = slow_duration * ( 1 - enemy:GetStatusResistance() )})
            if phoenix_ice_debuff then
                phoenix_ice_debuff:AddStack(enemy, 1)
            end
        end
    end)
end

function modifier_phoenix_icicle_shard_thinker:OnDestroy()
    if not IsServer() then return end
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_crystalmaiden/maiden_crystal_nova.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetAbsOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, self:GetAbility():GetSpecialValueFor("slow_duration"), self.radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	EmitSoundOnLocationWithCaster( self:GetParent():GetAbsOrigin(), "Hero_Crystal.CrystalNova", self:GetCaster() )
end

modifier_phoenix_icicle_shard_debuff = class({})

function modifier_phoenix_icicle_shard_debuff:DeclareFunctions()
    return {MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE}
end

function modifier_phoenix_icicle_shard_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("slow")
end