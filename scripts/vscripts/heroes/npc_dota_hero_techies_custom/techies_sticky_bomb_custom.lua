--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_techies_sticky_bomb_custom", "heroes/npc_dota_hero_techies_custom/techies_sticky_bomb_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_sticky_bomb_custom_motion", "heroes/npc_dota_hero_techies_custom/techies_sticky_bomb_custom", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_techies_sticky_bomb_activated", "heroes/npc_dota_hero_techies_custom/techies_sticky_bomb_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_sticky_bomb_slow", "heroes/npc_dota_hero_techies_custom/techies_sticky_bomb_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_sticky_bomb_slow_secondary", "heroes/npc_dota_hero_techies_custom/techies_sticky_bomb_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_sticky_bomb_handler", "heroes/npc_dota_hero_techies_custom/techies_sticky_bomb_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_sticky_bomb_handler_cooldown", "heroes/npc_dota_hero_techies_custom/techies_sticky_bomb_custom", LUA_MODIFIER_MOTION_NONE)

techies_sticky_bomb_custom = class({})

techies_sticky_bomb_custom.modifier_techies_16 = {45,30,15}
techies_sticky_bomb_custom.modifier_techies_15 = 100

function techies_sticky_bomb_custom:GetAOERadius()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_techies_15") then
        bonus = bonus + self.modifier_techies_15
    end
    return self:GetSpecialValueFor("radius") + bonus
end

function techies_sticky_bomb_custom:GetIntrinsicModifierName()
    return "modifier_techies_sticky_bomb_handler"
end

function techies_sticky_bomb_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    self:ThrowBomb(point)
end

function techies_sticky_bomb_custom:ThrowBomb(point)
    local speed = self:GetSpecialValueFor("speed")
    local npc_dota_techies_remote_mine = CreateUnitByName("npc_dota_techies_remote_mine", self:GetCaster():GetAbsOrigin(), false, nil, nil, self:GetCaster():GetTeamNumber())
    if npc_dota_techies_remote_mine then
        npc_dota_techies_remote_mine:EmitSound("Hero_Techies.StickyBomb.Cast")
        npc_dota_techies_remote_mine:AddNewModifier(self:GetCaster(), self, "modifier_techies_sticky_bomb_custom", {})
        npc_dota_techies_remote_mine:AddNewModifier( self:GetCaster(), self, "modifier_techies_sticky_bomb_custom_motion", {vLocX = point.x,vLocY = point.y,vLocZ = point.z} )
        npc_dota_techies_remote_mine:AddNewModifier(self:GetCaster(), self, "modifier_kill", {duration = 10})
    end
end

modifier_techies_sticky_bomb_custom = class({})
function modifier_techies_sticky_bomb_custom:IsHidden() return true end
function modifier_techies_sticky_bomb_custom:IsPurgable() return false end
function modifier_techies_sticky_bomb_custom:RemoveOnDeath() return false end
function modifier_techies_sticky_bomb_custom:IsPurgeException() return false end
function modifier_techies_sticky_bomb_custom:CheckState()
    return
    {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
    }
end

local TECHIES_MINIMUM_HEIGHT_ABOVE_LOWEST = 0
local TECHIES_MINIMUM_HEIGHT_ABOVE_HIGHEST = 600
local TECHIES_ACCELERATION_Z = 4000
local TECHIES_MAX_HORIZONTAL_ACCELERATION = 2000

modifier_techies_sticky_bomb_custom_motion = class({})
function modifier_techies_sticky_bomb_custom_motion:IsHidden() return true end
function modifier_techies_sticky_bomb_custom_motion:IsPurgable() return false end
function modifier_techies_sticky_bomb_custom_motion:IsPurgeException() return false end
function modifier_techies_sticky_bomb_custom_motion:RemoveOnDeath() return false end

function modifier_techies_sticky_bomb_custom_motion:OnCreated( kv )
    self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
    if self:GetCaster():HasModifier("modifier_techies_15") then
        self.radius = self.radius + self:GetAbility().modifier_techies_15
    end
    self.countdown = self:GetAbility():GetSpecialValueFor( "countdown" )
    if not IsServer() then return end
    if self:ApplyHorizontalMotionController() == false or self:ApplyVerticalMotionController() == false then
        if not self:IsNull() then
            self:Destroy()
        end
        return
    end
    self.bHorizontalMotionInterrupted = false
    self:GetCaster():RemoveGesture(ACT_DOTA_CAST_ABILITY_2_ES_ROLL_START)
    self.vStartPosition = GetGroundPosition( self:GetParent():GetOrigin(), self:GetParent() )
    self.flCurrentTimeHoriz = 0.0
    self.flCurrentTimeVert = 0.0
    self.vLoc = Vector( kv.vLocX, kv.vLocY, kv.vLocZ )
    self.vLastKnownTargetPos = self.vLoc
    local duration = 1.2
    local flDesiredHeight = TECHIES_MINIMUM_HEIGHT_ABOVE_LOWEST * duration * duration
    local flLowZ = math.min( self.vLastKnownTargetPos.z, self.vStartPosition.z )
    local flHighZ = math.max( self.vLastKnownTargetPos.z, self.vStartPosition.z )
    local flArcTopZ = math.max( flLowZ + flDesiredHeight, flHighZ + TECHIES_MINIMUM_HEIGHT_ABOVE_HIGHEST )
    local flArcDeltaZ = flArcTopZ - self.vStartPosition.z
    self.flInitialVelocityZ = math.sqrt( 2.0 * flArcDeltaZ * TECHIES_ACCELERATION_Z )
    local flDeltaZ = self.vLastKnownTargetPos.z - self.vStartPosition.z
    local flSqrtDet = math.sqrt( math.max( 0, ( self.flInitialVelocityZ * self.flInitialVelocityZ ) - 2.0 * TECHIES_ACCELERATION_Z * flDeltaZ ) )
    self.flPredictedTotalTime = math.max( ( self.flInitialVelocityZ + flSqrtDet) / TECHIES_ACCELERATION_Z, ( self.flInitialVelocityZ - flSqrtDet) / TECHIES_ACCELERATION_Z )
    self.vHorizontalVelocity = ( self.vLastKnownTargetPos - self.vStartPosition ) / self.flPredictedTotalTime
    self.vHorizontalVelocity.z = 0.0
end

function modifier_techies_sticky_bomb_custom_motion:OnDestroy()
    if not IsServer() then return end
    self:GetParent():RemoveHorizontalMotionController( self )
    self:GetParent():RemoveVerticalMotionController( self )
    self:GetParent():EmitSound("Hero_Techies.StickyBomb.Plant")
    self:GetParent():EmitSound("Ability.TossImpact")
    local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false )
    if #units > 0 then
        local target = units[1]
        self:GetParent():EmitSound("Hero_Techies.StickyBomb.Priming")
        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_techies_sticky_bomb_activated", {duration = self.countdown, target = target:entindex()})
    else
        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_techies_sticky_bomb_activated", {duration = self.countdown})
    end
    GridNav:DestroyTreesAroundPoint( self:GetParent():GetAbsOrigin(), 100, true )
end

function modifier_techies_sticky_bomb_custom_motion:UpdateHorizontalMotion( me, dt )
    if not IsServer() then return end
    self.flCurrentTimeHoriz = math.min( self.flCurrentTimeHoriz + dt, self.flPredictedTotalTime )
    local t = self.flCurrentTimeHoriz / self.flPredictedTotalTime
    local vStartToTarget = self.vLastKnownTargetPos - self.vStartPosition
    local vDesiredPos = self.vStartPosition + t * vStartToTarget
    local vOldPos = me:GetOrigin()
    local vToDesired = vDesiredPos - vOldPos
    vToDesired.z = 0.0
    local vDesiredVel = vToDesired / dt
    local vVelDif = vDesiredVel - self.vHorizontalVelocity
    local flVelDif = vVelDif:Length2D()
    vVelDif = vVelDif:Normalized()
    local flVelDelta = math.min( flVelDif, TECHIES_MAX_HORIZONTAL_ACCELERATION )
    self.vHorizontalVelocity = self.vHorizontalVelocity + vVelDif * flVelDelta * dt
    local vNewPos = vOldPos + self.vHorizontalVelocity * dt
    me:SetOrigin( vNewPos )
end

function modifier_techies_sticky_bomb_custom_motion:UpdateVerticalMotion( me, dt )
    if not IsServer() then return end
    self.flCurrentTimeVert = self.flCurrentTimeVert + dt
    local bGoingDown = ( -TECHIES_ACCELERATION_Z * self.flCurrentTimeVert + self.flInitialVelocityZ ) < 0
    local vNewPos = me:GetOrigin()
    vNewPos.z = self.vStartPosition.z + ( -0.5 * TECHIES_ACCELERATION_Z * ( self.flCurrentTimeVert * self.flCurrentTimeVert ) + self.flInitialVelocityZ * self.flCurrentTimeVert )
    local flGroundHeight = GetGroundHeight( vNewPos, self:GetParent() )
    local bLanded = false
    if ( vNewPos.z < flGroundHeight and bGoingDown == true ) then
        vNewPos.z = flGroundHeight
        bLanded = true
    end
    me:SetOrigin( vNewPos )
    if bLanded == true then
        self:GetParent():RemoveHorizontalMotionController( self )
        self:GetParent():RemoveVerticalMotionController( self )
        self:SetDuration( 0.01, false)
    end
end

function modifier_techies_sticky_bomb_custom_motion:OnHorizontalMotionInterrupted()
    if not IsServer() then return end
    self.bHorizontalMotionInterrupted = true
end

function modifier_techies_sticky_bomb_custom_motion:OnVerticalMotionInterrupted()
    if not IsServer() then return end
    self:Destroy()
end

modifier_techies_sticky_bomb_activated = class({})
function modifier_techies_sticky_bomb_activated:IsHidden() return true end
function modifier_techies_sticky_bomb_activated:IsPurgable() return false end
function modifier_techies_sticky_bomb_activated:IsPurgeException() return false end
function modifier_techies_sticky_bomb_activated:OnCreated(params)
    if not IsServer() then return end
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    if self:GetCaster():HasModifier("modifier_techies_15") then
        self.radius = self.radius + self:GetAbility().modifier_techies_15
    end
    self.explosion_radius = self:GetAbility():GetSpecialValueFor("explosion_radius")
    if self:GetCaster():HasModifier("modifier_techies_15") then
        self.explosion_radius = self.explosion_radius + self:GetAbility().modifier_techies_15
    end
    self.secondary_slow_duration = self:GetAbility():GetSpecialValueFor("secondary_slow_duration")
    self.damage = self:GetAbility():GetSpecialValueFor("damage")
    if params.target then
        self.target = EntIndexToHScript(params.target)
    end
    self.clay = false
    self.clay_direction = nil
    if self.target then
        self:GetParent():StartGestureFadeWithSequenceSettings(ACT_DOTA_ATTACK)
        local modifier_techies_sticky_bomb_slow = self.target:FindModifierByName("modifier_techies_sticky_bomb_slow")
        if not modifier_techies_sticky_bomb_slow then
            modifier_techies_sticky_bomb_slow = self.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_techies_sticky_bomb_slow", {})
        end
        if modifier_techies_sticky_bomb_slow then
            modifier_techies_sticky_bomb_slow:IncrementStackCount()
        end
    end
    self:StartIntervalThink(FrameTime())
end
function modifier_techies_sticky_bomb_activated:OnIntervalThink()
    if not IsServer() then return end
    if self.target == nil then return end
    if self.target:IsNull() then return end
    if not self.target:IsAlive() then return end
    local direction = (self.target:GetAbsOrigin() - self:GetParent():GetAbsOrigin())
    direction.z = 0
    local length = direction:Length2D()
    direction = direction:Normalized()
    local speed = length / 0.2
    local new_pos = self:GetParent():GetAbsOrigin() + direction * (speed * FrameTime())
    if self.clay then
        self:GetParent():SetForwardVector(direction)
        self:GetParent():SetAbsOrigin(self.target:GetAbsOrigin() + self.clay_direction * 50)
        return
    end
    if length <= 50 then
        self.clay = true
        self.clay_direction = (self:GetParent():GetAbsOrigin() - self.target:GetAbsOrigin()):Normalized()
    else
        self:GetParent():SetForwardVector(direction)
        self:GetParent():SetAbsOrigin(new_pos)
    end
end
function modifier_techies_sticky_bomb_activated:OnDestroy()
    if not IsServer() then return end
    if self.target then
        local modifier_techies_sticky_bomb_slow = self.target:FindModifierByName("modifier_techies_sticky_bomb_slow")
        if modifier_techies_sticky_bomb_slow then
            modifier_techies_sticky_bomb_slow:DecrementStackCount()
            if modifier_techies_sticky_bomb_slow:GetStackCount() <= 0 then
                modifier_techies_sticky_bomb_slow:Destroy()
            end
        end
    end
    self:GetParent():EmitSound("Hero_Techies.StickyBomb.Detonate")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_remote_cart_explode.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, Vector(self.explosion_radius, self.explosion_radius, self.explosion_radius))
    ParticleManager:ReleaseParticleIndex(particle)
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.explosion_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    for _, hero in pairs(units) do
        hero:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_techies_sticky_bomb_slow_secondary", {duration = self.secondary_slow_duration * (1 - hero:GetStatusResistance())})
        ApplyDamage({ victim = hero, attacker = self:GetCaster(), damage = self.damage, damage_type = self:GetAbility():GetAbilityDamageType(), ability = self:GetAbility() })
    end
    self:GetParent():AddNoDraw()
    self:GetParent():ForceKill(false)
end

modifier_techies_sticky_bomb_slow = class({})
function modifier_techies_sticky_bomb_slow:OnCreated()
    self.slow = self:GetAbility():GetSpecialValueFor("slow")
end
function modifier_techies_sticky_bomb_slow:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end
function modifier_techies_sticky_bomb_slow:GetModifierMoveSpeedBonus_Percentage( params )
    return self.slow
end
function modifier_techies_sticky_bomb_slow:GetStatusEffectName()
    return "particles/status_fx/status_effect_brewmaster_thunder_clap.vpcf"
end

function modifier_techies_sticky_bomb_slow:GetEffectName()
    return "particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap_debuff.vpcf"
end

function modifier_techies_sticky_bomb_slow:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_techies_sticky_bomb_slow:StatusEffectPriority()
    return 3
end

modifier_techies_sticky_bomb_slow_secondary = class({})
function modifier_techies_sticky_bomb_slow_secondary:OnCreated()
    self.secondary_slow = self:GetAbility():GetSpecialValueFor("secondary_slow")
end
function modifier_techies_sticky_bomb_slow_secondary:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end
function modifier_techies_sticky_bomb_slow_secondary:GetModifierMoveSpeedBonus_Percentage( params )
    return self.secondary_slow
end
function modifier_techies_sticky_bomb_slow_secondary:GetStatusEffectName()
    return "particles/status_fx/status_effect_brewmaster_thunder_clap.vpcf"
end

function modifier_techies_sticky_bomb_slow_secondary:GetEffectName()
    return "particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap_debuff.vpcf"
end

function modifier_techies_sticky_bomb_slow_secondary:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_techies_sticky_bomb_slow_secondary:StatusEffectPriority()
    return 3
end

modifier_techies_sticky_bomb_handler = class({})
function modifier_techies_sticky_bomb_handler:IsHidden() return true end
function modifier_techies_sticky_bomb_handler:IsPurgeException() return false end
function modifier_techies_sticky_bomb_handler:IsPurgable() return false end
function modifier_techies_sticky_bomb_handler:RemoveOnDeath() return false end
function modifier_techies_sticky_bomb_handler:DeclareFunctions()
    return
    {
         
    }
end
function modifier_techies_sticky_bomb_handler:OnTakeDamage( params )
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if params.attacker == self:GetParent() then return end
    if not params.attacker:IsRealHero() then return end
    if not self:GetParent():HasModifier("modifier_techies_16") then return end
    if not self:GetParent():IsAlive() then return end
    if self:GetParent():HasModifier("modifier_techies_sticky_bomb_handler_cooldown") then return end
    if self:GetParent():HasModifier("modifier_wodarelax") then return end
	if self:GetParent():HasModifier("modifier_wodarelax_invul") then return end
    if params.attacker:HasModifier("modifier_wodarelax") then return end
	if params.attacker:HasModifier("modifier_wodawispdeath_wisp") then return end
	if params.attacker:HasModifier("modifier_wodawisp") then return end
    if params.attacker:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then return end
    if not params.attacker:IsAlive() then return end
    self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_techies_sticky_bomb_handler_cooldown", {duration = self:GetAbility().modifier_techies_16[self:GetCaster():GetTalentLevel("modifier_techies_16")]})
    self:GetAbility():ThrowBomb(params.attacker:GetAbsOrigin())
end

modifier_techies_sticky_bomb_handler_cooldown = class({})
function modifier_techies_sticky_bomb_handler_cooldown:IsDebuff() return true end
function modifier_techies_sticky_bomb_handler_cooldown:IsPurgable() return false end
function modifier_techies_sticky_bomb_handler_cooldown:IsPurgeException() return false end
function modifier_techies_sticky_bomb_handler_cooldown:RemoveOnDeath() return false end