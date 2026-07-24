--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_huskar_inner_fire_custom", "abilities/huskar_inner_fire_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_huskar_inner_fire_custom_debuff", "abilities/huskar_inner_fire_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )

huskar_inner_fire_custom = class({})

function huskar_inner_fire_custom:Precache(context)
    PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_inner_fire.vpcf", context )
    PrecacheResource( "particle", "particles/huskar_root_inner_fire.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_inner_fire_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_huskar_lifebreak.vpcf", context )
end

function huskar_inner_fire_custom:GetBehavior()
    if self:GetCaster():HasShard() then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function huskar_inner_fire_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function huskar_inner_fire_custom:OnSpellStart()
    if not IsServer() then return end
    self:UseInnerFire(self:GetCaster():GetAbsOrigin())
end

function huskar_inner_fire_custom:UseInnerFire(point)
    local radius = self:GetSpecialValueFor("radius")
    local damage = self:GetSpecialValueFor("damage")
    local disarm_duration = self:GetSpecialValueFor("disarm_duration")
    local knockback_duration = self:GetSpecialValueFor("knockback_duration")
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
    for _, unit in pairs(units) do
        local direction = unit:GetAbsOrigin() - point
        direction.z = 0
        local length = direction:Length2D()
        direction = direction:Normalized()
        local knockback_distance = self:GetSpecialValueFor("knockback_distance")
        knockback_distance = math.max(0, knockback_distance - length)
        local knockback = unit:AddNewModifier(self:GetCaster(), self, "modifier_generic_knockback_lua", { duration = knockback_duration, distance = knockback_distance, IsStun = true, direction_x = direction.x, direction_y = direction.y} )
        if knockback then
            knockback:SetEndCallback( callback )
        end
        ApplyDamage({victim = unit, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
        unit:AddNewModifier(self:GetCaster(), self, "modifier_huskar_inner_fire_custom_debuff", {duration = disarm_duration * (1-unit:GetStatusResistance())})
    end
    self:GetCaster():EmitSound("Hero_Huskar.Inner_Fire.Cast")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_huskar/huskar_inner_fire.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, point)
    ParticleManager:SetParticleControl(particle, 1, Vector(radius, 0, 0))
    ParticleManager:SetParticleControl(particle, 3, point)
    ParticleManager:ReleaseParticleIndex(particle)
end

modifier_huskar_inner_fire_custom_debuff = class({})

function modifier_huskar_inner_fire_custom_debuff:CheckState()
    return
    {
        [MODIFIER_STATE_DISARMED] = true,
    }
end

function modifier_huskar_inner_fire_custom_debuff:GetEffectName()
    return "particles/units/heroes/hero_huskar/huskar_inner_fire_debuff.vpcf"
end
  
function modifier_huskar_inner_fire_custom_debuff:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end