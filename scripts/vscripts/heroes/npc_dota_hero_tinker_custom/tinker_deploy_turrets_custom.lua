--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tinker_deploy_turrets_custom", "heroes/npc_dota_hero_tinker_custom/tinker_deploy_turrets_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_tinker_deploy_turrets_custom_turret", "heroes/npc_dota_hero_tinker_custom/tinker_deploy_turrets_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_tinker_deploy_turrets_custom_handler", "heroes/npc_dota_hero_tinker_custom/tinker_deploy_turrets_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )

tinker_deploy_turrets_custom = class({})
tinker_deploy_turrets_custom.modifier_tinker_10_hp = {140,280,420}
tinker_deploy_turrets_custom.modifier_tinker_10 = {70,140,210}
tinker_deploy_turrets_custom.modifier_tinker_8 = {40,80,120}
tinker_deploy_turrets_custom.modifier_tinker_8_turret = {20,40,60}
tinker_deploy_turrets_custom.modifier_tinker_11 = 1.5
tinker_deploy_turrets_custom.modifier_tinker_13 = {0.2,0.4}
tinker_deploy_turrets_custom.modifier_tinker_12 = -0.4
tinker_deploy_turrets_custom.modifier_tinker_21 = 40

function tinker_deploy_turrets_custom:Precache(context)
    PrecacheResource( "model", "models/heroes/tinker/tinker_turret.vmdl", context )
end

function tinker_deploy_turrets_custom:GetAOERadius()
    return self:GetSpecialValueFor("drop_aoe_radius")
end

function tinker_deploy_turrets_custom:GetIntrinsicModifierName()
    return "modifier_tinker_deploy_turrets_custom_handler"
end

modifier_tinker_deploy_turrets_custom_handler = class({})
function modifier_tinker_deploy_turrets_custom_handler:IsHidden() return true end
function modifier_tinker_deploy_turrets_custom_handler:IsPurgable() return false end
function modifier_tinker_deploy_turrets_custom_handler:IsPurgeException() return false end
function modifier_tinker_deploy_turrets_custom_handler:RemoveOnDeath() return false end
function modifier_tinker_deploy_turrets_custom_handler:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
    }
end
function modifier_tinker_deploy_turrets_custom_handler:GetModifierTotalDamageOutgoing_Percentage()
    if self:GetParent().turret_damage and IsServer() then
        return self:GetAbility().modifier_tinker_21 - 100
    end
end
function modifier_tinker_deploy_turrets_custom_handler:GetAttackSound()
    if self:GetParent().turret_damage then
        return ""
    end
end
function tinker_deploy_turrets_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    CreateModifierThinker(self:GetCaster(), self, "modifier_tinker_deploy_turrets_custom", {}, point, self:GetCaster():GetTeamNumber(), false)
end

function tinker_deploy_turrets_custom:OnProjectileHit(target, vLocation)
    if not IsServer() then return end
    if not target then return end
    local radius_explosion = self:GetSpecialValueFor("radius_explosion")
    local damage = self:GetSpecialValueFor("missile_damage")
    if self:GetCaster():HasModifier("modifier_tinker_8") then
        damage = damage + self.modifier_tinker_8_turret[self:GetCaster():GetTalentLevel("modifier_tinker_8")]
    end
    if self:GetCaster():HasModifier("modifier_tinker_21") then
        self:GetCaster().turret_damage = true
        self:GetCaster():PerformAttack(target, true, true, true, true, false, true, true)
        self:GetCaster().turret_damage = nil
        damage = damage + (self:GetCaster():GetAverageTrueAttackDamage(nil) / 100 * self.modifier_tinker_21)
    end
    local damage_aoe = damage / 100 * self:GetSpecialValueFor("splash_pct")
    ApplyDamage({attacker = self:GetCaster(), victim = target, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, radius_explosion, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false)
    for _, unit in pairs(units) do
        if unit ~= target then
            ApplyDamage({attacker = self:GetCaster(), victim = unit, damage = damage_aoe, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
        end
    end
    target:EmitSound("Hero_TinkerTurret.Missile.Impact")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_tinker/turret_missile_explosion.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControlEnt(particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)
    return true
end

modifier_tinker_deploy_turrets_custom = class({})

function modifier_tinker_deploy_turrets_custom:OnCreated()
    if not IsServer() then return end
    self.point = self:GetParent():GetAbsOrigin()
    self.drop_aoe_radius = self:GetAbility():GetSpecialValueFor("drop_aoe_radius")
    self.turret_placement_radius = self:GetAbility():GetSpecialValueFor('turret_placement_radius')
    self.missile_target_range = self:GetAbility():GetSpecialValueFor("missile_target_range")
    self.base_interval = self:GetAbility():GetSpecialValueFor("missile_spawn_interval")
    self.proj_speed = self:GetAbility():GetSpecialValueFor("missile_speed")
    self.drop_damage = self:GetAbility():GetSpecialValueFor("drop_damage")
    self.missile_width = self:GetAbility():GetSpecialValueFor("missile_width")
    self.missile_range = self:GetAbility():GetSpecialValueFor("missile_range")
    self.drop_delay = self:GetAbility():GetSpecialValueFor("drop_delay")
    self.max_attacks = 3
    if self:GetCaster():HasModifier("modifier_tinker_12") then
        self.drop_delay = self.drop_delay + self:GetAbility().modifier_tinker_12
    end
    if self:GetCaster():HasModifier("modifier_tinker_8") then
        self.drop_damage = self.drop_damage + self:GetAbility().modifier_tinker_8[self:GetCaster():GetTalentLevel("modifier_tinker_8")]
    end
    if self:GetCaster():HasModifier("modifier_tinker_10") then
        self.missile_range = self.missile_range + self:GetAbility().modifier_tinker_10[self:GetCaster():GetTalentLevel("modifier_tinker_10")]
        self.missile_target_range = self.missile_target_range  + self:GetAbility().modifier_tinker_10[self:GetCaster():GetTalentLevel("modifier_tinker_10")]
    end
    
    self.spawned_turrets = false
    self.turrets = {}
    self.turrets_delays = {}
    self.turrets_attacks = {}
    self.interval = FrameTime()
    self.target = nil
    
    self.drop_particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_tinker/tinker_turret_drop.vpcf", PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( self.drop_particle, 0, self.point)
    ParticleManager:SetParticleControl( self.drop_particle, 1, Vector(self.drop_aoe_radius, 1, 1 ) )
    ParticleManager:SetParticleControl( self.drop_particle, 3, Vector(self.turret_placement_radius, 1, 1 ) )
    self:AddParticle( self.drop_particle, false, false, -1, false, false)
    self:GetParent():EmitSound("Hero_TinkerTurret.Drop.Falling")

    self.damageTable = {attacker = self:GetCaster(), ability = self:GetAbility(), damage_type = DAMAGE_TYPE_MAGICAL, damage = self.drop_damage}

    self.info = 
    {
        EffectName = "particles/units/heroes/hero_tinker/tinker_linear_missile.vpcf",
        Ability = self:GetAbility(),
        fStartRadius = self.missile_width,
        fEndRadius = self.missile_width,
        fDistance = self.missile_range,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
        bProvidesVision = true,
        bDeleteOnHit = true,
        iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
        iVisionRadius = self.missile_width*2,
    }

    self.attackers = 0

    self:StartIntervalThink(self.drop_delay)
end

function modifier_tinker_deploy_turrets_custom:OnIntervalThink()
    if not IsServer() then return end
    if not self.spawned_turrets then
        self:GetParent():EmitSound("Hero_TinkerTurret.Drop.Impact")
        if self.drop_particle then
            ParticleManager:DestroyParticle(self.drop_particle, true)
            ParticleManager:ReleaseParticleIndex(self.drop_particle)
        end

        local hit_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_tinker/tinker_turret_drop_impact.vpcf", PATTACH_WORLDORIGIN, nil )
        ParticleManager:SetParticleControl(hit_effect, 0, self.point)
        ParticleManager:ReleaseParticleIndex(hit_effect)

        local targets = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self.point, nil, self.drop_aoe_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false)
        if (self:GetCaster():GetAbsOrigin() - self.point):Length2D() <= self.drop_aoe_radius then
            table.insert(targets, self:GetCaster())
        end

        for _, target in pairs(targets) do
            local direction = (target:GetAbsOrigin() - self.point)
            direction.z = 0
            direction = direction:Normalized()
            if target:GetAbsOrigin() == self.point then
                direction = target:GetForwardVector()
            end
            FindClearSpaceForUnit(target, target:GetAbsOrigin(), false)
            local distance_knockback = self:GetAbility():GetSpecialValueFor("drop_knockback_distance")
            local duration = self:GetAbility():GetSpecialValueFor("drop_knockback_duration")
            if target == self:GetCaster() then
                distance_knockback = self:GetAbility():GetSpecialValueFor("drop_knockback_distance_tinker")
                duration = self:GetAbility():GetSpecialValueFor("drop_knockback_duration_tinker")
            else
                self.damageTable.victim = target
                ApplyDamage(self.damageTable)
            end
            target:AddNewModifier( caster, self, "modifier_generic_knockback_lua",
            { 
                direction_x = direction.x,
                direction_y = direction.y,
                distance = distance_knockback,
                height = 0, 
                duration = duration,
                IsStun = false,
                IsFlail = true,
                Purgable = 1,
            })
        end

        self.max = self:GetAbility():GetSpecialValueFor("turrets_per_drop")
        local line_position = self.point + self.turret_placement_radius * Vector(0, 1, 0)
        local duration = self:GetAbility():GetSpecialValueFor("turret_duration")
        if self:GetCaster():HasModifier("modifier_tinker_11") then
            duration = duration + self:GetAbility().modifier_tinker_11
            self.max_attacks = 4
        end
        if self:GetCaster():HasModifier("modifier_tinker_13") then
            self.max_attacks = 30
        end
        local turret_first_attack_delay = 1.1
        local turret_attack_delay = 0.4
        local turret_rest_delay = 0.7
        local turret_cycle_delay = ((self.max - 1) * turret_attack_delay) + turret_rest_delay

        if self:GetCaster():HasModifier("modifier_tinker_13") then
            turret_cycle_delay = turret_cycle_delay - self:GetAbility().modifier_tinker_13[self:GetCaster():GetTalentLevel("modifier_tinker_13")]
        end

        for i = 1, self.max do
            line_position = RotatePosition(self.point, QAngle(0, 360/self.max, 0), line_position)

            local effect = ParticleManager:CreateParticle( "particles/units/heroes/hero_tinker/tinker_turret_spawn.vpcf", PATTACH_WORLDORIGIN, nil )
            ParticleManager:SetParticleControl(effect, 0, line_position)
            ParticleManager:ReleaseParticleIndex(effect)

            local turret = CreateUnitByName( "npc_dota_tinker_turret"..self:GetAbility():GetLevel(), line_position, true, nil, nil, self:GetCaster():GetTeamNumber() )
            turret:SetAbsOrigin(line_position)
            turret:SetOwner(self:GetCaster())

            turret:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_tinker_deploy_turrets_custom_turret", {})
            turret:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_kill", {duration = (duration+1)})
            self.turrets[turret] = turret_first_attack_delay + (turret_attack_delay * (i - 1))
            self.turrets_delays[turret] = turret_cycle_delay
            self.turrets_attacks[turret] = 0

            if self:GetCaster():HasModifier("modifier_tinker_10") then
                local new_health = turret:GetBaseMaxHealth()
                new_health = new_health + self:GetAbility().modifier_tinker_10_hp[self:GetCaster():GetTalentLevel("modifier_tinker_10")]
                turret:SetBaseMaxHealth(new_health)
                turret:SetMaxHealth(new_health)
                turret:SetHealth(new_health)
            end
        end
        
        self.spawned_turrets = true
    else
        local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self.point, nil, self.missile_target_range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false)
        if #units <= 0 and self:GetCaster():HasModifier("modifier_tinker_11") then
            units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self.point, nil, self.missile_target_range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false)
        end
        self.target = units[1]
        local no_turrets = true
        for turret, _ in pairs(self.turrets) do
            if IsValidCustom(turret) and turret:IsAlive() then
                no_turrets = false
                if turret:IsStunned() then
                    if turret.attack_anim then
                        turret.attack_anim = nil
                        turret:FadeGesture(ACT_DOTA_ATTACK)
                    end
                elseif IsValidCustom(self.target) then
                    local vec = self.target:GetAbsOrigin() - turret:GetAbsOrigin()
                    turret:SetForceAttackTarget(self.target)
                    local attack_interval = self.base_interval
                    if self.turrets[turret] > 0 then
                        local interval = self.interval + FrameTime()
                        self.turrets[turret] = self.turrets[turret] - interval
                        if self.turrets[turret] <= 0.25 and not turret.attack_anim then
                            turret.attack_anim = true
                            turret:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1 / attack_interval)
                        end
                    end
                    if self.turrets[turret] <= 0 then
                        self.turrets_attacks[turret] = self.turrets_attacks[turret] + 1
                        self.turrets[turret] = self.turrets_delays[turret]
                        turret.attack_anim = nil
                        self.info.Source = turret
                        self.info.vVelocity = vec:Normalized() * self.proj_speed
                        self.info.vSpawnOrigin = turret:GetAttachmentOrigin(turret:ScriptLookupAttachment( "attach_attack1"))
                        turret:EmitSound("Hero_TinkerTurret.Missile.Spawn")
                        ProjectileManager:CreateLinearProjectile(self.info)
                    end
                end
                if self.turrets_attacks[turret] >= self.max_attacks then
                    self.turrets[turret] = 9999
                    turret.attack_anim = nil
                end
            end
        end
    end

    if no_turrets then
        self:Destroy()
        return
    end

    self:StartIntervalThink(self.interval)
end

modifier_tinker_deploy_turrets_custom_turret = class({})
function modifier_tinker_deploy_turrets_custom_turret:IsHidden() return true end
function modifier_tinker_deploy_turrets_custom_turret:IsPurgable() return false end
function modifier_tinker_deploy_turrets_custom_turret:OnCreated()
    if not IsServer() then return end
    self:GetParent():StartGesture(ACT_DOTA_SPAWN)
end
function modifier_tinker_deploy_turrets_custom_turret:CheckState()
    return
    {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true,
        [MODIFIER_STATE_ROOTED] = true,
        [MODIFIER_STATE_DISARMED] = true,
    }
end