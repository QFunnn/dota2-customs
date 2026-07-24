--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_death_prophet_exorcism_custom", "heroes/npc_dota_hero_death_prophet_custom/death_prophet_exorcism_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_death_prophet_exorcism_custom_unit", "heroes/npc_dota_hero_death_prophet_custom/death_prophet_exorcism_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_death_prophet_exorcism_custom_damage_cast", "heroes/npc_dota_hero_death_prophet_custom/death_prophet_exorcism_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_death_prophet_exorcism_custom_unit_talent", "heroes/npc_dota_hero_death_prophet_custom/death_prophet_exorcism_custom", LUA_MODIFIER_MOTION_NONE )

death_prophet_exorcism_custom = class({})

death_prophet_exorcism_custom.modifier_death_prophet_12 = {20,40,60}
death_prophet_exorcism_custom.modifier_death_prophet_11 = {50,100}
death_prophet_exorcism_custom.modifier_death_prophet_13 = {50,100}

function death_prophet_exorcism_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_death_prophet/death_prophet_spirit_glow.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_death_prophet/death_prophet_spirit_model.vpcf', context )
end

function death_prophet_exorcism_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")

    local modifier_death_prophet_exorcism_custom = self:GetCaster():FindModifierByName("modifier_death_prophet_exorcism_custom")
    if modifier_death_prophet_exorcism_custom then
        modifier_death_prophet_exorcism_custom:DeleteSpirits()
    end

    self:GetCaster():RemoveModifierByName("modifier_death_prophet_exorcism_custom")
    self:GetCaster():EmitSound("Hero_DeathProphet.Exorcism.Cast")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_death_prophet_exorcism_custom", {duration = duration})
end

function death_prophet_exorcism_custom:GetIntrinsicModifierName()
    return "modifier_death_prophet_exorcism_custom_damage_cast"
end

function death_prophet_exorcism_custom:CastGhostToTarget(target, bonus_damage)
    if not IsServer() then return end
    local unit = CreateUnitByName("npc_dota_companion", self:GetCaster():GetAbsOrigin(), true, nil, nil, self:GetCaster():GetTeamNumber())
    unit.numberOfHits = 0
    unit.current_target = target
    unit:AddNewModifier(self:GetCaster(), self, "modifier_death_prophet_exorcism_custom_unit_talent", {bonus_damage = bonus_damage})
end

modifier_death_prophet_exorcism_custom = class({})

function modifier_death_prophet_exorcism_custom:IsPurgable() return false end
function modifier_death_prophet_exorcism_custom:DestroyOnExpire() return false end

function modifier_death_prophet_exorcism_custom:OnCreated()
    if not IsServer() then return end
    self.spirits = {}
    self.spirits_entindex = {}
    self.last_targeted = nil
    local ghost_spawn_rate = self:GetAbility():GetSpecialValueFor("ghost_spawn_rate")
    local spirits = self:GetAbility():GetSpecialValueFor("spirits")

    local parent = self:GetParent()

    self:GetCaster():EmitSound("Hero_DeathProphet.Exorcism")

    for i=1,spirits do
        Timers:CreateTimer(i * ghost_spawn_rate, function()
            if not parent:HasModifier("modifier_death_prophet_exorcism_custom") then return end
            local unit = CreateUnitByName("npc_dota_companion", self:GetCaster():GetAbsOrigin(), true, nil, nil, self:GetCaster():GetTeamNumber())
            unit.numberOfHits = 0
            unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_death_prophet_exorcism_custom_unit", {duration = 60})
            table.insert(self.spirits, unit)
            table.insert(self.spirits_entindex, unit:entindex())
        end)
    end

    self:StartIntervalThink(ghost_spawn_rate * spirits)
end

function modifier_death_prophet_exorcism_custom:OnIntervalThink()
    if not IsServer() then return end
    self:StartIntervalThink(FrameTime())
    if self.spirits_entindex and #self.spirits_entindex <= 0 then self:Destroy() end
    if self:GetRemainingTime() <= 0 then
        for _, spirit in pairs(self.spirits) do
            if spirit and not spirit:IsNull() then
                spirit.state = "end"
            end
        end
        self.last_targeted = nil
    end
end

function modifier_death_prophet_exorcism_custom:DeleteSpirits()
    if not IsServer() then return end

    self:GetCaster():StopSound("Hero_DeathProphet.Exorcism")

    for _, spirit in pairs(self.spirits) do
        if spirit and not spirit:IsNull() then
            spirit:SetPhysicsVelocity(Vector(0,0,0))
            spirit:OnPhysicsFrame(nil)
            spirit:ForceKill(false)
        end
    end
end

function modifier_death_prophet_exorcism_custom:OnDestroy()
    if not IsServer() then return end

    self:GetCaster():StopSound("Hero_DeathProphet.Exorcism")

    if not self:GetParent():IsAlive() then
        for _, spirit in pairs(self.spirits) do
            if spirit and not spirit:IsNull() then
                spirit:SetPhysicsVelocity(Vector(0,0,0))
                spirit:OnPhysicsFrame(nil)
                spirit:ForceKill(false)
            end
        end
        return
    end

    self.last_targeted = nil
end

function modifier_death_prophet_exorcism_custom:DeclareFunctions()
    return 
    {
        MODIFIER_EVENT_ON_ATTACK
    }
end

function modifier_death_prophet_exorcism_custom:OnAttack(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.target == self:GetParent() then return end
    self.last_targeted = params.target
end

modifier_death_prophet_exorcism_custom_unit = class({})

function modifier_death_prophet_exorcism_custom_unit:IsHidden() return true end
function modifier_death_prophet_exorcism_custom_unit:IsPurgable() return false end
function modifier_death_prophet_exorcism_custom_unit:IsPurgeException() return false end

function modifier_death_prophet_exorcism_custom_unit:OnCreated()
    if not IsServer() then return end
    
    self:GetParent().pSpiritGlow = ParticleManager:CreateParticle( "particles/units/heroes/hero_death_prophet/death_prophet_spirit_glow.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( self:GetParent().pSpiritGlow, 0, self:GetParent():GetAbsOrigin() )
    ParticleManager:SetParticleControl( self:GetParent().pSpiritGlow, 1, self:GetParent():GetAbsOrigin() )  

    self:GetParent().pSpiritModel = ParticleManager:CreateParticle( "particles/units/heroes/hero_death_prophet/death_prophet_spirit_model.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( self:GetParent().pSpiritModel , 0, self:GetParent():GetAbsOrigin() )
    ParticleManager:SetParticleControl( self:GetParent().pSpiritModel , 1, self:GetParent():GetAbsOrigin() )    
    ParticleManager:SetParticleControl( self:GetParent().pSpiritModel , 2, self:GetParent():GetAbsOrigin() )

    local caster = self:GetCaster()
    local unit = self:GetParent()
    local ability = self:GetAbility()
    local radius = self:GetAbility():GetSpecialValueFor("radius")
    local duration = self:GetAbility():GetSpecialValueFor("duration")
    local spirit_speed = self:GetAbility():GetSpecialValueFor("spirit_speed")
    local min_damage = self:GetAbility():GetSpecialValueFor("min_damage")
    local max_damage = self:GetAbility():GetSpecialValueFor("max_damage")
    local average_damage = self:GetAbility():GetSpecialValueFor("average_damage")

    if self:GetCaster():HasModifier("modifier_death_prophet_12") then
        min_damage = min_damage + self:GetAbility().modifier_death_prophet_12[self:GetCaster():GetTalentLevel("modifier_death_prophet_12")]
        max_damage = max_damage + self:GetAbility().modifier_death_prophet_12[self:GetCaster():GetTalentLevel("modifier_death_prophet_12")]
        average_damage = average_damage + self:GetAbility().modifier_death_prophet_12[self:GetCaster():GetTalentLevel("modifier_death_prophet_12")]
    end

    local give_up_distance = self:GetAbility():GetSpecialValueFor("give_up_distance")
    local max_distance = self:GetAbility():GetSpecialValueFor("max_distance")
    local heal_percent = self:GetAbility():GetSpecialValueFor("heal_percent") * 0.01
    local min_time_between_attacks = 3
    local abilityDamageType = self:GetAbility():GetAbilityDamageType()
    if self:GetCaster():HasModifier("modifier_death_prophet_21") then
        abilityDamageType = DAMAGE_TYPE_MAGICAL
    end
    local abilityTargetType = self:GetAbility():GetAbilityTargetType()
    local particleDamage = "particles/units/heroes/hero_death_prophet/death_prophet_exorcism_attack.vpcf"
    local particleDamageBuilding = "particles/units/heroes/hero_death_prophet/death_prophet_exorcism_attack_building.vpcf"

    self.index = self:GetParent():entindex()

    Physics:Unit(unit)
    unit:PreventDI(true)
    unit:SetAutoUnstuck(false)
    unit:SetNavCollisionType(PHYSICS_NAV_NOTHING)
    unit:FollowNavMesh(false)
    unit:SetPhysicsVelocityMax(spirit_speed)
    unit:SetPhysicsVelocity(spirit_speed * RandomVector(1))
    unit:SetPhysicsFriction(0)
    unit:Hibernate(false)
    unit:SetGroundBehavior(PHYSICS_GROUND_LOCK)

    unit.state = "acquiring"

    local frameCount = 0
    unit.damage_done = 0
    unit.last_attack_time = GameRules:GetGameTime() - min_time_between_attacks

    local pathColor = Vector(255,255,255)
    local targetColor = Vector(255,0,0)
    local idleColor = Vector(0,255,0)
    local returnColor = Vector(0,0,255)
    local endColor = Vector(0,0,0)
    local draw_duration = 3

    local point = caster:GetAbsOrigin() + RandomVector(RandomInt(radius/2, radius))
    point.z = GetGroundHeight(point,nil)

    unit:OnPhysicsFrame(function(unit)

        unit:SetForwardVector( ( unit:GetPhysicsVelocity() ):Normalized() )

        local source = caster:GetAbsOrigin()
        local current_position = unit:GetAbsOrigin()

        local enemies = nil

        frameCount = (frameCount + 1) % 3

        local diff = point - unit:GetAbsOrigin()
        diff.z = 0
        local direction = diff:Normalized()

        local angle_difference = RotationDelta(VectorToAngles(unit:GetPhysicsVelocity():Normalized()), VectorToAngles(direction)).y

        if math.abs(angle_difference) < 5 then
            local newVel = unit:GetPhysicsVelocity():Length() * direction
            unit:SetPhysicsVelocity(newVel)
        elseif angle_difference > 0 then
            local newVel = RotatePosition(Vector(0,0,0), QAngle(0,10,0), unit:GetPhysicsVelocity())
            unit:SetPhysicsVelocity(newVel)
        else        
            local newVel = RotatePosition(Vector(0,0,0), QAngle(0,-10,0), unit:GetPhysicsVelocity())
            unit:SetPhysicsVelocity(newVel)
        end

        local distance = (point - current_position):Length()
        local collision = distance < 50

        local distance_to_caster = (source - current_position):Length()
        if distance > max_distance then 
            unit:SetAbsOrigin(source)
            unit.state = "acquiring" 
        end

        if unit.state == "acquiring" then
            local time_between_last_attack = GameRules:GetGameTime() - unit.last_attack_time
            if time_between_last_attack >= min_time_between_attacks then
                enemies = FindUnitsInRadius(caster:GetTeamNumber(), source, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, abilityTargetType, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)

                local last_targeted = nil
                
                local modifier_targeted = self:GetCaster():FindModifierByName("modifier_death_prophet_exorcism_custom")

                if modifier_targeted then
                    last_targeted = modifier_targeted.last_targeted
                    modifier_targeted.last_targeted = nil
                end
 
                local target_enemy = nil

                for _,enemy in pairs(enemies) do
                    if last_targeted and enemy == last_targeted then
                        target_enemy = enemy
                    end
                end

                if not target_enemy then
                    target_enemy = enemies[RandomInt(1, #enemies)]
                end

                if target_enemy then
                    unit.state = "target_acquired"
                    unit.current_target = target_enemy
                    point = unit.current_target:GetAbsOrigin()
                else
                    unit.state = "target_acquired"
                    unit.current_target = nil
                    unit.idling = true
                    point = source + RandomVector(RandomInt(radius/2, radius))
                    point.z = GetGroundHeight(point,nil)
                end
            else
                unit.state = "target_acquired"
                unit.current_target = nil
                unit.idling = true
                point = source + RandomVector(RandomInt(radius/2, radius))
                point.z = GetGroundHeight(point,nil)
            end     
        elseif unit.state == "target_acquired" then

            if unit.current_target and not unit.current_target:IsNull() and unit.current_target:IsAlive() then
                point = unit.current_target:GetAbsOrigin()
            else
                unit.current_target = nil
            end

            if distance_to_caster > give_up_distance then
                unit.state = "acquiring"
            end

            if collision then
                if unit.current_target ~= nil then
                    if not unit.current_target:IsAttackImmune() or self:GetCaster():HasModifier("modifier_death_prophet_21") then
                        local damage_table = {}
                        local spirit_damage = RandomInt(min_damage,max_damage)
                        damage_table.victim = unit.current_target
                        damage_table.attacker = caster                  
                        damage_table.damage_type = abilityDamageType
                        damage_table.damage = spirit_damage
                        damage_table.ability = self:GetAbility()
                        ApplyDamage(damage_table)
                        local targetArmor = unit.current_target:GetPhysicalArmorValue(false)
                        local damageReduction = ((0.06 * targetArmor) / (1 + 0.06 * targetArmor))
                        local damagePostReduction = spirit_damage * (1 - damageReduction)
                        unit.damage_done = unit.damage_done + damagePostReduction
                        if unit.current_target.InvulCount == 0 then
                            local particle = ParticleManager:CreateParticle(particleDamageBuilding, PATTACH_ABSORIGIN, unit.current_target)
                            ParticleManager:SetParticleControl(particle, 0, unit.current_target:GetAbsOrigin())
                            ParticleManager:SetParticleControlEnt(particle, 1, unit.current_target, PATTACH_POINT_FOLLOW, "attach_hitloc", unit.current_target:GetAbsOrigin(), true)
                        elseif unit.damage_done > 0 then
                            local particle = ParticleManager:CreateParticle(particleDamage, PATTACH_ABSORIGIN, unit.current_target)
                            ParticleManager:SetParticleControl(particle, 0, unit.current_target:GetAbsOrigin())
                            ParticleManager:SetParticleControlEnt(particle, 1, unit.current_target, PATTACH_POINT_FOLLOW, "attach_hitloc", unit.current_target:GetAbsOrigin(), true)
                        end
                        unit.numberOfHits = unit.numberOfHits + 1 
                        unit.current_target:EmitSound("Hero_DeathProphet.Exorcism.Damage")
                        unit.state = "returning"
                        point = source
                        unit.last_attack_time = GameRules:GetGameTime()
                    end
                else
                    if RollPercentage(50) then
                        unit.state = "acquiring"
                    else
                        unit.state = "returning"
                        point = source
                    end
                end
            end
        elseif unit.state == "returning" then
            point = source
            if collision then 
                unit.state = "acquiring"
            end 
        elseif unit.state == "end" then
            point = source
            if collision then 
                local heal_done =  unit.numberOfHits * average_damage* heal_percent
                caster:Heal(heal_done, ability)
                caster:EmitSound("Hero_DeathProphet.Exorcism.Heal")
                unit:SetPhysicsVelocity(Vector(0,0,0))
                unit:OnPhysicsFrame(nil)
                unit:ForceKill(false)
            end
        end
    end)
end

function modifier_death_prophet_exorcism_custom_unit:OnDestroy()
    if not IsServer() then return end
    local modifier_death_prophet_exorcism_custom = self:GetCaster():FindModifierByName("modifier_death_prophet_exorcism_custom")
    if modifier_death_prophet_exorcism_custom then
        for count = #modifier_death_prophet_exorcism_custom.spirits_entindex, 1, -1 do
            if modifier_death_prophet_exorcism_custom.spirits_entindex[count] and modifier_death_prophet_exorcism_custom.spirits_entindex[count] == self.index then
                table.remove(modifier_death_prophet_exorcism_custom.spirits_entindex, count)
            end
        end
    end 
    ParticleManager:DestroyParticle( self:GetParent().pSpiritGlow, false )
    ParticleManager:DestroyParticle( self:GetParent().pSpiritModel , false )

    if self:GetParent():IsAlive() then
        self:GetParent():ForceKill(false)
    end
end

function modifier_death_prophet_exorcism_custom_unit:CheckState()
    return 
    {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        [MODIFIER_STATE_FLYING] = true,
        [MODIFIER_STATE_DISARMED] = true,
    }
end


modifier_death_prophet_exorcism_custom_damage_cast = class({})

function modifier_death_prophet_exorcism_custom_damage_cast:IsHidden() return true end
function modifier_death_prophet_exorcism_custom_damage_cast:IsPurgable() return false end

function modifier_death_prophet_exorcism_custom_damage_cast:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_death_prophet_exorcism_custom_damage_cast:OnTakeDamage(params)
    if not IsServer() then return end
    if params.unit == self:GetParent() then return end
    if params.attacker ~= self:GetParent() then return end
    if self:GetCaster():HasModifier("modifier_death_prophet_1") then return end
    if self:GetParent():HasModifier("modifier_death_prophet_13") and params.inflictor == nil then
        self:GetAbility():CastGhostToTarget(params.unit, self:GetAbility().modifier_death_prophet_13[self:GetCaster():GetTalentLevel("modifier_death_prophet_13")])
    end
end

function modifier_death_prophet_exorcism_custom_damage_cast:GetModifierMoveSpeedBonus_Percentage()
    if self:GetCaster():HasModifier("modifier_death_prophet_1") then return end
    if self:GetCaster():HasModifier("modifier_death_prophet_exorcism_custom") then
        return self:GetAbility():GetSpecialValueFor("movement_bonus")
    end
end

modifier_death_prophet_exorcism_custom_unit_talent = class({})

function modifier_death_prophet_exorcism_custom_unit_talent:IsHidden() return true end
function modifier_death_prophet_exorcism_custom_unit_talent:IsPurgable() return false end
function modifier_death_prophet_exorcism_custom_unit_talent:IsPurgeException() return false end

function modifier_death_prophet_exorcism_custom_unit_talent:OnCreated(params)
    if not IsServer() then return end
    
    self:GetParent().pSpiritGlow = ParticleManager:CreateParticle( "particles/units/heroes/hero_death_prophet/death_prophet_spirit_glow.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( self:GetParent().pSpiritGlow, 0, self:GetParent():GetAbsOrigin() )
    ParticleManager:SetParticleControl( self:GetParent().pSpiritGlow, 1, self:GetParent():GetAbsOrigin() )  

    self:GetParent().pSpiritModel = ParticleManager:CreateParticle( "particles/units/heroes/hero_death_prophet/death_prophet_spirit_model.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( self:GetParent().pSpiritModel , 0, self:GetParent():GetAbsOrigin() )
    ParticleManager:SetParticleControl( self:GetParent().pSpiritModel , 1, self:GetParent():GetAbsOrigin() )    
    ParticleManager:SetParticleControl( self:GetParent().pSpiritModel , 2, self:GetParent():GetAbsOrigin() )

    local caster = self:GetCaster()
    local unit = self:GetParent()
    local ability = self:GetAbility()
    local radius = self:GetAbility():GetSpecialValueFor("radius")
    local duration = self:GetAbility():GetSpecialValueFor("duration")
    local spirit_speed = self:GetAbility():GetSpecialValueFor("spirit_speed")
    local min_damage = self:GetAbility():GetSpecialValueFor("min_damage")
    local max_damage = self:GetAbility():GetSpecialValueFor("max_damage")
    local average_damage = self:GetAbility():GetSpecialValueFor("average_damage")

    if self:GetCaster():HasModifier("modifier_death_prophet_12") then
        min_damage = min_damage + self:GetAbility().modifier_death_prophet_12[self:GetCaster():GetTalentLevel("modifier_death_prophet_12")]
        max_damage = max_damage + self:GetAbility().modifier_death_prophet_12[self:GetCaster():GetTalentLevel("modifier_death_prophet_12")]
        average_damage = average_damage + self:GetAbility().modifier_death_prophet_12[self:GetCaster():GetTalentLevel("modifier_death_prophet_12")]
    end

    min_damage = min_damage + (min_damage / 100 * params.bonus_damage)
    max_damage = max_damage + (max_damage / 100 * params.bonus_damage)
    average_damage = average_damage + (average_damage / 100 * params.bonus_damage)

    local give_up_distance = self:GetAbility():GetSpecialValueFor("give_up_distance")
    local max_distance = self:GetAbility():GetSpecialValueFor("max_distance")
    local heal_percent = self:GetAbility():GetSpecialValueFor("heal_percent") * 0.01
    local min_time_between_attacks = 3
    local abilityDamageType = self:GetAbility():GetAbilityDamageType()
    if self:GetCaster():HasModifier("modifier_death_prophet_21") then
        abilityDamageType = DAMAGE_TYPE_MAGICAL
    end
    local abilityTargetType = self:GetAbility():GetAbilityTargetType()
    local particleDamage = "particles/units/heroes/hero_death_prophet/death_prophet_exorcism_attack.vpcf"
    local particleDamageBuilding = "particles/units/heroes/hero_death_prophet/death_prophet_exorcism_attack_building.vpcf"

    self.index = self:GetParent():entindex()

    Physics:Unit(unit)
    unit:PreventDI(true)
    unit:SetAutoUnstuck(false)
    unit:SetNavCollisionType(PHYSICS_NAV_NOTHING)
    unit:FollowNavMesh(false)
    unit:SetPhysicsVelocityMax(spirit_speed)
    unit:SetPhysicsVelocity(spirit_speed * RandomVector(1))
    unit:SetPhysicsFriction(0)
    unit:Hibernate(false)
    unit:SetGroundBehavior(PHYSICS_GROUND_LOCK)

    unit.state = "acquiring"

    local frameCount = 0
    unit.damage_done = 0
    unit.last_attack_time = GameRules:GetGameTime() - min_time_between_attacks

    local pathColor = Vector(255,255,255)
    local targetColor = Vector(255,0,0)
    local idleColor = Vector(0,255,0)
    local returnColor = Vector(0,0,255)
    local endColor = Vector(0,0,0)
    local draw_duration = 3

    local point = caster:GetAbsOrigin() + RandomVector(RandomInt(radius/2, radius))
    point.z = GetGroundHeight(point,nil)

    unit:OnPhysicsFrame(function(unit)

        unit:SetForwardVector( ( unit:GetPhysicsVelocity() ):Normalized() )

        local source = caster:GetAbsOrigin()
        local current_position = unit:GetAbsOrigin()

        local enemies = nil

        frameCount = (frameCount + 1) % 3

        local diff = point - unit:GetAbsOrigin()
        diff.z = 0
        local direction = diff:Normalized()

        local angle_difference = RotationDelta(VectorToAngles(unit:GetPhysicsVelocity():Normalized()), VectorToAngles(direction)).y

        if math.abs(angle_difference) < 5 then
            local newVel = unit:GetPhysicsVelocity():Length() * direction
            unit:SetPhysicsVelocity(newVel)
        elseif angle_difference > 0 then
            local newVel = RotatePosition(Vector(0,0,0), QAngle(0,10,0), unit:GetPhysicsVelocity())
            unit:SetPhysicsVelocity(newVel)
        else        
            local newVel = RotatePosition(Vector(0,0,0), QAngle(0,-10,0), unit:GetPhysicsVelocity())
            unit:SetPhysicsVelocity(newVel)
        end

        local distance = (point - current_position):Length()
        local collision = distance < 50

        local distance_to_caster = (source - current_position):Length()
        if distance > max_distance then 
            unit:SetAbsOrigin(source)
            unit.state = "acquiring" 
        end

        if unit.state == "acquiring" then
            local time_between_last_attack = GameRules:GetGameTime() - unit.last_attack_time
            if time_between_last_attack >= min_time_between_attacks then
                local target_enemy = self:GetParent().current_target

                if target_enemy then
                    unit.state = "target_acquired"
                    unit.current_target = target_enemy
                    point = unit.current_target:GetAbsOrigin()
                else
                    unit.state = "target_acquired"
                    unit.current_target = nil
                    unit.idling = true
                    point = source + RandomVector(RandomInt(radius/2, radius))
                    point.z = GetGroundHeight(point,nil)
                end
            else
                unit.state = "target_acquired"
                unit.current_target = nil
                unit.idling = true
                point = source + RandomVector(RandomInt(radius/2, radius))
                point.z = GetGroundHeight(point,nil)
            end     
        elseif unit.state == "target_acquired" then

            if unit.current_target and not unit.current_target:IsNull() and unit.current_target:IsAlive() then
                point = unit.current_target:GetAbsOrigin()
            else
                unit.current_target = nil
            end

            if distance_to_caster > give_up_distance then
                unit.state = "acquiring"
            end

            if collision then
                if unit.current_target ~= nil then
                    if not unit.current_target:IsAttackImmune() or self:GetCaster():HasModifier("modifier_death_prophet_21") then
                        local damage_table = {}
                        local spirit_damage = RandomInt(min_damage,max_damage)
                        damage_table.victim = unit.current_target
                        damage_table.attacker = caster                  
                        damage_table.damage_type = abilityDamageType
                        damage_table.damage = spirit_damage
                        damage_table.ability = self:GetAbility()
                        ApplyDamage(damage_table)
                        local targetArmor = unit.current_target:GetPhysicalArmorValue(false)
                        local damageReduction = ((0.06 * targetArmor) / (1 + 0.06 * targetArmor))
                        local damagePostReduction = spirit_damage * (1 - damageReduction)
                        unit.damage_done = unit.damage_done + damagePostReduction
                        if unit.current_target.InvulCount == 0 then
                            local particle = ParticleManager:CreateParticle(particleDamageBuilding, PATTACH_ABSORIGIN, unit.current_target)
                            ParticleManager:SetParticleControl(particle, 0, unit.current_target:GetAbsOrigin())
                            ParticleManager:SetParticleControlEnt(particle, 1, unit.current_target, PATTACH_POINT_FOLLOW, "attach_hitloc", unit.current_target:GetAbsOrigin(), true)
                        elseif unit.damage_done > 0 then
                            local particle = ParticleManager:CreateParticle(particleDamage, PATTACH_ABSORIGIN, unit.current_target)
                            ParticleManager:SetParticleControl(particle, 0, unit.current_target:GetAbsOrigin())
                            ParticleManager:SetParticleControlEnt(particle, 1, unit.current_target, PATTACH_POINT_FOLLOW, "attach_hitloc", unit.current_target:GetAbsOrigin(), true)
                        end
                        unit.numberOfHits = unit.numberOfHits + 1 
                        unit.current_target:EmitSound("Hero_DeathProphet.Exorcism.Damage")
                        unit.state = "end"
                        point = source
                        unit.last_attack_time = GameRules:GetGameTime()
                    end
                else
                    if RollPercentage(50) then
                        point = source
                        unit.state = "end"
                    else
                        point = source
                        unit.state = "end"
                    end
                end
            end
        elseif unit.state == "returning" then
            point = source
            if collision then 
                unit.state = "acquiring"
            end 
        elseif unit.state == "end" then
            point = source
            if collision then 
                local heal_done =  unit.numberOfHits * average_damage* heal_percent
                caster:Heal(heal_done, ability)
                caster:EmitSound("Hero_DeathProphet.Exorcism.Heal")
                unit:SetPhysicsVelocity(Vector(0,0,0))
                unit:OnPhysicsFrame(nil)
                unit:ForceKill(false)
            end
        end
    end)
end

function modifier_death_prophet_exorcism_custom_unit_talent:OnDestroy()
    if not IsServer() then return end
    ParticleManager:DestroyParticle( self:GetParent().pSpiritGlow, false )
    ParticleManager:DestroyParticle( self:GetParent().pSpiritModel , false )
end

function modifier_death_prophet_exorcism_custom_unit_talent:CheckState()
    return 
    {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_FLYING] = true,
        [MODIFIER_STATE_DISARMED] = true,
    }
end