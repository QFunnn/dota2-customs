--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


lina_dragon_slave_custom = class({})
lina_dragon_slave_custom.modifier_lina_17_range = {300,300}
lina_dragon_slave_custom.modifier_lina_17_distance = {300,450}
lina_dragon_slave_custom.modifier_lina_17_width = 100
lina_dragon_slave_custom.modifier_lina_15 = {20,40}

function lina_dragon_slave_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_lina/lina_spell_dragon_slave.vpcf", context)
    PrecacheResource("particle", "particles/econ/items/lina/lina_head_headflame/lina_spell_dragon_slave_headflame.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf", context)
end

function lina_dragon_slave_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    if point == self:GetCaster():GetAbsOrigin() then
        point = point + self:GetCaster():GetForwardVector()
    end
    local direction = point - self:GetCaster():GetAbsOrigin()
    direction.z = 0
    direction = direction:Normalized()
    local particle_proj = "particles/units/heroes/hero_lina/lina_spell_dragon_slave.vpcf"
    if self:GetCaster():HasModifier("modifier_lina_15") then
        particle_proj = "particles/econ/items/lina/lina_head_headflame/lina_spell_dragon_slave_headflame.vpcf"
    end
    local points_back_spawn = self:GetCaster():GetAbsOrigin()
    if self:GetCaster():HasModifier("modifier_lina_17") then
        points_back_spawn = self:GetCaster():GetAbsOrigin() - self:GetCaster():GetForwardVector() * self.modifier_lina_17_range[self:GetCaster():GetTalentLevel("modifier_lina_17")]
    end
    self:CreateProjectile(direction, points_back_spawn, particle_proj)
end

function lina_dragon_slave_custom:CreateProjectile(direction, spawnpoint, particle)
    local projectile_distance = self:GetSpecialValueFor( "dragon_slave_distance" ) + self:GetCaster():GetCastRangeBonus()
    local projectile_speed = self:GetSpecialValueFor( "dragon_slave_speed" )
    local projectile_start_radius = self:GetSpecialValueFor( "dragon_slave_width_initial" )
    local projectile_end_radius = self:GetSpecialValueFor( "dragon_slave_width_end" )
    if self:GetCaster():HasModifier("modifier_lina_17") then
        projectile_start_radius = projectile_start_radius + self.modifier_lina_17_width
        projectile_end_radius = projectile_end_radius + self.modifier_lina_17_width
        projectile_distance = projectile_distance + self.modifier_lina_17_distance[self:GetCaster():GetTalentLevel("modifier_lina_17")]
    end
    local info = 
    {
        Source = self:GetCaster(),
        Ability = self,
        vSpawnOrigin = spawnpoint,
        bDeleteOnHit = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        EffectName = particle,
        fDistance = projectile_distance,
        fStartRadius = projectile_start_radius,
        fEndRadius = projectile_end_radius,
        vVelocity = direction * projectile_speed,
        bProvidesVision = false,
    }
    ProjectileManager:CreateLinearProjectile(info)
    self:GetCaster():EmitSound("Hero_Lina.DragonSlave.Cast")
    self:GetCaster():EmitSound("Hero_Lina.DragonSlave")
end

function lina_dragon_slave_custom:OnProjectileHit(target, vLocation)
    if not IsServer() then return end
    if target == nil then return end
    local damage = self:GetSpecialValueFor("dragon_slave_damage")
    if self:GetCaster():HasModifier("modifier_lina_15") then
        damage = damage + self.modifier_lina_15[self:GetCaster():GetTalentLevel("modifier_lina_15")]
    end
    ApplyDamage({victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
    local modifier_lina_fiery_soul_custom = self:GetCaster():FindModifierByName("modifier_lina_fiery_soul_custom")
    if modifier_lina_fiery_soul_custom then
        modifier_lina_fiery_soul_custom:AddStack()
    end
end