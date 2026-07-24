--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_alchemist_unstable_concoction_custom", "abilities/alchemist/alchemist_unstable_concoction_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_alchemist_unstable_concoction_custom_damage_aura", "abilities/alchemist/alchemist_unstable_concoction_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_alchemist_unstable_concoction_custom_bonus", "abilities/alchemist/alchemist_unstable_concoction_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_alchemist_unstable_concoction_custom_charge", "abilities/alchemist/alchemist_unstable_concoction_custom", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_alchemist_unstable_concoction_custom_charge_effect", "abilities/alchemist/alchemist_unstable_concoction_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "modifier_alchemist_unstable_concoction_custom_mirror", "abilities/alchemist/alchemist_unstable_concoction_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "modifier_alchemist_unstable_concoction_custom_tracker", "abilities/alchemist/alchemist_unstable_concoction_custom", LUA_MODIFIER_MOTION_NONE)


alchemist_unstable_concoction_custom = class({})
alchemist_unstable_concoction_custom.talents = {}

function alchemist_unstable_concoction_custom:CreateTalent()
self:ToggleAutoCast()
end

function alchemist_unstable_concoction_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_projectile.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_explosion.vpcf", context )
PrecacheResource( "particle", "particles/alch_stun_legendary.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_timer.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf" , context )
PrecacheResource( "particle", "particles/econ/events/fall_2022/radiance/radiance_owner_fall2022.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_brewmaster/brewmaster_fire_immolation_child.vpcf", context )
PrecacheResource( "particle", "particles/lc_odd_proc_.vpcf", context )
PrecacheResource( "particle", "particles/lc_lowhp.vpcf", context )
PrecacheResource( "particle", "particles/items2_fx/vindicators_axe_armor.vpcf", context )
PrecacheResource( "particle", "particles/alch_root.vpcf", context )
PrecacheResource( "particle", "particles/status_fx/status_effect_forcestaff.vpcf", context )
PrecacheResource( "particle", "particles/econ/events/ti10/phase_boots_ti10.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_alchemist/alchemist_unstableconc_bottles.vpcf", context )

end

function alchemist_unstable_concoction_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
  	regen_inc = 0,
  	status_inc = 0,

  	cd_inc = 0,
  	stun_inc = 0,

  	has_str = 0,
  	damage_inc = 0,
  	str_inc = 0,
  	str_bonus = caster:GetTalentValue("modifier_alchemist_unstable_3", "bonus", true),
  	str_timer = caster:GetTalentValue("modifier_alchemist_unstable_3", "timer", true),
  	str_duration = caster:GetTalentValue("modifier_alchemist_unstable_3", "duration", true),

  	has_speed = 0,
  	speed_inc = 0,
  	h5_resist = 0,
  	speed_range = caster:GetTalentValue("modifier_alchemist_hero_5", "range", true),
  	speed_duration = caster:GetTalentValue("modifier_alchemist_hero_5", "duration", true),
  }
end

if caster:HasTalent("modifier_alchemist_unstable_2") then
	self.talents.cd_inc = caster:GetTalentValue("modifier_alchemist_unstable_2", "cd")
	self.talents.stun_inc = caster:GetTalentValue("modifier_alchemist_unstable_2", "stun")
end

if caster:HasTalent("modifier_alchemist_unstable_3") then
	self.talents.has_str = 1
	self.talents.damage_inc = caster:GetTalentValue("modifier_alchemist_unstable_3", "damage")
	self.talents.str_inc = caster:GetTalentValue("modifier_alchemist_unstable_3", "str")/100
	caster:AddPercentStat({str = self.talents.str_inc}, self.tracker)

	if IsServer() then
		caster:CalculateStatBonus(true)
	end
end

if caster:HasTalent("modifier_alchemist_hero_4") then
	self.talents.regen_inc = caster:GetTalentValue("modifier_alchemist_hero_4", "heal")
	self.talents.status_inc = caster:GetTalentValue("modifier_alchemist_hero_4", "status")
end

if caster:HasTalent("modifier_alchemist_hero_5") then
	self.talents.has_speed = 1
	self.talents.speed_inc = caster:GetTalentValue("modifier_alchemist_hero_5", "move")
	self.talents.h5_resist = caster:GetTalentValue("modifier_alchemist_hero_5", "resist")
end

end

function alchemist_unstable_concoction_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_alchemist_unstable_concoction_custom_tracker"
end

function alchemist_unstable_concoction_custom:GetManaCost(level)
local bonus = 0
if self:GetCaster():HasModifier("modifier_alchemist_unstable_concoction_custom") then
	return 0
end
return self.BaseClass.GetManaCost(self,level) + bonus
end

function alchemist_unstable_concoction_custom:GetCooldown(level)
return self.BaseClass.GetCooldown( self, level ) + (self.talents.cd_inc and self.talents.cd_inc or 0)
end

function alchemist_unstable_concoction_custom:GetBehavior()
local caster = self:GetCaster()

if caster:HasModifier("modifier_alchemist_unstable_concoction_custom") then
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_AOE
end

local bonus = self.talents.has_speed == 1 and DOTA_ABILITY_BEHAVIOR_AUTOCAST or 0
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + bonus
end

function alchemist_unstable_concoction_custom:GetCastRange(vLocation, hTarget)
return self:GetSpecialValueFor( "throw_distance" )
end

function alchemist_unstable_concoction_custom:GetCastPoint()
local caster = self:GetCaster()
if not caster:HasModifier("modifier_alchemist_unstable_concoction_custom") or caster:HasTalent("modifier_alchemist_unstable_4") then 
  return 0
end
return self:GetSpecialValueFor("throw_cast_point")
end

function alchemist_unstable_concoction_custom:GetAOERadius()
return self:GetSpecialValueFor( "radius" )
end

function alchemist_unstable_concoction_custom:GetAbilityTextureName()
local caster = self:GetCaster()
return caster:HasModifier("modifier_alchemist_unstable_concoction_custom") and "alchemist_unstable_concoction_throw" or "alchemist_unstable_concoction"
end


function alchemist_unstable_concoction_custom:DealDamage(target, time, legendary_bonus, self_stun)
local caster = self:GetCaster()

local passive = caster:FindAbilityByName("alchemist_corrosive_weaponry_custom")

local damage_type = caster:HasTalent("modifier_alchemist_unstable_legendary") and DAMAGE_TYPE_MAGICAL or DAMAGE_TYPE_PHYSICAL
local radius = self:GetSpecialValueFor("radius")
local min_stun = self:GetSpecialValueFor( "min_stun" )
local max_stun = self:GetSpecialValueFor( "max_stun" ) + self.talents.stun_inc
local min_damage = self:GetSpecialValueFor( "min_damage" )
local max_damage = self:GetSpecialValueFor( "max_damage" )
local shard_stun = self:GetSpecialValueFor("shard_stun")

local max_brew = self:GetSpecialValueFor( "brew_time" )
local time_k = math.min(1, time/max_brew)

local stun = time_k*(max_stun-min_stun) + min_stun
local damage = time_k*(max_damage-min_damage) + min_damage

damage = legendary_bonus and legendary_bonus + damage or damage
local damage_table = { attacker = caster, damage = damage, damage_type = damage_type, ability = self, }

local targets = caster:FindTargets(radius, target:GetAbsOrigin())
if self_stun then
	table.insert(targets, caster)
end

for _,target in pairs(targets) do
	damage_table.victim = target
	local real_damage = DoDamage(damage_table)

	if target:GetTeamNumber() ~= caster:GetTeamNumber() and passive and not passive:IsNull() then
		passive:AddStack(target, math.floor(time))
	end

	local stun_duration = stun*(1 - target:GetStatusResistance())
	if target == caster and caster:HasShard() then
		stun_duration = shard_stun
	end

	target:AddNewModifier( caster, self, "modifier_stunned", { duration = stun_duration})
end

local name = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_explosion.vpcf", self)

local effect_cast = ParticleManager:CreateParticle( name, PATTACH_ABSORIGIN_FOLLOW, target )
ParticleManager:SetParticleControlEnt( effect_cast, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
ParticleManager:ReleaseParticleIndex( effect_cast )

EmitSoundOnLocationWithCaster(target:GetAbsOrigin(), "Hero_Alchemist.UnstableConcoction.Stun", caster)
end



function alchemist_unstable_concoction_custom:OnSpellStart()
local caster = self:GetCaster()
local mod = caster:FindModifierByName("modifier_alchemist_unstable_concoction_custom")
if not mod then
	mod = caster:FindModifierByName("modifier_alchemist_unstable_concoction_custom_mirror")
end

if mod then
	local target = self:GetCursorTarget()

	local max_brew = self:GetSpecialValueFor( "brew_time" )
	local projectile_speed = self:GetSpecialValueFor( "projectile_speed" )
	local projectile_vision = self:GetSpecialValueFor( "vision_range" )

	caster:FadeGesture(ACT_DOTA_ALCHEMIST_CONCOCTION)
	caster:StartGesture(ACT_DOTA_ALCHEMIST_CONCOCTION_THROW)

	local legendary_damage = mod.legendary_damage and mod.legendary_damage or 0
	local brew_time = mod.mirror_time and mod.mirror_time or mod:GetElapsedTime()

	mod.explode = true

	if target:IsRealHero() and caster:GetQuest() == "Alch.Quest_6" and brew_time >= caster.quest.number then 
		caster:UpdateQuest(1)
	end

	if caster:HasTalent("modifier_alchemist_unstable_4") then
		caster:CdItems(caster:GetTalentValue("modifier_alchemist_unstable_4", "cd_items")* math.min(1, brew_time/max_brew))
	end

	local proj = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_projectile.vpcf", self)

	local info = 
	{
		Target = target,
		Source = caster,
		Ability = self,	
		iSourceAttachment = caster:ScriptLookupAttachment("attach_attack3"),
		EffectName = proj,
		iMoveSpeed = projectile_speed,
		bDodgeable = false,                         
		bVisibleToEnemies = true,                   
		bProvidesVision = true,                     
		iVisionRadius = projectile_vision,          
		iVisionTeamNumber = caster:GetTeamNumber(), 
		ExtraData = 
		{
			brew_time = brew_time,
			legendary_damage = legendary_damage,
			is_mirror = mod:GetName() == "modifier_alchemist_unstable_concoction_custom_mirror"
		}
	}
	ProjectileManager:CreateTrackingProjectile(info)
	caster:EmitSound("Hero_Alchemist.UnstableConcoction.Throw")
	
	mod:Destroy()
	return
end

local duration = self:GetSpecialValueFor( "brew_explosion" ) + caster:GetTalentValue("modifier_alchemist_unstable_legendary", "duration")
caster:StartGesture(ACT_DOTA_ALCHEMIST_CONCOCTION)

self:EndCd(0)

if self.talents.has_speed == 1 then
	if self:GetAutoCastState() == true and not caster:IsRooted() and not caster:IsLeashed() then 
		caster:AddNewModifier(caster, self, "modifier_alchemist_unstable_concoction_custom_charge", {duration = self.talents.speed_duration})
		caster:AddNewModifier(caster, self, "modifier_alchemist_unstable_concoction_custom_charge_effect", {duration = 2})
	end
end 

caster:AddNewModifier( caster, self, "modifier_alchemist_unstable_concoction_custom", { duration = duration } )
end



function alchemist_unstable_concoction_custom:OnProjectileHit_ExtraData( target, location, ExtraData )
if not target then return end
local caster = self:GetCaster()

caster:FadeGesture(ACT_DOTA_ALCHEMIST_CONCOCTION_THROW)

local brew_time = ExtraData.brew_time

if ExtraData.is_mirror == 0 then
	target:AddNewModifier(caster, self, "modifier_alchemist_unstable_concoction_custom_mirror", {duration = 3, brew_time = brew_time})
	if target:TriggerSpellAbsorb( self ) then return end
end

self:DealDamage(target, brew_time, ExtraData.legendary_damage)
end




modifier_alchemist_unstable_concoction_custom = class(mod_hidden)
function modifier_alchemist_unstable_concoction_custom:OnCreated( kv )

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.move_speed = self.ability:GetSpecialValueFor("movespeed") + self.ability.talents.speed_inc
self.max_brew = self.ability:GetSpecialValueFor("brew_time")
self.dispel_delay = self.ability:GetSpecialValueFor("shard_delay")

self.legendary_damage = 0
self.legendary_bonus = self.parent:GetTalentValue("modifier_alchemist_unstable_legendary", "damage", true)/100
self.legendary_bonus_creeps = self.parent:GetTalentValue("modifier_alchemist_unstable_legendary", "creeps", true)

if self.parent:HasTalent("modifier_alchemist_unstable_legendary") then
	self.parent:AddDamageEvent_out(self, true)
end

self.max_shield = self.parent:GetTalentValue("modifier_alchemist_hero_2", "shield", true)*self.parent:GetMaxHealth()/100
self.shield = self.max_shield

self.dispel = false

if not IsServer() then return end
self:SetHasCustomTransmitterData(true)

local bottle_name = wearables_system:GetParticleReplacementAbility(self.parent, "particles/units/heroes/hero_alchemist/alchemist_unstableconc_bottles.vpcf", self)

self.particle_bottle = ParticleManager:CreateParticle(bottle_name, PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.particle_bottle, 1, self.parent, PATTACH_POINT_FOLLOW, "alchem_wl", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(self.particle_bottle, 2, self.parent, PATTACH_POINT_FOLLOW, "alchem_wr", self.parent:GetAbsOrigin(), true)
self:AddParticle(self.particle_bottle, false, false, -1, false, false ) 

if self.parent:HasTalent("modifier_alchemist_hero_2") then
	self.shield_effect = self.parent:GenericParticle( "particles/alch_stun_legendary.vpcf", self )
	self.shield_talent = "modifier_alchemist_hero_2"
end

if self.parent:HasTalent("modifier_alchemist_unstable_1") then
	self.parent:GenericParticle("particles/econ/events/fall_2022/radiance/radiance_owner_fall2022.vpcf", self)
end

self.parent:RemoveModifierByName("modifier_alchemist_unstable_concoction_custom_bonus")

self.max_duration = self:GetRemainingTime()

self.tick_interval = 0.1
self.time = self:GetRemainingTime()
self.count = 0

if self.parent:HasTalent("modifier_alchemist_unstable_legendary") then 
	self.parent:UpdateUIshort({time = self:GetRemainingTime(), max_time = self.time, stack = self.legendary_damage, style = "AlchemistUnstable"})
end 

self.tick = self:GetRemainingTime()
self.tick_halfway = true
self.explode = false

self:StartIntervalThink( self.tick_interval )

self.sound_name = self.parent:HasTalent("modifier_alchemist_unstable_legendary") and "Alch.Long_brew" or "Hero_Alchemist.UnstableConcoction.Fuse"
self.parent:EmitSound(self.sound_name)
end

function modifier_alchemist_unstable_concoction_custom:AddCustomTransmitterData() 
return {shield = self.shield}
end

function modifier_alchemist_unstable_concoction_custom:HandleCustomTransmitterData(data)
self.shield = data.shield
end

function modifier_alchemist_unstable_concoction_custom:OnIntervalThink()
if not IsServer() then return end

if self.parent:HasTalent("modifier_alchemist_unstable_legendary") then 
	self.parent:UpdateUIshort({time = self:GetRemainingTime(), max_time = self.time, stack = self.legendary_damage, active = self:GetElapsedTime() >= self.max_brew, style = "AlchemistUnstable"})
end 

self.count = self.count + self.tick_interval

if self.ability.talents.has_str == 1 and self:GetElapsedTime() >= self.ability.talents.str_timer and not self.damage_proc then 
	self.damage_proc = true
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_alchemist_unstable_concoction_custom_bonus", {duration = self.ability.talents.str_duration})
end 

if self.parent:HasShard() and self:GetElapsedTime() >= self.dispel_delay and self.dispel == false then
	self.dispel = true
	self.parent:Purge(false, true, false, true, true)
	self.parent:EmitSound("Alch.Stun_purge")
	self.parent:GenericParticle("particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf")
end

if self.count >= 0.5 then 
	self.count = 0
else 
	return
end 

self.tick = self.tick - 0.5

if self.tick>0 then
	self.tick_halfway = not self.tick_halfway
	local time = math.floor( self.tick )
	local mid = 1
	if self.tick_halfway then mid = 8 end

	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_timer.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( 1, time, mid ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( 2, 0, 0 ) )
	if time<1 then
		ParticleManager:SetParticleControl( effect_cast, 2, Vector( 1, 0, 0 ) )
	end
	ParticleManager:ReleaseParticleIndex( effect_cast )
	return
end

end

function modifier_alchemist_unstable_concoction_custom:OnDestroy()
if not IsServer() then return end

self.ability:StartCd()

if self.parent:HasTalent("modifier_alchemist_unstable_legendary") then 
	self.parent:UpdateUIshort({hide = 1, hide_full = 1, style = "AlchemistUnstable"})
end 

self.parent:FadeGesture(ACT_DOTA_ALCHEMIST_CONCOCTION)
self.parent:FadeGesture(ACT_DOTA_ALCHEMIST_CONCOCTION_THROW)

self.parent:StopSound(self.sound_name)

if self.explode == false then
	self.explode = true
	self.ability:DealDamage(self.parent, self:GetElapsedTime(), nil, true)
end

end

function modifier_alchemist_unstable_concoction_custom:DamageEvent_out(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_alchemist_unstable_legendary") then return end
if self.parent ~= params.attacker then return end
if not params.unit:IsUnit() then return end
if not params.inflictor then return end
if params.unit:IsIllusion() then return end

local damage = params.damage*self.legendary_bonus
damage = params.unit:IsCreep() and damage/self.legendary_bonus_creeps or damage

self.legendary_damage = self.legendary_damage + damage
end


function modifier_alchemist_unstable_concoction_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end

function modifier_alchemist_unstable_concoction_custom:GetModifierHealthRegenPercentage()
return self.ability.talents.regen_inc
end

function modifier_alchemist_unstable_concoction_custom:GetModifierMoveSpeedBonus_Percentage()
return self.move_speed
end

function modifier_alchemist_unstable_concoction_custom:GetModifierIncomingDamageConstant( params )
if not self.parent:HasTalent("modifier_alchemist_hero_2") then return end

if IsClient() then 
	if params.report_max then 
		return self.max_shield
	else 
    return self.shield
  end 
end

if not IsServer() then return end
if self.shield <= 0 then return end

local damage = math.min(params.damage, self.shield)
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self.shield = self.shield - damage
self:SendBuffRefreshToClients()
if self.shield <= 0 then
  if self.shield_effect then
  	ParticleManager:Delete(self.shield_effect, 1)
  	self.shield_effect = nil
  end
end

return -damage
end





modifier_alchemist_unstable_concoction_custom_bonus = class(mod_visible)
function modifier_alchemist_unstable_concoction_custom_bonus:GetTexture() return "buffs/alchemist/unstable_3" end
function modifier_alchemist_unstable_concoction_custom_bonus:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end 
self.parent:GenericParticle("particles/lc_odd_proc_.vpcf")
self.parent:EmitSound("Lc.Moment_Lowhp")
self.parent:GenericParticle("particles/lc_lowhp.vpcf", self)
self.parent:AddPercentStat({str = self.ability.talents.str_inc}, self)
self.parent:CalculateStatBonus(true)
end 

function modifier_alchemist_unstable_concoction_custom_bonus:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MODEL_SCALE,
}
end

function modifier_alchemist_unstable_concoction_custom_bonus:GetModifierModelScale()
return 20
end




modifier_alchemist_unstable_concoction_custom_charge = class(mod_hidden)
function modifier_alchemist_unstable_concoction_custom_charge:OnCreated(kv)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:EmitSound("Alch.Unstable_charge")
self.angle = self.parent:GetForwardVector():Normalized()
self.speed = self.ability.talents.speed_range / self:GetDuration()

if self:ApplyHorizontalMotionController() == false then
  self:Destroy()
end

end

function modifier_alchemist_unstable_concoction_custom_charge:DeclareFunctions()
return
{
 	MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
 	MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
  MODIFIER_PROPERTY_DISABLE_TURNING
}
end

function modifier_alchemist_unstable_concoction_custom_charge:GetActivityTranslationModifiers() return "haste" end
function modifier_alchemist_unstable_concoction_custom_charge:GetOverrideAnimation() return ACT_DOTA_RUN end
function modifier_alchemist_unstable_concoction_custom_charge:GetModifierDisableTurning() return 1 end

function modifier_alchemist_unstable_concoction_custom_charge:OnDestroy()
if not IsServer() then return end
self.parent:InterruptMotionControllers( true )

local dir = self.parent:GetForwardVector()
dir.z = 0
self.parent:SetForwardVector(dir)
self.parent:FaceTowards(self.parent:GetAbsOrigin() + dir*10)
ResolveNPCPositions(self.parent:GetAbsOrigin(), 128)
end


function modifier_alchemist_unstable_concoction_custom_charge:UpdateHorizontalMotion( me, dt )
if not IsServer() then return end
local pos = self.parent:GetAbsOrigin()
GridNav:DestroyTreesAroundPoint(pos, 80, false)

local pos_p = self.angle * self.speed * dt
local next_pos = GetGroundPosition(pos + pos_p, self.parent)
self.parent:SetAbsOrigin(next_pos)
end

function modifier_alchemist_unstable_concoction_custom_charge:OnHorizontalMotionInterrupted()
self:Destroy()
end

modifier_alchemist_unstable_concoction_custom_charge_effect = class(mod_hidden)
function modifier_alchemist_unstable_concoction_custom_charge_effect:GetEffectName() return "particles/econ/events/ti10/phase_boots_ti10.vpcf" end
function modifier_alchemist_unstable_concoction_custom_charge_effect:GetStatusEffectName() return "particles/status_fx/status_effect_forcestaff.vpcf" end
function modifier_alchemist_unstable_concoction_custom_charge_effect:StatusEffectPriority() return MODIFIER_PRIORITY_NORMAL end




modifier_alchemist_unstable_concoction_custom_tracker = class(mod_hidden)
function modifier_alchemist_unstable_concoction_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.aura_radius = self.parent:GetTalentValue("modifier_alchemist_unstable_1", "radius", true)

self.cast_range = self.parent:GetTalentValue("modifier_alchemist_unstable_4", "range")

if not IsServer() then return end
self:SetHasCustomTransmitterData(true)
self:UpdateTalent()
end

function modifier_alchemist_unstable_concoction_custom_tracker:UpdateTalent(name)
if not IsServer() then return end

if name == "modifier_alchemist_unstable_4" or self.parent:HasTalent("modifier_alchemist_unstable_4") then
	self.cast_range = self.parent:GetTalentValue("modifier_alchemist_unstable_4", "range")
end

self:SendBuffRefreshToClients()
end

function modifier_alchemist_unstable_concoction_custom_tracker:AddCustomTransmitterData() 
return 
{
  cast_range = self.cast_range,
} 
end

function modifier_alchemist_unstable_concoction_custom_tracker:HandleCustomTransmitterData(data)
self.cast_range = data.cast_range
end

function modifier_alchemist_unstable_concoction_custom_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
  MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING,
}
end

function modifier_alchemist_unstable_concoction_custom_tracker:GetModifierSlowResistance_Stacking()
if self.ability.talents.has_speed == 0 then return end
return self.ability.talents.h5_resist
end

function modifier_alchemist_unstable_concoction_custom_tracker:GetModifierSpellAmplify_Percentage()
return self.parent:HasModifier("modifier_alchemist_unstable_concoction_custom_bonus") and self.ability.talents.damage_inc*self.ability.talents.str_bonus or self.ability.talents.damage_inc
end

function modifier_alchemist_unstable_concoction_custom_tracker:GetModifierCastRangeBonusStacking()
return self.cast_range
end

function modifier_alchemist_unstable_concoction_custom_tracker:IsAura() return self.parent:HasTalent("modifier_alchemist_unstable_1") end
function modifier_alchemist_unstable_concoction_custom_tracker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_alchemist_unstable_concoction_custom_tracker:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_alchemist_unstable_concoction_custom_tracker:GetModifierAura() return "modifier_alchemist_unstable_concoction_custom_damage_aura" end
function modifier_alchemist_unstable_concoction_custom_tracker:GetAuraRadius() return self.aura_radius end
function modifier_alchemist_unstable_concoction_custom_tracker:GetAuraDuration() return 0 end








modifier_alchemist_unstable_concoction_custom_damage_aura = class(mod_hidden)
function modifier_alchemist_unstable_concoction_custom_damage_aura:OnCreated()
if not IsServer() then return end

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.interval = self.caster:GetTalentValue("modifier_alchemist_unstable_1", "interval")
self.damage = self.caster:GetTalentValue("modifier_alchemist_unstable_1", "damage")*self.interval
self.bonus = self.caster:GetTalentValue("modifier_alchemist_unstable_1", "bonus")

self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}

self.particle_index = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_fire_immolation_child.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.particle_index, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(self.particle_index, 1, self.caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.caster:GetAbsOrigin(), true)
self:AddParticle(self.particle_index, false, false, -1, false, false ) 

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_alchemist_unstable_concoction_custom_damage_aura:OnIntervalThink()
if not IsServer() then return end 

self.damageTable.damage = self.caster:HasModifier("modifier_alchemist_unstable_concoction_custom") and self.damage*self.bonus or self.damage
DoDamage(self.damageTable, "modifier_alchemist_unstable_1")
end






modifier_alchemist_unstable_concoction_custom_mirror = class(mod_hidden)
function modifier_alchemist_unstable_concoction_custom_mirror:OnCreated(table)
if not IsServer() then return end
self.mirror_time = table.brew_time
end