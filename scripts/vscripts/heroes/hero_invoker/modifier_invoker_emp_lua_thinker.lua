--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_emp_pull_custom", "heroes/hero_invoker/modifier_invoker_emp_lua_thinker", LUA_MODIFIER_MOTION_NONE)

modifier_invoker_emp_lua_thinker = class({})

function modifier_invoker_emp_lua_thinker:IsHidden()
    return true
end

function modifier_invoker_emp_lua_thinker:IsPurgable()
    return false
end

function modifier_invoker_emp_lua_thinker:OnCreated(kv)
    if IsServer() then
        self.burn = self:GetAbility():GetSpecialValueFor("mana_burned")
        self.radius = self:GetAbility():GetSpecialValueFor("area_of_effect")
        self.damage_pct = self:GetAbility():GetSpecialValueFor("damage_per_mana_pct") / 100
        self.restore_pct = self:GetAbility():GetSpecialValueFor("restore_per_mana_pct") / 100
        self:PlayEffects1()
    end
end

function modifier_invoker_emp_lua_thinker:OnDestroy()
    if IsServer() then
        -- find caught units
        local enemies = FindUnitsInRadius(
        self:GetCaster():GetTeamNumber(), -- int, your team number
        self:GetParent():GetOrigin(), -- point, center point
        nil, -- handle, cacheUnit. (not known)
        self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
        DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
        DOTA_UNIT_TARGET_FLAG_MANA_ONLY, -- int, flag filter
        FIND_ANY_ORDER, -- int, order filter
        false	-- bool, can grow cache
        )
        
        if self:GetAbility() and not self:GetAbility():IsNull() then
            -- precache damage
            local damageTable = {
                -- victim = target,
                attacker = self:GetCaster(),
                -- damage = 500,
                damage_type = self:GetAbility():GetAbilityDamageType(),
                ability = self:GetAbility(), --Optional.
            }

            local burned = 0
            for _, enemy in pairs(enemies) do
                -- burn mana
                local mana_burn = math.min(enemy:GetMana(), self.burn)
                enemy:Script_ReduceMana(mana_burn, self:GetAbility())

                -- damage based on mana burned
                damageTable.victim = enemy
                damageTable.damage = mana_burn * self.damage_pct
                ApplyDamage(damageTable)

                -- sum mana burned
                burned = burned + mana_burn
            end

            -- give mana to caster
            self:GetCaster():GiveMana(burned * self.restore_pct)
        end

        -- play effects
        self:PlayEffects2()

        -- remove thinker
        UTIL_Remove(self:GetParent())
    end
end

function modifier_invoker_emp_lua_thinker:PlayEffects1()
    -- Get Resources
    local particle_cast = "particles/units/heroes/hero_invoker/invoker_emp.vpcf"
    local sound_cast = "Hero_Invoker.EMP.Charge"

    -- Create Particle
    self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(self.effect_cast, 0, self:GetParent():GetOrigin())
    ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.radius, 0, 0))
    -- ParticleManager:ReleaseParticleIndex( effect_cast )
    -- Create Sound
    self:GetCaster():EmitSound(sound_cast)
end

function modifier_invoker_emp_lua_thinker:PlayEffects2()
    -- Get Resources
    local sound_cast = "Hero_Invoker.EMP.Discharge"

    ParticleManager:DestroyParticle(self.effect_cast, false)
    ParticleManager:ReleaseParticleIndex(self.effect_cast)

    -- Create Sound
    self:GetCaster():EmitSound(sound_cast)
end

function modifier_invoker_emp_lua_thinker:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("area_of_effect")
end

function modifier_invoker_emp_lua_thinker:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_invoker_emp_lua_thinker:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_invoker_emp_lua_thinker:GetAuraDuration()
    return 0
end

function modifier_invoker_emp_lua_thinker:GetModifierAura()
    return "modifier_emp_pull_custom"
end

function modifier_invoker_emp_lua_thinker:IsAura()
    return self:GetCaster():HasShard()
end

modifier_emp_pull_custom = class({})

function modifier_emp_pull_custom:IsHidden() return true end
function modifier_emp_pull_custom:IsPurgable() return false end

function modifier_emp_pull_custom:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(FrameTime())
end

function modifier_emp_pull_custom:OnIntervalThink()
    if not IsServer() then return end
    if self:GetAuraOwner() == nil then return end
    if self:GetParent():IsCustomHasDebuffImmune() then return end
    if self:GetParent():IsInvulnerable() then return end
    local unit_location = self:GetParent():GetAbsOrigin()
    local vector_distance = self:GetAuraOwner():GetAbsOrigin() - unit_location
    local distance = (vector_distance):Length2D()
    local direction = (vector_distance):Normalized()

    if not self:GetParent():IsCurrentlyHorizontalMotionControlled() and not self:GetParent():IsCurrentlyVerticalMotionControlled() then
        if distance >= 50 then
            self:GetParent():SetAbsOrigin(unit_location + direction * (100 * FrameTime()))
        else
            self:GetParent():SetAbsOrigin(unit_location)
        end
    end
end

function modifier_emp_pull_custom:OnDestroy()
    if not IsServer() then return end
    if self:GetParent():IsCustomHasDebuffImmune() then return end
    if self:GetParent():IsInvulnerable() then return end
    if self:GetParent():IsCurrentlyHorizontalMotionControlled() then return end
    if self:GetParent():IsCurrentlyVerticalMotionControlled() then return end
    FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
end