--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tiny_avalanche_custom_handler", "heroes/npc_dota_hero_tiny_custom/tiny_avalanche_custom", LUA_MODIFIER_MOTION_NONE)

tiny_avalanche_custom = class({})
tiny_avalanche_custom.modifier_tiny_4 = {3,6}
tiny_avalanche_custom.modifier_tiny_6 = {0.3,0.6,0.9}
tiny_avalanche_custom.modifier_tiny_13 = {1200,950,700}
tiny_avalanche_custom.modifier_tiny_13_cooldown = 1

function tiny_avalanche_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function tiny_avalanche_custom:GetIntrinsicModifierName()
    return "modifier_tiny_avalanche_custom_handler"
end

function tiny_avalanche_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local projectile_speed = self:GetSpecialValueFor("projectile_speed")
    local casterPos = self:GetCaster():GetAbsOrigin()
    local direction = (point - casterPos)
    direction.z = 0
    local distance = direction:Length2D()
    direction = direction:Normalized()
	local velocity = projectile_speed * direction
	velocity.z = 0
    local interval = self:GetSpecialValueFor("tick_interval")

    local count = self:GetSpecialValueFor("tick_count")
    if self:GetCaster():HasModifier("modifier_tiny_6") then
        count = count + (self.modifier_tiny_6[self:GetCaster():GetTalentLevel("modifier_tiny_6")] / interval)
    end

    local info = 
    {
        EffectName = "particles/units/heroes/hero_tiny/tiny_avalanche_projectile.vpcf",
        Ability = self,
        vSpawnOrigin = self:GetCaster():GetOrigin(),
        fStartRadius = 0,
        fEndRadius = 0,
        vVelocity = velocity,
        fDistance = distance,
        Source = self:GetCaster(),
        iUnitTargetTeam = 0,
        iUnitTargetType = 0,
        ExtraData = {tick_count = count, dir_x = direction.x, dir_y = direction.y}
    }
    ProjectileManager:CreateLinearProjectile( info )
    EmitSoundOnLocationWithCaster(point, "Ability.Avalanche", self:GetCaster())
end

function tiny_avalanche_custom:OnProjectileHit_ExtraData(hTarget, vLocation, data)
    if not IsServer() then return end
    local caster = self:GetCaster()
    local stun_duration = self:GetSpecialValueFor("stun_duration")
    local radius = self:GetSpecialValueFor("radius")
    local interval = self:GetSpecialValueFor("tick_interval")
    local avalanch_damage = self:GetSpecialValueFor("avalanche_damage")
    if self:GetCaster():HasModifier("modifier_tiny_4") then
        avalanch_damage = avalanch_damage + (self:GetCaster():GetMaxHealth() / 100 * self.modifier_tiny_4[self:GetCaster():GetTalentLevel("modifier_tiny_4")])
    end
    local avalance_particle = "particles/units/heroes/hero_tiny/tiny_avalanche_lvl"..self:GetLevel()..".vpcf"
    local avalanche = ParticleManager:CreateParticle(avalance_particle, PATTACH_CUSTOMORIGIN, nil)
    ParticleManager:SetParticleControl(avalanche, 0, vLocation)
    ParticleManager:SetParticleControl(avalanche, 1, Vector(radius, 1, radius))
    ParticleManager:SetParticleControlForward( avalanche, 0, Vector(data.dir_x, data.dir_y, 0))
    local ability = self
    local tick_counts = self:GetSpecialValueFor("tick_count")
    local damage_type = self:GetAbilityDamageType()
    local heroes = {}

    Timers:CreateTimer(function()
        if ability and not ability:IsNull() then
            local enemies_tick = FindUnitsInRadius(caster:GetTeamNumber(), vLocation, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
            for _,enemy in pairs(enemies_tick) do
                local damage = avalanch_damage / tick_counts
                ApplyDamage({victim = enemy, attacker = caster, damage = damage, damage_type = damage_type, ability = ability})
                if enemy:IsAlive() and not heroes[enemy] then
                    heroes[enemy] = true
                    enemy:AddNewModifier(caster, ability, "modifier_stunned", {duration = data.tick_count * stun_duration})
                end
            end
        end

        data.tick_count = data.tick_count - 1

        if data.tick_count > 0 then
            return interval
        else
            ParticleManager:DestroyParticle(avalanche, false)
            ParticleManager:ReleaseParticleIndex(avalanche)
        end
    end)
end

modifier_tiny_avalanche_custom_handler = class({})
function modifier_tiny_avalanche_custom_handler:IsHidden() return true end
function modifier_tiny_avalanche_custom_handler:IsPurgable() return false end
function modifier_tiny_avalanche_custom_handler:IsPurgeException() return false end
function modifier_tiny_avalanche_custom_handler:RemoveOnDeath() return false end

function modifier_tiny_avalanche_custom_handler:OnCreated()
    if not IsServer() then return end
    self.distance = 0
    self.origin = self:GetCaster():GetOrigin()
    self:StartIntervalThink(FrameTime())
end

function modifier_tiny_avalanche_custom_handler:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetCaster():HasModifier("modifier_tiny_13") then return end
    if self:GetAbility():IsCooldownReady() then return end
    local new_distance = (self:GetCaster():GetOrigin() - self.origin):Length2D()
    self.origin = self:GetParent():GetAbsOrigin()
    if new_distance > 600 then return end
    self.distance = self.distance + new_distance
    if self.distance >= self:GetAbility().modifier_tiny_13[self:GetCaster():GetTalentLevel("modifier_tiny_13")] then
        self.distance = math.max(0, self.distance - self:GetAbility().modifier_tiny_13[self:GetCaster():GetTalentLevel("modifier_tiny_13")])
        local new_cooldown = self:GetAbility():GetCooldownTimeRemaining() - self:GetAbility().modifier_tiny_13_cooldown
        if new_cooldown <= self:GetAbility().modifier_tiny_13_cooldown then
            self:GetAbility():EndCooldown()
        else
            self:GetAbility():EndCooldown()
            self:GetAbility():StartCooldown(new_cooldown)
        end
    end
end