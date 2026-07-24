--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_invoker_chaos_meteor_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_invoker_chaos_meteor_lua_thinker:IsHidden()
    return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_invoker_chaos_meteor_lua_thinker:OnCreated(kv)
    if IsServer() then
        -- references
        self.caster_origin = self:GetCaster():GetOrigin()
        self.parent_origin = self:GetParent():GetOrigin()
        self.direction = self.parent_origin - self.caster_origin
        self.direction.z = 0
        self.direction = self.direction:Normalized()


        --修复陨石不动BUG
        if self.direction:Length2D()<0.5 then
           print("direction is zero")
           self.direction = self:GetCaster():GetForwardVector()
        end

        self.delay = self:GetAbility():GetSpecialValueFor("land_time")
        self.radius = self:GetAbility():GetSpecialValueFor("area_of_effect")
        self.distance = self:GetAbility():GetSpecialValueFor("travel_distance")
        self.speed = self:GetAbility():GetSpecialValueFor("travel_speed")
        self.vision = self:GetAbility():GetSpecialValueFor("vision_distance")
        self.vision_duration = self:GetAbility():GetSpecialValueFor("end_vision_duration")

        self.interval = self:GetAbility():GetSpecialValueFor("damage_interval")
        self.duration = self:GetAbility():GetSpecialValueFor("burn_duration")
        local damage = self:GetAbility():GetSpecialValueFor("main_damage")

        local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_invoker_6")
        if talent and talent:GetLevel() > 0 then
            damage = damage + talent:GetSpecialValueFor("value")
        end

        -- variables
        self.fallen = false
        self.damageTable = {
            -- victim = target,
            attacker = self:GetCaster(),
            damage = damage,
            damage_type = self:GetAbility():GetAbilityDamageType(),
            ability = self:GetAbility(), --Optional.
        }

        self:GetParent():SetMoveCapability(DOTA_UNIT_CAP_MOVE_FLY)
        
        self.nMoveStep = 0
        -- Start interval
        self:StartIntervalThink(self.delay)

        -- play effects
        self:PlayEffects1()
    end
end

function modifier_invoker_chaos_meteor_lua_thinker:OnRefresh(kv)

end

function modifier_invoker_chaos_meteor_lua_thinker:OnDestroy()
    if IsServer() then
        -- add vision
        AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), self.vision, self.vision_duration, false)

        -- stop effects
        -- local sound_stop = "Hero_Invoker.ChaosMeteor.Destroy"
        -- EmitSoundOnLocationWithCaster(self:GetParent():GetOrigin(), sound_stop, self:GetCaster())
        local sound_loop = "Hero_Invoker.ChaosMeteor.Loop"
        StopSoundOn(sound_loop, self:GetParent())
        if self.nLinearProjectile then
            ProjectileManager:DestroyLinearProjectile(self.nLinearProjectile)
        end
    end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_invoker_chaos_meteor_lua_thinker:OnIntervalThink()
    if not self.fallen then
        -- meatball has fallen
        self.fallen = true
        self:StartIntervalThink(self.interval)
        self:Burn()
        self:PlayEffects2()
    else
		self:Move_Burn()
    end
end

function modifier_invoker_chaos_meteor_lua_thinker:Burn()
    -- find enemies
    local enemies = FindUnitsInRadius(
    self:GetCaster():GetTeamNumber(), -- int, your team number
    self:GetParent():GetOrigin(), -- point, center point
    nil, -- handle, cacheUnit. (not known)
    self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
    DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
    DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
    0, -- int, flag filter
    0, -- int, order filter
    false	-- bool, can grow cache
    )

    for _, enemy in pairs(enemies) do
        -- apply damage
        self.damageTable.victim = enemy
        ApplyDamage(self.damageTable)

        -- add modifier
        enemy:AddNewModifier(
        self:GetCaster(), -- player source
        self:GetAbility(), -- ability source
        "modifier_invoker_chaos_meteor_lua_burn", -- modifier name
        { duration = self.duration } -- kv
        )
    end
end

--------------------------------------------------------------------------------
-- Motion effects
function modifier_invoker_chaos_meteor_lua_thinker:Move_Burn()
    local parent = self:GetParent()

    -- set position
    local target = self.direction * self.speed * self.interval
    parent:SetOrigin(parent:GetOrigin() + target)
    self.nMoveStep = self.nMoveStep+1

    -- Burn
    self:Burn()

    --修复陨石卡主
    if self.nMoveStep and self.nMoveStep > 20 then
        self:Destroy()
        return
    end

    -- check distance for next step
    if (parent:GetOrigin() - self.parent_origin + target):Length2D() > self.distance then
        self:Destroy()
        return
    end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_invoker_chaos_meteor_lua_thinker:PlayEffects1()
    -- Get Resources
    local particle_cast = "particles/units/heroes/hero_invoker/invoker_chaos_meteor_fly.vpcf"
    local sound_cast = "Hero_Invoker.ChaosMeteor.Cast"
    local sound_loop = "Hero_Invoker.ChaosMeteor.Loop"

    -- Get Data
    local height = 1000
    local height_target = -0

    -- Create Particle
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    -- local effect_cast = assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_arcana"))(self, particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, self.caster_origin + Vector(0, 0, height))
    ParticleManager:SetParticleControl(effect_cast, 1, self.parent_origin + Vector(0, 0, height_target))
    ParticleManager:SetParticleControl(effect_cast, 2, Vector(self.delay, 0, 0))
    ParticleManager:ReleaseParticleIndex(effect_cast)

    -- Create Sound
    self:GetCaster():EmitSound(sound_cast)
    self:GetParent():EmitSound(sound_loop)
end

function modifier_invoker_chaos_meteor_lua_thinker:PlayEffects2()
    -- Get Resources
    local particle_loop = "particles/units/heroes/hero_invoker/invoker_chaos_meteor.vpcf"
    local sound_impact = "Hero_Invoker.ChaosMeteor.Impact"

    -- Create Particle
    --local effect_loop = ParticleManager:CreateParticle(particle_loop, PATTACH_WORLDORIGIN, nil)
    -- local effect_loop = assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_arcana"))(self, particle_cast, PATTACH_WORLDORIGIN, nil)
    -- ParticleManager:SetParticleControl(effect_loop, 0, self.parent_origin)
    -- ParticleManager:SetParticleControlForward(effect_loop, 0, self.direction)
    -- ParticleManager:SetParticleControl(effect_loop, 1, self.direction * self.speed)
    local meteor_projectile = {
        Ability = self:GetAbility(),
        EffectName = particle_loop,
        vSpawnOrigin = self.parent_origin,
        fDistance = self.distance,
        fStartRadius = self.radius,
        fEndRadius = self.radius,
        Source = self:GetCaster(),
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_NONE,
        bDeleteOnHit = false,
        vVelocity = self.direction * self.speed,
        bProvidesVision = true,
        iVisionRadius = self.vision,
        iVisionTeamNumber = self:GetCaster():GetTeamNumber()
    }

    self.nLinearProjectile = ProjectileManager:CreateLinearProjectile(meteor_projectile)

    self:GetCaster():EmitSound(sound_impact)
end