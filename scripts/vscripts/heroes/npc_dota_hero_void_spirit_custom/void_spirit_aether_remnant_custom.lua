--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_void_remnant_thinker", "heroes/npc_dota_hero_void_spirit_custom/void_spirit_aether_remnant_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_void_remnant_target", "heroes/npc_dota_hero_void_spirit_custom/void_spirit_aether_remnant_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_void_remnant_buff", "heroes/npc_dota_hero_void_spirit_custom/void_spirit_aether_remnant_custom", LUA_MODIFIER_MOTION_NONE)

void_spirit_aether_remnant_custom = class({})

void_spirit_aether_remnant_custom.modifier_void_spirit_2 = {50,100,150}
void_spirit_aether_remnant_custom.modifier_void_spirit_3 = 5
void_spirit_aether_remnant_custom.modifier_void_spirit_3_damage = {5,10,15}
void_spirit_aether_remnant_custom.modifier_void_spirit_1 = 30
void_spirit_aether_remnant_custom.modifier_void_spirit_1_duration_mult = 0.5

function void_spirit_aether_remnant_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_void_spirit_1") then
        return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_MOVEMENT + DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING + DOTA_ABILITY_BEHAVIOR_AUTOCAST
    end
    return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_MOVEMENT + DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING
end

function void_spirit_aether_remnant_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/void_spirit_attack_alt_blur.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/void_spirit_attack_alt_02_blur.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_run.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_pre.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_watch.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_pull.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_flash.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_void_spirit_aether_remnant.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_run_red.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_pre_red.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_watch_red.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_void_spirit.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_void_spirit.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_void_spirit.vpcf", context)
end

function void_spirit_aether_remnant_custom:OnVectorCastStart(vStartLocation, vDirection)
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    if point == self:GetCaster():GetAbsOrigin() then 
        point = self:GetCaster():GetAbsOrigin() + 10*self:GetCaster():GetForwardVector()
    end 
    local thinker = CreateModifierThinker( caster,  self, "modifier_custom_void_remnant_thinker",  { dir_x = vDirection.x, dir_y = vDirection.y, dir_z = vDirection.z, main = 1},  point, caster:GetTeamNumber(), false)
    caster:EmitSound("Hero_VoidSpirit.AetherRemnant.Cast")
    if self:GetCaster():HasModifier("modifier_void_spirit_3") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_custom_void_remnant_buff", {duration = self.modifier_void_spirit_3})
    end
end

local STATE_RUN = 1
local STATE_DELAY = 2
local STATE_WATCH = 3
local STATE_PULL = 4

modifier_custom_void_remnant_thinker = class({})

function modifier_custom_void_remnant_thinker:OnCreated( kv )
    self.interval = FrameTime()
    self.delay = self:GetAbility():GetSpecialValueFor( "activation_delay" )
    self.speed = self:GetAbility():GetSpecialValueFor( "projectile_speed" )
    self.width = self:GetAbility():GetSpecialValueFor( "remnant_watch_radius" )
    self.distance = self:GetAbility():GetSpecialValueFor( "remnant_watch_distance" )
    self.watch_vision = self:GetAbility():GetSpecialValueFor( "watch_path_vision_radius" )
    self.pull_duration = self:GetAbility():GetSpecialValueFor( "pull_duration" )
    self.pull = self:GetAbility():GetSpecialValueFor( "pull_destination" )
    self.damage = self:GetAbility():GetSpecialValueFor( "impact_damage" )
    if self:GetCaster():HasModifier("modifier_void_spirit_2") then
        self.damage = self.damage + (self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_void_spirit_2[self:GetCaster():GetTalentLevel("modifier_void_spirit_2")])
    end
    self.damage_tick_rate = self:GetAbility():GetSpecialValueFor("damage_tick_rate")
    self.creep_damage_pct = self:GetAbility():GetSpecialValueFor("creep_damage_pct")/100
    self.creeps_count = 1
    self.modifier_void_spirit_5 = self:GetCaster():HasModifier("modifier_void_spirit_5") and kv.main
    if not IsServer() then return end
    self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
    self.abilityTargetTeam = self:GetAbility():GetAbilityTargetTeam()
    self.abilityTargetType = self:GetAbility():GetAbilityTargetType()
    self.abilityTargetFlags = self:GetAbility():GetAbilityTargetFlags()
    self.origin = self:GetParent():GetAbsOrigin()
    self.start_origin = self:GetCaster():GetAbsOrigin()
    self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
    if self:GetAbility():GetAutoCastState() then
        self.duration = self.duration * self:GetAbility().modifier_void_spirit_1_duration_mult
    end
    if kv.new_point_x then
        self.start_origin = Vector(kv.new_point_x, kv.new_point_y, kv.new_point_z)
        self.duration = kv.new_duration
    end
    self.IsAuto = self:GetAbility():GetAutoCastState()
    self.direction = Vector( kv.dir_x, kv.dir_y, kv.dir_z )
    self.watcher_direction = Vector( kv.dir_x, kv.dir_y, kv.dir_z )
    self.main = kv.main
    self.target = GetGroundPosition( self.origin + self.direction * self.distance, nil )
    local run_dist = (self.origin-self.start_origin):Length2D()
    local run_delay = run_dist/self.speed
    local delay_teleportation = run_dist/self.speed
    self.check_origin = self.start_origin
    local check_direction = self.origin - self.check_origin
    self.check_direction = check_direction:Normalized()
    Timers:CreateTimer(FrameTime(), function()
        delay_teleportation = delay_teleportation - FrameTime()
        self.check_origin = self.check_origin + self.check_direction * (self.speed * FrameTime())
        if delay_teleportation <= 0 then
            return
        end
        return FrameTime()
    end)
    self.state = STATE_RUN
    self:StartIntervalThink( run_delay )
    self:PlayEffects1()
end

function modifier_custom_void_remnant_thinker:OnRefresh( kv )
	if not IsServer() then return end
	self.state = kv.state
end

function modifier_custom_void_remnant_thinker:OnDestroy()
	if not IsServer() then return end
	self:GetParent():StopSound( "Hero_VoidSpirit.AetherRemnant.Spawn_lp" )
	self:PlayEffects5()
	UTIL_Remove( self:GetParent() )
end

function modifier_custom_void_remnant_thinker:OnIntervalThink()
	if self.state == STATE_RUN then
		self.state = STATE_DELAY
		self:StartIntervalThink( self.delay )
		self:PlayEffects2()
		return
	elseif self.state == STATE_DELAY then
		self.state = STATE_WATCH
		self:StartIntervalThink( self.interval )
		self:SetDuration( self.duration, false )
		self:PlayEffects3()
		return
	elseif self.state == STATE_WATCH then
		self:WatchLogic()
	else
		self:StartIntervalThink( -1 )
	end
end

function modifier_custom_void_remnant_thinker:WatchLogic()
    if not IsServer() then return end
    self.watcher_direction = RotateVector2D( self.watcher_direction, ToRadians( -1.5 ) )
    if self.shard_watcher then
        local target = GetGroundPosition( self.origin + self.watcher_direction * self.distance, nil )
        ParticleManager:SetParticleControl( self.shard_watcher, 0, self.origin )
        ParticleManager:SetParticleControl( self.shard_watcher, 1, target )
        ParticleManager:SetParticleControlForward( self.shard_watcher, 0, self.watcher_direction )
        ParticleManager:SetParticleControlForward( self.shard_watcher, 2, self.watcher_direction )
    end
    if not self:CheckoutPosition(self.origin, self.direction) then
        if self.modifier_void_spirit_5 then
            self:CheckoutPosition(self.origin, self.watcher_direction)
        end
    end
end

function ToRadians(degrees)
    return degrees * math.pi / 180
end

function RotateVector2D(vector, theta)
    local xp = vector.x*math.cos(theta)-vector.y*math.sin(theta)
    local yp = vector.x*math.sin(theta)+vector.y*math.cos(theta)
    return Vector(xp,yp,vector.z):Normalized()
end

function modifier_custom_void_remnant_thinker:CheckoutPosition(start_point, direction)
    local target = GetGroundPosition( start_point + direction * self.distance, nil )
    AddFOWViewer( self:GetParent():GetTeamNumber(), start_point, self.watch_vision, 0.1, true)
    AddFOWViewer( self:GetParent():GetTeamNumber(), start_point + direction * self.distance / 2, self.watch_vision, 0.1, true)
    AddFOWViewer( self:GetParent():GetTeamNumber(), target, self.watch_vision, 0.1, true)
    local origin = start_point + 150 * direction
    local targets_flag = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
    local enemies_heroes = FindUnitsInLine( self:GetCaster():GetTeamNumber(), origin, target, nil, self.width, self.abilityTargetTeam, targets_flag, self.abilityTargetFlags)
    if #enemies_heroes==0 then return false end
    local min = 999
    local min_i = 0
    for i,enemy in pairs(enemies_heroes) do 
        if enemy:HasModifier("modifier_custom_void_remnant_target") then 
            table.remove(enemies_heroes,i)
        end
    end
    if #enemies_heroes==0 then return false end
    for i = 1,#enemies_heroes do
        if (enemies_heroes[i]:GetAbsOrigin() - origin):Length2D() <= min then 
            min = (enemies_heroes[i]:GetAbsOrigin() - origin):Length2D()
            min_i = i
        end
    end
    if min_i == 0 then return false end
    local enemies_heroes = FindUnitsInLine( self:GetCaster():GetTeamNumber(), origin, target, nil,	 self.width, self.abilityTargetTeam, targets_flag, self.abilityTargetFlags)
    if self.IsAuto then
        self.creeps_count = self.creeps_count + self.interval
        if self.creeps_count >= 0.5 then 
            self.creeps_count = 0
            for _, creep in pairs(enemies_heroes) do 
                local damageTable = {victim = creep, attacker = self:GetCaster(), damage = (self.damage * self:GetAbility().modifier_void_spirit_1 / 100) * 0.5, damage_type = self.abilityDamageType, ability = self:GetAbility()}
                ApplyDamage(damageTable)
            end
        end
        return
    end
    local enemy = enemies_heroes[min_i]
    local stun_duration = self.pull_duration*(1 - enemy:GetStatusResistance())
    enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_custom_void_remnant_target", {duration = stun_duration, pos_x = start_point.x, pos_y = start_point.y, pull = self.pull, durat = self.pull_duration })
    ApplyDamage({victim = enemy, attacker = self:GetCaster(), damage = self.damage, damage_type = self.abilityDamageType, ability = self:GetAbility()})
    self.state = STATE_PULL
    self:SetDuration( self.pull_duration*(1 - enemy:GetStatusResistance()), false )
    local direction = enemy:GetOrigin()-start_point
    local dist = direction:Length2D()
    direction.z = 0
    direction = direction:Normalized()
    AddFOWViewer( self:GetParent():GetTeamNumber(), start_point, self.watch_vision, self.pull_duration, true)
    AddFOWViewer( self:GetParent():GetTeamNumber(), start_point + direction*dist/2, self.watch_vision, self.pull_duration, true)
    AddFOWViewer( self:GetParent():GetTeamNumber(), enemy:GetOrigin(), self.watch_vision, self.pull_duration, true)
    self:PlayEffects4( enemy )
    return true
end

function modifier_custom_void_remnant_thinker:PlayEffects1()
    local direction = self.origin-self.start_origin
    direction.z = 0
    direction = direction:Normalized()
    local particle_name = "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_run.vpcf"
    if self.IsAuto then
        particle_name = "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_run_red.vpcf"
    end
    local effect_cast = ParticleManager:CreateParticle( particle_name, PATTACH_CUSTOMORIGIN, self:GetParent() )
    ParticleManager:SetParticleControlEnt(effect_cast, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetOrigin() , true)
    ParticleManager:SetParticleControl( effect_cast, 1, direction * self.speed )
    ParticleManager:SetParticleControlForward( effect_cast, 0, -direction )
    self.effect_cast = effect_cast
    self:GetParent():EmitSound("Hero_VoidSpirit.AetherRemnant")
end

function modifier_custom_void_remnant_thinker:PlayEffects2()
    if self.effect_cast then
        ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end
    local particle_name = "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_pre.vpcf"
    if self.IsAuto then
        particle_name = "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_pre_red.vpcf"
    end
    local effect_cast = ParticleManager:CreateParticle( particle_name, PATTACH_CUSTOMORIGIN, self:GetParent() )
    ParticleManager:SetParticleControl( effect_cast, 0, self.origin )
    ParticleManager:SetParticleControlForward( effect_cast, 0, self.direction )
    ParticleManager:SetParticleControlEnt( effect_cast, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
    self.effect_cast = effect_cast
end

function modifier_custom_void_remnant_thinker:PlayEffects3()
    if self.effect_cast then
        ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end
    local particle_name = "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_watch.vpcf"
    if self.IsAuto then
        particle_name = "particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_watch_red.vpcf"
    end
    local effect_cast = ParticleManager:CreateParticle( particle_name, PATTACH_CUSTOMORIGIN, self:GetParent() )
    ParticleManager:SetParticleControl( effect_cast, 0, self.origin )
    ParticleManager:SetParticleControl( effect_cast, 1, self.target )
    ParticleManager:SetParticleControlEnt(effect_cast, 3, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
    ParticleManager:SetParticleControlForward( effect_cast, 0, self.direction )
    ParticleManager:SetParticleControlForward( effect_cast, 2, self.direction )
    self.effect_cast = effect_cast

    if self.modifier_void_spirit_5 then
        self.shard_watcher = ParticleManager:CreateParticle( particle_name, PATTACH_CUSTOMORIGIN, self:GetParent() )
        ParticleManager:SetParticleControl( self.shard_watcher, 0, self.origin )
        ParticleManager:SetParticleControl( self.shard_watcher, 1, self.target )
        ParticleManager:SetParticleControlEnt(self.shard_watcher, 3, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
        ParticleManager:SetParticleControlForward( self.shard_watcher, 0, self.direction )
        ParticleManager:SetParticleControlForward( self.shard_watcher, 2, self.direction )
    end

    self:GetParent():EmitSound("Hero_VoidSpirit.AetherRemnant.Spawn_lp")
end

function modifier_custom_void_remnant_thinker:PlayEffects4( target, illusion )
    if self.effect_cast then
        ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end
    if self.shard_watcher then
        ParticleManager:DestroyParticle( self.shard_watcher, false )
        ParticleManager:ReleaseParticleIndex( self.shard_watcher )
    end
    local direction = target:GetOrigin()-self.origin
    direction.z = 0
    direction = -direction:Normalized()
    local effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_void_spirit/aether_remnant/void_spirit_aether_remnant_pull.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent() )
    ParticleManager:SetParticleControlEnt(effect_cast, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
    ParticleManager:SetParticleControlEnt(effect_cast, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true )
    ParticleManager:SetParticleControl(effect_cast, 2, Vector(target:GetAbsOrigin().x, target:GetAbsOrigin().y, target:GetAbsOrigin().z + 150) )
    ParticleManager:SetParticleControlForward( effect_cast, 2, direction )
    ParticleManager:SetParticleControl(effect_cast, 3, self.origin )
    self.effect_cast = effect_cast
    self:GetParent():EmitSound("Hero_VoidSpirit.AetherRemnant.Triggered")
    target:EmitSound("Hero_VoidSpirit.AetherRemnant.Target")
end

function modifier_custom_void_remnant_thinker:PlayEffects5()
    if self.effect_cast then
        ParticleManager:DestroyParticle( self.effect_cast, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end

    self:GetParent():EmitSound("Hero_VoidSpirit.AetherRemnant.Destroy")
end

function modifier_custom_void_remnant_thinker:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PROVIDES_FOW_POSITION
    }
end

function modifier_custom_void_remnant_thinker:GetModifierProvidesFOWVision() 
    return 1 
end

modifier_custom_void_remnant_target = class({})
function modifier_custom_void_remnant_target:IsHidden() return false end
function modifier_custom_void_remnant_target:IsDebuff() return true end
function modifier_custom_void_remnant_target:IsStunDebuff() return true end
function modifier_custom_void_remnant_target:IsPurgable() return true end
function modifier_custom_void_remnant_target:GetPriority() return 20 end
function modifier_custom_void_remnant_target:OnCreated( kv )
    if not IsServer() then return end
    self.target = Vector( kv.pos_x, kv.pos_y, 0 )
    local dist = (self:GetParent():GetOrigin()-self.target):Length2D()
    self.speed = kv.pull/100*dist/kv.durat
    if not self:GetParent():IsDebuffImmune() then 
        self:GetParent():MoveToPosition( self.target )
    end
    self.mod = self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_truesight", {})
end

function modifier_custom_void_remnant_target:OnRefresh( kv )
    self:OnCreated( kv )
end

function modifier_custom_void_remnant_target:OnDestroy()
    if not IsServer() then return end
    if not self:GetParent():IsDebuffImmune() then 
        self:GetParent():Stop()
    end 
    if self.mod and not self.mod:IsNull() then
        self.mod:Destroy()
    end
end

function modifier_custom_void_remnant_target:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
        MODIFIER_PROPERTY_MOVESPEED_MAX_OVERRIDE,
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MAX,
    }
end

function modifier_custom_void_remnant_target:GetModifierMoveSpeed_Absolute()
    if IsServer() then 
        return self.speed 
    end
end

function modifier_custom_void_remnant_target:GetModifierMoveSpeed_MaxOverride()
    if IsServer() then 
        return self.speed 
    end
end

function modifier_custom_void_remnant_target:GetModifierMoveSpeed_AbsoluteMax()
    if IsServer() then 
        return self.speed 
    end
end

function modifier_custom_void_remnant_target:CheckState()
    return
    {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
        [MODIFIER_STATE_TAUNTED] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_DISARMED] = true
    }
end

function modifier_custom_void_remnant_target:GetStatusEffectName()
	return "particles/status_fx/status_effect_void_spirit_aether_remnant.vpcf"
end

function modifier_custom_void_remnant_target:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

modifier_custom_void_remnant_buff = class({})

function modifier_custom_void_remnant_buff:GetTexture() return "void_spirit_3" end

function modifier_custom_void_remnant_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
    }
end

function modifier_custom_void_remnant_buff:GetModifierTotalDamageOutgoing_Percentage()
    return self:GetAbility().modifier_void_spirit_3_damage[self:GetCaster():GetTalentLevel("modifier_void_spirit_3")]
end