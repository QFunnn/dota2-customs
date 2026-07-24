--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_roshan_roshpit_custom_thinker", "heroes/npc_dota_hero_arc_warden_custom/roshan_roshpit_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_roshan_roshpit_custom_thinker_wall", "heroes/npc_dota_hero_arc_warden_custom/roshan_roshpit_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_roshan_roshpit_custom_thinker_stunned", "heroes/npc_dota_hero_arc_warden_custom/roshan_roshpit_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier("modifier_roshan_roshpit_custom_thinker_stun_cooldown", "heroes/npc_dota_hero_arc_warden_custom/roshan_roshpit_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_roshan_roshpit_custom_thinker_friendly", "heroes/npc_dota_hero_arc_warden_custom/roshan_roshpit_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_roshan_roshpit_custom_thinker_friendly_buff", "heroes/npc_dota_hero_arc_warden_custom/roshan_roshpit_custom", LUA_MODIFIER_MOTION_NONE)

roshan_roshpit_custom = class({})

roshan_roshpit_custom.modifier_arc_warden_11 = {1,2,3}

function roshan_roshpit_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_mars.vsndevts", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_mars/mars_arena_of_blood_impact.vpcf", context )
    PrecacheResource( "particle", "particles/roshan_arena_roshpit.vpcf", context )
end

function roshan_roshpit_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function roshan_roshpit_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local duration = self:GetSpecialValueFor("duration")
    CreateModifierThinker(self:GetCaster(), self, "modifier_roshan_roshpit_custom_thinker", {duration = duration}, point, self:GetCaster():GetTeamNumber(), false)
    CreateModifierThinker(self:GetCaster(), self, "modifier_roshan_roshpit_custom_thinker_friendly", {duration = duration}, point, self:GetCaster():GetTeamNumber(), false)
end

modifier_roshan_roshpit_custom_thinker = class({})
function modifier_roshan_roshpit_custom_thinker:IsHidden() return true end

function modifier_roshan_roshpit_custom_thinker:OnCreated( kv )
    self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
    self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
    local delay = self:GetAbility():GetSpecialValueFor("delay")
    if not IsServer() then return end
    self.thinkers = {}

    --for i = 0, 100 - 1 do
    --    local angle = math.rad(360 / 100 * i)
    --    local offset = Vector(math.cos(angle), math.sin(angle), 0) * self.radius
    --    local origin = self:GetParent():GetOrigin() + offset
    --    local pso = SpawnEntityFromTableSynchronous("ent_fow_blocker_node", { origin = origin })
    --    table.insert(self.thinkers, pso)
    --end

    self:StartIntervalThink( 0 )
    local particle = ParticleManager:CreateParticle("particles/roshan_arena_roshpit.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, Vector(self.radius+100,0,0))
    ParticleManager:SetParticleControl(particle, 2, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 4, Vector(self.duration,0,0))
    self:AddParticle( particle, false, false, -1, false, false )
end

function modifier_roshan_roshpit_custom_thinker:OnDestroy()
    if not IsServer() then return end
    local modifiers = {}
    for k,v in pairs(self:GetParent():FindAllModifiers()) do
        modifiers[k] = v
    end
    for k,v in pairs(modifiers) do
        v:Destroy()
    end
    for _, blocker in pairs(self.thinkers) do
        UTIL_Remove(blocker)
    end
    UTIL_Remove( self:GetParent() ) 
end

function modifier_roshan_roshpit_custom_thinker:OnIntervalThink()
    if not IsServer() then return end
    AddFOWViewer( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), self.radius, self.duration, false)
    self:GetParent():AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_roshan_roshpit_custom_thinker_wall", {} )
    self:GetParent():AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_roshan_roshpit_custom_thinker_stunned", {} )
    self:StartIntervalThink(-1)
end

modifier_roshan_roshpit_custom_thinker_wall = class({})

function modifier_roshan_roshpit_custom_thinker_wall:IsHidden()
    return true
end

function modifier_roshan_roshpit_custom_thinker_wall:IsDebuff()
    return true
end

function modifier_roshan_roshpit_custom_thinker_wall:IsPurgable()
    return false
end

function modifier_roshan_roshpit_custom_thinker_wall:OnCreated( kv )
    if not IsServer() then return end
    self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
    self.width = 70
    self.parent = self:GetParent()
    self.twice_width = self.width*2
    self.aura_radius = self.radius + self.twice_width
    self.MAX_SPEED = 550
    self.MIN_SPEED = 1
    self.owner = kv.isProvidedByAura~=1
    if not self.owner then
        self.aura_origin = Vector( kv.aura_origin_x, kv.aura_origin_y, 0 )
        self:StartIntervalThink(FrameTime())
    else
        self.aura_origin = self:GetParent():GetOrigin()
    end
end

function modifier_roshan_roshpit_custom_thinker_wall:OnIntervalThink()
    if not IsServer() then return end
    AddFOWViewer(self:GetParent():GetTeamNumber(), self.aura_origin, self.radius, FrameTime(), false)
end

function modifier_roshan_roshpit_custom_thinker_wall:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_FIXED_DAY_VISION,
        MODIFIER_PROPERTY_FIXED_NIGHT_VISION,
        MODIFIER_PROPERTY_BONUS_VISION_PERCENTAGE,
    }
end

function modifier_roshan_roshpit_custom_thinker_wall:GetModifierMoveSpeed_Limit( params )
    if not IsServer() then return end
    if self.owner then return 0 end
    local parent_vector = self.parent:GetOrigin()-self.aura_origin
    local parent_direction = parent_vector:Normalized()

    local actual_distance = parent_vector:Length2D()
    local wall_distance = actual_distance-self.radius
    local isInside = (wall_distance)<0
    wall_distance = math.min( math.abs( wall_distance ), self.twice_width )
    wall_distance = math.max( wall_distance, self.width ) - self.width

    local parent_angle = 0
    if isInside then
        parent_angle = VectorToAngles(parent_direction).y
    else
        parent_angle = VectorToAngles(-parent_direction).y
    end
    local unit_angle = self:GetParent():GetAnglesAsVector().y
    local wall_angle = math.abs( AngleDiff( parent_angle, unit_angle ) )

    local limit = 0
    if wall_angle>90 then
        limit = 0
        if not self:GetParent():IsDebuffImmune() then
            self:GetParent():RemoveModifierByName("modifier_item_forcestaff_active")
            self:GetParent():RemoveModifierByName("modifier_force_boots_active")
            self:GetParent():RemoveModifierByName("modifier_item_hurricane_pike_active")
        end
    else
        limit = self:Interpolate( wall_distance/self.width, self.MIN_SPEED, self.MAX_SPEED )
    end

    return limit
end

function modifier_roshan_roshpit_custom_thinker_wall:GetBonusVisionPercentage() 
    if self.owner then return 0 end
    return -100  
end
    
function modifier_roshan_roshpit_custom_thinker_wall:GetFixedDayVision()
    if self.owner then return 0 end
    return 0
end
    
function modifier_roshan_roshpit_custom_thinker_wall:GetFixedNightVision()
    if self.owner then return 0 end
    return 0
end

function modifier_roshan_roshpit_custom_thinker_wall:Interpolate( value, min, max )
    return value*(max-min) + min
end

function modifier_roshan_roshpit_custom_thinker_wall:IsAura()
    return self.owner
end

function modifier_roshan_roshpit_custom_thinker_wall:GetModifierAura()
    return "modifier_roshan_roshpit_custom_thinker_wall"
end

function modifier_roshan_roshpit_custom_thinker_wall:GetAuraRadius()
    return self.aura_radius
end

function modifier_roshan_roshpit_custom_thinker_wall:GetAuraDuration()
    return 0.3
end

function modifier_roshan_roshpit_custom_thinker_wall:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_roshan_roshpit_custom_thinker_wall:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_roshan_roshpit_custom_thinker_wall:GetAuraSearchFlags()
    return 0
end

function modifier_roshan_roshpit_custom_thinker_wall:GetAuraEntityReject( unit )
    if not IsServer() then return end
    return false
end

modifier_roshan_roshpit_custom_thinker_stunned = class({})

function modifier_roshan_roshpit_custom_thinker_stunned:IsHidden()
    return true
end

function modifier_roshan_roshpit_custom_thinker_stunned:IsDebuff()
    return true
end

function modifier_roshan_roshpit_custom_thinker_stunned:IsPurgable()
    return true
end

function modifier_roshan_roshpit_custom_thinker_stunned:OnCreated( kv )
    self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
    self.width = 80 
    self.duration = 0.05
    self.knockback_duration = 0.2
    self.parent = self:GetParent()
    self.spear_radius = self.radius-self.width
    if not IsServer() then return end
    self.owner = kv.isProvidedByAura~=1
    self.aura_origin = self:GetParent():GetOrigin()
    if not self.owner then
        self.aura_origin = Vector( kv.aura_origin_x, kv.aura_origin_y, 0 )
        local direction = self.aura_origin-self:GetParent():GetOrigin()
        direction.z = 0
        if not self:GetParent():IsDebuffImmune() then
            self:GetParent():RemoveModifierByName("modifier_item_forcestaff_active")
            self:GetParent():RemoveModifierByName("modifier_force_boots_active")
            self:GetParent():RemoveModifierByName("modifier_item_hurricane_pike_active")
            self:GetParent():AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_generic_knockback_lua", { duration = self.knockback_duration, distance = 150, height = 30, direction_x = direction.x, direction_y = direction.y})
            self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_roshan_roshpit_custom_thinker_stun_cooldown", {duration = self:GetAbility().modifier_arc_warden_11[self:GetCaster():GetTalentLevel("modifier_arc_warden_11")]})
            self:PlayEffects( self:GetParent() )
            if self:GetCaster():HasModifier("modifier_arc_warden_11") then
                self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stunned", {duration = self:GetAbility().modifier_arc_warden_11[self:GetCaster():GetTalentLevel("modifier_arc_warden_11")]})
            end
        end
    end
end

function modifier_roshan_roshpit_custom_thinker_stunned:IsAura()
    return self.owner
end

function modifier_roshan_roshpit_custom_thinker_stunned:GetModifierAura()
    return "modifier_roshan_roshpit_custom_thinker_stunned"
end

function modifier_roshan_roshpit_custom_thinker_stunned:GetAuraRadius()
    return self.radius
end

function modifier_roshan_roshpit_custom_thinker_stunned:GetAuraDuration()
    return self.duration
end

function modifier_roshan_roshpit_custom_thinker_stunned:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_roshan_roshpit_custom_thinker_stunned:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_roshan_roshpit_custom_thinker_stunned:GetAuraSearchFlags()
    return 0
end

function modifier_roshan_roshpit_custom_thinker_stunned:GetAuraEntityReject( unit )
    if not IsServer() then return end
    if unit:HasFlyMovementCapability() then return true end
    if unit:IsCurrentlyVerticalMotionControlled() then return true end
    if unit:FindModifierByNameAndCaster( "modifier_roshan_roshpit_custom_thinker_stunned", self:GetCaster() ) then
        return true
    end
    local distance = (unit:GetOrigin()-self.aura_origin):Length2D()
    if (distance-self.spear_radius)<0 then
        return true
    end
    return false
end

function modifier_roshan_roshpit_custom_thinker_stunned:PlayEffects( target )
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_mars/mars_arena_of_blood_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
    target:EmitSound("Hero_Mars.Spear.Knockback")
end

modifier_roshan_roshpit_custom_thinker_stun_cooldown = class({})
function modifier_roshan_roshpit_custom_thinker_stun_cooldown:IsHidden() return true end
function modifier_roshan_roshpit_custom_thinker_stun_cooldown:IsPurgable() return false end



modifier_roshan_roshpit_custom_thinker_friendly = class({})

function modifier_roshan_roshpit_custom_thinker_friendly:IsAura()
    return true
end

function modifier_roshan_roshpit_custom_thinker_friendly:GetModifierAura()
    return "modifier_roshan_roshpit_custom_thinker_friendly_buff"
end

function modifier_roshan_roshpit_custom_thinker_friendly:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_roshan_roshpit_custom_thinker_friendly:GetAuraDuration()
    return 0.1
end

function modifier_roshan_roshpit_custom_thinker_friendly:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_roshan_roshpit_custom_thinker_friendly:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_roshan_roshpit_custom_thinker_friendly:GetAuraSearchFlags()
    return 0
end

modifier_roshan_roshpit_custom_thinker_friendly_buff = class({})
function modifier_roshan_roshpit_custom_thinker_friendly_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_roshan_roshpit_custom_thinker_friendly_buff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("bonus_speed")
end