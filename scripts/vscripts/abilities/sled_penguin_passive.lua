--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



sled_penguin_passive = class({})

LinkLuaModifier( "modifier_sled_penguin_passive", "abilities/sled_penguin_passive", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sled_penguin_movement", "abilities/sled_penguin_passive", LUA_MODIFIER_MOTION_NONE )
 
--------------------------------------------------------------------------------

function sled_penguin_passive:Precache(context)
    PrecacheResource("particle", "particles/units/frostivus_penguin/peng_ice_shards_projectile_stout.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/ti9/penguin_death.vpcf", context)
end

function sled_penguin_passive:GetIntrinsicModifierName()
	return "modifier_sled_penguin_passive"
end

--------------------------------------------------------------------------------

modifier_sled_penguin_passive = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsPermanent             = function(self) return true end,
    RemoveOnDeath           = function(self) return false end,
    GetAttributes           = function(self) return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_PERMANENT end,

    CheckState              = function (self)
        return {
            [MODIFIER_STATE_INVULNERABLE] = true,
            [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
            [MODIFIER_STATE_UNSELECTABLE] = true,
            [MODIFIER_STATE_UNTARGETABLE] = true,
            [MODIFIER_STATE_DISARMED] = true,
            [MODIFIER_STATE_NO_HEALTH_BAR] = true,
            [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
            [MODIFIER_STATE_STUNNED] = true,
        }
    end,
})

----------------------------------------------------------------------------------

function modifier_sled_penguin_passive:OnCreated( kv )
	if not IsServer() then return end

    local parent = self:GetParent()

    local RandomYaw = RandomInt(0, 360)
    parent:SetAngles(0, RandomYaw, 0)

    parent:AddNewModifier(parent, self:GetAbility(), "modifier_sled_penguin_movement", {})
end

modifier_sled_penguin_movement = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsPermanent             = function(self) return true end,
    RemoveOnDeath           = function(self) return false end,
    GetAttributes           = function(self) return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_PERMANENT end,

    DeclareFunctions        = function (self)
        return {
            MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		    MODIFIER_PROPERTY_DISABLE_TURNING,
        }
    end,

    GetModifierDisableTurning   = function (self)
        return 1
    end,

    GetOverrideAnimation        = function (self)
        return ACT_DOTA_SLIDE_LOOP
    end,

    GetEffectName           = function (self)
        return "particles/units/frostivus_penguin/peng_ice_shards_projectile_stout.vpcf"
    end
})

function modifier_sled_penguin_movement:OnCreated( kv )
	if not IsServer() then return end

    local ability = self:GetAbility()
    if ability then
        self.max_sled_speed = ability:GetSpecialValueFor( "max_sled_speed" )
        self.speed_step = ability:GetSpecialValueFor( "speed_step" )
        self.tree_destroy_radius = ability:GetSpecialValueFor( "tree_destroy_radius" )
        self.collision_radius = ability:GetSpecialValueFor( "collision_radius" )
        self.reset_pos_offset = ability:GetSpecialValueFor( "reset_pos_offset" )
        self.impaired_duration = ability:GetSpecialValueFor( "impaired_duration" )
    end

    self.nCurSpeed = 400
    self.flDesiredYaw = self:GetCaster():GetAnglesAsVector().y

    self.EntCooldown = GameRules:GetGameTime() + 0.75

    if kv.just_crashed ~= nil then
        -- self:GetParent():StartGesture( ACT_DOTA_DIE )

        FindClearSpaceForUnit( self:GetParent(), self:GetParent():GetAbsOrigin(), true )

        ParticleManager:ReleaseParticleIndex(ParticleManager:CreateParticle("particles/econ/events/ti9/penguin_death.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent()))
    end

    self.fThinkInterval = 0.033

    self:StartIntervalThink( self.fThinkInterval )
end

function modifier_sled_penguin_movement:OnIntervalThink()
    local parent = self:GetParent()
    local ability = self:GetAbility()

    if self.EntCooldown <= GameRules:GetGameTime() then
        local nTargetFlags = DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
        local hEnemies = FindUnitsInRadius( 
            parent:GetTeamNumber(), 
            parent:GetOrigin(), 
            parent, 
            self.collision_radius, 
            DOTA_UNIT_TARGET_TEAM_ENEMY, 
            ability:GetAbilityTargetType(), 
            nTargetFlags,
            0, 
            false 
        )

        for _, unit in pairs( hEnemies ) do
            if unit and not unit:IsNull() and unit:IsAlive() then
                self:CrashAndRecover(unit)
                return
            end
        end
    end

    -- if self.bStartedLoop == nil and self:GetElapsedTime() > 0.3 then
    --     self.bStartedLoop = true
    --     parent:StartGesture( ACT_DOTA_SLIDE_LOOP )
    -- end

    -- local flTurnAmount = 0.0
    -- local curAngles = parent:GetAngles()

    -- local flAngleDiff = AngleDiff( self.flDesiredYaw, curAngles.y )

    -- local flTurnRate = 100
    -- flTurnAmount = flTurnRate * 0.033
    -- flTurnAmount = math.min( flTurnAmount, math.abs( flAngleDiff ) )

    -- if flAngleDiff < 0.0 then
    --     flTurnAmount = flTurnAmount * -1
    -- end

    -- if flAngleDiff ~= 0.0 then
    --     curAngles.y = curAngles.y + flTurnAmount
    --     parent:SetAbsAngles( curAngles.x, curAngles.y, curAngles.z )
    -- end

    local vNewPos = parent:GetOrigin() + parent:GetForwardVector() * ( 0.033 * self.nCurSpeed )
    if GridNav:CanFindPath( parent:GetOrigin(), vNewPos ) == false then
        self:CrashAndRecover()
        return
    end

    parent:SetAbsOrigin( GetGroundPosition(vNewPos, parent) )
    self.nCurSpeed = math.min( self.nCurSpeed + self.speed_step, self.max_sled_speed )
end

--------------------------------------------------------------------------------

function modifier_sled_penguin_movement:CrashAndRecover(unit)
    local parent = self:GetParent()

	local vForward = parent:GetForwardVector()
    self.vResetPos = parent:GetAbsOrigin() - ( vForward * self.reset_pos_offset )
    if unit then
        for _, PlayerID in ipairs(Players:GetAllPlayers(true)) do
            if Server:IsPlayerPenguinSoundEnabled(PlayerID) then
                EmitSoundOnEntityForPlayer( "Hero_Tusk.IceShards.Penguin", parent, PlayerID )
                EmitSoundOnEntityForPlayer( "SledPenguin.Crash.Impact", parent, PlayerID )
                EmitSoundOnEntityForPlayer( "SledPenguin.Crash.Ow", parent, PlayerID )
            end
        end

        local target_angle = unit:GetAnglesAsVector().y
        local origin_difference =  parent:GetAbsOrigin() - unit:GetAbsOrigin()
        local origin_difference_radian = math.atan2(origin_difference.y, origin_difference.x)
        
        origin_difference_radian = origin_difference_radian * 180
        local angle_from_center = origin_difference_radian / math.pi

        angle_from_center = angle_from_center + 180.0

        local diff = math.abs(target_angle - angle_from_center)

        if diff > 90 and diff < 270 then
            vForward = unit:GetForwardVector() * -1
        end
    end

	parent:SetForwardVector( vForward * -1 )
	parent:SetAbsOrigin( self.vResetPos )

    self:Destroy()

	local kv = {}
	kv.just_crashed = true

	parent:AddNewModifier( parent, self:GetAbility(), "modifier_sled_penguin_movement", kv )
end