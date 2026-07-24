--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_invoker_sun_strike_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_invoker_sun_strike_lua_thinker:IsHidden()
    return true
end

function modifier_invoker_sun_strike_lua_thinker:IsPurgable()
    return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_invoker_sun_strike_lua_thinker:OnCreated(kv)
    if IsServer() then
        -- references
        self.damage = self:GetAbility():GetSpecialValueFor("damage")
        self.radius = self:GetAbility():GetSpecialValueFor("area_of_effect")
        if kv.cataclysm then
            -- 毁天灭地伤害减半
            self.damage = self.damage / 2
            self:PlayEffects2()
        else
            self:PlayEffects1()
        end
    end
end

function modifier_invoker_sun_strike_lua_thinker:OnDestroy()
    if IsServer() then
        
        if not self:GetAbility() then
            return
        end

        if self:GetAbility():IsNull() then
            return
        end

        -- Damage enemies
        local damageTable = {
            -- victim = target,
            attacker = self:GetCaster(),
            -- damage = self.damage,
            damage_type = self:GetAbility():GetAbilityDamageType(),
            ability = self:GetAbility(), --Optional.
        }

        local enemies = FindUnitsInRadius(
        self:GetCaster():GetTeamNumber(), -- int, your team number
        self:GetParent():GetOrigin(), -- point, center point
        nil, -- handle, cacheUnit. (not known)
        self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
        DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, -- int, flag filter
        0, -- int, order filter
        false	-- bool, can grow cache
        )

        for _, enemy in pairs(enemies) do
            damageTable.victim = enemy
            damageTable.damage = self.damage / #enemies
            ApplyDamage(damageTable)
        end

        -- Play effects
        self:PlayEffects3()

        -- remove thinker
        UTIL_Remove(self:GetParent())
    end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_invoker_sun_strike_lua_thinker:PlayEffects1()
    -- Get Resources
    local particle_cast = "particles/units/heroes/hero_invoker/invoker_sun_strike_team.vpcf"
    local sound_cast = "Hero_Invoker.SunStrike.Charge"

    -- Create Particle
    local effect_cast = ParticleManager:CreateParticleForTeam(particle_cast, PATTACH_WORLDORIGIN, self:GetCaster(), self:GetCaster():GetTeamNumber())
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetOrigin())
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 0, 0))
    ParticleManager:ReleaseParticleIndex(effect_cast)

    -- Create Sound
    EmitSoundOnLocationWithCaster(self:GetParent():GetOrigin(), sound_cast, self:GetCaster())
end

function modifier_invoker_sun_strike_lua_thinker:PlayEffects2()
    -- Get Resources
    local particle_cast = "particles/units/heroes/hero_invoker/invoker_sun_strike_team.vpcf"
    local sound_cast = "Hero_Invoker.SunStrike.Charge"

    -- Create Particle
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetOrigin())
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 0, 0))
    ParticleManager:ReleaseParticleIndex(effect_cast)

    -- Create Sound
    EmitSoundOnLocationWithCaster(self:GetParent():GetOrigin(), sound_cast, self:GetCaster())
end

function modifier_invoker_sun_strike_lua_thinker:PlayEffects3()
    -- Get Resources
    local particle_cast = "particles/units/heroes/hero_invoker/invoker_sun_strike.vpcf"
    local sound_cast = "Hero_Invoker.SunStrike.Ignite"

    -- Create Particle
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetOrigin())
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 0, 0))
    ParticleManager:ReleaseParticleIndex(effect_cast)

    -- Create Sound
    EmitSoundOnLocationWithCaster(self:GetParent():GetOrigin(), sound_cast, self:GetCaster())
end