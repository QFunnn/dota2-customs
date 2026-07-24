--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_generic_knockback_lua", "heroes/npc_dota_hero_meepo_custom/aghanim_blink_cast", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier("modifier_aghanim_blink_attack_debuff", "heroes/npc_dota_hero_meepo_custom/aghanim_blink_cast", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_aghanim_blink_attack_buff", "heroes/npc_dota_hero_meepo_custom/aghanim_blink_cast", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_aghanim_blink_attack_backawards", "heroes/npc_dota_hero_meepo_custom/aghanim_blink_cast", LUA_MODIFIER_MOTION_NONE )

aghanim_blink_cast = class({})

aghanim_blink_cast.modifier_meepo_10 = {25,50}
aghanim_blink_cast.modifier_meepo_10_duration = 4
aghanim_blink_cast.modifier_meepo_12 = {-2,-4}
aghanim_blink_cast.modifier_meepo_13 = 2

function aghanim_blink_cast:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_elder_titan.vsndevts", context )
end

function aghanim_blink_cast:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_meepo_12") then
		bonus = self.modifier_meepo_12[self:GetCaster():GetTalentLevel("modifier_meepo_12")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function aghanim_blink_cast:GetBehavior()
    if self:GetCaster():HasModifier("modifier_meepo_21") and self:GetCaster():HasModifier("modifier_aghanim_ray") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
end

function aghanim_blink_cast:GetCastRange(location, target)
    return self.BaseClass.GetCastRange(self, location, target)
end

function aghanim_blink_cast:GetManaCost(level)
    return self.BaseClass.GetManaCost(self, level)
end

function aghanim_blink_cast:GetCastPoint( point, target )
	if self:GetCaster():HasModifier("modifier_aghanim_blink_attack_backawards") then
		return 0
	end
	return self.BaseClass.GetCastPoint( self )
end

function aghanim_blink_cast:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_aghanim_blink_attack_backawards") then
        return "aghanim_13"
    end
    return "continuum"
end

function aghanim_blink_cast:OnSpellStart()
    if not IsServer() then return end
    local origin = self:GetCaster():GetOrigin()
    if self:GetCaster():HasModifier("modifier_aghanim_blink_attack_backawards") then
        local modifier_aghanim_blink_attack_backawards = self:GetCaster():FindModifierByName("modifier_aghanim_blink_attack_backawards")
        if modifier_aghanim_blink_attack_backawards then
            self:GetCaster():EmitSound("woda_aghanim_jump")
            local point = modifier_aghanim_blink_attack_backawards.point
            local nFXIndex = ParticleManager:CreateParticle( "particles/creatures/aghanim/aghanim_preimage.vpcf", PATTACH_CUSTOMORIGIN, nil )
            ParticleManager:SetParticleControl( nFXIndex, 0, origin )
            ParticleManager:SetParticleControl( nFXIndex, 1, point )
            ParticleManager:SetParticleFoWProperties( nFXIndex, 0, 2, 64.0 )
            ParticleManager:ReleaseParticleIndex( nFXIndex )

            local distance_teleport = (point - self:GetCaster():GetAbsOrigin()):Length2D()
            local dist_check = (point - self:GetCaster():GetAbsOrigin()):Length2D()
            local direciton = (point - self:GetCaster():GetAbsOrigin())
            direciton.z = 0
            direciton = direciton:Normalized()

            local knockback = self:GetCaster():AddNewModifier(
                self:GetCaster(),
                self,
                "modifier_generic_knockback_lua",
                {
                    direction_x = direciton.x,
                    direction_y = direciton.y,
                    distance = distance_teleport,
                    duration = 0.25,
                }
            )
            modifier_aghanim_blink_attack_backawards:Destroy()
        end
        return
    end
    local range = self:GetSpecialValueFor("distance")
    local point = origin + (self:GetCaster():GetForwardVector() * -1) * range
    self.point = self:GetCaster():GetAbsOrigin()
    local distance_teleport = (point - self:GetCaster():GetAbsOrigin()):Length2D()
    local dist_check = (point - self:GetCaster():GetAbsOrigin()):Length2D()
    local direciton = (point - self:GetCaster():GetAbsOrigin())
    direciton.z = 0
    direciton = direciton:Normalized()

    ProjectileManager:ProjectileDodge(self:GetCaster())
    
    local knockback = self:GetCaster():AddNewModifier(
        self:GetCaster(),
        self,
        "modifier_generic_knockback_lua",
        {
            direction_x = direciton.x,
            direction_y = direciton.y,
            distance = distance_teleport,
            duration = 0.25,
        }
    )

    self:GetCaster():EmitSound("woda_aghanim_jump")

    local nFXIndex = ParticleManager:CreateParticle( "particles/creatures/aghanim/aghanim_preimage.vpcf", PATTACH_CUSTOMORIGIN, nil )
    ParticleManager:SetParticleControl( nFXIndex, 0, origin )
    ParticleManager:SetParticleControl( nFXIndex, 1, point )
    ParticleManager:SetParticleFoWProperties( nFXIndex, 0, 2, 64.0 )
    ParticleManager:ReleaseParticleIndex( nFXIndex )

    self:StunTargets(origin)

    local callback = function( bInterrupted )
        FindClearSpaceForUnit( self:GetCaster(), self:GetCaster():GetAbsOrigin(), true )
        ProjectileManager:ProjectileDodge(self:GetCaster())
        if self:GetCaster():HasModifier("modifier_meepo_10") then
            self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_aghanim_blink_attack_buff", {duration = self.modifier_meepo_10_duration})
        end
        if self:GetCaster():HasModifier("modifier_meepo_13") then
            self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_aghanim_blink_attack_backawards", {duration = self.modifier_meepo_13, x=origin.x, y=origin.y, z=origin.z})
        end
    end

    knockback:SetEndCallback( callback )
end

modifier_aghanim_blink_attack_backawards = class({})
function modifier_aghanim_blink_attack_backawards:IsPurgable() return false end
function modifier_aghanim_blink_attack_backawards:RemoveOnDeath() return false end
function modifier_aghanim_blink_attack_backawards:OnCreated(params)
    if not IsServer() then return end
    self.point = Vector(params.x,params.y,params.z)
    self:GetAbility():EndCooldown()
end
function modifier_aghanim_blink_attack_backawards:OnDestroy()
    if not IsServer() then return end
    self:GetAbility():UseResources(false,false,false,true)
end

function aghanim_blink_cast:StunTargets(point)
    if not IsServer() then return end
    local radius = self:GetSpecialValueFor("radius")
    local slow_duration = self:GetSpecialValueFor("slow_duration")

    local nFXCastIndex = ParticleManager:CreateParticle( "particles/creatures/aghanim/aghanim_stomp_magical.vpcf", PATTACH_WORLDORIGIN, self:GetCaster() )
    ParticleManager:SetParticleControl( nFXCastIndex, 0, point )
    ParticleManager:SetParticleControl( nFXCastIndex, 1, Vector( radius, radius, radius ) )
    ParticleManager:ReleaseParticleIndex( nFXCastIndex )

    EmitSoundOn( "Hero_ElderTitan.EchoStomp", self:GetCaster() )

    local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), point, self:GetCaster(), radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
    for _,enemy in pairs( enemies ) do
        if enemy ~= nil and enemy:IsInvulnerable() == false then
            enemy:AddNewModifier( self:GetCaster(), self, "modifier_aghanim_blink_attack_debuff", { duration = slow_duration * (1 - enemy:GetStatusResistance()) } )
        end
    end

    if true then
        local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), point, self:GetCaster(), radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
        for _,enemy in pairs( enemies ) do
            if enemy ~= nil and enemy:IsInvulnerable() == false then
                local direciton = (point - enemy:GetAbsOrigin())
                local dlina = direciton:Length2D()
                direciton.z = 0
                direciton = direciton:Normalized()
                local knockback = enemy:AddNewModifier(
                    self:GetCaster(),
                    self,
                    "modifier_generic_knockback_lua",
                    {
                        direction_x = direciton.x,
                        direction_y = direciton.y,
                        height = 50,
                        distance = dlina - 75,
                        duration = 0.2,
                    }
                )
                local callback = function( bInterrupted )
                    FindClearSpaceForUnit( enemy, enemy:GetAbsOrigin(), true )
                end
            end
        end
    end
end

modifier_generic_knockback_lua = class({})
function modifier_generic_knockback_lua:IsHidden()
    return true
end
function modifier_generic_knockback_lua:IsPurgable()
    return false
end
function modifier_generic_knockback_lua:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_generic_knockback_lua:OnCreated( kv )
    if IsServer() then
        self.distance = kv.distance or 0
        self.height = kv.height or -1
        self.duration = kv.duration or 0
        if kv.direction_x and kv.direction_y then
            self.direction = Vector(kv.direction_x,kv.direction_y,0):Normalized()
        else
            self.direction = -(self:GetParent():GetForwardVector())
        end
        self.tree = kv.tree_destroy_radius or self:GetParent():GetHullRadius()

        if kv.IsStun then self.stun = kv.IsStun==1 else self.stun = false end
        if kv.IsFlail then self.flail = kv.IsFlail==1 else self.flail = true end

        
        if self.duration == 0 then
            self:Destroy()
            return
        end

        
        self.parent = self:GetParent()
        self.origin = self.parent:GetOrigin()

        
        self.hVelocity = self.distance/self.duration

        
        local half_duration = self.duration/2
        self.gravity = 2*self.height/(half_duration*half_duration)
        self.vVelocity = self.gravity*half_duration

        
        if self.distance>0 then
            if self:ApplyHorizontalMotionController() == false then 
                self:Destroy()
                return
            end
        end
        if self.height>=0 then
            if self:ApplyVerticalMotionController() == false then 
                self:Destroy()
                return
            end
        end
        if self.flail then
            self:SetStackCount( 1 )
        elseif self.stun then
            self:SetStackCount( 2 )
        end
    else
        self.anim = self:GetStackCount()
        self:SetStackCount( 0 )
    end
end
function modifier_generic_knockback_lua:OnRefresh( kv )
    if not IsServer() then return end
end
function modifier_generic_knockback_lua:OnDestroy( kv )
    if not IsServer() then return end
    if not self.interrupted then
        
        if self.tree>0 then
            GridNav:DestroyTreesAroundPoint( self:GetParent():GetOrigin(), self.tree, true )
        end
    end
    if self.EndCallback then
        self.EndCallback( self.interrupted )
    end
    self:GetParent():InterruptMotionControllers( true )
end
function modifier_generic_knockback_lua:SetEndCallback( func ) 
    self.EndCallback = func
end
function modifier_generic_knockback_lua:CheckState()
    local state = {
        [MODIFIER_STATE_STUNNED] = self.stun,
    }
    return state
end
function modifier_generic_knockback_lua:UpdateHorizontalMotion( me, dt )
    local parent = self:GetParent()
    local target = self.direction*self.distance*(dt/self.duration)
    parent:SetOrigin( parent:GetOrigin() + target )
end

function modifier_generic_knockback_lua:OnHorizontalMotionInterrupted()
    if IsServer() then
        self.interrupted = true
        self:Destroy()
    end
end

function modifier_generic_knockback_lua:UpdateVerticalMotion( me, dt )
    local time = dt/self.duration
    self.parent:SetOrigin( self.parent:GetOrigin() + Vector( 0, 0, self.vVelocity*dt ) )
    self.vVelocity = self.vVelocity - self.gravity*dt
end

function modifier_generic_knockback_lua:OnVerticalMotionInterrupted()
    if IsServer() then
        self.interrupted = true
        self:Destroy()
    end
end

function modifier_generic_knockback_lua:GetEffectName()
    if not IsServer() then return end
    if self.stun then
        return "particles/generic_gameplay/generic_stunned.vpcf"
    end
end

function modifier_generic_knockback_lua:GetEffectAttachType()
    if not IsServer() then return end
    return PATTACH_OVERHEAD_FOLLOW
end

modifier_aghanim_blink_attack_debuff = class({})

function modifier_aghanim_blink_attack_debuff:OnCreated()
    self.slow = self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_aghanim_blink_attack_debuff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_aghanim_blink_attack_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self.slow
end

modifier_aghanim_blink_attack_buff = class({})
function modifier_aghanim_blink_attack_buff:GetTexture() return "aghanim_10" end
function modifier_aghanim_blink_attack_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
end
function modifier_aghanim_blink_attack_buff:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility().modifier_meepo_10[self:GetCaster():GetTalentLevel("modifier_meepo_10")]
end
function modifier_aghanim_blink_attack_buff:GetModifierMoveSpeedBonus_Constant()
    return self:GetAbility().modifier_meepo_10[self:GetCaster():GetTalentLevel("modifier_meepo_10")]
end