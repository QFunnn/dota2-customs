--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_mars_spear_custom", "abilities/mars/mars_spear_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_spear_custom_debuff", "abilities/mars/mars_spear_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_spear_custom_legendary", "abilities/mars/mars_spear_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_spear_custom_hit_speed", "abilities/mars/mars_spear_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_spear_custom_trail_thinker", "abilities/mars/mars_spear_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_spear_custom_trail_burn", "abilities/mars/mars_spear_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_spear_custom_delay", "abilities/mars/mars_spear_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_spear_custom_tracker", "abilities/mars/mars_spear_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_spear_custom_slow", "abilities/mars/mars_spear_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_spear_custom_heal_reduce", "abilities/mars/mars_spear_custom", LUA_MODIFIER_MOTION_NONE)

mars_spear_custom = class({})
mars_spear_custom.talents = {}
mars_spear_custom.projectiles = {}
mars_spear_custom.index = 0

function mars_spear_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
	
PrecacheResource( "particle", "particles/mars/spear_legendary_start.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_mars/mars_spear.vpcf", context )
PrecacheResource( "particle", "particles/sf_raze_heal.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_mars/mars_spear_impact.vpcf", context )
PrecacheResource( "particle", "particles/mars/spear_legendary_rope.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_chargeup.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_mars/mars_spear_impact_debuff.vpcf", context )
PrecacheResource( "particle", "particles/status_fx/status_effect_mars_spear.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", context )
PrecacheResource( "particle", "particles/mars_trail.vpcf", context )
PrecacheResource( "particle", "particles/roshan_meteor_burn_.vpcf", context )
PrecacheResource( "particle", "particles/lc_odd_charge_mark.vpcf", context )
PrecacheResource( "particle", "particles/items4_fx/spirit_vessel_damage.vpcf", context )
PrecacheResource( "particle", "particles/jugg_legendary_proc_.vpcf", context )
PrecacheResource( "particle", "particles/items3_fx/iron_talon_active.vpcf", context )
PrecacheResource( "particle", "particles/lina_attack_slow.vpcf", context )
PrecacheResource( "particle", "particles/jugg_refresh.vpcf", context )
end

function mars_spear_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_q1 = 0,
    q1_damage_creeps = 0,
    q1_heal_reduce = 0,
    q1_damage = 0,
    q1_duration = caster:GetTalentValue("modifier_mars_spear_1", "duration", true),
    
    has_q2 = 0,
    q2_cd = 0,
    q2_range = 0,
    
    has_q3 = 0,
    q3_damage = 0,
    q3_heal = 0,
    q3_damage_type = caster:GetTalentValue("modifier_mars_spear_3", "damage_type", true),
    q3_timer = caster:GetTalentValue("modifier_mars_spear_3", "timer", true),
    
    has_q4 = 0,
    q4_cd_items = caster:GetTalentValue("modifier_mars_spear_4", "cd_items", true),
    q4_move = caster:GetTalentValue("modifier_mars_spear_4", "move", true),
    q4_duration = caster:GetTalentValue("modifier_mars_spear_4", "duration", true),
    
    has_q7 = 0,
    q7_range = caster:GetTalentValue("modifier_mars_spear_7", "range", true),
    q7_turn_speed = caster:GetTalentValue("modifier_mars_spear_7", "turn_speed", true),
    q7_cast = caster:GetTalentValue("modifier_mars_spear_7", "cast", true),
    q7_radius = caster:GetTalentValue("modifier_mars_spear_7", "radius", true),
    q7_slow_duration = caster:GetTalentValue("modifier_mars_spear_7", "slow_duration", true),
    q7_damage = caster:GetTalentValue("modifier_mars_spear_7", "damage", true)/100,
    q7_cd_inc = caster:GetTalentValue("modifier_mars_spear_7", "cd_inc", true)/100,
    q7_slow = caster:GetTalentValue("modifier_mars_spear_7", "slow", true),
    
    has_h4 = 0,
    h4_silence = caster:GetTalentValue("modifier_mars_hero_4", "silence", true),
    h4_speed = caster:GetTalentValue("modifier_mars_hero_4", "speed", true)/100,
    h4_stun = caster:GetTalentValue("modifier_mars_hero_4", "stun", true),

    has_e7 = 0,
  }
end

if caster:HasTalent("modifier_mars_spear_1") then
  self.talents.has_q1 = 1
  self.talents.q1_damage_creeps = caster:GetTalentValue("modifier_mars_spear_1", "damage_creeps")
  self.talents.q1_heal_reduce = caster:GetTalentValue("modifier_mars_spear_1", "heal_reduce")
  self.talents.q1_damage = caster:GetTalentValue("modifier_mars_spear_1", "damage")/100
end

if caster:HasTalent("modifier_mars_spear_2") then
  self.talents.has_q2 = 1
  self.talents.q2_cd = caster:GetTalentValue("modifier_mars_spear_2", "cd")
  self.talents.q2_range = caster:GetTalentValue("modifier_mars_spear_2", "range")
end

if caster:HasTalent("modifier_mars_spear_3") then
  self.talents.has_q3 = 1
  self.talents.q3_damage = caster:GetTalentValue("modifier_mars_spear_3", "damage")/100
  self.talents.q3_heal = caster:GetTalentValue("modifier_mars_spear_3", "heal")/100
end

if caster:HasTalent("modifier_mars_spear_4") then
  self.talents.has_q4 = 1
end

if caster:HasTalent("modifier_mars_spear_7") then
  self.talents.has_q7 = 1
end

if caster:HasTalent("modifier_mars_hero_4") then
  self.talents.has_h4 = 1
end

if caster:HasTalent("modifier_mars_bulwark_7") then
  self.talents.has_e7 = 1
end

end

function mars_spear_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_mars_spear_custom_tracker"
end

function mars_spear_custom:GetAbilityTextureName()
if self.caster:HasModifier("modifier_mars_spear_custom_legendary") then 
	return "stop_icons/mars_spear"
end
return wearables_system:GetAbilityIconReplacement(self.caster, "mars_spear", self)
end 

function mars_spear_custom:GetManaCost(level)
return self.BaseClass.GetManaCost(self,level)
end

function mars_spear_custom:GetCastRange(vLocation, hTarget)
return self.spear_range and self.spear_range or 0
end

function mars_spear_custom:GetBehavior()
if self.caster:HasModifier("modifier_mars_spear_custom_legendary") then 
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end
return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_DIRECTIONAL
end

function mars_spear_custom:GetCastPoint()
if self.talents.has_q7 == 1 then 
	return 0
end
return self.BaseClass.GetCastPoint(self)
end

function mars_spear_custom:GetCastAnimation()
if self.talents.has_q7 == 1 then 
	return 
end
return ACT_DOTA_CAST_ABILITY_5
end

function mars_spear_custom:GetCooldown(iLevel)
return self.BaseClass.GetCooldown(self, iLevel) + (self.talents.q2_cd and self.talents.q2_cd or 0)
end

function mars_spear_custom:GetDamage(target)
local bonus = 0
if self.talents.has_q1 == 1 then
	bonus = target:IsCreep() and self.talents.q1_damage_creeps or self.talents.q1_damage*target:GetMaxHealth()
end
return self.damage + bonus
end

function mars_spear_custom:OnSpellStart()

local mod = self.caster:FindModifierByName("modifier_mars_spear_custom_legendary")
if mod then 
	mod:Destroy()
	return
end 

local point = self.caster:CastPosition(self:GetCursorPosition())

local bulwark = self.caster:FindModifierByName("modifier_mars_bulwark_custom_idle")
if bulwark and self.talents.has_e7 == 0 then
	bulwark:Destroy()
end

if self.talents.has_q7 == 1 then 
	self.caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_5, 0.06)
	self.caster:SetForwardVector( (point - self.caster:GetAbsOrigin()):Normalized())
	self.caster:FaceTowards(point)

	local origin = self.caster:GetAbsOrigin()

	local nFXIndex = ParticleManager:CreateParticle( "particles/mars/spear_legendary_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
	ParticleManager:SetParticleControl( nFXIndex, 0, self.caster:GetAbsOrigin() )
	ParticleManager:SetParticleControl( nFXIndex, 1, Vector(self.talents.q7_radius, 1, 1 ) )
	ParticleManager:ReleaseParticleIndex( nFXIndex )

	for _,target in pairs(self.caster:FindTargets(self.talents.q7_radius)) do

		local enemy_direction = (target:GetOrigin() - origin):Normalized()
		local point = origin + enemy_direction*(self.talents.q7_radius + 10) 
		local distance = (point - target:GetAbsOrigin()):Length2D()

		target:AddNewModifier(self.caster, self, "modifier_generic_knockback",
		{
			duration = 0.2,
			distance = distance,
			height = 0,
			direction_x = enemy_direction.x,
			direction_y = enemy_direction.y,
		})

		target:AddNewModifier(self.caster, self, "modifier_mars_spear_custom_slow", {duration = (1 - target:GetStatusResistance())*self.talents.q7_slow_duration})
	end 

	self.caster:AddNewModifier( self.caster, self, "modifier_mars_spear_custom_legendary", { duration = self.talents.q7_cast})
	self.caster:EmitSound("Mars.Spear_cast")
	self.caster:EmitSound("Mars.Spear_legendary_start")
else 
	self:LaunchSpear(self.caster:GetAbsOrigin(), point, 0)
end

end


function mars_spear_custom:LaunchSpear(origin, point, legendary_k)
if not IsServer() then return end

local projectile_distance = self.spear_range + self.caster:GetCastRangeBonus()
local projectile_speed = self.spear_speed *(1 + (self.talents.has_h4 == 1 and self.talents.h4_speed or 0))

local direction = point - origin
direction.z = 0
direction = direction:Normalized()

self.index = self.index + 1

local pfx = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_mars/mars_spear.vpcf", self)

local info = {
	Source = self.caster,
	Ability = self,
	vSpawnOrigin = origin,
  bDeleteOnHit = false,
  iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
  iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
  EffectName = pfx,
  fDistance = projectile_distance,
  fStartRadius = self.spear_width,
  fEndRadius = self.spear_width,
	vVelocity = direction * projectile_speed,
	bHasFrontalCone = false,
	bReplaceExisting = false,
	bProvidesVision = true,
	iVisionRadius = self.spear_vision,
	fVisionDuration = 10,
	iVisionTeamNumber = self.caster:GetTeamNumber(),
	ExtraData = 
	{
		index = self.index,
	}
}

if legendary_k >= 0.99 then
	local particle = ParticleManager:CreateParticle("particles/jugg_refresh.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
	ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex(particle)

	self.caster:CdAbility(self, nil, self.talents.q7_cd_inc)
end

self.projectiles[self.index] = {}

self.caster:EmitSound("Hero_Mars.Spear.Cast")
self.caster:EmitSound("Hero_Mars.Spear")

local id = ProjectileManager:CreateLinearProjectile(info)
self.projectiles[self.index].projid = id
self.projectiles[self.index].direction = direction
self.projectiles[self.index].origin = origin
self.projectiles[self.index].point = origin
self.projectiles[self.index].legendary_k = legendary_k
end


function mars_spear_custom:OnProjectileHit_ExtraData(target, location, table)
if not IsServer() then return end
local index = table.index

if not target then
	self:EndSpear(index)
	AddFOWViewer(self.caster:GetTeamNumber(), location, self.spear_vision, 1, false)
	return
end

if self.talents.has_q4 == 1 and not self.projectiles[index].hit and self.caster:IsAlive() then 
	self.projectiles[index].hit = true

	self.caster:EmitSound("Sf.Speed_Heal")

	self.particle_aoe_fx = ParticleManager:CreateParticle("particles/sf_raze_heal.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
	ParticleManager:SetParticleControl(self.particle_aoe_fx, 0,  self.caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.particle_aoe_fx, 1,  self.caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.particle_aoe_fx, 2,  self.caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.particle_aoe_fx, 3,  self.caster:GetAbsOrigin())
	ParticleManager:DestroyParticle(self.particle_aoe_fx, false)
	ParticleManager:ReleaseParticleIndex(self.particle_aoe_fx) 

	self.caster:CdItems(self.ability.talents.q4_cd_items)
	self.caster:AddNewModifier(self.caster, self, "modifier_mars_spear_custom_hit_speed", {duration = self.ability.talents.q4_duration})
end

if self.talents.has_q3 == 1 then
	target:AddNewModifier(self.caster, self, "modifier_mars_spear_custom_delay", {duration = self.talents.q3_timer})
end

if self.talents.has_q1 == 1 then
	target:AddNewModifier(self.caster, self, "modifier_mars_spear_custom_heal_reduce", {duration = self.ability.talents.q1_duration})
end

local damage_k = 1
if self.projectiles[index].legendary_k > 0 and self.talents.has_q7 == 1 then
	damage_k = 1 + self.projectiles[index].legendary_k*self.talents.q7_damage
end

DoDamage({ victim = target, attacker = self.caster, damage = self.ability:GetDamage(target)*damage_k, damage_type = DAMAGE_TYPE_MAGICAL, ability = self })

local direction = self.projectiles[index].direction

if not target:IsRealHero() or self.projectiles[index].entindex ~= nil or target:IsDebuffImmune() then
	local proj_angle = VectorToAngles( direction ).y
	local unit_angle = VectorToAngles( target:GetOrigin()-location ).y
	local angle_diff = unit_angle - proj_angle

	if AngleDiff( unit_angle, proj_angle )>=0 then
		direction = RotatePosition( Vector(0,0,0), QAngle( 0, 90, 0 ), direction )
	else
		direction = RotatePosition( Vector(0,0,0), QAngle( 0, -90, 0 ), direction )
	end

	local point = target:GetAbsOrigin() + direction*self.knockback_distance
  target:AddNewModifier(self.caster,  self,  "modifier_generic_arc",  
  {
    target_x = point.x,
    target_y = point.y,
    distance = self.knockback_distance,
    duration = self.knockback_duration,
    height = 0,
    fix_end = false,
    isStun = true,
  })
	target:EmitSound("Hero_Mars.Spear.Knockback")
	return false
end

target:SetForwardVector( -direction )
target:FaceTowards(target:GetAbsOrigin() - direction*10)

self.projectiles[index].entindex = target:entindex()
self.projectiles[index].mod = target:AddNewModifier( self.caster, self, "modifier_mars_spear_custom", {})
target:EmitSound("Hero_Mars.Spear.Target")
end


function mars_spear_custom:OnProjectileThink_ExtraData(vLocation, table)
if not IsServer() then return end

local index = table.index
local location = GetGroundPosition(vLocation, nil)
self.projectiles[index].point = location

if not self.projectiles[index].entindex then return end

local direction = self.projectiles[index].direction

local unit = EntIndexToHScript(self.projectiles[index].entindex)
unit:SetAbsOrigin(location + direction*60)

local tree_radius = 50
local wall_radius = 50
local building_radius = 30

if self.caster.current_arena and self.caster.current_arena.radius then 
	local center = self.caster.current_arena:GetAbsOrigin()
	local dist = (location - center):Length2D()
	local max_range = self.caster.current_arena.radius

	if (dist >= max_range - wall_radius) and (dist <= max_range + wall_radius) then 
  	self:Pinned(index, true)
		return
	end 
end

for _,thinker in pairs(Entities:FindAllByClassnameWithin("npc_dota_thinker", location, wall_radius)) do
	if thinker:IsPhantomBlocker() then
		self:Pinned(index)
		return
	end
end

if (not GridNav:IsTraversable(GetGroundPosition(location + direction*wall_radius, nil ))) then
	self:Pinned( index )
	return
end

if GridNav:IsNearbyTree( location, tree_radius, true) then
	self:Pinned( index )
	return
end

local buildings = FindUnitsInRadius(self.caster:GetTeamNumber(), location, nil, building_radius, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0, false )
if #buildings > 0 then
	self:Pinned( index )
	return
end

end

function mars_spear_custom:Pinned(index, is_arena)
if not IsServer() then return end
if not self.projectiles[index] then return end
if not self.projectiles[index].entindex then return end

local unit = EntIndexToHScript(self.projectiles[index].entindex)
local direction = self.projectiles[index].direction
local duration = (self.stun_duration + (self.talents.has_h4 == 1 and self.talents.h4_stun or 0)) *(1 - unit:GetStatusResistance()) 

AddFOWViewer(self.caster:GetTeamNumber(), unit:GetOrigin(), self.spear_vision, duration, false)

ProjectileManager:DestroyLinearProjectile( self.projectiles[index].projid )

if is_arena then 
	local point = unit:GetAbsOrigin() + self.projectiles[index].direction*-80
	point = GetGroundPosition(point, nil)
	FindClearSpaceForUnit(unit, point, true)
end

unit:AddNewModifier(self.caster, ability, "modifier_mars_spear_custom_debuff", {duration =  duration})

if IsValid(self.caster.arena_ability) then
	self.caster.arena_ability:SpawnSoldier(unit:GetAbsOrigin() - direction*200)
end

if unit:IsValidKill(self.caster) then 
	if self.caster:GetQuest() == "Mars.Quest_5" then 
		self.caster:UpdateQuest(1)
	end
end

unit:EmitSound("Hero_Mars.Spear.Root")

local pfx = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_mars/mars_spear_impact.vpcf", self)

local effect_cast = ParticleManager:CreateParticle( pfx, PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast, 0, GetGroundPosition( unit:GetAbsOrigin(), unit ) + direction*50)
ParticleManager:SetParticleControl( effect_cast, 1, direction*1000 )
ParticleManager:SetParticleControl( effect_cast, 2, Vector(duration, 0, 0 ))
ParticleManager:SetParticleControlForward( effect_cast, 0, direction )
ParticleManager:ReleaseParticleIndex( effect_cast )

self:EndSpear(index)
end

function mars_spear_custom:EndSpear(index)
if not IsServer() then return end
if not self.projectiles[index] then return end

if self.projectiles[index].entindex then 
	local mod = self.projectiles[index].mod
	local unit = EntIndexToHScript(self.projectiles[index].entindex)
	local dir = self.projectiles[index].direction
	unit:SetAbsOrigin(GetGroundPosition( unit:GetAbsOrigin() - dir*50, nil))

	if IsValid(mod) then
		mod:Destroy()
	end
end

local start_point = self.projectiles[index].origin
local end_point = self.projectiles[index].point

CreateModifierThinker(self.caster, self, "modifier_mars_spear_custom_trail_thinker", {duration = self.fire_duration, x = start_point.x, y = start_point.y, legendary_k = self.projectiles[index].legendary_k}, end_point, self.caster:GetTeamNumber(), false)
self.projectiles[index] = nil
end



modifier_mars_spear_custom = class(mod_hidden)
function modifier_mars_spear_custom:IsStunDebuff() return true end
function modifier_mars_spear_custom:IsPurgeException() return true end
function modifier_mars_spear_custom:OnCreated(kv)
if not IsServer() then return end 
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.parent:Stop()
end

function modifier_mars_spear_custom:OnDestroy()
if not IsServer() then return end
self.parent:Stop()
self.parent:InterruptMotionControllers(false)
FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), false)
end

function modifier_mars_spear_custom:CheckState()
return
{
	[MODIFIER_STATE_STUNNED] = true,
}
end

function modifier_mars_spear_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
}
end

function modifier_mars_spear_custom:GetOverrideAnimation()
return ACT_DOTA_FLAIL
end



modifier_mars_spear_custom_debuff = class(mod_hidden)
function modifier_mars_spear_custom_debuff:IsStunDebuff() return true end
function modifier_mars_spear_custom_debuff:IsPurgeException()	return true end
function modifier_mars_spear_custom_debuff:GetStatusEffectName() return "particles/status_fx/status_effect_mars_spear.vpcf" end
function modifier_mars_spear_custom_debuff:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH  end
function modifier_mars_spear_custom_debuff:OnCreated( kv )
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self.caster.spear_ability
if not self.ability then
	self:Destroy()
	return
end

if not IsServer() then return end 
self.parent:GenericParticle("particles/units/heroes/hero_mars/mars_spear_impact_debuff.vpcf", self, true)

self.parent:Stop()
self.parent:AddNewModifier(self.caster, self.ability, "modifier_mars_spear_stun", {duration = self:GetRemainingTime()})
end

function modifier_mars_spear_custom_debuff:OnDestroy()
if not IsServer() then return end
self.parent:RemoveModifierByName("modifier_mars_spear_stun")

GridNav:DestroyTreesAroundPoint( self.parent:GetOrigin(), 120, false)

if self.parent:IsAlive() and self.ability.talents.has_h4 == 1 then 
	self.parent:EmitSound("SF.Raze_silence")
	self.parent:AddNewModifier(self.caster, self.ability, "modifier_generic_silence", {duration = (1 - self.parent:GetStatusResistance())*self.ability.talents.h4_silence})
end 

self.parent:Stop()
end

function modifier_mars_spear_custom_debuff:CheckState()
return
{
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	[MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED ] = true,
	[MODIFIER_STATE_STUNNED] = true,
	[MODIFIER_STATE_INVISIBLE] = false,
}
end

function modifier_mars_spear_custom_debuff:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
}
end

function modifier_mars_spear_custom_debuff:GetOverrideAnimation( params )
return ACT_DOTA_DISABLED
end



modifier_mars_spear_custom_legendary = class(mod_visible)
function modifier_mars_spear_custom_legendary:OnCreated( kv )
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.turn_speed = self.ability.talents.q7_turn_speed
self.max_time = self.ability.talents.q7_cast
self.distance = self.ability.spear_range + self.parent:GetCastRangeBonus()
self.width = self.ability.spear_width

if not IsServer() then return end
self.parent:EmitSound("Mars.Spear_voice")
self.parent:AddOrderEvent(self)

self.ability:EndCd(0.2)

self.anim_return = 0
self.origin = self.parent:GetOrigin()
self.charge_finish = false
self.target_angle = self.parent:GetAnglesAsVector().y
self.current_angle = self.target_angle
self.face_target = true
self.interval = FrameTime()
self.stack = 0

CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self.parent:GetPlayerOwnerID()), "ability_mars_spear",  {state = 1, range = self.distance, width = self.width})

local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_chargeup.vpcf", PATTACH_POINT_FOLLOW, self.parent )
ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetOrigin() )
ParticleManager:SetParticleControlEnt( effect_cast, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
self:AddParticle( effect_cast, false, false, -1, false, false )

self:StartIntervalThink( self.interval )
end

function modifier_mars_spear_custom_legendary:OnDestroy()
if not IsServer() then return end

CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self.parent:GetPlayerOwnerID()), "ability_mars_spear",  {state = 2})

local dir = self.parent:GetForwardVector()
dir.z = 0

self.ability:StartCd()

self.parent:FaceTowards(self.parent:GetAbsOrigin() + dir*10)
self.parent:SetForwardVector(dir)

FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), false)

if self.stack >= 0.8 then 
	self.parent:EmitSound("Mars.Spear_cast_voice")
end

self.parent:RemoveGesture(ACT_DOTA_CAST_ABILITY_5)
self.parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_5, 1)
self.parent:Stop()

self.ability:LaunchSpear(self.parent:GetAbsOrigin(), self.parent:GetForwardVector()*10 + self.parent:GetAbsOrigin(), self.stack)
end

function modifier_mars_spear_custom_legendary:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MOVESPEED_LIMIT,
	MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
	MODIFIER_PROPERTY_DISABLE_TURNING
}
end

function modifier_mars_spear_custom_legendary:GetModifierIgnoreCastAngle()
return 1
end

function modifier_mars_spear_custom_legendary:GetModifierDisableTurning()
return 1
end

function modifier_mars_spear_custom_legendary:GetModifierMoveSpeed_Limit()
return 0.1
end

function modifier_mars_spear_custom_legendary:OrderEvent( params )

if params.order_type==DOTA_UNIT_ORDER_MOVE_TO_POSITION or
	params.order_type==DOTA_UNIT_ORDER_MOVE_TO_DIRECTION
then
	self:SetDirection( params.pos )
elseif 
	(params.order_type==DOTA_UNIT_ORDER_MOVE_TO_TARGET or
	params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET) and params.target
then
	self:SetDirection( params.target:GetOrigin() )
elseif
	params.order_type==DOTA_UNIT_ORDER_STOP or 
	params.order_type==DOTA_UNIT_ORDER_HOLD_POSITION
then
	self:Destroy()
end	

end

function modifier_mars_spear_custom_legendary:SetDirection( location )
local dir = ((location-self.parent:GetOrigin())*Vector(1,1,0)):Normalized()
self.target_angle = VectorToAngles( dir ).y
self.face_target = false
end

function modifier_mars_spear_custom_legendary:CheckState()
return
{
	[MODIFIER_STATE_DISARMED] = true,
	[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
}
end

function modifier_mars_spear_custom_legendary:OnIntervalThink()
if not IsServer() then return end

self.stack = math.min(1, self:GetElapsedTime()/self.max_time)

self.anim_return = self.anim_return + FrameTime()
if self.anim_return >= 1 then
	self.anim_return = 0
end

AddFOWViewer(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), self.distance, FrameTime(), false)

if self.parent:IsStunned() or self.parent:IsFeared() or self.parent:IsHexed() then
	self:Destroy()
end

self:TurnLogic(self.interval)
end

function modifier_mars_spear_custom_legendary:TurnLogic( dt )
if self.face_target then return end
local angle_diff = AngleDiff( self.current_angle, self.target_angle )
local turn_speed = self.turn_speed*dt

local sign = -1
if angle_diff<0 then sign = 1 end

if math.abs( angle_diff )<1.1*turn_speed then
	self.current_angle = self.target_angle
	self.face_target = true
else
	self.current_angle = self.current_angle + sign*turn_speed
end

local angles = self.parent:GetAnglesAsVector()
self.parent:SetLocalAngles( angles.x, self.current_angle, angles.z )
end



modifier_mars_spear_custom_trail_thinker = class(mod_hidden)
function modifier_mars_spear_custom_trail_thinker:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.point = self.parent:GetAbsOrigin()
self.radius = self.ability.fire_radius
self.start_point = GetGroundPosition(Vector(table.x, table.y, 0), nil)

self.dir = (self.start_point - self.point)
self.length = self.dir:Length2D()

self.parent:EmitSound("Mars.Fire_target")

local effect_count = math.max(1, math.min(3, math.floor(self.length/300)))

for i = 1, effect_count do
	self.pfx = ParticleManager:CreateParticle("particles/mars_trail.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.pfx, 0, self.start_point)
	ParticleManager:SetParticleControl(self.pfx, 1, self.point)
	ParticleManager:SetParticleControl(self.pfx, 2, Vector(table.duration, 0, 0))
	ParticleManager:SetParticleControl(self.pfx, 3, Vector(self.radius, 0, 0))
	self:AddParticle( self.pfx, false, false, -1, false, false )
end

self.damage_k = 1
if table.legendary_k > 0 and self.ability.talents.has_q7 == 1 then
	self.damage_k = 1 + table.legendary_k*self.ability.talents.q7_damage
end

self.damageTable = {attacker = self.caster, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability }

self.interval = self.ability.fire_interval
self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_mars_spear_custom_trail_thinker:OnDestroy()
if not IsServer() then return end
self.parent:StopSound("Mars.Fire_target")
end

function modifier_mars_spear_custom_trail_thinker:OnIntervalThink()
if not IsServer() then return end

local targets = FindUnitsInLine(self.caster:GetTeamNumber(), self.point, self.start_point, nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, 0)
for _,target in pairs(targets) do
	self.damageTable.victim = target
	self.damageTable.damage = self.ability:GetDamage(target)*self.ability.damage_fire*self.interval*self.damage_k
	DoDamage(self.damageTable)

	target:AddNewModifier(self.caster, self.ability, "modifier_mars_spear_custom_trail_burn", {duration = self.interval + 0.2})
end

end

modifier_mars_spear_custom_trail_burn = class(mod_hidden)
function modifier_mars_spear_custom_trail_burn:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.parent:GenericParticle("particles/roshan_meteor_burn_.vpcf", self)
end



modifier_mars_spear_custom_delay = class(mod_visible)
function modifier_mars_spear_custom_delay:GetTexture() return "buffs/mars/spear_3" end
function modifier_mars_spear_custom_delay:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

if not IsServer() then return end
self.stack = 0
self.parent:AddDamageEvent_inc(self, true)
self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = self.ability.talents.q3_damage_type, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION}
self.parent:GenericParticle("particles/lc_odd_charge_mark.vpcf", self, true)
end

function modifier_mars_spear_custom_delay:DamageEvent_inc(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end
if params.attacker ~= self.caster then return end
if not params.inflictor then return end

self.stack = self.stack + params.original_damage
end

function modifier_mars_spear_custom_delay:OnDestroy()
if not IsServer() then return end 
if self.stack <= 0 then return end
if not self.parent:IsAlive() then return end

self.damageTable.damage = self.stack*self.ability.talents.q3_damage

self.parent:EmitSound("Mars.Spear_damage_after")
self.parent:GenericParticle("particles/jugg_legendary_proc_.vpcf")

local trail_pfx = ParticleManager:CreateParticle("particles/items3_fx/iron_talon_active.vpcf", PATTACH_ABSORIGIN, self.parent)
ParticleManager:SetParticleControlEnt(trail_pfx, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt( trail_pfx, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(trail_pfx)

local real_damage = DoDamage(self.damageTable, "modifier_mars_spear_3")
self.parent:SendNumber(106, real_damage)

local result = self.caster:CanLifesteal(self.parent)
if not result then return end

self.caster:GenericHeal(result*self.ability.talents.q3_heal*real_damage, self.ability, false, "particles/items3_fx/octarine_core_lifesteal.vpcf", "modifier_mars_spear_3")
end 



modifier_mars_spear_custom_tracker = class(mod_hidden)
function modifier_mars_spear_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.spear_ability = self.ability

self.ability.stun_duration = self.ability:GetSpecialValueFor("stun_duration")
self.ability.damage = self.ability:GetSpecialValueFor("damage")
self.ability.damage_fire = self.ability:GetSpecialValueFor("damage_fire")/100
self.ability.fire_radius = self.ability:GetSpecialValueFor("fire_radius")
self.ability.fire_duration = self.ability:GetSpecialValueFor("fire_duration")
self.ability.fire_interval = self.ability:GetSpecialValueFor("fire_interval")
self.ability.spear_speed = self.ability:GetSpecialValueFor("spear_speed")
self.ability.spear_width = self.ability:GetSpecialValueFor("spear_width")
self.ability.spear_vision = self.ability:GetSpecialValueFor("spear_vision")
self.ability.spear_range = self.ability:GetSpecialValueFor("spear_range" )
self.ability.knockback_duration = self.ability:GetSpecialValueFor("knockback_duration")
self.ability.knockback_distance = self.ability:GetSpecialValueFor("knockback_distance")
end 

function modifier_mars_spear_custom_tracker:OnRefresh(table)
self.ability.stun_duration = self.ability:GetSpecialValueFor("stun_duration")
self.ability.damage = self.ability:GetSpecialValueFor("damage")
end

function modifier_mars_spear_custom_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING
}
end

function modifier_mars_spear_custom_tracker:GetModifierCastRangeBonusStacking()
return self.ability.talents.q2_range
end



modifier_mars_spear_custom_slow = class(mod_hidden)
function modifier_mars_spear_custom_slow:IsPurgable() return true end
function modifier_mars_spear_custom_slow:GetEffectName() return "particles/lina_attack_slow.vpcf" end
function modifier_mars_spear_custom_slow:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.slow = self.ability.talents.q7_slow
end

function modifier_mars_spear_custom_slow:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end
function modifier_mars_spear_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end



modifier_mars_spear_custom_heal_reduce = class(mod_hidden)
function modifier_mars_spear_custom_heal_reduce:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

end

function modifier_mars_spear_custom_heal_reduce:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
}
end

function modifier_mars_spear_custom_heal_reduce:GetModifierHealChange() 
return self.ability.talents.q1_heal_reduce 
end

function modifier_mars_spear_custom_heal_reduce:GetModifierHPRegenAmplify_Percentage() 
return self.ability.talents.q1_heal_reduce 
end



modifier_mars_spear_custom_hit_speed = class(mod_visible)
function modifier_mars_spear_custom_hit_speed:GetTexture() return "buffs/mars/spear_4" end
function modifier_mars_spear_custom_hit_speed:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.move = self.ability.talents.q4_move

if not IsServer() then return end
self.parent:GenericParticle("particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", self)
end

function modifier_mars_spear_custom_hit_speed:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
}
end

function modifier_mars_spear_custom_hit_speed:GetModifierMoveSpeedBonus_Percentage()
return self.move
end

function modifier_mars_spear_custom_hit_speed:GetActivityTranslationModifiers()
return "spear_stun"
end