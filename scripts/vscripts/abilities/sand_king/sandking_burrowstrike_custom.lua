--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_sandking_burrowstrike_custom", "abilities/sand_king/sandking_burrowstrike_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_burrowstrike_custom_stun", "abilities/sand_king/sandking_burrowstrike_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_burrowstrike_custom_stun_second", "abilities/sand_king/sandking_burrowstrike_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_burrowstrike_custom_stun_attacks", "abilities/sand_king/sandking_burrowstrike_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_burrowstrike_custom_legendary", "abilities/sand_king/sandking_burrowstrike_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_burrowstrike_custom_tracker", "abilities/sand_king/sandking_burrowstrike_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_burrowstrike_custom_legendary_cd", "abilities/sand_king/sandking_burrowstrike_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_burrowstrike_custom_second", "abilities/sand_king/sandking_burrowstrike_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_burrowstrike_custom_speed", "abilities/sand_king/sandking_burrowstrike_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_burrowstrike_custom_reverse", "abilities/sand_king/sandking_burrowstrike_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_burrowstrike_custom_immune", "abilities/sand_king/sandking_burrowstrike_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_burrowstrike_custom_quest", "abilities/sand_king/sandking_burrowstrike_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sandking_burrowstrike_custom_leash", "abilities/sand_king/sandking_burrowstrike_custom", LUA_MODIFIER_MOTION_NONE)


sandking_burrowstrike_custom = class({})
				
function sandking_burrowstrike_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/units/heroes/hero_sandking/sandking_burrowstrike.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_stunned.vpcf", context )
PrecacheResource( "particle","particles/sand_king/burrow_legendary_start.vpcf", context )
PrecacheResource( "particle","particles/sand_king/burrow_legendary_active.vpcf", context )
PrecacheResource( "particle","particles/sand_king/burrow_legendary.vpcf", context )
PrecacheResource( "particle","particles/sand_king/sand_king_wave.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sandking/sandking_sandstorm_burrowstrike_field_explosion.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sandking/sandking_sandstorm_burrowstrike_field_explosion.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow_exit.vpcf", context )
PrecacheResource( "particle","particles/lina_timer.vpcf", context )
PrecacheResource( "particle","particles/sand_king/burrow_second.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_stunned.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sandking/sandking_burrowstrike.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_sniper/sniper_headshot_slow.vpcf", context )
PrecacheResource( "model","models/heroes/nerubian_assassin/mound.vmdl", context )
end



function sandking_burrowstrike_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_sandking_burrowstrike_custom_tracker"
end


function sandking_burrowstrike_custom:GetCooldown(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_sand_king_burrow_6") then 
	bonus = self:GetCaster():GetTalentValue("modifier_sand_king_burrow_6", "cd")
end 
return self.BaseClass.GetCooldown(self, level)  + bonus
end



function sandking_burrowstrike_custom:GetCastRange(vLocation, hTarget)
if IsClient() then 
	return self:GetSpecialValueFor("AbilityCastRange")
else 
	return 99999
end 

end 



function sandking_burrowstrike_custom:OnSpellStart(new_target)
if not IsServer() then return end 

local point = self:GetCursorPosition()
local caster = self:GetCaster()
local origin = caster:GetAbsOrigin()


if new_target then 
	point = new_target:GetAbsOrigin()
end 

if point == origin then 
	point = origin + caster:GetForwardVector()*10
end
local dir = (point - origin)

local max_distance = self:GetSpecialValueFor("AbilityCastRange") + self:GetCaster():GetCastRangeBonus()

if dir:Length2D() >= max_distance then 
	dir = dir:Normalized()
	dir.z = 0
	point = GetGroundPosition(origin + dir*max_distance, nil)
end

dir = (point - origin)
local distance = dir:Length2D()


if not caster:HasModifier("modifier_sandking_burrowstrike_custom_legendary") then 
	caster:FaceTowards(point)
	caster:SetForwardVector(dir:Normalized())
end 

if caster:GetQuest() == "Sand.Quest_5" then 
 	caster:AddNewModifier(caster, self, "modifier_sandking_burrowstrike_custom_quest", {duration = caster.quest.number})
end

self.anim_time =  self:GetSpecialValueFor("burrow_anim_time")
local speed = self:GetSpecialValueFor("burrow_speed")

if self:GetCaster():HasTalent("modifier_sand_king_burrow_5") then 
	self.anim_time = self.anim_time*(1 - self:GetCaster():GetTalentValue("modifier_sand_king_burrow_5", "speed")/100)
	speed = speed*(1 + self:GetCaster():GetTalentValue("modifier_sand_king_burrow_5", "speed")/100)
end 

local width = self:GetSpecialValueFor("burrow_width")

ProjectileManager:CreateLinearProjectile(
{
    Ability = self,
    vSpawnOrigin = caster:GetAbsOrigin(),
    fStartRadius = width,
    fEndRadius = width,
    vVelocity = dir:Normalized() * speed,
    fDistance = distance,
    Source = caster,
    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
    bProvidesVision = true,
    iVisionTeamNumber = caster:GetTeamNumber(),
    iVisionRadius = width,
})


local delay = distance/speed
local duration = math.max(delay, self.anim_time)

if caster:HasTalent("modifier_sand_king_burrow_5") then 
	ProjectileManager:ProjectileDodge(self:GetCaster())
	caster:AddNewModifier(caster, self, "modifier_sandking_burrowstrike_custom_immune", {duration = caster:GetTalentValue("modifier_sand_king_burrow_5", "duration") + delay})
end 

caster:AddNewModifier(caster, self, "modifier_sandking_burrowstrike_custom", {duration = duration, delay = delay, pos_x = point.x, pos_y = point.y, pos_z = point.z, reverse = 0})

if caster:HasTalent("modifier_sand_king_burrow_6") then 
	caster:AddNewModifier(caster, self, "modifier_sandking_burrowstrike_custom_reverse", {duration = caster:GetTalentValue("modifier_sand_king_burrow_6", "duration")})
end 

self:PlayEffects( origin, point )
end   





function sandking_burrowstrike_custom:OnProjectileHit( target, location )
if not target then return end
--if target:TriggerSpellAbsorb( self ) then return end
local caster = self:GetCaster()
 
local duration = self:GetSpecialValueFor( "burrow_duration" ) + caster:GetTalentValue("modifier_sand_king_burrow_1", "stun")

target:RemoveModifierByName("modifier_sandking_burrowstrike_custom_stun")
target:AddNewModifier(caster, self, "modifier_sandking_burrowstrike_custom_stun", { duration = duration*(1 - target:GetStatusResistance()) } )

local finale = self:GetCaster():FindAbilityByName("sandking_caustic_finale_custom")

if finale then 
	finale:ApplyEffect(target)
end 

end



function sandking_burrowstrike_custom:PlayEffects( origin, target )
 
local particle_cast = "particles/units/heroes/hero_sandking/sandking_burrowstrike.vpcf"
local sound_cast = "SandKing.BurrowStrike"
 
local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster() )
ParticleManager:SetParticleControl( effect_cast, 0, origin )
ParticleManager:SetParticleControl( effect_cast, 1, target )
ParticleManager:ReleaseParticleIndex( effect_cast )

EmitSoundOnLocationWithCaster(target, sound_cast, self:GetCaster())
end





modifier_sandking_burrowstrike_custom = class({})
 
function modifier_sandking_burrowstrike_custom:IsHidden() return true end
function modifier_sandking_burrowstrike_custom:IsPurgable() return false end
function modifier_sandking_burrowstrike_custom:OnCreated( kv )
if not IsServer() then return end
self.caster = self:GetCaster()
self.delay = kv.delay
self.ended = false

self.reverse = kv.reverse

self.caster:StartGesture(ACT_DOTA_SAND_KING_BURROW_IN)
self.point = Vector( kv.pos_x, kv.pos_y, 0 )
self.origin = self.caster:GetAbsOrigin()

self:StartIntervalThink(math.max(0.25, self.delay - FrameTime()))
end

function modifier_sandking_burrowstrike_custom:OnDestroy( kv )
if not IsServer() then return end
self:Teleport()
end

function modifier_sandking_burrowstrike_custom:OnIntervalThink()
self:Teleport()
end


function modifier_sandking_burrowstrike_custom:Teleport()
if not IsServer() then return end
if self.ended == true then return end
self.ended = true

if self.reverse == 0 then 

	if self.caster:HasTalent("modifier_sand_king_burrow_4") then 
		self.caster:RemoveModifierByName("modifier_sandking_burrowstrike_custom_second")
		self.caster:AddNewModifier(self.caster, self:GetAbility(), "modifier_sandking_burrowstrike_custom_second", {duration = self.caster:GetTalentValue("modifier_sand_king_burrow_4", "delay")})
	end

	if self.caster:HasTalent("modifier_sand_king_burrow_3") then 
		self.caster:AddNewModifier(self.caster, self:GetAbility(), "modifier_sandking_burrowstrike_custom_speed", {duration = self.caster:GetTalentValue("modifier_sand_king_burrow_3", "duration")})
	end
end 

self.caster:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_1)
self.caster:FadeGesture(ACT_DOTA_SAND_KING_BURROW_IN)
FindClearSpaceForUnit( self.caster, self.point, true )

local sand = self.caster:FindAbilityByName("sandking_sand_storm_custom")
if sand and sand:IsTrained() and self.caster:HasTalent("modifier_sand_king_sand_7") then 
	sand:ProcLegendary(self.caster:GetAbsOrigin())
end

local face_dir = self.caster:GetForwardVector()
face_dir.z = 0
self.caster:FaceTowards(self.caster:GetAbsOrigin() + face_dir*10)
self.caster:SetForwardVector(face_dir)

if self.reverse == 1 then 
	self:Destroy()
end 

end 


function modifier_sandking_burrowstrike_custom:CheckState()
return 
{
	[MODIFIER_STATE_STUNNED] = true,
}
end










modifier_sandking_burrowstrike_custom_stun = class({})
function modifier_sandking_burrowstrike_custom_stun:IsPurgable() return false end
function modifier_sandking_burrowstrike_custom_stun:IsPurgeException() return true end
function modifier_sandking_burrowstrike_custom_stun:IsStunDebuff() return true end

function modifier_sandking_burrowstrike_custom_stun:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
self.caster = self:GetCaster()

self.parent:InterruptMotionControllers(false)

self.damage = self:GetAbility():GetAbilityDamage() + self.caster:GetTalentValue("modifier_sand_king_burrow_2", "damage")*self.caster:GetAverageTrueAttackDamage(nil)/100

if self.parent:IsCreep() then 
	local damageTable = {victim = self.parent, attacker = self.caster, damage = 1, damage_type = DAMAGE_TYPE_PURE, ability = self:GetAbility(), }
	DoDamage(damageTable)
end

self.anim_time = self:GetAbility():GetSpecialValueFor("burrow_anim_time")

self.mod = self.parent:AddNewModifier( self.caster, self:GetAbility(),
"modifier_knockback",
{	
	center_x = self.parent:GetAbsOrigin().x,
	center_y = self.parent:GetAbsOrigin().y,
	center_z = self.parent:GetAbsOrigin().z,
	knockback_distance = 0,
	knockback_height = 300,	
	duration = self.anim_time,
	knockback_duration = self.anim_time,
	should_stun = true,
})

self.parent:StartGesture(ACT_DOTA_FLAIL)

self:StartIntervalThink(self.anim_time)
end


function modifier_sandking_burrowstrike_custom_stun:OnIntervalThink()
if not IsServer() then return end

self.parent:RemoveGesture(ACT_DOTA_FLAIL)
self.parent:StartGesture(ACT_DOTA_DISABLED)

local damageTable = {victim = self.parent, attacker = self.caster, damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility(), }
DoDamage(damageTable)

self:StartIntervalThink(-1)
end

function modifier_sandking_burrowstrike_custom_stun:CheckState()
return
{
	[MODIFIER_STATE_STUNNED] = true
}
end


function modifier_sandking_burrowstrike_custom_stun:OnDestroy()
if not IsServer() then return end 

if self.mod and not self.mod:IsNull() then 
	self.mod:Destroy()
end 

if self.caster:HasTalent("modifier_sand_king_burrow_5") then 
	self.parent:AddNewModifier(self.caster, self.ability, "modifier_sandking_burrowstrike_custom_leash", {duration = (1 - self.parent:GetStatusResistance())*self.caster:GetTalentValue("modifier_sand_king_burrow_5", "leash")})
end

self.parent:FadeGesture(ACT_DOTA_DISABLED)
end


function modifier_sandking_burrowstrike_custom_stun:GetEffectName()
return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_sandking_burrowstrike_custom_stun:GetEffectAttachType()
return PATTACH_OVERHEAD_FOLLOW
end






sandking_burrowstrike_custom_legendary = class({})

function sandking_burrowstrike_custom_legendary:CreateTalent()
self:SetHidden(false)
end

function sandking_burrowstrike_custom_legendary:GetCooldown(iLevel)
return self:GetCaster():GetTalentValue("modifier_sand_king_burrow_7", "cd")
end

function sandking_burrowstrike_custom_legendary:OnAbilityPhaseStart()
self.particle_sandblast_fx = ParticleManager:CreateParticle("particles/sand_king/burrow_legendary_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
self:GetCaster():StartGesture(ACT_DOTA_SAND_KING_BURROW_IN)
return true
end 

function sandking_burrowstrike_custom_legendary:OnAbilityPhaseInterrupted()

self:GetCaster():FadeGesture(ACT_DOTA_SAND_KING_BURROW_IN)
if self.particle_sandblast_fx then 
	ParticleManager:DestroyParticle(self.particle_sandblast_fx, false)
	ParticleManager:ReleaseParticleIndex(self.particle_sandblast_fx)
end 

end


function sandking_burrowstrike_custom_legendary:OnSpellStart()
local caster = self:GetCaster()

if self.particle_sandblast_fx then 
	ParticleManager:DestroyParticle(self.particle_sandblast_fx, false)
	ParticleManager:ReleaseParticleIndex(self.particle_sandblast_fx)
end 

caster:FadeGesture(ACT_DOTA_SAND_KING_BURROW_IN)

local point = caster:GetAbsOrigin() + caster:GetForwardVector()*50
FindClearSpaceForUnit(caster, point, true)

local ability = caster:FindAbilityByName("sandking_burrowstrike_custom_legendary_exit")

if ability:IsHidden() then 
	caster:SwapAbilities("sandking_burrowstrike_custom_legendary_exit", "sandking_burrowstrike_custom_legendary", true, false)
end 

caster:AddNewModifier(caster, self, "modifier_sandking_burrowstrike_custom_legendary", {})
end 



modifier_sandking_burrowstrike_custom_legendary = class({})
function modifier_sandking_burrowstrike_custom_legendary:IsHidden() return true end
function modifier_sandking_burrowstrike_custom_legendary:IsPurgable() return false end
function modifier_sandking_burrowstrike_custom_legendary:OnCreated()
self.caster = self:GetCaster()
self.parent = self:GetParent()

if not self.caster:HasTalent("modifier_sand_king_burrow_7") then 
	self:Destroy()
	return
end 

self.interval = 0.05
self.count = 0

self.shield_talent = "modifier_sand_king_burrow_7"
self.max_shield = self.caster:GetTalentValue("modifier_sand_king_burrow_7", "shield")*self.caster:GetMaxHealth()/100
self.restore = (self.max_shield / self.caster:GetTalentValue("modifier_sand_king_burrow_7", "restore_timer"))*self.interval
self.speed = self.caster:GetTalentValue("modifier_sand_king_burrow_7", "speed")
self.attack_cd = self.caster:GetTalentValue("modifier_sand_king_burrow_7", "attack_cd")
self.radius = self.caster:GetTalentValue("modifier_sand_king_burrow_7", "radius")
self.attack_stun = self.caster:GetTalentValue("modifier_sand_king_burrow_7", "attack_stun")
self.damage = self.caster:GetTalentValue("modifier_sand_king_burrow_7", "damage")

self.speed_bonus = self.caster:GetTalentValue("modifier_sand_king_burrow_3", "speed")
self.speed_active = self.caster:GetTalentValue("modifier_sand_king_burrow_3", "bonus")

self.damage_reduce = self:GetAbility():GetSpecialValueFor("damage")/100

self:SetStackCount(self.max_shield)

if not IsServer() then return end

self:GetAbility():EndCd(0)
self:GetAbility():SetActivated(false)

local face_dir = self:GetParent():GetForwardVector()
face_dir.z = 0
self:GetParent():FaceTowards(self:GetParent():GetAbsOrigin() + face_dir*10)
self:GetParent():SetForwardVector(face_dir)
self.RemoveForDuel = true

self.active_effect = ParticleManager:CreateParticle( "particles/sand_king/burrow_legendary_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
self:AddParticle(self.active_effect,false, false, -1, false, false)

self.ability = self.caster:FindAbilityByName("sandking_burrowstrike_custom")

self.caster:EmitSound("SandKing.Burrow_loop")

self.caster:EmitSound("SandKing.Burrow_start")
local particle_cast = "particles/sand_king/burrow_legendary.vpcf"

self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 160, 160, 160 ) )
self:AddParticle(self.effect_cast,false, false, -1, false, false)

self.effect_count = 0
self.effect_max = 0.5

self.sound_count = 0
self.sound_max = 0.8

self.attack_max = self.caster:GetTalentValue("modifier_sand_king_burrow_7", "attack_cd")
self.attack_count = self.attack_max

self.old_pos = self.caster:GetAbsOrigin()
self.dir = self.caster:GetForwardVector()

self:StartIntervalThink(self.interval)
end


function modifier_sandking_burrowstrike_custom_legendary:OnIntervalThink()
if not IsServer() then return end 

if self.old_pos ~= self.caster:GetAbsOrigin() then

	self.dir = (self.caster:GetAbsOrigin() - self.old_pos):Normalized()
	self.dir.z = 0
	self.old_pos = self.caster:GetAbsOrigin()
end

self.effect_count = self.effect_count + self.interval
if self.effect_count >= self.effect_max and self.caster:IsMoving() then 
	self.effect_count = 0
	self.caster:EmitSound("SandKing.Burrow_move")
	local effect_cast = ParticleManager:CreateParticle( "particles/sand_king/sand_king_wave.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster )
	ParticleManager:SetParticleControl( effect_cast, 0, self.caster:GetAbsOrigin())
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(120,1,1))
	ParticleManager:ReleaseParticleIndex( effect_cast )


	effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_sandking/sandking_sandstorm_burrowstrike_field_explosion.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self.caster:GetAbsOrigin() - self.dir*100)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end 

self.sound_count = self.sound_count + self.interval
if self.sound_count >= self.sound_max and self.caster:IsMoving() then 
	self.sound_count = 0
	self.caster:EmitSound("SandKing.Burrow_move")
end 


self.attack_count = self.attack_count + self.interval
if self.attack_count >= self.attack_max then 

	self.attack_count = 0
	local targets = self.caster:FindTargets(self.radius)

	for _,target in pairs(targets) do 

		target:EmitSound("SandKing.Burrow_attack")
		local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_sandking/sandking_sandstorm_burrowstrike_field_explosion.vpcf", PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( effect_cast, 0, target:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex( effect_cast )

		self:GetParent():PerformAttack(target, true, true, true, false, false, false, false)

		if not target:IsCurrentlyHorizontalMotionControlled() and not target:IsCurrentlyVerticalMotionControlled() then 

			target:AddNewModifier( self.caster, self:GetAbility(),
			"modifier_knockback",
			{	
				center_x = target:GetAbsOrigin().x,
				center_y = target:GetAbsOrigin().y,
				center_z = target:GetAbsOrigin().z,
				knockback_distance = 0,
				knockback_height = 70,	
				duration = self.attack_stun,
				knockback_duration = self.attack_stun,
				should_stun = true,
			})
		end
	end 
end


self:SetStackCount(math.min(self.max_shield, (self:GetStackCount() + self.restore)))
end


function modifier_sandking_burrowstrike_custom_legendary:OnDestroy()
if not IsServer() then return end

self:GetAbility():UseResources(false, false, false, true)
self:GetAbility():SetActivated(true)

self.caster:StopSound("SandKing.Burrow_loop")

self.caster:EmitSound("SandKing.Burrow_end")

self.particle_sandblast_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow_exit.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
ParticleManager:ReleaseParticleIndex(self.particle_sandblast_fx)

local caster = self.caster
local prev_offset = caster:GetBaseHealthBarOffset()

local dir = self.dir

caster:SetForwardVector(dir)
caster:FaceTowards(caster:GetAbsOrigin() + dir*10)

caster:SetAbsOrigin(self.caster:GetAbsOrigin() + Vector(0,0,-300))
caster:SetHealthBarOffsetOverride(prev_offset + 300)

caster:Stop()

Timers:CreateTimer(FrameTime(), function()
	if caster and not caster:IsNull() then 
		FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), true)
		caster:SetHealthBarOffsetOverride(prev_offset)

	end 
end)

local ability = self.caster:FindAbilityByName("sandking_burrowstrike_custom_legendary")

if ability:IsHidden() then 
	self.caster:SwapAbilities("sandking_burrowstrike_custom_legendary_exit", "sandking_burrowstrike_custom_legendary", false, true)
end 

self.caster:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_1)
end


function modifier_sandking_burrowstrike_custom_legendary:CheckState()
return
{
	[MODIFIER_STATE_DISARMED] = true, 
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true
}
end


function modifier_sandking_burrowstrike_custom_legendary:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MODEL_CHANGE,
	MODIFIER_PROPERTY_MODEL_SCALE,
	MODIFIER_PROPERTY_DISABLE_TURNING,
	MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MAX,
	MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
	MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
}
end

function modifier_sandking_burrowstrike_custom_legendary:GetModifierDamageOutgoing_Percentage()
return self.damage
end


function modifier_sandking_burrowstrike_custom_legendary:GetModifierIgnoreCastAngle()
return 1
end

function modifier_sandking_burrowstrike_custom_legendary:GetModifierDisableTurning()
return 1
end

function modifier_sandking_burrowstrike_custom_legendary:GetModifierMoveSpeed_AbsoluteMax()

local bonus = 0

if self.caster:HasTalent("modifier_sand_king_burrow_3") then 
	bonus = self.speed_bonus
	if self.caster:HasModifier("modifier_sandking_burrowstrike_custom_speed") then 
		bonus = bonus*self.speed_active
	end 
end
return self.speed + bonus
end

function modifier_sandking_burrowstrike_custom_legendary:GetModifierModelChange()
return "models/heroes/nerubian_assassin/mound.vmdl"
end

function modifier_sandking_burrowstrike_custom_legendary:GetModifierModelScale()
return 15
end

function modifier_sandking_burrowstrike_custom_legendary:GetModifierIncomingDamageConstant( params )

if IsClient() then 
	if params.report_max then 
		return self.max_shield
	else 
     	return self:GetStackCount()
    end 
end

if not IsServer() then return end

local damage = math.min(params.damage*self.damage_reduce, self:GetStackCount())
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self:SetStackCount(self:GetStackCount() - damage)
if self:GetStackCount() <= 0 then
  self:Destroy()
end

return -damage
end






sandking_burrowstrike_custom_legendary_exit = class({})

function sandking_burrowstrike_custom_legendary_exit:OnSpellStart()

self:GetCaster():RemoveModifierByName("modifier_sandking_burrowstrike_custom_legendary")

local ability = self:GetCaster():FindAbilityByName("sandking_burrowstrike_custom_legendary")

if ability:IsHidden() then 
	self:GetCaster():SwapAbilities("sandking_burrowstrike_custom_legendary_exit", "sandking_burrowstrike_custom_legendary", false, true)
end 

end








modifier_sandking_burrowstrike_custom_second = class({})
function modifier_sandking_burrowstrike_custom_second:IsHidden() return true end
function modifier_sandking_burrowstrike_custom_second:IsPurgable() return false end
function modifier_sandking_burrowstrike_custom_second:OnCreated(table)
if not IsServer() then return end 
self.caster = self:GetParent()

self.radius = self:GetCaster():GetTalentValue("modifier_sand_king_burrow_4", "radius")
self.RemoveForDuel = true
self.damage = 0
self.t = -1
self.time = self:GetCaster():GetTalentValue("modifier_sand_king_burrow_4", "delay")

self.count = 0.4
self.interval = 0.1

self.timer = self.time*2 
self:StartIntervalThink(self.interval)
self:OnIntervalThink()
end

function modifier_sandking_burrowstrike_custom_second:OnIntervalThink()
if not IsServer() then return end

self.count = self.count + self.interval

if self.count >= 0.5 then 
  self.count = 0
else 
  return
end

self.t = self.t + 1

local caster = self:GetParent()

local number = (self.timer-self.t)/2 
local int = 0
int = number
if number % 1 ~= 0 then int = number - 0.5  end

local digits = math.floor(math.log10(number)) + 2

local decimal = number % 1

if decimal == 0.5 then
  decimal = 8
else 
  decimal = 1
end

local particleName = "particles/lina_timer.vpcf"
local particle = ParticleManager:CreateParticle(particleName, PATTACH_OVERHEAD_FOLLOW, caster)
ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
ParticleManager:SetParticleControl(particle, 1, Vector(0, int, decimal))
ParticleManager:SetParticleControl(particle, 2, Vector(digits, 0, 0))
ParticleManager:ReleaseParticleIndex(particle)

end









function modifier_sandking_burrowstrike_custom_second:OnDestroy()
if not IsServer() then return end

local targets = self.caster:FindTargets(self.radius)
local duration = self:GetCaster():GetTalentValue("modifier_sand_king_burrow_4", "stun")

for _,target in pairs(targets) do 
	target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_sandking_burrowstrike_custom_stun_second", {duration = (1 - target:GetStatusResistance())*duration})
	target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_sandking_burrowstrike_custom_stun_attacks", {duration = duration})
end 



local origin = self:GetParent():GetAbsOrigin()
local particle_cast = "particles/sand_king/burrow_second.vpcf"

EmitSoundOnLocationWithCaster(self:GetParent():GetAbsOrigin(), "SandKing.Burrow_second", self:GetCaster())
local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast, 0, GetGroundPosition(origin, nil) )
ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, self.radius, self.radius ) )
ParticleManager:ReleaseParticleIndex( effect_cast )
end 










modifier_sandking_burrowstrike_custom_stun_second = class({})
function modifier_sandking_burrowstrike_custom_stun_second:IsPurgable() return false end
function modifier_sandking_burrowstrike_custom_stun_second:IsPurgeException() return true end
function modifier_sandking_burrowstrike_custom_stun_second:IsStunDebuff() return true end

function modifier_sandking_burrowstrike_custom_stun_second:OnCreated(table)
if not IsServer() then return end

self:GetParent():InterruptMotionControllers(false)
local height = 200
local k = 300/height

self.anim_time = self:GetAbility():GetSpecialValueFor("burrow_anim_time")/k

self.mod = self:GetParent():AddNewModifier( self:GetCaster(), self:GetAbility(),
"modifier_knockback",
{	
	center_x = self:GetParent():GetAbsOrigin().x,
	center_y = self:GetParent():GetAbsOrigin().y,
	center_z = self:GetParent():GetAbsOrigin().z,
	knockback_distance = 0,
	knockback_height = height,	
	duration = self.anim_time,
	knockback_duration = self.anim_time,
	should_stun = true,
})

self:GetParent():StartGesture(ACT_DOTA_FLAIL)

self:StartIntervalThink(self.anim_time)
end


function modifier_sandking_burrowstrike_custom_stun_second:OnIntervalThink()
if not IsServer() then return end

self:GetParent():RemoveGesture(ACT_DOTA_FLAIL)
self:GetParent():StartGesture(ACT_DOTA_DISABLED)


self:StartIntervalThink(-1)
end

function modifier_sandking_burrowstrike_custom_stun_second:CheckState()
return
{
	[MODIFIER_STATE_STUNNED] = true
}
end


function modifier_sandking_burrowstrike_custom_stun_second:OnDestroy()
if not IsServer() then return end 

if self.mod and not self.mod:IsNull() then 
	self.mod:Destroy()
end 

self:GetParent():FadeGesture(ACT_DOTA_DISABLED)
end



function modifier_sandking_burrowstrike_custom_stun_second:GetEffectName()
return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_sandking_burrowstrike_custom_stun_second:GetEffectAttachType()
return PATTACH_OVERHEAD_FOLLOW
end



modifier_sandking_burrowstrike_custom_stun_attacks = class({})
function modifier_sandking_burrowstrike_custom_stun_attacks:IsHidden() return true end
function modifier_sandking_burrowstrike_custom_stun_attacks:IsPurgable() return false end
function modifier_sandking_burrowstrike_custom_stun_attacks:OnCreated()
if not IsServer() then return end
self.attacks = self:GetCaster():GetTalentValue("modifier_sand_king_burrow_4", "attacks")
local interval = 0.2

self.caster = self:GetCaster()
self.parent = self:GetParent()

self:StartIntervalThink(interval)
end 

function modifier_sandking_burrowstrike_custom_stun_attacks:OnIntervalThink()
if not IsServer() then return end 

self:IncrementStackCount()

self.caster:PerformAttack(self.parent, true, true, true, false, false, false, true)

if self:GetStackCount() >= self.attacks then 
	self:Destroy()
end 

end 




modifier_sandking_burrowstrike_custom_speed = class({})
function modifier_sandking_burrowstrike_custom_speed:IsHidden() return false end
function modifier_sandking_burrowstrike_custom_speed:IsPurgable() return true end
function modifier_sandking_burrowstrike_custom_speed:GetTexture() return "buffs/burrow_speed" end


function modifier_sandking_burrowstrike_custom_speed:GetEffectName()
return "particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf"
end 

function modifier_sandking_burrowstrike_custom_speed:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end








modifier_sandking_burrowstrike_custom_reverse = class({})
function modifier_sandking_burrowstrike_custom_reverse:IsHidden() return true end
function modifier_sandking_burrowstrike_custom_reverse:IsPurgable() return false end
function modifier_sandking_burrowstrike_custom_reverse:OnCreated()
if not IsServer() then return end 

if not self:GetAbility():IsHidden() then
	self:GetCaster():SwapAbilities(self:GetAbility():GetName(), "sandking_burrowstrike_custom_reverse",  false, true)
	self:GetCaster():FindAbilityByName("sandking_burrowstrike_custom_reverse"):StartCooldown(0.5)
end 

end

function modifier_sandking_burrowstrike_custom_reverse:OnDestroy()
if not IsServer() then return end 

if self:GetAbility():IsHidden() then
	self:GetCaster():SwapAbilities(self:GetAbility():GetName(), "sandking_burrowstrike_custom_reverse",  true, false)
end 

end





sandking_burrowstrike_custom_reverse = class({})



function sandking_burrowstrike_custom_reverse:GetCastRange(vLocation, hTarget)
if IsClient() then 
	return self:GetCaster():GetTalentValue("modifier_sand_king_burrow_6", "range")
else 
	return 99999
end 

end 


function sandking_burrowstrike_custom_reverse:OnSpellStart()
if not IsServer() then return end 

local caster = self:GetCaster()
local ability = self:GetCaster():FindAbilityByName("sandking_burrowstrike_custom")
caster:RemoveModifierByName("modifier_sandking_burrowstrike_custom_reverse")

local point = self:GetCursorPosition()
local origin = caster:GetAbsOrigin()

if point == origin then 
	point = origin + caster:GetForwardVector()*10
end
local dir = (point - origin)

local max_distance = self:GetCaster():GetTalentValue("modifier_sand_king_burrow_6", "range") + self:GetCaster():GetCastRangeBonus()

if dir:Length2D() >= max_distance then 
	dir = dir:Normalized()
	dir.z = 0
	point = GetGroundPosition(origin + dir*max_distance, nil)
end

dir = (point - origin)
local distance = dir:Length2D()


if not caster:HasModifier("modifier_sandking_burrowstrike_custom_legendary") then 
	caster:FaceTowards(point)
	caster:SetForwardVector(dir:Normalized())
end 

self.anim_time = ability:GetSpecialValueFor("burrow_anim_time")

local width = ability:GetSpecialValueFor("burrow_width")
local speed = ability:GetSpecialValueFor("burrow_speed")

self.hit = false

if self:GetCaster():HasTalent("modifier_sand_king_burrow_5") then 
	speed = speed*(1 + self:GetCaster():GetTalentValue("modifier_sand_king_burrow_5", "speed")/100)
end 

ProjectileManager:CreateLinearProjectile(
{
    Ability = self,
    vSpawnOrigin = caster:GetAbsOrigin(),
    fStartRadius = width,
    fEndRadius = width,
    vVelocity = dir:Normalized() * speed,
    fDistance = distance,
    Source = caster,
    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
    bProvidesVision = true,
    iVisionTeamNumber = caster:GetTeamNumber(),
    iVisionRadius = width,
})


local delay = distance/speed

local delay = distance/speed
local duration = math.max(delay, self.anim_time)

if caster:HasModifier("modifier_sandking_burrowstrike_custom_legendary") then 
	duration = delay
end 

caster:AddNewModifier(caster, self, "modifier_sandking_burrowstrike_custom", {duration = duration, delay = delay, pos_x = point.x, pos_y = point.y, pos_z = point.z, reverse = 1})

self.slow_duration = self:GetCaster():GetTalentValue("modifier_sand_king_burrow_6", "slow_duration")
self:PlayEffects( origin, point )
end   



function sandking_burrowstrike_custom_reverse:OnProjectileHit( target, location )
if not target then return end

target:EmitSound("SandKing.Burrow_attack")

local hit_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", PATTACH_CUSTOMORIGIN, target)
ParticleManager:SetParticleControlEnt(hit_effect, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false) 
ParticleManager:SetParticleControlEnt(hit_effect, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false) 
ParticleManager:ReleaseParticleIndex(hit_effect)

self:GetCaster():PerformAttack(target, true, true, true, false, false, false, true)
end






function sandking_burrowstrike_custom_reverse:PlayEffects( origin, target )
 
local particle_cast = "particles/units/heroes/hero_sandking/sandking_burrowstrike.vpcf"
local sound_cast = "SandKing.BurrowStrike_reverse"
 
local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster() )
ParticleManager:SetParticleControl( effect_cast, 0, origin )
ParticleManager:SetParticleControl( effect_cast, 1, target )
ParticleManager:ReleaseParticleIndex( effect_cast )

EmitSoundOnLocationWithCaster(target, sound_cast, self:GetCaster())
end









modifier_sandking_burrowstrike_custom_tracker = class({})
function modifier_sandking_burrowstrike_custom_tracker:IsHidden() return true end
function modifier_sandking_burrowstrike_custom_tracker:IsPurgable() return false end
function modifier_sandking_burrowstrike_custom_tracker:OnCreated()
self.caster = self:GetCaster()

end

function modifier_sandking_burrowstrike_custom_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_EVASION_CONSTANT,
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
  	MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
}
end

function modifier_sandking_burrowstrike_custom_tracker:GetModifierDamageOutgoing_Percentage()
if not self.caster:HasTalent("modifier_sand_king_burrow_2") then return end
return self.caster:GetTalentValue("modifier_sand_king_burrow_2", "damage_auto")
end

function modifier_sandking_burrowstrike_custom_tracker:GetModifierCastRangeBonusStacking()
if not self.caster:HasTalent("modifier_sand_king_burrow_1") then return end 
return self.caster:GetTalentValue("modifier_sand_king_burrow_1", "range")
end


function modifier_sandking_burrowstrike_custom_tracker:GetModifierMoveSpeedBonus_Constant()
if not self.caster:HasTalent("modifier_sand_king_burrow_3") then return end 

local base = self.caster:GetTalentValue("modifier_sand_king_burrow_3", "speed")
local bonus = 1 

if self.caster:HasModifier("modifier_sandking_burrowstrike_custom_speed") then 
	bonus = self.caster:GetTalentValue("modifier_sand_king_burrow_3",  "bonus")
end 
return base*bonus
end

function modifier_sandking_burrowstrike_custom_tracker:GetModifierEvasion_Constant()
if not self.caster:HasTalent("modifier_sand_king_burrow_3") then return end 

local base = self.caster:GetTalentValue("modifier_sand_king_burrow_3", "evasion")
local bonus = 1 

if self.caster:HasModifier("modifier_sandking_burrowstrike_custom_speed") then 
	bonus = self.caster:GetTalentValue("modifier_sand_king_burrow_3",  "bonus")
end 
return base*bonus
end






modifier_sandking_burrowstrike_custom_immune = class({})
function modifier_sandking_burrowstrike_custom_immune:IsHidden() return true end
function modifier_sandking_burrowstrike_custom_immune:IsPurgable() return false end
function modifier_sandking_burrowstrike_custom_immune:CheckState()
return
{
	[MODIFIER_STATE_INVULNERABLE] = true,
	[MODIFIER_STATE_OUT_OF_GAME] = true,
	[MODIFIER_STATE_NO_HEALTH_BAR] = true,
}
end




modifier_sandking_burrowstrike_custom_quest = class({})
function modifier_sandking_burrowstrike_custom_quest:IsHidden() return true end
function modifier_sandking_burrowstrike_custom_quest:IsPurgable() return false end





modifier_sandking_burrowstrike_custom_leash = class({})
function modifier_sandking_burrowstrike_custom_leash:IsHidden() return true end
function modifier_sandking_burrowstrike_custom_leash:IsPurgable() return false end
function modifier_sandking_burrowstrike_custom_leash:CheckState()
return
{
	[MODIFIER_STATE_TETHERED] = true
}
end


function modifier_sandking_burrowstrike_custom_leash:GetStatusEffectName()
return "particles/status_fx/status_effect_mars_spear.vpcf"
end

function modifier_sandking_burrowstrike_custom_leash:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH  end


function modifier_sandking_burrowstrike_custom_leash:OnCreated()
self.speed = self:GetCaster():GetTalentValue("modifier_sand_king_burrow_5", "slow")
end

function modifier_sandking_burrowstrike_custom_leash:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_sandking_burrowstrike_custom_leash:GetModifierMoveSpeedBonus_Percentage()
return self.speed
end

function modifier_sandking_burrowstrike_custom_leash:GetEffectName()
return "particles/units/heroes/hero_sniper/sniper_headshot_slow.vpcf"
end

function modifier_sandking_burrowstrike_custom_leash:GetEffectAttachType()
return PATTACH_OVERHEAD_FOLLOW
end