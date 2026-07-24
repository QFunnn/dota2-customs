--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


chen_creep_shockwave = class({})

function chen_creep_shockwave:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/generic_gameplay/generic_has_quest.vpcf", context )
    PrecacheResource( "particle", "particles/creep_particles/satyr_hellcaller.vpcf", context )
end

function chen_creep_shockwave:OnSpellStart()
	if not IsServer() then return end
	local point = self:GetCursorPosition()
    if point == self:GetCaster():GetAbsOrigin() then
        point = point + self:GetCaster():GetForwardVector()
    end
    local direction = point - self:GetCaster():GetAbsOrigin()
    direction.z = 0
    direction = direction:Normalized()
    local range = self:GetSpecialValueFor("range")
    local radius = self:GetSpecialValueFor("radius")
    local info = 
    {
        EffectName = "particles/creep_particles/satyr_hellcaller.vpcf",
        Ability = self,
        vSpawnOrigin = self:GetCaster():GetOrigin(), 
        fStartRadius = radius / 2,
        fEndRadius = radius,
        vVelocity = direction * 900,
        fDistance = range,
        Source = self:GetCaster(),
        bDeleteOnHit = false,
        fExpireTime = GameRules:GetGameTime() + 4,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
    }
    self:GetCaster():EmitSound("n_creep_SatyrHellcaller.Shockwave")
    ProjectileManager:CreateLinearProjectile(info)
end

function chen_creep_shockwave:OnProjectileHit(target, vLocation)
	if not IsServer() then return end
	if target == nil then return end
    local damage = self:GetSpecialValueFor("damage")
    local damage_intellect = self:GetSpecialValueFor("damage_intellect")
	local damage = damage + (self:GetCaster():GetIntellect(false) / 100 * damage_intellect)
	ApplyDamage({victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
end