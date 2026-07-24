--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_snapfire_mortimer_kisses_custom", "abilities/snapfire/snapfire_mortimer_kisses_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_mortimer_kisses_custom_thinker", "abilities/snapfire/snapfire_mortimer_kisses_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_mortimer_kisses_custom_damage_reduce", "abilities/snapfire/snapfire_mortimer_kisses_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_mortimer_kisses_custom_debuff", "abilities/snapfire/snapfire_mortimer_kisses_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_mortimer_kisses_custom_tracker", "abilities/snapfire/snapfire_mortimer_kisses_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_mortimer_kisses_custom_napalm", "abilities/snapfire/snapfire_mortimer_kisses_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_mortimer_kisses_custom_legendary", "abilities/snapfire/snapfire_mortimer_kisses_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_mortimer_kisses_custom_legendary_count", "abilities/snapfire/snapfire_mortimer_kisses_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_mortimer_kisses_custom_stun_check", "abilities/snapfire/snapfire_mortimer_kisses_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_mortimer_kisses_custom_scatter", "abilities/snapfire/snapfire_mortimer_kisses_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_mortimer_kisses_custom_heal_reduce", "abilities/snapfire/snapfire_mortimer_kisses_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_mortimer_kisses_custom_immune", "abilities/snapfire/snapfire_mortimer_kisses_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_mortimer_kisses_custom_blink", "abilities/snapfire/snapfire_mortimer_kisses_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_mortimer_kisses_custom_cdr", "abilities/snapfire/snapfire_mortimer_kisses_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_mortimer_kisses_custom_root", "abilities/snapfire/snapfire_mortimer_kisses_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_mortimer_kisses_custom_root_count", "abilities/snapfire/snapfire_mortimer_kisses_custom", LUA_MODIFIER_MOTION_NONE )


snapfire_mortimer_kisses_custom = class({})


function snapfire_mortimer_kisses_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/snapfire_lizard_blobs_arced.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_batrider/batrider_stickynapalm_impact.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_impact.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_linger.vpcf", context )
PrecacheResource( "particle","particles/hero_snapfire_ultimate_linger_longer.vpcf", context )
PrecacheResource( "particle","particles/alch_stun_legendary.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/star_emblem_friend_shield.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/hero_snapfire_burn_debuff.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_snapfire_magma.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_batrider/batrider_stickynapalm_debuff.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_stickynapalm.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_batrider/batrider_stickynapalm_stack.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_lone_druid/lone_druid_bear_blink_end.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_lone_druid/lone_druid_bear_blink_end.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_doom_bringer/doom_bringer_devour.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_snapfire/snapfire_flaming_creep.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_life_stealer/life_stealer_infested_unit_icon.vpcf", context )
PrecacheResource( "particle","particles/snapfire/fire_long.vpcf", context )
PrecacheResource( "particle","particles/beast_root.vpcf", context )
PrecacheResource( "particle","particles/snapfire/kisses_legendary_radius.vpcf", context )

end

function snapfire_mortimer_kisses_custom:GetBehavior()
if self:GetCaster():HasModifier("modifier_snapfire_mortimer_kisses_custom_blink") then
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end
return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_MOVEMENT + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK
end

function snapfire_mortimer_kisses_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_snapfire_mortimer_kisses_custom_tracker"
end

function snapfire_mortimer_kisses_custom:GetManaCost(iLevel)
if self:GetCaster():HasModifier("modifier_snapfire_mortimer_kisses_custom_blink") then
    return 0
end
return self.BaseClass.GetManaCost(self, iLevel)
end

function snapfire_mortimer_kisses_custom:GetCooldown(iLevel)
local upgrade_cooldown = 0
if self:GetCaster():HasTalent("modifier_snapfire_kisses_1") then 
  upgrade_cooldown = self:GetCaster():GetTalentValue("modifier_snapfire_kisses_1", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + upgrade_cooldown
end

function snapfire_mortimer_kisses_custom:GetAOERadius()
return self:GetSpecialValueFor( "impact_radius" )
end

function snapfire_mortimer_kisses_custom:MaxShots()
return self:GetSpecialValueFor("projectile_count") + self:GetCaster():GetTalentValue("modifier_snapfire_kisses_2", "max")
end

function snapfire_mortimer_kisses_custom:OnSpellStart()

local caster = self:GetCaster()

local mod = caster:FindModifierByName("modifier_snapfire_mortimer_kisses_custom_blink")
if mod and caster:HasModifier("modifier_snapfire_mortimer_kisses_custom") then

    local dist = caster:GetTalentValue("modifier_snapfire_kisses_5", "range")
    local vec = caster:GetForwardVector()
    local point = caster:GetAbsOrigin() - vec*dist

    EmitSoundOnLocationWithCaster(caster:GetAbsOrigin(), "Snapfire.Kisses_blink", caster)

    local effect = ParticleManager:CreateParticle("particles/items3_fx/blink_overwhelming_start.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect, 0, caster:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(effect)

    FindClearSpaceForUnit(caster, point, false)
    caster:SetForwardVector(vec)
    caster:FaceTowards(caster:GetAbsOrigin() + vec*10)
    ProjectileManager:ProjectileDodge(caster)

    caster:GenericParticle("particles/items3_fx/blink_overwhelming_end.vpcf")

    local smash2 = ParticleManager:CreateParticle("particles/items3_fx/blink_overwhelming_burst.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(smash2, 0, caster:GetAbsOrigin())
    ParticleManager:SetParticleControl(smash2, 1, Vector(350, 350, 350))
    ParticleManager:DestroyParticle(smash2, false)
    ParticleManager:ReleaseParticleIndex(smash2)

    self:EndCd()
    mod:Destroy()
    return
end

local point = self:GetCursorPosition()

if point == caster:GetAbsOrigin() then 
    point = caster:GetAbsOrigin() + caster:GetForwardVector()*10
end

local duration = self:GetDuration()

if caster:HasTalent("modifier_snapfire_kisses_5") then 
    caster:EmitSound("Snapfire.Kisses_bkb")
    caster:AddNewModifier(caster, self, "modifier_generic_debuff_immune", {effect = 1, duration = caster:GetTalentValue("modifier_snapfire_kisses_5", "bkb")})
    caster:AddNewModifier(caster, self, "modifier_snapfire_mortimer_kisses_custom_immune", {duration = caster:GetTalentValue("modifier_snapfire_kisses_5", "bkb")})
    caster:AddNewModifier(caster, self, "modifier_snapfire_mortimer_kisses_custom_blink", {duration = duration})
end

caster:AddNewModifier( caster, self, "modifier_snapfire_mortimer_kisses_custom", {duration = duration, pos_x = point.x,  pos_y = point.y, })
end


function snapfire_mortimer_kisses_custom:LauchBall(location, damage_ability, new_caster)
local caster = self:GetCaster()
local min_range = self:GetSpecialValueFor( "min_range" )
local max_range = self:GetCastRange( Vector(0,0,0), nil )
    
local min_travel = self:GetSpecialValueFor( "min_lob_travel_time" )
local max_travel = self:GetSpecialValueFor( "max_lob_travel_time" )
local projectile_speed = self:GetSpecialValueFor( "projectile_speed" )
local projectile_vision = self:GetSpecialValueFor( "projectile_vision" )
local damage = 1 

local source_loc = caster:GetAbsOrigin()
local source = caster
local source_attach = caster:GetAttachmentOrigin(caster:ScriptLookupAttachment("attach_mount_head")) + Vector(0, 0, 50)

local ability = -1
if damage_ability then
    ability = damage_ability
end

if ability == "shard" then
    min_travel = 0.2
    min_range = 0
    local ability = caster:FindAbilityByName("snapfire_firesnap_cookie_custom")
    if ability then
        damage = ability:GetSpecialValueFor("shard_damage")/100
    end
end

if ability == "modifier_snapfire_kisses_7" and new_caster then
    damage = caster:GetTalentValue("modifier_snapfire_kisses_7", "damage")/100
    source_loc = new_caster:GetAbsOrigin()
    source = new_caster
    source_attach = new_caster:GetAttachmentOrigin(new_caster:ScriptLookupAttachment("attach_mount_head")) + Vector(0, 0, 100)
end


local info = 
{
    Source = source,
    Ability = self,    
    bDodgeable = false,
    vSourceLoc = source_loc, 
    iSourceAttachment = source_attach,
    bDrawsOnMinimap = false, 
    bVisibleToEnemies = true,
    bProvidesVision = true,
    iVisionRadius = projectile_vision,
    iVisionTeamNumber = caster:GetTeamNumber(),
}

local origin = source:GetOrigin()
local vec = location-origin
local direction = vec
direction.z = 0
direction = direction:Normalized()

if vec:Length2D()<min_range then
    vec = direction * min_range
elseif vec:Length2D()>max_range then
    vec = direction * max_range
end

local travel_range = max_travel-min_travel
local range = max_range-min_range
local target = GetGroundPosition( origin + vec, nil )
local travel_time = (vec:Length2D()-min_range)/range * travel_range + min_travel

if caster:HasTalent("modifier_snapfire_kisses_6") then
    travel_time = travel_time * (1 - caster:GetTalentValue("modifier_snapfire_kisses_6", "speed")/100)

    if ability == -1 then
        caster:AddNewModifier(caster, self, "modifier_snapfire_mortimer_kisses_custom_root_count", {duration = travel_time + 1})
    end
end

local thinker = CreateModifierThinker( caster, self,  "modifier_snapfire_mortimer_kisses_custom_thinker", {travel_time = travel_time }, target, caster:GetTeamNumber(),  false )

local speed = (vec:Length2D()/travel_time)

info.iMoveSpeed = speed
info.Target = thinker

local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_snapfire/snapfire_lizard_blobs_arced.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl( particle, 0, source_attach)
--ParticleManager:SetParticleControlForward( particle, 0, source:GetForwardVector() )
ParticleManager:SetParticleControl(particle, 1, target )
ParticleManager:SetParticleControl(particle, 2, Vector(speed, 0, 0))

info.ExtraData = 
{
    damage = damage,
    damage_ability = ability,
    particle = particle
}

ProjectileManager:CreateTrackingProjectile( info )


AddFOWViewer( caster:GetTeamNumber(), thinker:GetOrigin(), 100, 1, false )
source:EmitSound("Hero_Snapfire.MortimerBlob.Launch")
end 


function snapfire_mortimer_kisses_custom:OnProjectileHit_ExtraData(target, location, extraData)
if not target then return end
local caster = self:GetCaster()

if extraData.particle then
    ParticleManager:DestroyParticle(extraData.particle, false)
    ParticleManager:ReleaseParticleIndex(extraData.particle)
end

local k = 1
if extraData.damage then 
    k = extraData.damage
end

local damage_ability = nil
if extraData.damage_ability and extraData.damage_ability ~= -1 then
    damage_ability = extraData.damage_ability
end

local damage = self:GetSpecialValueFor( "damage_per_impact" )*k
local duration = self:GetSpecialValueFor( "burn_ground_duration" ) + caster:GetTalentValue("modifier_snapfire_kisses_4", "fire_duration")
local impact_radius = self:GetSpecialValueFor( "impact_radius" )
local vision = self:GetSpecialValueFor( "projectile_vision" )
local heal_reduce_duration = caster:GetTalentValue("modifier_snapfire_kisses_2", "duration")
local root_duration = caster:GetTalentValue("modifier_snapfire_kisses_6", "root")

local root_mod = caster:FindModifierByName("modifier_snapfire_mortimer_kisses_custom_root_count")

local damageTable = {attacker = caster, damage = damage, damage_type = self:GetAbilityDamageType(), ability = self}
for _,enemy in pairs(caster:FindTargets(impact_radius, location)) do

    if caster:HasTalent("modifier_snapfire_kisses_2") then
        enemy:AddNewModifier(caster, self, "modifier_snapfire_mortimer_kisses_custom_heal_reduce", {duration = heal_reduce_duration})
    end

    if enemy:IsRealHero() and not damage_ability then
        caster:AddNewModifier(caster, self, "modifier_snapfire_mortimer_kisses_custom_cdr", {})
    end

    if caster:HasTalent("modifier_snapfire_kisses_6") and not damage_ability and root_mod and not root_mod.targets[enemy:entindex()]  then
        root_mod.targets[enemy:entindex()] = true
        enemy:EmitSound("Snapfire.Kisses_root")
        enemy:AddNewModifier(caster, self, "modifier_snapfire_mortimer_kisses_custom_root", {duration = (1 - enemy:GetStatusResistance())*root_duration}) 
    end

    damageTable.victim = enemy
    DoDamage(damageTable)
end

target:AddNewModifier(  caster, self,  "modifier_snapfire_mortimer_kisses_custom_thinker", {duration = duration,  slow = 1})

local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_impact.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast, 3, location )
ParticleManager:ReleaseParticleIndex( effect_cast )

AddFOWViewer( caster:GetTeamNumber(), location, vision, duration, false )
EmitSoundOnLocationWithCaster( location, "Hero_Snapfire.MortimerBlob.Impact", caster )
end




function snapfire_mortimer_kisses_custom:NapalmStack(point)
if not IsServer() then return end

local caster = self:GetCaster()
local radius = caster:GetTalentValue("modifier_snapfire_kisses_4", "radius")
local duration = caster:GetTalentValue("modifier_snapfire_kisses_4", "duration")

EmitSoundOnLocationWithCaster(point, "Hero_Batrider.StickyNapalm.Impact", caster)

local napalm_impact_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_batrider/batrider_stickynapalm_impact.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(napalm_impact_particle, 0, point)
ParticleManager:SetParticleControl(napalm_impact_particle, 1, Vector(radius, 0, 0))
ParticleManager:SetParticleControl(napalm_impact_particle, 2, caster:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(napalm_impact_particle)

for _,enemy in pairs(caster:FindTargets(radius, point)) do
    enemy:AddNewModifier(caster, self, "modifier_snapfire_mortimer_kisses_custom_napalm", {duration = duration})
end

end









modifier_snapfire_mortimer_kisses_custom = class({})
function modifier_snapfire_mortimer_kisses_custom:IsHidden() return false end
function modifier_snapfire_mortimer_kisses_custom:IsPurgable() return false end
function modifier_snapfire_mortimer_kisses_custom:OnCreated( kv )

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max_range = self.ability:GetCastRange( Vector(0,0,0), nil )

self.vision_radius = self.ability:GetSpecialValueFor("vision_radius")
self.vision_duration = self.ability:GetSpecialValueFor("vision_duration")
self.max_base = self.ability:GetSpecialValueFor( "projectile_count" )
self.max_real = self.ability:MaxShots()

if not IsServer() then return end

self.parent:AddOrderEvent(self)

self.radius_visual = ParticleManager:CreateParticleForPlayer("particles/snapfire/kisses_legendary_radius.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, self.parent:GetPlayerOwner())
ParticleManager:SetParticleControl(self.radius_visual, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.radius_visual, 1, Vector(self.max_range, 0, 0))
self:AddParticle(self.radius_visual, false, false, -1, false, false)

if self.parent:HasTalent("modifier_snapfire_kisses_1") then
    self.reduce_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_snapfire_mortimer_kisses_custom_damage_reduce", {duration = self:GetRemainingTime() + 1})
end

if self.parent:HasTalent("modifier_snapfire_kisses_7") then
    self.parent:RemoveModifierByName("modifier_snapfire_mortimer_kisses_custom_legendary_count")
    self.legendary_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_snapfire_mortimer_kisses_custom_legendary_count", {duration = self:GetRemainingTime() + 1})
end

self.ability:EndCd()

if self.parent:HasTalent("modifier_snapfire_kisses_5") then
    self.ability:SetActivated(true)
    self.ability:StartCooldown(0.2)
end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_snapfire_mortimer_kisses_custom_scatter", {})
self.parent:AddNewModifier(self.parent, self.ability, "modifier_snapfire_mortimer_kisses_custom_stun_check", {})

self.RemoveForDuel = true

self.interval = self.ability:GetDuration()/self.max_real + 0.01
self.target = Vector( kv.pos_x, kv.pos_y, 0 ) 
self.count = 0

self:StartIntervalThink( self.interval )
self:OnIntervalThink()
end

function modifier_snapfire_mortimer_kisses_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_MOVESPEED_LIMIT,
    MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE,
}
end

function modifier_snapfire_mortimer_kisses_custom:OrderEvent( params )


if  params.order_type==DOTA_UNIT_ORDER_MOVE_TO_POSITION or
    params.order_type==DOTA_UNIT_ORDER_ATTACK_MOVE then 
    self.target = params.pos
elseif 
    (params.order_type==DOTA_UNIT_ORDER_MOVE_TO_TARGET or
    params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET) and params.target
then
    self.target = params.target:GetOrigin()
elseif 
    params.order_type==DOTA_UNIT_ORDER_STOP or
    params.order_type==DOTA_UNIT_ORDER_HOLD_POSITION or
    params.order_type==DOTA_UNIT_ORDER_CAST_POSITION or
    params.order_type==DOTA_UNIT_ORDER_CAST_TARGET or
    (params.order_type==DOTA_UNIT_ORDER_CAST_NO_TARGET and params.ability ~= self.ability)
then
    self:Destroy()
end

end

function modifier_snapfire_mortimer_kisses_custom:GetModifierMoveSpeed_Limit()
return 0.1
end

function modifier_snapfire_mortimer_kisses_custom:GetModifierTurnRate_Percentage()
return -150
end

function modifier_snapfire_mortimer_kisses_custom:CheckState()
return 
{
    [MODIFIER_STATE_DISARMED] = true,
    [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
}
end

function modifier_snapfire_mortimer_kisses_custom:OnIntervalThink()
if not IsServer() then return end
if self.count > self.max_real then return end
self.count = self.count + 1

AddFOWViewer(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), self.vision_radius, self.vision_duration, false)

if self.legendary_mod and not self.legendary_mod:IsNull() then
    self.legendary_mod:IncrementStackCount()
end

self.ability:LauchBall(self.target)

self.parent:StartGestureWithPlaybackRate(ACT_DOTA_OVERRIDE_ABILITY_4, self.max_real / self.max_base)
EmitSoundOn("Hero_Snapfire.MortimerBlob.Launch", self.parent )
end

function modifier_snapfire_mortimer_kisses_custom:OnDestroy()
if not IsServer() then return end

if self.reduce_mod and not self.reduce_mod:IsNull() then
    self.reduce_mod:SetDuration(self.parent:GetTalentValue("modifier_snapfire_kisses_1", "duration"), true)
end

if self.legendary_mod and not self.legendary_mod:IsNull() then
    self.legendary_mod:SetEnd()
end

self.ability:StartCd()
self.parent:RemoveModifierByName("modifier_snapfire_mortimer_kisses_custom_scatter")
self.parent:RemoveModifierByName("modifier_snapfire_mortimer_kisses_custom_stun_check")
self.parent:RemoveModifierByName("modifier_snapfire_mortimer_kisses_custom_blink")
self.parent:FadeGesture(ACT_DOTA_OVERRIDE_ABILITY_4)
end










modifier_snapfire_mortimer_kisses_custom_debuff = class({})
function modifier_snapfire_mortimer_kisses_custom_debuff:IsHidden() return false end
function modifier_snapfire_mortimer_kisses_custom_debuff:IsPurgable() return true end

function modifier_snapfire_mortimer_kisses_custom_debuff:OnCreated( kv )
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.epic_damage = self.caster:GetTalentValue("modifier_snapfire_kisses_4", "damage")

self.slow = -self.ability:GetSpecialValueFor( "move_slow_pct" ) + self.caster:GetTalentValue("modifier_snapfire_kisses_3", "slow")
self.dps = self.ability:GetSpecialValueFor( "burn_damage" )
self.interval = self.ability:GetSpecialValueFor( "burn_interval" )

if not IsServer() then return end

self.damageTable = 
{
    victim = self.parent,
    attacker = self.caster,
    damage = self.dps*self.interval,
    damage_type = self.ability:GetAbilityDamageType(),
    ability = self.ability,
}

self:StartIntervalThink( self.interval )
self:OnIntervalThink()
end

function modifier_snapfire_mortimer_kisses_custom_debuff:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_snapfire_mortimer_kisses_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end


function modifier_snapfire_mortimer_kisses_custom_debuff:OnIntervalThink()
if not IsServer() then return end
local damage = self.dps

local mod = self.parent:FindModifierByName("modifier_snapfire_mortimer_kisses_custom_napalm")
if mod then 
    damage = damage + self.epic_damage*mod:GetStackCount()
end

damage = damage*self.interval
self.damageTable.damage = damage

SendOverheadEventMessage(self.parent, 4, self.parent, damage, nil)
DoDamage( self.damageTable )
end


function modifier_snapfire_mortimer_kisses_custom_debuff:GetEffectName()
return "particles/units/heroes/hero_snapfire/hero_snapfire_burn_debuff.vpcf"
end

function modifier_snapfire_mortimer_kisses_custom_debuff:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_snapfire_mortimer_kisses_custom_debuff:GetStatusEffectName()
return "particles/status_fx/status_effect_snapfire_magma.vpcf"
end

function modifier_snapfire_mortimer_kisses_custom_debuff:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL 
end






modifier_snapfire_mortimer_kisses_custom_thinker = class({})
function modifier_snapfire_mortimer_kisses_custom_thinker:OnCreated( kv )
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max_travel = self.ability:GetSpecialValueFor( "max_lob_travel_time" )
self.radius = self.ability:GetSpecialValueFor( "impact_radius" )
self.linger = self.ability:GetSpecialValueFor( "burn_linger_duration" )

if not IsServer() then return end

self.start = false

self.effect_cast = ParticleManager:CreateParticleForTeam( "particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf", PATTACH_CUSTOMORIGIN, self.caster, self.caster:GetTeamNumber() )
ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetOrigin() )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 0, -self.radius*(self.max_travel/kv.travel_time) ) )
ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( kv.travel_time, 0, 0 ) )
self:AddParticle(self.effect_cast, false, false, -1, false, false)
end


function modifier_snapfire_mortimer_kisses_custom_thinker:OnRefresh( kv )
if not IsServer() then return end

self.start = true

local effect_cast = ParticleManager:CreateParticle( "particles/snapfire/fire_long.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetAbsOrigin() )
ParticleManager:SetParticleControl( effect_cast, 1, self.parent:GetAbsOrigin() )
ParticleManager:SetParticleControl( effect_cast, 2, Vector(kv.duration, 0, 0))
ParticleManager:ReleaseParticleIndex( effect_cast )
 
if self.effect_cast then
    ParticleManager:DestroyParticle( self.effect_cast, true )
    ParticleManager:ReleaseParticleIndex( self.effect_cast )
end

end

function modifier_snapfire_mortimer_kisses_custom_thinker:OnDestroy()
if not IsServer() then return end
UTIL_Remove( self:GetParent() )
end

function modifier_snapfire_mortimer_kisses_custom_thinker:IsAura()
return self.start
end

function modifier_snapfire_mortimer_kisses_custom_thinker:GetModifierAura()
return "modifier_snapfire_mortimer_kisses_custom_debuff"
end

function modifier_snapfire_mortimer_kisses_custom_thinker:GetAuraRadius()
return self.radius
end

function modifier_snapfire_mortimer_kisses_custom_thinker:GetAuraDuration()
return self.linger
end

function modifier_snapfire_mortimer_kisses_custom_thinker:GetAuraSearchTeam()
return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_snapfire_mortimer_kisses_custom_thinker:GetAuraSearchType()
return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end





modifier_snapfire_mortimer_kisses_custom_tracker = class({})
function modifier_snapfire_mortimer_kisses_custom_tracker:IsHidden() return true end
function modifier_snapfire_mortimer_kisses_custom_tracker:IsPurgable() return false end


function modifier_snapfire_mortimer_kisses_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.heal_creeps = self.parent:GetTalentValue("modifier_snapfire_kisses_3", "creeps", true)
self.heal_bonus = self.parent:GetTalentValue("modifier_snapfire_kisses_3", "bonus", true)

self.attack_max = self.parent:GetTalentValue("modifier_snapfire_kisses_4", "attack", true)
self.cast_range = self.parent:GetTalentValue("modifier_snapfire_kisses_4", "range", true)

self.parent:AddDamageEvent_out(self)
self.parent:AddAttackStartEvent_out(self)
self.parent:AddSpellEvent(self)
end

function modifier_snapfire_mortimer_kisses_custom_tracker:DamageEvent_out(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_snapfire_kisses_3") then return end
if not self.parent:CheckLifesteal(params) then return end

local heal = params.damage*self.parent:GetTalentValue("modifier_snapfire_kisses_3", "heal")/100
local particle = ""
if params.inflictor and params.inflictor == self.ability then 
    heal = heal * self.heal_bonus
    particle = nil
end
if params.unit:IsCreep() then
    heal = heal / self.heal_creeps
end
self.parent:GenericHeal(heal, self.ability, true, particle, "modifier_snapfire_kisses_3")
end


function modifier_snapfire_mortimer_kisses_custom_tracker:AttackStartEvent_out(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_snapfire_kisses_4") then return end
if params.no_attack_cooldown then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

self:IncrementStackCount()

if self:GetStackCount() >= self.attack_max then 
    self:SetStackCount(0)
    self.ability:NapalmStack(params.target:GetAbsOrigin())
end

end


function modifier_snapfire_mortimer_kisses_custom_tracker:SpellEvent( params )
if not IsServer() then return end
if not self.parent:HasTalent("modifier_snapfire_kisses_4") then return end
if params.unit~=self.parent then return end
if params.ability:IsItem() then return end
 
local unit = self.parent:RandomTarget(self.cast_range)

if unit then 
    self.ability:NapalmStack(unit:GetAbsOrigin())
end

end







modifier_snapfire_mortimer_kisses_custom_napalm = class({})
function modifier_snapfire_mortimer_kisses_custom_napalm:IsHidden() return false end
function modifier_snapfire_mortimer_kisses_custom_napalm:IsPurgable() return false end
function modifier_snapfire_mortimer_kisses_custom_napalm:GetTexture() return "batrider_sticky_napalm" end
function modifier_snapfire_mortimer_kisses_custom_napalm:OnCreated()
self.caster = self:GetCaster()
self.parent = self:GetParent()

self.damage = self.caster:GetTalentValue("modifier_snapfire_kisses_4", "damage")
self.max = self.caster:GetTalentValue("modifier_snapfire_kisses_4", "max")

if not IsServer() then return end

self.effect_cast = self.parent:GenericParticle("particles/units/heroes/hero_batrider/batrider_stickynapalm_stack.vpcf", self , true)

self:SetStackCount(1)
self.RemoveForDuel = true
end

function modifier_snapfire_mortimer_kisses_custom_napalm:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_snapfire_mortimer_kisses_custom_napalm:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_TOOLTIP
}
end

function modifier_snapfire_mortimer_kisses_custom_napalm:OnTooltip()
return self:GetStackCount()*self.damage
end


function modifier_snapfire_mortimer_kisses_custom_napalm:GetEffectName()
return "particles/units/heroes/hero_batrider/batrider_stickynapalm_debuff.vpcf"
end

function modifier_snapfire_mortimer_kisses_custom_napalm:GetStatusEffectName()
return "particles/status_fx/status_effect_stickynapalm.vpcf"
end

function modifier_snapfire_mortimer_kisses_custom_napalm:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end


function modifier_snapfire_mortimer_kisses_custom_napalm:OnStackCountChanged(iStackCount)
if not IsServer() then return end
if not self.effect_cast then return end

local k1 = 0
local k2 = self:GetStackCount()

if k2 >= 10 then 
    k1 = 1
    k2 = self:GetStackCount() - 10
end

ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( k1, k2, 0 ) )
end



modifier_snapfire_mortimer_kisses_custom_stun_check = class({})
function modifier_snapfire_mortimer_kisses_custom_stun_check:IsHidden() return true end
function modifier_snapfire_mortimer_kisses_custom_stun_check:IsPurgable() return false end
function modifier_snapfire_mortimer_kisses_custom_stun_check:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self:StartIntervalThink(FrameTime())
end

function modifier_snapfire_mortimer_kisses_custom_stun_check:OnIntervalThink()
if not IsServer() then return end
if self.parent:HasModifier("modifier_snapfire_mortimer_kisses_custom_immune") then return end

if self.parent:IsStunned() or self.parent:IsHexed() or self.parent:IsSilenced() or self.parent:GetForceAttackTarget() ~= nil then 
    self.parent:RemoveModifierByName("modifier_snapfire_mortimer_kisses_custom")
    self:Destroy()
end

end




modifier_snapfire_mortimer_kisses_custom_scatter = class({})
function modifier_snapfire_mortimer_kisses_custom_scatter:IsHidden() return true end
function modifier_snapfire_mortimer_kisses_custom_scatter:IsPurgable() return false end
function modifier_snapfire_mortimer_kisses_custom_scatter:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetParent():FindAbilityByName("snapfire_scatterblast_custom")

if not self.ability or not self.ability:IsTrained() then 
    self:Destroy()
    return
end


self.timer = self.parent:GetTalentValue("modifier_snapfire_scatter_7", "interval", true)
self:StartIntervalThink(1)
end


function modifier_snapfire_mortimer_kisses_custom_scatter:OnIntervalThink()
if not IsServer() then return end

if self.parent:HasTalent("modifier_snapfire_scatter_6") then
    self.parent:CdItems(self.parent:GetTalentValue("modifier_snapfire_scatter_6", "cd_items"))
end

if self.parent:HasTalent("modifier_snapfire_scatter_7") then
    self.ability:OnSpellStart(self.parent:GetAbsOrigin() + self.parent:GetForwardVector()*10, 1 )
end

end



modifier_snapfire_mortimer_kisses_custom_heal_reduce = class({})
function modifier_snapfire_mortimer_kisses_custom_heal_reduce:IsHidden() return true end
function modifier_snapfire_mortimer_kisses_custom_heal_reduce:IsPurgable() return false end
function modifier_snapfire_mortimer_kisses_custom_heal_reduce:OnCreated()
self.heal_reduce = self:GetCaster():GetTalentValue("modifier_snapfire_kisses_2", "heal_reduce")
end

function modifier_snapfire_mortimer_kisses_custom_heal_reduce:DeclareFunctions()
return
{
    --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
    MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
    --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end

function modifier_snapfire_mortimer_kisses_custom_heal_reduce:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal_reduce
end

function modifier_snapfire_mortimer_kisses_custom_heal_reduce:GetModifierHealChange() 
return self.heal_reduce
end

function modifier_snapfire_mortimer_kisses_custom_heal_reduce:GetModifierHPRegenAmplify_Percentage() 
return self.heal_reduce
end



modifier_snapfire_mortimer_kisses_custom_immune = class({})
function modifier_snapfire_mortimer_kisses_custom_immune:IsHidden() return true end
function modifier_snapfire_mortimer_kisses_custom_immune:IsPurgable() return false end
function modifier_snapfire_mortimer_kisses_custom_immune:GetEffectName() return "particles/alch_stun_legendary.vpcf" end


modifier_snapfire_mortimer_kisses_custom_blink = class({})
function modifier_snapfire_mortimer_kisses_custom_blink:IsHidden() return true end
function modifier_snapfire_mortimer_kisses_custom_blink:IsPurgable() return false end



modifier_snapfire_mortimer_kisses_custom_cdr = class({})
function modifier_snapfire_mortimer_kisses_custom_cdr:IsHidden() return not self:GetCaster():HasTalent("modifier_snapfire_kisses_6") end
function modifier_snapfire_mortimer_kisses_custom_cdr:IsPurgable() return false end
function modifier_snapfire_mortimer_kisses_custom_cdr:RemoveOnDeath() return false end
function modifier_snapfire_mortimer_kisses_custom_cdr:GetTexture() return "buffs/wrath_perma" end
function modifier_snapfire_mortimer_kisses_custom_cdr:OnCreated(table)
self.parent = self:GetParent()
self.max = self.parent:GetTalentValue("modifier_snapfire_kisses_6", "max", true)
self.cdr = self.parent:GetTalentValue("modifier_snapfire_kisses_6", "cdr", true)/self.max

if not IsServer() then return end
self:SetStackCount(1)
self:StartIntervalThink(0.5)
end

function modifier_snapfire_mortimer_kisses_custom_cdr:OnIntervalThink()
if not IsServer() then return end 
if self:GetStackCount() < self.max then return end
if not self.parent:HasTalent("modifier_snapfire_kisses_6") then return end

self.parent:GenericParticle("particles/lc_odd_proc_.vpcf")
self.parent:EmitSound("BS.Thirst_legendary_active")
self:StartIntervalThink(-1)
end 

function modifier_snapfire_mortimer_kisses_custom_cdr:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

end


function modifier_snapfire_mortimer_kisses_custom_cdr:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
}
end


function modifier_snapfire_mortimer_kisses_custom_cdr:GetModifierPercentageCooldown() 
if not self.parent:HasTalent("modifier_snapfire_kisses_6") then return end
return self:GetStackCount()*self.cdr
end

modifier_snapfire_mortimer_kisses_custom_root = class({})
function modifier_snapfire_mortimer_kisses_custom_root:IsHidden() return true end
function modifier_snapfire_mortimer_kisses_custom_root:IsPurgable() return true end
function modifier_snapfire_mortimer_kisses_custom_root:CheckState()
return
{
    [MODIFIER_STATE_ROOTED] = true
}
end

function modifier_snapfire_mortimer_kisses_custom_root:GetEffectName()
return "particles/beast_root.vpcf"
end


modifier_snapfire_mortimer_kisses_custom_root_count = class({})
function modifier_snapfire_mortimer_kisses_custom_root_count:IsHidden() return true end
function modifier_snapfire_mortimer_kisses_custom_root_count:IsPurgable() return false end
function modifier_snapfire_mortimer_kisses_custom_root_count:RemoveOnDeath() return false end
function modifier_snapfire_mortimer_kisses_custom_root_count:OnCreated()
self.targets = {}
end









snapfire_mortimer_kisses_custom_legendary = class({})


function snapfire_mortimer_kisses_custom_legendary:CreateTalent()
self:SetHidden(false)
self:SetActivated(false)
end

function snapfire_mortimer_kisses_custom_legendary:OnAbilityPhaseStart() 
return self:GetCaster():HasModifier("modifier_snapfire_mortimer_kisses_custom_legendary_count")
end



function snapfire_mortimer_kisses_custom_legendary:OnSpellStart()
local caster = self:GetCaster()
local mod = caster:FindModifierByName("modifier_snapfire_mortimer_kisses_custom_legendary_count")

if not mod then return end
local stack = mod:GetStackCount()
mod:Destroy()

if stack <= 0 then return end


local unit = CreateUnitByName("npc_snapfire_firetoad", self:GetCursorPosition(), true, caster, caster, caster:GetTeamNumber())

unit.owner = caster
unit:EmitSound("Marci.Sidekick_summon")
unit:GenericParticle("particles/units/heroes/hero_lone_druid/lone_druid_bear_blink_end.vpcf")
unit:AddNewModifier(caster, self, "modifier_snapfire_mortimer_kisses_custom_legendary", {stack = stack})
end


modifier_snapfire_mortimer_kisses_custom_legendary = class({})
function modifier_snapfire_mortimer_kisses_custom_legendary:IsHidden() return true end
function modifier_snapfire_mortimer_kisses_custom_legendary:IsPurgable() return false end
function modifier_snapfire_mortimer_kisses_custom_legendary:OnCreated(table)

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.armor = self.ability:GetSpecialValueFor("armor")
self.magic = self.ability:GetSpecialValueFor("magic")
if not IsServer() then return end

self.main_ability = self.caster:FindAbilityByName("snapfire_mortimer_kisses_custom")
if not self.main_ability then
    self:Destroy()
    return
end

self.max_range = self.caster:GetTalentValue("modifier_snapfire_kisses_7", "radius")
self:SetStackCount(table.stack)

self.start_interval = 0.4
self.main_max_base =  self.main_ability:GetSpecialValueFor("projectile_count")
self.main_duration = self.main_ability:GetDuration()
self.interval = self.main_duration/self.main_max_base

self.radius_visual = ParticleManager:CreateParticleForPlayer("particles/snapfire/kisses_legendary_radius.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, self.caster:GetPlayerOwner())
ParticleManager:SetParticleControl(self.radius_visual, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.radius_visual, 1, Vector(self.max_range, 0, 0))
self:AddParticle(self.radius_visual, false, false, -1, false, false)

self.change_health = self.caster:GetMaxHealth()*self.caster:GetTalentValue("modifier_snapfire_kisses_7", "health")/100

self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_4)

self:StartIntervalThink(self.start_interval)
end


function modifier_snapfire_mortimer_kisses_custom_legendary:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE,
    MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS,
    MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
    MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_snapfire_mortimer_kisses_custom_legendary:GetModifierExtraHealthBonus()
return self.change_health
end

function modifier_snapfire_mortimer_kisses_custom_legendary:GetModifierPhysicalArmorBonus()
return self.armor
end

function modifier_snapfire_mortimer_kisses_custom_legendary:GetModifierMagicalResistanceBonus()
return self.magic
end

function modifier_snapfire_mortimer_kisses_custom_legendary:GetModifierTurnRate_Percentage()
return -100
end

function modifier_snapfire_mortimer_kisses_custom_legendary:OnIntervalThink()
if not IsServer() then return end

if self.parent:IsStunned() or self.parent:IsHexed() or self.parent:IsFeared() then
    self:StartIntervalThink(0.1)
    return
end

self.parent:StartGestureWithPlaybackRate(ACT_DOTA_OVERRIDE_ABILITY_4, 1)

local abs = self.parent:GetAbsOrigin() + self.parent:GetForwardVector()*RandomInt(300, self.max_range)
local unit = self.parent:RandomTarget(self.max_range)
if unit then
    abs = unit:GetAbsOrigin()
end

self.parent:MoveToPosition(abs)
self.main_ability:LauchBall(abs, "modifier_snapfire_kisses_7", self.parent)

self:DecrementStackCount()
if self:GetStackCount() <= 0 then
    self:Destroy()
    return
end

self:StartIntervalThink(self.interval)
end


function modifier_snapfire_mortimer_kisses_custom_legendary:OnDestroy()
if not IsServer() then return end
if not self.parent:IsAlive() then return end

self.parent:GenericParticle("particles/units/heroes/hero_lone_druid/lone_druid_bear_blink_end.vpcf")
self.parent:EmitSound("Marci.Sidekick_summon")
UTIL_Remove(self.parent)
end


function modifier_snapfire_mortimer_kisses_custom_legendary:CheckState()
return
{
    [MODIFIER_STATE_ROOTED] = true,
    [MODIFIER_STATE_DISARMED] = true,
    [MODIFIER_STATE_COMMAND_RESTRICTED] = true
}
end



modifier_snapfire_mortimer_kisses_custom_damage_reduce = class({})
function modifier_snapfire_mortimer_kisses_custom_damage_reduce:IsHidden() return true end
function modifier_snapfire_mortimer_kisses_custom_damage_reduce:IsPurgable() return false end
function modifier_snapfire_mortimer_kisses_custom_damage_reduce:GetEffectName() return "particles/items2_fx/vindicators_axe_armor.vpcf" end
function modifier_snapfire_mortimer_kisses_custom_damage_reduce:OnCreated()
self.damage_reduce = self:GetParent():GetTalentValue("modifier_snapfire_kisses_1", "damage_reduce")
end

function modifier_snapfire_mortimer_kisses_custom_damage_reduce:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_snapfire_mortimer_kisses_custom_damage_reduce:GetModifierIncomingDamage_Percentage()
return self.damage_reduce
end



modifier_snapfire_mortimer_kisses_custom_legendary_count = class({})
function modifier_snapfire_mortimer_kisses_custom_legendary_count:IsHidden() return false end
function modifier_snapfire_mortimer_kisses_custom_legendary_count:IsPurgable() return false end
function modifier_snapfire_mortimer_kisses_custom_legendary_count:RemoveOnDeath() return false end
function modifier_snapfire_mortimer_kisses_custom_legendary_count:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.RemoveForDuel = true
self.legendary_ability = self.parent:FindAbilityByName("snapfire_mortimer_kisses_custom_legendary")
self.duration = self.parent:GetTalentValue("modifier_snapfire_kisses_7", "duration")
self.max_shots = self.ability:MaxShots()

if not IsServer() then return end
if not self.legendary_ability then return end
self.legendary_ability:SetActivated(true)

self:OnIntervalThink()
self:StartIntervalThink(0.1)
end

function modifier_snapfire_mortimer_kisses_custom_legendary_count:OnDestroy()
if not IsServer() then return end

self.parent:UpdateUIshort({hide = 1, priority = 2, style = "SnapfireKisses"})
self.legendary_ability:SetActivated(false)
end

function modifier_snapfire_mortimer_kisses_custom_legendary_count:SetEnd()
if not IsServer() then return end
self:SetDuration(self.duration, true)
end

function modifier_snapfire_mortimer_kisses_custom_legendary_count:OnIntervalThink()
if not IsServer() then return end
self.parent:UpdateUIshort({max_time = self.max_shots, time = self:GetStackCount(), stack = self:GetStackCount(), priority = 2,  style = "SnapfireKisses"})
end