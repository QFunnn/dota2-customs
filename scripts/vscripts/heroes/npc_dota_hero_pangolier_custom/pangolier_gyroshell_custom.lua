--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pangolier_gyroshell_custom", "heroes/npc_dota_hero_pangolier_custom/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_rollup", "heroes/npc_dota_hero_pangolier_custom/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_stunned", "heroes/npc_dota_hero_pangolier_custom/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_stop", "heroes/npc_dota_hero_pangolier_custom/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_VERTICAL)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_damage_cd", "heroes/npc_dota_hero_pangolier_custom/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_shard_damage_cd", "heroes/npc_dota_hero_pangolier_custom/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_turn_boost", "heroes/npc_dota_hero_pangolier_custom/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_pangolier_gyroshell_custom_unbugged", "heroes/npc_dota_hero_pangolier_custom/pangolier_gyroshell_custom", LUA_MODIFIER_MOTION_NONE)

pangolier_gyroshell_custom = class({})
pangolier_gyroshell_custom.modifier_pangolier_18 = {-15,-25,-35}
pangolier_gyroshell_custom.modifier_pangolier_20 = {50,100}

function pangolier_gyroshell_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_gyroshell_cast.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_gyroshell.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_blast_off_trail.vpcf", context)
    PrecacheResource("model", "models/heroes/pangolier/pangolier_gyroshell2.vmdl", context)
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_pangolier.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_pangolier.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_pangolier.vpcf", context)
end

function pangolier_gyroshell_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_pangolier_18") then
        bonus = self.modifier_pangolier_18[self:GetCaster():GetTalentLevel("modifier_pangolier_18")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function pangolier_gyroshell_custom:OnAbilityPhaseStart()
    local caster = self:GetCaster()
    caster:EmitSound("Hero_Pangolier.Gyroshell.Cast")
    caster:StartGesture(ACT_DOTA_CAST_ABILITY_4)
    self.cast_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_gyroshell_cast.vpcf", PATTACH_CUSTOMORIGIN, caster)
    ParticleManager:SetParticleControlEnt( self.cast_effect, 0, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true )
    ParticleManager:SetParticleControlEnt( self.cast_effect, 3, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true )
    ParticleManager:SetParticleControlForward( self.cast_effect, 0,  caster:GetForwardVector())
    ParticleManager:SetParticleControlForward( self.cast_effect, 3,  caster:GetForwardVector())
    return true
end

function pangolier_gyroshell_custom:OnAbilityPhaseInterrupted()
    local caster = self:GetCaster()
    if self.cast_effect then
        ParticleManager:DestroyParticle(self.cast_effect, true)
        ParticleManager:ReleaseParticleIndex(self.cast_effect)
        caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
        caster:StopSound("Hero_Pangolier.Gyroshell.Cast")
    end
end

function pangolier_gyroshell_custom:GetBehavior()
    local pangolier_shield_crash_custom = self:GetCaster():FindAbilityByName("pangolier_shield_crash_custom")
    if self:GetCaster():HasModifier("modifier_pangolier_18") and pangolier_shield_crash_custom and pangolier_shield_crash_custom:GetLevel() > 0 then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
end

function pangolier_gyroshell_custom:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    local pangolier_shield_crash_custom = self:GetCaster():FindAbilityByName("pangolier_shield_crash_custom")
    if self:GetCaster():HasModifier("modifier_pangolier_18") and pangolier_shield_crash_custom and pangolier_shield_crash_custom:GetLevel() > 0 then
        caster:Purge(false, true, false, false, false)
        self:EndCooldown()
        pangolier_shield_crash_custom:OnSpellStart(self, duration)
        return
    end
    caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
    if self.cast_effect then
        ParticleManager:DestroyParticle(self.cast_effect, true)
        ParticleManager:ReleaseParticleIndex(self.cast_effect)
    end
    local point = caster:GetAbsOrigin() + caster:GetForwardVector()
    caster:Purge(false, true, false, false, false)
    caster:AddNewModifier(caster, self, "modifier_pangolier_gyroshell_custom", {duration = duration, original = 1})
end

pangolier_gyroshell_stop_custom = class({})

function pangolier_gyroshell_stop_custom:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():RemoveModifierByName("modifier_pangolier_gyroshell")
    self:GetCaster():RemoveModifierByName("modifier_pangolier_gyroshell_custom")
end

modifier_pangolier_gyroshell_custom = class({})
function modifier_pangolier_gyroshell_custom:IsPurgable() return false end
function modifier_pangolier_gyroshell_custom:IsHidden() return false end
function modifier_pangolier_gyroshell_custom:DestroyOnExpire()
    if self:GetParent():HasModifier("modifier_generic_arc_lua") then return false end
    return true
end
function modifier_pangolier_gyroshell_custom:OnCreated(table)
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.max_speed = self.ability:GetSpecialValueFor("forward_move_speed")
    if self:GetCaster():HasModifier("modifier_pangolier_20") then
        self.max_speed = self.max_speed + self:GetAbility().modifier_pangolier_20[self:GetCaster():GetTalentLevel("modifier_pangolier_20")]
    end
    if not IsServer() then return end
    self.parent:SwapAbilities("pangolier_gyroshell_custom", "pangolier_gyroshell_stop_custom", false, true)
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_gyroshell_custom_turn_boost", {duration = self.ability:GetSpecialValueFor("jump_recover_time")})
    self.parent:RemoveModifierByName("modifier_pangolier_gyroshell_custom_heal")
    
    local shard = self.parent:FindModifierByName("modifier_pangolier_rollup_custom")
    if shard then 
        shard.early_stop = true 
        shard:Destroy()
    end

    local pangolier_shield_crash_custom = self:GetParent():FindAbilityByName("pangolier_shield_crash_custom")
    if pangolier_shield_crash_custom and not pangolier_shield_crash_custom:IsCooldownReady() then
        if pangolier_shield_crash_custom:GetCooldownTimeRemaining() > self:GetAbility():GetSpecialValueFor("shield_crash_cooldown") then
            pangolier_shield_crash_custom:EndCooldown()
            pangolier_shield_crash_custom:StartCooldown(self:GetAbility():GetSpecialValueFor("shield_crash_cooldown"))
        end
    end
    
    self:GetAbility():SetActivated(false)
    self.parent:Stop()
    
    self.cast_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_gyroshell.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
    ParticleManager:SetParticleControlEnt( self.cast_effect, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
    self:AddParticle(self.cast_effect,false, false, -1, false, false)
    
    self.parent:EmitSound("Hero_Pangolier.Gyroshell.Loop")
    self.parent:EmitSound("Hero_Pangolier.Gyroshell.Layer")

    self.acceleration = 350
    self.deceleration = 500
    self.turn_rate_min = self.ability:GetSpecialValueFor("turn_rate")
    self.turn_rate_max = self.ability:GetSpecialValueFor("turn_rate")

    if self:GetCaster():HasModifier("modifier_pangolier_20") then
        self.turn_rate_min = self.turn_rate_min * 1.4
        self.turn_rate_max = self.turn_rate_max * 1.4
    end

    self.flCurrentSpeed = self.max_speed
    self.flDespawnTime = 0.5
    self.nTreeDestroyRadius = 75
    self.bMaxSpeedNotified = false
    self.bCrashScheduled = false
    self.hCrashScheduledUnit = nil
    if self.parent.flDesiredYaw == nil then
        self.parent.flDesiredYaw = self.parent:GetAnglesAsVector().y
    end
    self:StartIntervalThink( 0.01 )
end

function modifier_pangolier_gyroshell_custom:OnDestroy()
    if not IsServer() then return end
    local parent = self:GetParent()
    if not parent:HasModifier("modifier_generic_arc") and not parent:HasModifier("modifier_eul_cyclone") and not parent:HasModifier("modifier_cyclone") and not parent:HasModifier("modifier_wind_waker") then
        FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
    end
    parent:AddNewModifier(parent, self:GetAbility(), "modifier_pangolier_gyroshell_custom_unbugged", {duration = 0.1})
    if not self.early_stop or not self.parent:IsAlive() then
        --if not self.reset_cooldown then
        --    self:GetAbility():UseResources(false, false, false, true)
        --end
        self:GetAbility():SetActivated(true)
    end
    if not self.early_stop then 
        self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_4_END)
        self.parent:EmitSound("Hero_Pangolier.Gyroshell.Stop")
    end
    self.parent:StopSound("Hero_Pangolier.Gyroshell.Loop")
    self.parent:StopSound("Hero_Pangolier.Gyroshell.Layer")
    self.parent:SwapAbilities("pangolier_gyroshell_stop_custom", "pangolier_gyroshell_custom", false, true)
end

function modifier_pangolier_gyroshell_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MODEL_CHANGE,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_DISABLE_TURNING,
        MODIFIER_PROPERTY_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
        MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
    }
end

function modifier_pangolier_gyroshell_custom:GetModifierIgnoreCastAngle(params)
    return 1
end

function modifier_pangolier_gyroshell_custom:GetAbsoluteNoDamagePure(params)
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 1
    end
end

function modifier_pangolier_gyroshell_custom:GetModifierMagicalResistanceBonus(params)
    if IsClient() then 
        return 80
    end
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 80
    end
end

function modifier_pangolier_gyroshell_custom:GetModifierMoveSpeed_Limit()
    return 0.1
end

function modifier_pangolier_gyroshell_custom:GetModifierModelChange()
    return "models/heroes/pangolier/pangolier_gyroshell2.vmdl"
end

function modifier_pangolier_gyroshell_custom:GetOverrideAnimation()
    return ACT_DOTA_RUN
end

function modifier_pangolier_gyroshell_custom:CheckState()
    return 
    {
        [ MODIFIER_STATE_DISARMED ] = true,
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true,
    }
end

function modifier_pangolier_gyroshell_custom:GetModifierDisableTurning( params )
    return 1
end

function modifier_pangolier_gyroshell_custom:OnIntervalThink()
    self.max_speed = self.ability:GetSpecialValueFor("forward_move_speed")
    if self:GetCaster():HasModifier("modifier_pangolier_20") then
        self.max_speed = self.max_speed + self:GetAbility().modifier_pangolier_20[self:GetCaster():GetTalentLevel("modifier_pangolier_20")]
    end
    self.flCurrentSpeed = self.max_speed
    self.turn_rate_min = self.ability:GetSpecialValueFor("turn_rate")
    self.turn_rate_max = self.turn_rate_min
    if self.parent:HasModifier("modifier_pangolier_gyroshell_custom_turn_boost") then 
        self.turn_rate_min = self.ability:GetSpecialValueFor("turn_rate_boosted")
    end
    if self:GetCaster():HasModifier("modifier_pangolier_20") then
        self.turn_rate_min = self.turn_rate_min * 1.4
        self.turn_rate_max = self.turn_rate_max * 1.4
    end
    if not IsServer() then return end
    self.parent:SetForceAttackTarget(nil)
    self.parent:Stop()

    if not self.parent:HasModifier("modifier_generic_arc") then 
    	self.ability:RollUpDamage()
    end
    self:UpdateHorizontalMotionCustom(self.parent, 0.01)
end

function modifier_pangolier_gyroshell_custom:OnOrderCustom( new_pos, target )
    if not IsServer() then return end
    local vTargetPos = new_pos
    if target ~= nil and target:IsNull() == false then
    	vTargetPos = target:GetAbsOrigin()
    end
    local vMountOrigin = self.parent:GetOrigin()
    if self.angle_correction ~= nil and self.angle_correction > 0 then
        local flOrderDist = (vMountOrigin - vTargetPos):Length2D()
        vMountOrigin = vMountOrigin + self.parent:GetForwardVector() * math.min(self.angle_correction, flOrderDist * 0.75)
    end
    local vDir = vTargetPos - vMountOrigin
    vDir.z = 0
    vDir = vDir:Normalized()
    local angles = VectorAngles( vDir )
    self.parent.flDesiredYaw = angles.y
end


function modifier_pangolier_gyroshell_custom:UpdateHorizontalMotionCustom( me, dt )
    if not IsServer() or not self.parent then return end
    if (self.parent:IsCurrentlyHorizontalMotionControlled() or self.parent:IsCurrentlyVerticalMotionControlled() 
        or self.parent:IsStunned() or self.parent:IsRooted()) then 
        return
    end 
    if self.parent:HasModifier("modifier_pangolier_gyroshell_custom_stop") then return end
    if self.bCrashScheduled then
        self:Crash( self.hCrashScheduledUnit )
        return
    end
    local curAngles = self.parent:GetAnglesAsVector()
    local flAngleDiff = AngleDiff( self.parent.flDesiredYaw, curAngles.y ) or 0
    local flTurnAmount = dt * ( self.turn_rate_min + self:GetSpeedMultiplier() * ( self.turn_rate_max - self.turn_rate_min ) )
    if self.flLastCrashTime ~= nil and GameRules:GetDOTATime(false, true) - self.flLastCrashTime <= 2.0 then
        flTurnAmount = flTurnAmount * 1.5
    end
    flTurnAmount = math.min( flTurnAmount, math.abs( flAngleDiff ) )
    if flAngleDiff < 0.0 then
        flTurnAmount = flTurnAmount * -1
    end
    if flAngleDiff ~= 0.0 then
        curAngles.y = curAngles.y + flTurnAmount
        me:SetAbsAngles( curAngles.x, curAngles.y, curAngles.z )
    end
    local flMaxSpeed = self.max_speed
    local flAcceleration = self.acceleration or -self.deceleration
    self.flCurrentSpeed = math.max( math.min( self.flCurrentSpeed + ( dt * flAcceleration ), flMaxSpeed ), 0 )
    local vNewPos = self.parent:GetOrigin() + self.parent:GetForwardVector() *( ( dt * self.flCurrentSpeed ))
    local range_vector = self.parent:GetForwardVector()
    local check_pos = vNewPos + range_vector
    if not GridNav:CanFindPath( me:GetOrigin(), check_pos ) and not me:HasModifier("modifier_item_giants_ring") then
        GridNav:DestroyTreesAroundPoint( check_pos, self.nTreeDestroyRadius, true )
        if GridNav:CanFindPath( me:GetOrigin(), check_pos ) then
            self:Crash( nil, true )
        else
            self:Crash()
            return
        end
    end
    me:SetOrigin(GetGroundPosition( vNewPos , me))
end

function modifier_pangolier_gyroshell_custom:ScheduleCrash( hHitUnit )
    self.bCrashScheduled = true
    self.hCrashScheduledUnit = hHitUnit
end

function modifier_pangolier_gyroshell_custom:Crash( hHitUnit, bHitTree )
    if bHitTree == nil then bHitTree = false end
    if not bHitTree then
        if self.flLastCrashTime ~= nil and GameRules:GetDOTATime(false, true) - self.flLastCrashTime <= 0.1 then
            if self.hLastCrashUnit ~= nil and self.hLastCrashUnit == hHitUnit then
                return
            elseif self.hLastCrashUnit == nil and hHitUnit == nil then
                return
            end
        end
        self.flLastCrashTime = GameRules:GetDOTATime(false, true)
        self.hLastCrashUnit = hHitUnit
    end
    if not bHitTree then
        local resetDistance = 0
        local vResetPos = self.parent:GetAbsOrigin() 
        local vAngles = self.parent:GetAngles()
        local old_vec = self.parent:GetForwardVector()
        self.parent:FaceTowards(self.parent:GetAbsOrigin() - old_vec)
        self.parent:SetForwardVector(old_vec*-1)
        self.parent:SetOrigin( vResetPos )
        self.parent.flDesiredYaw = self.parent:GetAnglesAsVector().y
        self.parent:EmitSound("Hero_Pangolier.Gyroshell.Carom")
        self.parent:EmitSound("Hero_Pangolier.Carom.Layer") 
        self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_gyroshell_custom_stop", {duration = self.ability:GetSpecialValueFor("jump_recover_time")})
        self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_gyroshell_custom_turn_boost", {duration = 2*self.ability:GetSpecialValueFor("jump_recover_time")})
    end
    self.bCrashScheduled = false
    self.hCrashScheduledUnit = nil
end

function modifier_pangolier_gyroshell_custom:GetSpeedMultiplier()
    return 0.5 + 0.5 * (self.flCurrentSpeed / self.max_speed)
end

function pangolier_gyroshell_custom:DealDamage(enemy)
    local caster = self:GetCaster()
    local swash = caster:FindAbilityByName("pangolier_swashbuckle_custom")
    local passive = caster:FindAbilityByName("pangolier_lucky_shot_custom")
    local mod = caster:FindModifierByName("modifier_pangolier_gyroshell_custom")
    local stun_duration = self:GetSpecialValueFor("stun_duration")
    local knock_duration = self:GetSpecialValueFor("bounce_duration")
    if enemy:IsHero() then 
        enemy:EmitSound("Hero_Pangolier.Gyroshell.Stun")
    else 
        enemy:EmitSound("Hero_Pangolier.Gyroshell.Stun.Creep")
    end
    if passive and passive:GetLevel() > 0 then 
        passive:ProcPassive(enemy, false)
    end

    local damage_pct = self:GetSpecialValueFor("damage_pct")/100
    local damage = self:GetSpecialValueFor("damage") + caster:GetAverageTrueAttackDamage(nil)*damage_pct
    local damage_ability = nil
    local damage_type = DAMAGE_TYPE_PHYSICAL

    local number = ApplyDamage({victim = enemy, attacker = caster, damage = damage, damage_type = damage_type, ability = self})
    SendOverheadEventMessage(enemy, 4, enemy, number, nil)

    if not enemy:IsDebuffImmune() then
        enemy:AddNewModifier(caster, self, "modifier_pangolier_gyroshell_custom_stunned", {duration = stun_duration*(1 - enemy:GetStatusResistance()) + knock_duration})
    end
    enemy:AddNewModifier(caster, self, "modifier_pangolier_gyroshell_custom_damage_cd", {duration = stun_duration + knock_duration})
end 

function pangolier_gyroshell_custom:RollUpDamage(new_radius)
    local caster = self:GetCaster()
    local hit_radius = self:GetSpecialValueFor("hit_radius")
    if new_radius then 
        hit_radius = new_radius
    end
    local mod = caster:FindModifierByName("modifier_pangolier_gyroshell_custom")
    local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, hit_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false )
    for _, enemy in pairs(enemies) do
        if not enemy:HasModifier("modifier_pangolier_gyroshell_custom_damage_cd") then
            if not self:GetCaster():HasModifier("modifier_generic_arc_lua") then
                self:DealDamage(enemy)
            end
        end
    end
end

modifier_pangolier_gyroshell_custom_stunned = class({})

function modifier_pangolier_gyroshell_custom_stunned:OnCreated(table)
    if not IsServer() then return end
    local direction = (self:GetParent():GetAbsOrigin() - self:GetCaster():GetAbsOrigin()):Normalized()
    local distance = self:GetAbility():GetSpecialValueFor("knockback_radius")
    local mod = self:GetParent():AddNewModifier( self:GetCaster(), self:GetAbility(),
    "modifier_generic_knockback_lua",
    {	
        direction_x = direction.x,
        direction_y = direction.y,
        distance = distance,
        height = self:GetAbility():GetSpecialValueFor("knockback_radius"),	
        duration = self:GetAbility():GetSpecialValueFor("bounce_duration"),
        IsStun = true,
        IsFlail = true,
    })
    local particle_stomp_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_warstomp.vpcf", PATTACH_ABSORIGIN, self:GetParent())
    ParticleManager:SetParticleControl(particle_stomp_fx, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle_stomp_fx, 1, Vector(300, 1, 1))
    ParticleManager:SetParticleControl(particle_stomp_fx, 2, self:GetParent():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle_stomp_fx)
    if mod then
        self.cast_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_blast_off_trail.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent())
        ParticleManager:SetParticleControlEnt( self.cast_effect, 0, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true )
        ParticleManager:SetParticleControlEnt( self.cast_effect, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true )
    
        mod:AddParticle( self.cast_effect, false, false, -1, false, false  )
    end
    self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("bounce_duration"))
end

function modifier_pangolier_gyroshell_custom_stunned:OnIntervalThink()
    if not IsServer() then return end
    self:GetParent():RemoveGesture(ACT_DOTA_FLAIL)
    self:GetParent():StartGesture(ACT_DOTA_DISABLED)
    self:StartIntervalThink(-1)
end

function modifier_pangolier_gyroshell_custom_stunned:CheckState()
    return
    {
        [MODIFIER_STATE_STUNNED] = true
    }
end

function modifier_pangolier_gyroshell_custom_stunned:OnDestroy()
    if not IsServer() then return end 
    self:GetParent():FadeGesture(ACT_DOTA_DISABLED)
end

function modifier_pangolier_gyroshell_custom_stunned:GetEffectName()
    return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_pangolier_gyroshell_custom_stunned:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end


modifier_pangolier_gyroshell_custom_stop = class({})
function modifier_pangolier_gyroshell_custom_stop:IsHidden() return true end
function modifier_pangolier_gyroshell_custom_stop:IsPurgable() return false end 
function modifier_pangolier_gyroshell_custom_stop:OnCreated(table)
    if not IsServer() then return end
    self.abs = self:GetParent():GetAbsOrigin()
    self.interrupted = false 
    self.dir = self:GetParent():GetForwardVector()
    self:SetJumpParameters(
	{
		dir_x = self.dir.x,
		dir_y = self.dir.y,
		duration = self:GetRemainingTime(),
		distance = 0,
		height = 50,
		fix_end = true,
		isStun = false,
		isForward = true,
	})
    if not self:ApplyVerticalMotionController() then
        self.interrupted = true
        self:Destroy()
    end
end

function modifier_pangolier_gyroshell_custom_stop:OnDestroy()
    if not IsServer() then return end 
    self:GetParent():RemoveVerticalMotionController( self )
    self:GetParent():SetAbsOrigin(self.abs)
end

function modifier_pangolier_gyroshell_custom_stop:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }
end

function modifier_pangolier_gyroshell_custom_stop:GetOverrideAnimation()
    return ACT_DOTA_FLAIL
end

function modifier_pangolier_gyroshell_custom_stop:UpdateVerticalMotion( me, dt )
    if self.fix_duration and self:GetElapsedTime()>=self.duration then return end
    local pos = me:GetOrigin()
    local time = self:GetElapsedTime()
    local height = pos.z
    local speed = self:GetVerticalSpeed( time )
    pos.z = height + speed * dt
    me:SetOrigin( pos )
    if not self.fix_duration then
        local ground = GetGroundHeight( pos, me ) + self.end_offset
        if pos.z <= ground then
            pos.z = ground
            me:SetOrigin( pos )
            self:Destroy()
        end
    end
end

function modifier_pangolier_gyroshell_custom_stop:OnVerticalMotionInterrupted()
    self.interrupted = true
    self:Destroy()
end

function modifier_pangolier_gyroshell_custom_stop:SetJumpParameters( kv )
    self.parent = self:GetParent()
    self.fix_end = true
    self.fix_duration = true
    self.fix_height = true
    if kv.fix_end then
        self.fix_end = kv.fix_end==1
    end
    if kv.fix_duration then
        self.fix_duration = kv.fix_duration==1
    end
    if kv.fix_height then
        self.fix_height = kv.fix_height==1
    end
    self.isStun = kv.isStun==1
    self.isRestricted = kv.isRestricted==1
    self.isForward = kv.isForward==1
    self.activity = kv.activity or 0
    self:SetStackCount( self.activity )
    if kv.target_x and kv.target_y then
        local origin = self.parent:GetOrigin()
        local dir = Vector( kv.target_x, kv.target_y, 0 ) - origin
        dir.z = 0
        dir = dir:Normalized()
        self.direction = dir
    end
    if kv.dir_x and kv.dir_y then
        self.direction = Vector( kv.dir_x, kv.dir_y, 0 ):Normalized()
    end
    if not self.direction then
        self.direction = self.parent:GetForwardVector()
    end
    self.duration = kv.duration
    self.distance = kv.distance
    self.speed = kv.speed
    if not self.duration then
        self.duration = self.distance/self.speed
    end
    if not self.distance then
        self.speed = self.speed or 0
        self.distance = self.speed*self.duration
    end
    if not self.speed then
        self.distance = self.distance or 0
        self.speed = self.distance/self.duration
    end


    self.height = kv.height or 0
    self.start_offset = kv.start_offset or 0
    self.end_offset = kv.end_offset or 0
    local pos_start = self.parent:GetOrigin()
    local pos_end = pos_start + self.direction * self.distance
    local height_start = GetGroundHeight( pos_start, self.parent ) + self.start_offset
    local height_end = GetGroundHeight( pos_end, self.parent ) + self.end_offset
    local height_max
    if not self.fix_height then
        self.height = math.min( self.height, self.distance/4 )
    end

    if self.fix_end then
        height_end = height_start
        height_max = height_start + self.height
    else
        local tempmin, tempmax = height_start, height_end
        if tempmin>tempmax then
            tempmin,tempmax = tempmax, tempmin
        end
        local delta = (tempmax-tempmin)*2/3

        height_max = tempmin + delta + self.height
    end

    if not self.fix_duration then
        self:SetDuration( -1, false )
    else
        self:SetDuration( self.duration, true )
    end

    self:InitVerticalArc( height_start, height_max, height_end, self.duration )
end

function modifier_pangolier_gyroshell_custom_stop:InitVerticalArc( height_start, height_max, height_end, duration )
    local height_end = height_end - height_start
    local height_max = height_max - height_start
    if height_max<height_end then
        height_max = height_end+0.01
    end
    if height_max<=0 then
        height_max = 0.01
    end
    local duration_end = ( 1 + math.sqrt( 1 - height_end/height_max ) )/2
    self.const1 = 4*height_max*duration_end/duration
    self.const2 = 4*height_max*duration_end*duration_end/(duration*duration)
end

function modifier_pangolier_gyroshell_custom_stop:GetVerticalPos( time )
	return self.const1*time - self.const2*time*time
end

function modifier_pangolier_gyroshell_custom_stop:GetVerticalSpeed( time )
	return self.const1 - 2*self.const2*time
end

function modifier_pangolier_gyroshell_custom_stop:SetEndCallback( func )
	self.endCallback = func
end

modifier_pangolier_gyroshell_custom_damage_cd = class({})
function modifier_pangolier_gyroshell_custom_damage_cd:IsHidden() return true end
function modifier_pangolier_gyroshell_custom_damage_cd:IsPurgable() return false end

modifier_pangolier_gyroshell_custom_shard_damage_cd = class({})
function modifier_pangolier_gyroshell_custom_shard_damage_cd:IsHidden() return true end
function modifier_pangolier_gyroshell_custom_shard_damage_cd:IsPurgable() return false end

modifier_pangolier_gyroshell_custom_turn_boost = class({})
function modifier_pangolier_gyroshell_custom_turn_boost:IsHidden() return true end
function modifier_pangolier_gyroshell_custom_turn_boost:IsPurgable() return false end



-- roll up

modifier_pangolier_gyroshell_custom_rollup = class({})
function modifier_pangolier_gyroshell_custom_rollup:IsPurgable() return false end
function modifier_pangolier_gyroshell_custom_rollup:IsHidden() return false end
function modifier_pangolier_gyroshell_custom_rollup:OnCreated(table)
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.max_speed = self.ability:GetSpecialValueFor("forward_move_speed")
    if not IsServer() then return end
    self.parent:Stop()
    self.cast_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_gyroshell.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
    ParticleManager:SetParticleControlEnt( self.cast_effect, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
    self:AddParticle(self.cast_effect,false, false, -1, false, false)
    self.acceleration = 350
    self.deceleration = 500
    self.turn_rate_min = self.ability:GetSpecialValueFor("turn_rate")
    self.turn_rate_max = self.ability:GetSpecialValueFor("turn_rate")
    self.flCurrentSpeed = self.max_speed
    self.flDespawnTime = 0.5
    self.nTreeDestroyRadius = 75
    self.bMaxSpeedNotified = false
    self.bCrashScheduled = false
    self.hCrashScheduledUnit = nil
    if self.parent.flDesiredYaw == nil then
        self.parent.flDesiredYaw = self.parent:GetAnglesAsVector().y
    end
    self:StartIntervalThink( 0.01 )
end

function modifier_pangolier_gyroshell_custom_rollup:OnDestroy()
    if not IsServer() then return end
    if not self.parent:HasModifier("modifier_generic_arc") and not self.parent:HasModifier("modifier_eul_cyclone") and not self.parent:HasModifier("modifier_cyclone") and not self.parent:HasModifier("modifier_wind_waker") then
        FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), true)
    end
end

function modifier_pangolier_gyroshell_custom_rollup:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MODEL_CHANGE,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_DISABLE_TURNING,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
    }
end

function modifier_pangolier_gyroshell_custom_rollup:GetModifierModelChange()
    return "models/heroes/pangolier/pangolier_gyroshell2.vmdl"
end

function modifier_pangolier_gyroshell_custom_rollup:GetOverrideAnimation()
    return ACT_DOTA_RUN
end

function modifier_pangolier_gyroshell_custom_rollup:CheckState()
    return 
    {
        [ MODIFIER_STATE_DISARMED ] = true,
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true,
    }
end

function modifier_pangolier_gyroshell_custom_rollup:GetModifierMagicalResistanceBonus()
    return 60
end

function modifier_pangolier_gyroshell_custom_rollup:GetModifierIncomingDamage_Percentage(params)
    if not IsServer() then return end
    if not params.attacker then return end
    if not params.inflictor then return end
    if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then 
        return -100 
    end
    local behavior = params.inflictor:GetAbilityTargetFlags()
    if params.damage_type == DAMAGE_TYPE_PURE then
        if bit.band(behavior, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) == 0 then
            return -100
        end
    end
end

function modifier_pangolier_gyroshell_custom_rollup:GetModifierDisableTurning( params )
    return 1
end

function modifier_pangolier_gyroshell_custom_rollup:OnIntervalThink()
    self.max_speed = self.ability:GetSpecialValueFor("forward_move_speed")
    self.flCurrentSpeed = self.max_speed
    self.turn_rate_min = self.ability:GetSpecialValueFor("turn_rate")
    self.turn_rate_max = self.turn_rate_min
    if self.parent:HasModifier("modifier_pangolier_gyroshell_custom_turn_boost") then 
        self.turn_rate_min = self.ability:GetSpecialValueFor("turn_rate_boosted")
    end
    if self:GetCaster():HasModifier("modifier_pangolier_20") then
        self.turn_rate_min = self.turn_rate_min * 1.4
        self.turn_rate_max = self.turn_rate_max * 1.4
    end
    if not IsServer() then return end
    self.parent:SetForceAttackTarget(nil)
    self.parent:Stop()

    if not self.parent:HasModifier("modifier_generic_arc") then 
    	self.ability:RollUpDamage()
    end
    self:UpdateHorizontalMotionCustom(self.parent, 0.01)
end

function modifier_pangolier_gyroshell_custom_rollup:UpdateHorizontalMotionCustom( me, dt )
    if not IsServer() or not self.parent then return end
    if (self.parent:IsCurrentlyHorizontalMotionControlled() or self.parent:IsCurrentlyVerticalMotionControlled() 
        or self.parent:IsStunned() or self.parent:IsRooted()) then 
        return
    end 
    if self.parent:HasModifier("modifier_pangolier_gyroshell_custom_stop") then return end
    if self.bCrashScheduled then
        self:Crash( self.hCrashScheduledUnit )
        return
    end
    local curAngles = self.parent:GetAnglesAsVector()
    local flAngleDiff = AngleDiff( self.parent.flDesiredYaw, curAngles.y ) or 0
    local flTurnAmount = dt * ( self.turn_rate_min + self:GetSpeedMultiplier() * ( self.turn_rate_max - self.turn_rate_min ) )
    if self.flLastCrashTime ~= nil and GameRules:GetDOTATime(false, true) - self.flLastCrashTime <= 2.0 then
        flTurnAmount = flTurnAmount * 1.5
    end
    flTurnAmount = math.min( flTurnAmount, math.abs( flAngleDiff ) )
    if flAngleDiff < 0.0 then
        flTurnAmount = flTurnAmount * -1
    end
    if flAngleDiff ~= 0.0 then
        curAngles.y = curAngles.y + flTurnAmount
        me:SetAbsAngles( curAngles.x, curAngles.y, curAngles.z )
    end
    local flMaxSpeed = self.max_speed
    local flAcceleration = self.acceleration or -self.deceleration
    self.flCurrentSpeed = math.max( math.min( self.flCurrentSpeed + ( dt * flAcceleration ), flMaxSpeed ), 0 )
    local vNewPos = self.parent:GetOrigin() + self.parent:GetForwardVector() *( ( dt * self.flCurrentSpeed ))
    local range_vector = self.parent:GetForwardVector()
    local check_pos = vNewPos + range_vector
    if not GridNav:CanFindPath( me:GetOrigin(), check_pos ) then
        GridNav:DestroyTreesAroundPoint( check_pos, self.nTreeDestroyRadius, true )
        if GridNav:CanFindPath( me:GetOrigin(), check_pos ) then
            self:Crash( nil, true )
        else
            self:Crash()
            return
        end
    end
    me:SetOrigin(GetGroundPosition( vNewPos , me))
end

function modifier_pangolier_gyroshell_custom_rollup:ScheduleCrash( hHitUnit )
    self.bCrashScheduled = true
    self.hCrashScheduledUnit = hHitUnit
end

function modifier_pangolier_gyroshell_custom_rollup:Crash( hHitUnit, bHitTree )
    if bHitTree == nil then bHitTree = false end
    if not bHitTree then
        if self.flLastCrashTime ~= nil and GameRules:GetDOTATime(false, true) - self.flLastCrashTime <= 0.1 then
            if self.hLastCrashUnit ~= nil and self.hLastCrashUnit == hHitUnit then
                return
            elseif self.hLastCrashUnit == nil and hHitUnit == nil then
                return
            end
        end
        self.flLastCrashTime = GameRules:GetDOTATime(false, true)
        self.hLastCrashUnit = hHitUnit
    end
    if not bHitTree then
        local resetDistance = 0
        local vResetPos = self.parent:GetAbsOrigin() 
        local vAngles = self.parent:GetAngles()
        local old_vec = self.parent:GetForwardVector()
        self.parent:FaceTowards(self.parent:GetAbsOrigin() - old_vec)
        self.parent:SetForwardVector(old_vec*-1)
        self.parent:SetOrigin( vResetPos )
        self.parent.flDesiredYaw = self.parent:GetAnglesAsVector().y
        self.parent:EmitSound("Hero_Pangolier.Gyroshell.Carom")
        self.parent:EmitSound("Hero_Pangolier.Carom.Layer") 
        self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_gyroshell_custom_stop", {duration = self.ability:GetSpecialValueFor("jump_recover_time")})
        self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_gyroshell_custom_turn_boost", {duration = 2*self.ability:GetSpecialValueFor("jump_recover_time")})
    end
    self.bCrashScheduled = false
    self.hCrashScheduledUnit = nil
end

function modifier_pangolier_gyroshell_custom_rollup:GetSpeedMultiplier()
    return 0.5 + 0.5 * (self.flCurrentSpeed / self.max_speed)
end

modifier_pangolier_gyroshell_custom_unbugged = class({})
function modifier_pangolier_gyroshell_custom_unbugged:IsHidden() return true end
function modifier_pangolier_gyroshell_custom_unbugged:IsPurgable() return false end
function modifier_pangolier_gyroshell_custom_unbugged:IsPurgeException() return false end
function modifier_pangolier_gyroshell_custom_unbugged:CheckState()
    return
    {
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
    }
end