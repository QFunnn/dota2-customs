--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


faceless_void_bash_wave = class({})

function faceless_void_bash_wave:Precache(context)
    PrecacheResource("particle", "particles/faceless_void_custom/magnataur_shockanvil.vpcf", context)
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts", context )
end

function faceless_void_bash_wave:GetCastRange(vLocation, hTarget)
    if IsClient() then
        return self:GetSpecialValueFor("range")
    end
end

function faceless_void_bash_wave:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    if point == self:GetCaster():GetAbsOrigin() then
        point = point + self:GetCaster():GetForwardVector()
    end
    local range = self:GetSpecialValueFor("range") + self:GetCaster():GetCastRangeBonus()
    local shock_width = self:GetSpecialValueFor("shock_width")
    local shock_speed = self:GetSpecialValueFor("shock_speed")
    local direction = (point - self:GetCaster():GetAbsOrigin())
    direction.z = 0
    direction = direction:Normalized()
    local index = DoUniqueString("index")
    self[index] = 0
    local projectile =
    {
        Ability             = self,
        EffectName          = "particles/faceless_void_custom/magnataur_shockanvil.vpcf",
        vSpawnOrigin        = self:GetCaster():GetAbsOrigin(),
        fDistance           = range,
        fStartRadius        = shock_width,
        fEndRadius          = shock_width,
        Source              = self:GetCaster(),
        bHasFrontalCone     = false,
        bReplaceExisting    = false,
        iUnitTargetTeam     = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags    = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
        iUnitTargetType     = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        fExpireTime         = GameRules:GetGameTime() + 5.0,
        bDeleteOnHit        = false,
        vVelocity           = direction * shock_speed,
        bProvidesVision     = false,
        ExtraData           = {index = index}
    }
    ProjectileManager:CreateLinearProjectile(projectile)
    self:GetCaster():EmitSound("Hero_Magnataur.ShockWave.Cast")
    self:GetCaster():EmitSound("Hero_Magnataur.ShockWave.Particle")
end

function faceless_void_bash_wave:OnProjectileHit_ExtraData(hTarget, vLocation, data)
    if not hTarget then return end
    ApplyDamage({ victim = hTarget, attacker = self:GetCaster(), damage = self:GetSpecialValueFor("shock_damage"), damage_type = DAMAGE_TYPE_MAGICAL, ability = self })
    if self[data.index] then
        if self[data.index] >= self:GetSpecialValueFor("target_counter") then return end
        self[data.index] = self[data.index] + 1
    end
    local faceless_void_time_lock_custom = self:GetCaster():FindAbilityByName("faceless_void_time_lock_custom")
    if faceless_void_time_lock_custom and faceless_void_time_lock_custom:GetLevel() > 0 then
        faceless_void_time_lock_custom:TimeLock(hTarget, true)
    end
end