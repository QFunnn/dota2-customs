--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Created by Elfansoer
--[[Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
modifier_luna_eclipse_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_luna_eclipse_lua:IsHidden()
    return false
end

function modifier_luna_eclipse_lua:IsDebuff()
    return false
end

function modifier_luna_eclipse_lua:IsPurgable()
    return false
end

function modifier_luna_eclipse_lua:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_luna_eclipse_lua:OnCreated(kv)
    -- references
    self.beams = self:GetAbility():GetSpecialValueFor("beams")
    self.hit_count = self:GetAbility():GetSpecialValueFor("hit_count")
    self.beam_interval = self:GetAbility():GetSpecialValueFor("beam_interval")
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.stun_duration = self:GetAbility():GetSpecialValueFor("stun_duration")

    self.parent = self:GetParent()
    self.caster = self:GetCaster()

    if IsServer() then
        if kv.point == 1 then
            self.point = Vector(kv.pointx, kv.pointy, kv.pointz)

            -- provide vision if on ground
            AddFOWViewer(self:GetCaster():GetTeamNumber(), self.point, self.radius + 75, self.beams * self.beam_interval, true)
        end
        self.counter = 0
        self.hits = {}

        self.aoe_radius = kv.aoe_radius or 0


        self.damageTable = {
            -- victim = target,
            attacker = self.caster,
            damage = kv.damage,
            damage_type = self:GetAbility():GetAbilityDamageType(),
            ability = self:GetAbility(), --Optional.
        }



        -- Start interval
        self:StartIntervalThink(self.beam_interval)
        self:OnIntervalThink()

        -- play effects
        self:PlayEffects1()
    end
end

function modifier_luna_eclipse_lua:OnRemoved()
end

function modifier_luna_eclipse_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_luna_eclipse_lua:OnIntervalThink()
    local point = self.point or self.parent:GetOrigin()
    local units = FindUnitsInRadius(
    self.caster:GetTeamNumber(), -- int, your team number
    point, -- point, center point
    nil, -- handle, cacheUnit. (not known)
    self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
    DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
    DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
    DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, -- int, flag filter
    0, -- int, order filter
    false	-- bool, can grow cache
    )

    local unit = nil
    if #units > 0 then
        -- pick random unit
        for i = 1, #units do
            unit = units[i]
            self.hits[unit] = self.hits[unit] or 0
            self.hits[unit] = self.hits[unit] + 1
            if self.hits[unit] <= self.hit_count then
                -- damage
                if self.aoe_radius > 0 then
                    local enemies = FindUnitsInRadius(self.caster:GetTeamNumber(), unit:GetAbsOrigin(), nil, self.aoe_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
                    for _, enemy in pairs(enemies) do
                        if IsValid(enemy) and enemy:IsAlive() then
                            enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stunned", { duration = self.stun_duration * enemy:GetStatusResistanceFactor(self:GetCaster()) })
                            self.damageTable.victim = enemy
                            ApplyDamage(self.damageTable)
                        end
                    end

                else
                    unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stunned", { duration = self.stun_duration * unit:GetStatusResistanceFactor(self:GetCaster()) })
                    -- precache damage
                    self.damageTable.victim = unit
                    ApplyDamage(self.damageTable)
                end

                break
            end
            unit = nil
        end
    end

    -- play effects
    self:PlayEffects2(unit, point)

    -- check counter
    self.counter = self.counter + 1
    if self.counter >= self.beams then
        self:StartIntervalThink(-1)
        self:Destroy()
    end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_luna_eclipse_lua:PlayEffects1()
    -- Get Resources
    local particle_cast = "particles/units/heroes/hero_luna/luna_eclipse.vpcf"
    local sound_cast = "Hero_Luna.Eclipse.Cast"

    -- Get Data
    local effect_cast = nil
    if self.point then
        effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(effect_cast, 0, self.point)

        -- Create Sound
        EmitSoundOn(sound_cast, self:GetParent())
    else
        effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())

        -- Create Sound
        EmitSoundOn(sound_cast, self:GetParent())
    end

    ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 0, 0))

    -- buff particle
    self:AddParticle(
    effect_cast,
    false, -- bDestroyImmediately
    false, -- bStatusEffect
    -1, -- iPriority
    false, -- bHeroEffect
    false -- bOverheadEffect
    )
end

function modifier_luna_eclipse_lua:PlayEffects2(target, point)
    local particle_cast = "particles/units/heroes/hero_luna/luna_lucent_beam.vpcf"
    local sound_target = "Hero_Luna.Eclipse.Target"
    local sound_fail = "Hero_Luna.Eclipse.NoTarget"

    if not target then
        local vector = point + RandomVector(RandomInt(0, self.radius))
        local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
        ParticleManager:SetParticleControl(effect_cast, 0, vector)
        ParticleManager:SetParticleControl(effect_cast, 1, vector)
        ParticleManager:SetParticleControl(effect_cast, 5, vector)
        ParticleManager:SetParticleControl(effect_cast, 6, vector)
        ParticleManager:ReleaseParticleIndex(effect_cast)

        EmitSoundOn(sound_fail, self.caster) --TODO Звук должен быть на точке а не на кастере
        return
    end

    -- Create Particle
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControl(effect_cast, 0, target:GetOrigin())
    ParticleManager:SetParticleControlEnt(
    effect_cast,
    1,
    target,
    PATTACH_ABSORIGIN_FOLLOW,
    "attach_hitloc",
    Vector(0, 0, 0), -- unknown
    true -- unknown, true
    )
    ParticleManager:SetParticleControlEnt(
    effect_cast,
    5,
    target,
    PATTACH_POINT_FOLLOW,
    "attach_hitloc",
    Vector(0, 0, 0), -- unknown
    true -- unknown, true
    )
    ParticleManager:SetParticleControlEnt(
    effect_cast,
    6,
    target,
    PATTACH_POINT_FOLLOW,
    "attach_hitloc",
    Vector(0, 0, 0), -- unknown
    true -- unknown, true
    )
    ParticleManager:ReleaseParticleIndex(effect_cast)

    -- Create Sound
    EmitSoundOn(sound_target, target)
end