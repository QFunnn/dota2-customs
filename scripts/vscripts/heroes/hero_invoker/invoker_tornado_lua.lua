--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


invoker_tornado_lua = class({})
LinkLuaModifier("modifier_invoker_tornado_lua", "heroes/hero_invoker/modifier_invoker_tornado_lua", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
-- Ability Start
function invoker_tornado_lua:OnSpellStart()
    -- unit identifier
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()

    self.caster_origin = self:GetCaster():GetOrigin()
    self.parent_origin = point
    self.direction = self.parent_origin - self.caster_origin
    self.direction.z = 0
    self.direction = self.direction:Normalized()

    self.radius = self:GetSpecialValueFor("area_of_effect")
    self.distance = self:GetSpecialValueFor("travel_distance")
    self.speed = self:GetSpecialValueFor("travel_speed")
    self.vision = self:GetSpecialValueFor("vision_distance")
    self.vision_duration = self:GetSpecialValueFor("end_vision_duration")

    self.interval = self:GetSpecialValueFor("damage_interval")
    self.duration = self:GetSpecialValueFor("lift_duration")

    -- play effects
    self:PlayEffects()
end

function invoker_tornado_lua:GetCastAnimation()
    return ACT_DOTA_CAST_TORNADO
end

function invoker_tornado_lua:PlayEffects()
    -- Get Resources
    local particle_loop = "particles/units/heroes/hero_invoker/invoker_tornado.vpcf"
    local sound_cast = "Hero_Invoker.Tornado.Cast"
    local sound_loop = "Hero_Invoker.Tornado"


    local tornado_projectile = {
        Ability = self,
        EffectName = particle_loop,
        vSpawnOrigin = self.caster_origin,
        fDistance = self.distance,
        fStartRadius = self.radius,
        fEndRadius = self.radius,
        Source = self:GetCaster(),
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        bDeleteOnHit = false,
        vVelocity = self.direction * self.speed,
        bProvidesVision = true,
        iVisionRadius = self.vision,
        iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
        fExpireTime = GameRules:GetGameTime() + 10
    }

    ProjectileManager:CreateLinearProjectile(tornado_projectile)

    -- Create Sound
    EmitSoundOnLocationWithCaster(self.caster_origin, sound_cast, self:GetCaster())
    EmitSoundOn(sound_loop, self)
end


function invoker_tornado_lua:OnProjectileHit(hTarget, vLocation)
    -- If no target was hit, do nothing
    local hCaster = self:GetCaster()
    if not hTarget then
        -- add vision
        AddFOWViewer(self:GetCaster():GetTeamNumber(), vLocation, self.vision, self.vision_duration, false)

        -- stop effects
        local sound_loop = "Hero_Invoker.Tornado"
        StopSoundOn(sound_loop, self)
        return nil
    end

    hTarget:AddNewModifier(self:GetCaster(), self, "modifier_invoker_tornado_lua", { duration = self.duration * hTarget:GetStatusResistanceFactor(hCaster) })

    return false
end