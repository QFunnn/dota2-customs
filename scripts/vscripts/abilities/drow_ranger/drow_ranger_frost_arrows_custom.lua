--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom_tracker", "abilities/drow_ranger/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom_slow", "abilities/drow_ranger/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom_proc", "abilities/drow_ranger/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom_legendary", "abilities/drow_ranger/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom_legendary_active", "abilities/drow_ranger/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom_legendary_damage", "abilities/drow_ranger/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom_stun", "abilities/drow_ranger/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom_reduction", "abilities/drow_ranger/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom_root", "abilities/drow_ranger/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom_root_cd", "abilities/drow_ranger/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom_attack_cd", "abilities/drow_ranger/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom_attack_damage", "abilities/drow_ranger/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom_shield", "abilities/drow_ranger/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom_shield_cd", "abilities/drow_ranger/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom_shield_stun", "abilities/drow_ranger/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom_armor", "abilities/drow_ranger/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_frost_arrows_custom_haste", "abilities/drow_ranger/drow_ranger_frost_arrows_custom", LUA_MODIFIER_MOTION_NONE )

drow_ranger_frost_arrows_custom = class({})
drow_ranger_frost_arrows_custom.talents = {}

function drow_ranger_frost_arrows_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/drow_ranger/frost_legendary_hit.vpcf", context )
PrecacheResource( "particle", "particles/drow_ranger/frost_legendary.vpcf", context )
PrecacheResource( "particle", "particles/drow_ranger/frost_legendary_start.vpcf", context )
PrecacheResource( "particle", "particles/maiden_mark.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_invoker/invoker_cold_snap.vpcf", context )
PrecacheResource( "particle", "particles/maiden_frostbite_slow.vpcf", context )
PrecacheResource( "particle", "particles/drow_ranger/frost_cleave.vpcf", context )
PrecacheResource( "particle", "particles/drow_ranger/frost_heal.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf", context )
PrecacheResource( "particle", "particles/drow_ranger/frost_crystal.vpcf", context )
PrecacheResource( "particle", "particles/drow_ranger/frost_crystal_2.vpcf", context )
PrecacheResource( "particle", "particles/drow_ranger/frost_legendary_stack.vpcf", context )
PrecacheResource( "particle", "particles/drow_ranger/frost_shield.vpcf", context )
PrecacheResource( "particle", "particles/drow_ranger/frost_shield_end.vpcf", context )
PrecacheResource( "particle", "particles/crystal_maiden/frostbite_legendary_stack.vpcf", context )
PrecacheResource( "particle", "particles/drow_ranger/frost_legendary_active.vpcf", context )
PrecacheResource( "particle", "particles/maiden_shield_active.vpcf", context )

end

function drow_ranger_frost_arrows_custom:UpdateTalents()
local caster = self:GetCaster()

if not self.init then
	self.init = true
	self.talents =
	{
	  has_q1 = 0,
	  q1_armor = 0,
	  q1_armor_inc = 0,
	  q1_max = caster:GetTalentValue("modifier_drow_frost_1", "max", true),
	  q1_duration = caster:GetTalentValue("modifier_drow_frost_1", "duration", true),

	  slow_inc = 0,
	  mana_inc = 0,

	  has_reduce = 0,
	  reduce_damage = 0,
	  reduce_heal = 0,
	  reduce_bonus = caster:GetTalentValue("modifier_drow_hero_1", "bonus", true),
	  reduce_health = caster:GetTalentValue("modifier_drow_hero_1", "health", true),
	  reduce_duration = caster:GetTalentValue("modifier_drow_hero_1", "duration", true),

	  has_proc = 0,
	  proc_damage = 0,
	  proc_cd = caster:GetTalentValue("modifier_drow_frost_3", "cd", true),
	  proc_radius = caster:GetTalentValue("modifier_drow_frost_3", "radius", true),
	  proc_targets = caster:GetTalentValue("modifier_drow_frost_3", "targets", true),

	  has_haste = 0,
	  haste_max = caster:GetTalentValue("modifier_drow_frost_4", "max", true),
	  haste_move = caster:GetTalentValue("modifier_drow_frost_4", "move", true),
	  haste_duration = caster:GetTalentValue("modifier_drow_frost_4", "duration", true),
	  haste_vision = caster:GetTalentValue("modifier_drow_frost_4", "vision", true),
	  haste_slow_resist = caster:GetTalentValue("modifier_drow_frost_4", "slow_resist", true),

	  has_root = 0,
	  duration_inc = caster:GetTalentValue("modifier_drow_hero_6", "duration", true),
	  root_duration = caster:GetTalentValue("modifier_drow_hero_6", "root", true),
	  root_cd = caster:GetTalentValue("modifier_drow_hero_6", "talent_cd", true),

	  has_shield = 0,
	  shield_health = caster:GetTalentValue("modifier_drow_hero_4", "health", true),
	  shield_cd = caster:GetTalentValue("modifier_drow_hero_4", "talent_cd", true),
	  shield_amount = caster:GetTalentValue("modifier_drow_hero_4", "shield", true)/100,
	  shield_duration = caster:GetTalentValue("modifier_drow_hero_4", "duration", true),
	  shield_radius = caster:GetTalentValue("modifier_drow_hero_4", "radius", true),
	  shield_stun = caster:GetTalentValue("modifier_drow_hero_4", "stun", true),

	  has_legendary = 0,
	  legendary_range = caster:GetTalentValue("modifier_drow_frost_7", "range", true),
	  legendary_cd = caster:GetTalentValue("modifier_drow_frost_7", "talent_cd", true),
	  legendary_max = caster:GetTalentValue("modifier_drow_frost_7", "max", true),
	  legendary_width = caster:GetTalentValue("modifier_drow_frost_7", "width", true),
	  legendary_duration = caster:GetTalentValue("modifier_drow_frost_7", "duration", true),
	  legendary_cast = caster:GetTalentValue("modifier_drow_frost_7", "cast", true),
	  legendary_stun = caster:GetTalentValue("modifier_drow_frost_7", "stun", true),
	  legendary_speed = caster:GetTalentValue("modifier_drow_frost_7", "speed", true),
	  legendary_damage = caster:GetTalentValue("modifier_drow_frost_7", "damage", true),

		has_w7 = 0,
	}
end

if caster:HasTalent("modifier_drow_frost_1") then
	self.talents.has_q1 = 1
	self.talents.q1_armor = caster:GetTalentValue("modifier_drow_frost_1", "armor")
	self.talents.q1_armor_inc = caster:GetTalentValue("modifier_drow_frost_1", "armor_inc")
end

if caster:HasTalent("modifier_drow_frost_2") then
	self.talents.slow_inc = caster:GetTalentValue("modifier_drow_frost_2", "slow")
	self.talents.mana_inc = caster:GetTalentValue("modifier_drow_frost_2", "mana")
end

if caster:HasTalent("modifier_drow_hero_1") then
	self.talents.has_reduce = 1
	self.talents.reduce_damage = caster:GetTalentValue("modifier_drow_hero_1", "damage_reduce")
	self.talents.reduce_heal = caster:GetTalentValue("modifier_drow_hero_1", "heal_reduce")
end

if caster:HasTalent("modifier_drow_frost_3") then
	self.talents.has_proc = 1
	self.talents.proc_damage = caster:GetTalentValue("modifier_drow_frost_3", "damage")
	caster:AddSpellEvent(self.tracker, true)
end

if caster:HasTalent("modifier_drow_frost_4") then
	self.talents.has_haste = 1
end

if caster:HasTalent("modifier_drow_hero_6") then
	self.talents.has_root = 1
end

if caster:HasTalent("modifier_drow_hero_4") then
	self.talents.has_shield = 1
	caster:AddDamageEvent_inc(self.tracker, true)
end

if caster:HasTalent("modifier_drow_frost_7") then
  self.talents.has_legendary = 1
end

if caster:HasTalent("modifier_drow_gust_7") then
  self.talents.has_w7 = 1
end

end

function drow_ranger_frost_arrows_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "drow_ranger_frost_arrows", self)
end

function drow_ranger_frost_arrows_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_drow_ranger_frost_arrows_custom_tracker"
end

function drow_ranger_frost_arrows_custom:GetCastRange(vLocation, hTarget)
if self.talents.has_legendary == 1 then 	
	return self.talents.legendary_range
end 
return self:GetCaster():Script_GetAttackRange() - self:GetCaster():GetCastRangeBonus()
end

function drow_ranger_frost_arrows_custom:GetManaCost(iLevel)
return self:GetCost()
end

function drow_ranger_frost_arrows_custom:GetCooldown(iLevel)
if self.talents.has_legendary == 1 then 
	return self.talents.legendary_cd
end 
return 0
end

function drow_ranger_frost_arrows_custom:GetCastPoint()
if self.talents.has_legendary == 1 then 
	return self.talents.legendary_cast
end 
return 0
end

function drow_ranger_frost_arrows_custom:GetCastAnimation()
if self.talents.has_legendary == 1 then 
	return 0
end 

end

function drow_ranger_frost_arrows_custom:OnAbilityPhaseStart()
if self.talents.has_legendary == 0 then return end
self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1.9)
return true
end

function drow_ranger_frost_arrows_custom:OnAbilityPhaseInterrupted()
if self.talents.has_legendary == 0 then return end
self:GetCaster():FadeGesture(ACT_DOTA_ATTACK)
end

function drow_ranger_frost_arrows_custom:GetBehavior()
if self.talents.has_legendary == 1 then 
	return DOTA_ABILITY_BEHAVIOR_AUTOCAST + DOTA_ABILITY_BEHAVIOR_POINT
end
return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_AUTOCAST + DOTA_ABILITY_BEHAVIOR_ATTACK
end

function drow_ranger_frost_arrows_custom:GetCost()
return (self.AbilityManaCost and self.AbilityManaCost or 0) + (self.talents.mana_inc and self.talents.mana_inc or 0)
end

function drow_ranger_frost_arrows_custom:GetProj()
local frost_effect = wearables_system:GetParticleReplacementAbility(self:GetCaster(), "particles/units/heroes/hero_drow/drow_frost_arrow.vpcf", self)
return frost_effect
end

function drow_ranger_frost_arrows_custom:GetProjUlti()
local frost_ulti_effect = wearables_system:GetParticleReplacementAbility(self:GetCaster(), "particles/units/heroes/hero_drow/drow_marksmanship_frost_arrow.vpcf", self, "drow_ranger_marksmanship_custom")
return frost_ulti_effect
end

function drow_ranger_frost_arrows_custom:OnSpellStart()
local caster = self:GetCaster()

if self.talents.has_legendary == 0 then return end

local range = self.talents.legendary_range
local speed = self.talents.legendary_speed
local width = self.talents.legendary_width

local origin = caster:GetAbsOrigin()
local vect = self:GetCursorPosition() - origin
local dir = vect:Normalized()
local point = origin + dir*(range + caster:GetCastRangeBonus())

ProjectileManager:CreateLinearProjectile({
	EffectName = "particles/drow_ranger/frost_legendary.vpcf",
	Ability = self,
	vSpawnOrigin = origin,
	fStartRadius = width,
	fEndRadius = width,
	vVelocity = dir * speed,
	fDistance = range + caster:GetCastRangeBonus(),
	Source = caster,
	iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
	bProvidesVision = true,
	iVisionTeamNumber = caster:GetTeamNumber(),
	iVisionRadius = width*3,
	ExtraData =   
	{
		active = 1,
	},
})

caster:EmitSound("Drow.Frost_legendary_start")
caster:EmitSound("Drow.Frost_legendary_start2")

local effect_cast = ParticleManager:CreateParticle( "particles/drow_ranger/frost_legendary_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster )
ParticleManager:SetParticleControl( effect_cast, 0, caster:GetOrigin())
ParticleManager:SetParticleControl( effect_cast, 1, caster:GetOrigin())
ParticleManager:SetParticleControlForward( effect_cast, 1, caster:GetForwardVector())
ParticleManager:ReleaseParticleIndex(effect_cast)
end


function drow_ranger_frost_arrows_custom:OnProjectileHit_ExtraData(target, vLocation, table)
if not target then return end

local caster = self:GetCaster()

if table.active == 1 then  
	local mod = target:FindModifierByName("modifier_drow_ranger_frost_arrows_custom_legendary")

	if not mod then return end

	local stack = mod:GetStackCount()
	target:AddNewModifier(caster, self, "modifier_drow_ranger_frost_arrows_custom_stun", {duration = self.talents.legendary_stun*stack*(1 - target:GetStatusResistance())})
    target:AddNewModifier(caster, self, "modifier_drow_ranger_frost_arrows_custom_legendary_active", {stack = stack})
	target:EmitSound("Drow.Frost_legendary_hit")

	local effect_cast = ParticleManager:CreateParticle( "particles/drow_ranger/frost_legendary_hit.vpcf", PATTACH_CUSTOMORIGIN, target )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex(effect_cast)

	mod:Destroy()
else 
	caster:AddNewModifier(caster, self, "modifier_drow_ranger_frost_arrows_custom_attack_damage", {duration = FrameTime()})
	caster:PerformAttack(target, true, true, true, true, false, false, true)
	caster:RemoveModifierByName("modifier_drow_ranger_frost_arrows_custom_attack_damage")
	target:EmitSound("Drow.Frost_proc_target")
end

end

function drow_ranger_frost_arrows_custom:LaunchShard()
if not IsServer() then return end
local caster = self:GetCaster()
local radius = self.talents.proc_radius
local max = self.talents.proc_targets
local count = 0
local projectile_speed = 1500

local projectile =
{
	Source 				= caster,
	Ability 			= self,
	iMoveSpeed			= projectile_speed,
	vSourceLoc 			= caster:GetAbsOrigin(),
	bDrawsOnMinimap 	= false,
	bDodgeable 			= true,
	bIsAttack 			= false,
	bVisibleToEnemies 	= true,
	bReplaceExisting 	= false,
	flExpireTime 		= GameRules:GetGameTime() + 20,
	bProvidesVision 	= false,
	ExtraData			= {active = 0}
}

local targets = caster:FindTargets(radius)

for _,target in pairs(targets) do 
	if RandomInt(1, 2) == 1 then 
		projectile.EffectName = "particles/drow_ranger/frost_crystal_2.vpcf"
	else 
		projectile.EffectName = "particles/drow_ranger/frost_crystal.vpcf"
	end
	projectile.Target = target
	ProjectileManager:CreateTrackingProjectile(projectile)

	count = count + 1
	if count >= max then 
		break
	end 
end

if #targets > 0 then
	self:ApplyHaste()

	if self.caster.marksmanship_ability then
		self.caster.marksmanship_ability:LegendaryStack()
	end

	caster:EmitSound("Drow.Frost_proc")
end

end 

function drow_ranger_frost_arrows_custom:ApplyHaste()
if not IsServer() then return end
if not self:IsTrained() or self.talents.has_haste == 0 then return end
local caster = self:GetCaster()
caster:AddNewModifier(caster, self, "modifier_drow_ranger_frost_arrows_custom_haste", {duration = self.talents.haste_duration})
end


function drow_ranger_frost_arrows_custom:ApplySlow(target, is_illusion)

local caster = self:GetCaster()
local duration = self.AbilityDuration

if self.talents.has_root == 1 then 
	duration = duration + self.talents.duration_inc

	if not target:HasModifier("modifier_drow_ranger_frost_arrows_custom_root_cd") then
	    target:EmitSound("Hero_Crystal.frostbite")
	    target:AddNewModifier(caster, self, "modifier_drow_ranger_frost_arrows_custom_root", {duration = (1 - target:GetStatusResistance())*self.talents.root_duration})
	    target:AddNewModifier(caster, self, "modifier_drow_ranger_frost_arrows_custom_root_cd", {duration = self.talents.root_cd})
	end
end 

if not target:HasModifier("modifier_drow_ranger_frost_arrows_custom_legendary_active") and self.talents.has_legendary == 1 and self:GetCooldownTimeRemaining() <= 0 and not is_illusion then
	target:AddNewModifier(caster, self, "modifier_drow_ranger_frost_arrows_custom_legendary", {duration = self.talents.legendary_duration})
end

if self.talents.has_q1 == 1 then
	target:AddNewModifier(caster, self, "modifier_drow_ranger_frost_arrows_custom_armor", {duration = self.talents.q1_duration})
end

if self.talents.has_reduce == 1 then 
	target:AddNewModifier(caster, self, "modifier_drow_ranger_frost_arrows_custom_reduction", {duration = self.talents.reduce_duration})
end 

if self.talents.has_haste == 1 and target:IsRealHero() then
	target:AddNewModifier(caster, self, "modifier_generic_vision", {duration = self.talents.haste_vision})
end

target:AddNewModifier(caster, caster:BkbAbility(self, self.talents.has_root == 1), "modifier_drow_ranger_frost_arrows_custom_slow", {duration = (1 - target:GetStatusResistance())*duration})
end



modifier_drow_ranger_frost_arrows_custom_tracker = class(mod_hidden)
function modifier_drow_ranger_frost_arrows_custom_tracker:OnCreated(table)
self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.parent = self:GetParent()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.frost_arrow_ability = self.ability

self.ability.AbilityDuration = self.ability:GetSpecialValueFor("AbilityDuration")
self.ability.AbilityManaCost = self.ability:GetSpecialValueFor("AbilityManaCost")
self.ability.frost_arrows_movement_speed = self.ability:GetSpecialValueFor("frost_arrows_movement_speed")
self.ability.damage = self.ability:GetSpecialValueFor("damage")                             

self.ulti_ability = self.parent:FindAbilityByName("drow_ranger_marksmanship_custom")
self.silence_ability = self.parent:FindAbilityByName("drow_ranger_wave_of_silence_custom")

self.parent:AddRecordDestroyEvent(self, true)
self.parent:AddAttackRecordEvent_out(self)
self.parent:AddAttackStartEvent_out(self)
self.parent:AddOrderEvent(self)

self.records = {}
self.cast = false
end

function modifier_drow_ranger_frost_arrows_custom_tracker:OnRefresh()
self.ability.AbilityManaCost = self.ability:GetSpecialValueFor("AbilityManaCost")
self.ability.frost_arrows_movement_speed = self.ability:GetSpecialValueFor("frost_arrows_movement_speed")
self.ability.damage = self.ability:GetSpecialValueFor("damage")    
end

function modifier_drow_ranger_frost_arrows_custom_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	MODIFIER_PROPERTY_PROJECTILE_NAME,
  MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
  MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end

function modifier_drow_ranger_frost_arrows_custom_tracker:GetModifierPhysicalArmorBonus()
return self.ability.talents.q1_armor_inc
end

function modifier_drow_ranger_frost_arrows_custom_tracker:GetModifierAttackRangeBonus()
if self.parent:IsRangedAttacker() then return end
return 300
end

function modifier_drow_ranger_frost_arrows_custom_tracker:RecordDestroyEvent( params )
self.records[params.record] = nil
end

function modifier_drow_ranger_frost_arrows_custom_tracker:OrderEvent( params )
if self.ability.talents.has_legendary == 1 then return end 
self.cast = params.ability and params.ability == self.ability
end

function modifier_drow_ranger_frost_arrows_custom_tracker:AttackRecordEvent_out(params)
if not IsServer() then return end 
if self.parent ~= params.attacker then return end 

self.parent:RemoveModifierByName("modifier_drow_ranger_frost_arrows_custom_proc")

if not self:ShouldLaunch( params.target ) then return end
self.parent:AddNewModifier(self.parent, self.ability, "modifier_drow_ranger_frost_arrows_custom_proc", {})
end 

function modifier_drow_ranger_frost_arrows_custom_tracker:AttackStartEvent_out( params )
local attacker = params.attacker

if attacker:IsIllusion() and attacker.owner and attacker.owner == self.parent then 
	attacker:EmitSound("Hero_DrowRanger.FrostArrows")
end

if attacker~=self.parent then return end

if self.parent:HasModifier("modifier_drow_ranger_frost_arrows_custom_proc") then
	self.parent:RemoveModifierByName("modifier_drow_ranger_frost_arrows_custom_proc")

	self.cast = false
	self.ability:UseResources( true, false, false, false )
	self.records[params.record] = true
	self.parent:EmitSound("Hero_DrowRanger.FrostArrows")
end

if params.no_attack_cooldown then return end
self.ability:ApplyHaste()

if self.ability.talents.has_proc == 0 then return end
if self.parent:HasModifier("modifier_drow_ranger_frost_arrows_custom_attack_cd") then return end
if not params.target:IsUnit() then return end
self.ability:LaunchShard()

self.parent:AddNewModifier(self.parent, self.ability, "modifier_drow_ranger_frost_arrows_custom_attack_cd", {duration = self.ability.talents.proc_cd})
end



function modifier_drow_ranger_frost_arrows_custom_tracker:DamageEvent_inc(params)
if not IsServer() then return end
if self.ability.talents.has_shield == 0 then return end
if self.parent:GetHealthPercent() > self.ability.talents.shield_health then return end
if self.parent ~= params.unit then return end
if self.parent:PassivesDisabled() then return end 
if not self.parent:IsAlive() then return end
if self.parent:HasModifier("modifier_drow_ranger_frost_arrows_custom_shield") or self.parent:HasModifier("modifier_drow_ranger_frost_arrows_custom_shield_cd") then return end
if self.parent:HasModifier("modifier_death") then return end 

self.parent:AddNewModifier(self.parent, self.ability, "modifier_drow_ranger_frost_arrows_custom_shield", {duration = self.ability.talents.shield_duration})
end

function modifier_drow_ranger_frost_arrows_custom_tracker:SpellEvent(params)
if not IsServer() then return end 
if not self.ability.talents.has_proc == 1 then return end
if params.unit~=self.parent then return end
if self.ability == params.ability then return end

self.ability:LaunchShard()
end

function modifier_drow_ranger_frost_arrows_custom_tracker:GetPriority()
if self.parent:HasModifier("modifier_drow_ranger_marksmanship_custom_proc") then
	return MODIFIER_PRIORITY_SUPER_ULTRA
end
if self.parent:HasModifier("modifier_drow_ranger_frost_arrows_custom_proc") then
	return MODIFIER_PRIORITY_NORMAL
end
return MODIFIER_PRIORITY_LOW
end

function modifier_drow_ranger_frost_arrows_custom_tracker:GetModifierProjectileName()
local has_ulti = self.parent:HasModifier("modifier_drow_ranger_marksmanship_custom_proc")
local has_frost = self.parent:HasModifier("modifier_drow_ranger_frost_arrows_custom_proc")

local base = wearables_system:GetParticleReplacementAbility(self.parent, "particles/units/heroes/hero_drow/drow_base_attack.vpcf", self)

if has_frost and has_ulti then 
   return self.ability:GetProjUlti()
end 
if has_frost then 
   return self.ability:GetProj()
end
if has_ulti and self.ulti_ability then 
   return self.ulti_ability:GetProj()
end
return base
end


function modifier_drow_ranger_frost_arrows_custom_tracker:ShouldLaunch( target )
if self.parent:IsSilenced() then return false end
if not self.ability:GetAutoCastState() and not self.cast then return false end
if self.parent:GetMana() < self.ability:GetCost() then return end
if not target:IsUnit() then return end

return true
end

function modifier_drow_ranger_frost_arrows_custom_tracker:GetModifierProcAttack_BonusDamage_Physical( params )
if not IsServer() then return end 
if self.parent ~= params.attacker then return end 
local target = params.target

if not target:IsUnit() then return end 

local k = 1

if self.parent:HasModifier("modifier_drow_ranger_frost_arrows_custom_attack_damage") or self.parent:HasModifier("modifier_drow_ranger_frost_arrows_custom_legendary_damage") then 

else 
	if not self.records[params.record] then 
		return
	end
end 

self.ability:ApplySlow(target)
return self.ability.damage
end


modifier_drow_ranger_frost_arrows_custom_slow = class({})
function modifier_drow_ranger_frost_arrows_custom_slow:IsHidden() return true end
function modifier_drow_ranger_frost_arrows_custom_slow:IsPurgable() return true end
function modifier_drow_ranger_frost_arrows_custom_slow:GetTexture() return "drow_ranger_frost_arrows" end
function modifier_drow_ranger_frost_arrows_custom_slow:OnCreated()
self.caster = self:GetCaster()
self.parent = self:GetParent()

self.ability = self.caster:FindAbilityByName("drow_ranger_frost_arrows_custom")
if not self.ability then 
	self:Destroy()
	return
end

self.slow = self.ability.frost_arrows_movement_speed + self.ability.talents.slow_inc

if not IsServer() then return end 

local part = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_drow/drow_frost_arrow_debuff.vpcf", self)

self.parent:GenericParticle(part, self)

if self.parent:IsRealHero() and self.caster:GetQuest() == "Drow.Quest_5" and not self.caster:QuestCompleted()  then
	self.interval = 0.5
	self:StartIntervalThink(self.interval)
end

end

function modifier_drow_ranger_frost_arrows_custom_slow:OnIntervalThink()
if not IsServer() then return end 
self.caster:UpdateQuest(self.interval)
end

function modifier_drow_ranger_frost_arrows_custom_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_drow_ranger_frost_arrows_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_drow_ranger_frost_arrows_custom_slow:GetStatusEffectName()
if not self.caster or self.caster:IsNull() then 
return "particles/status_fx/status_effect_drow_frost_arrow.vpcf"
end

local effect = wearables_system:GetParticleReplacementAbility(self.caster, "particles/status_fx/status_effect_drow_frost_arrow.vpcf", self)
return effect
end

function modifier_drow_ranger_frost_arrows_custom_slow:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL 
end


modifier_drow_ranger_frost_arrows_custom_proc = class(mod_hidden)


modifier_drow_ranger_frost_arrows_custom_legendary = class(mod_visible)
function modifier_drow_ranger_frost_arrows_custom_legendary:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max = self.ability.talents.legendary_max

if not IsServer() then return end 
self.RemoveForDuel = true
self.effect_cast = self.parent:GenericParticle("particles/crystal_maiden/frostbite_legendary_stack.vpcf", self, true)
self:SetStackCount(1)
end

function modifier_drow_ranger_frost_arrows_custom_legendary:OnRefresh()
if not IsServer() then return end 
if self:GetStackCount() >= self.max then return end 

self:IncrementStackCount()

if self:GetStackCount() >= self.max then 
	self.parent:EmitSound("Drow.Frost_legendary_max")
	self.parent:GenericParticle("particles/maiden_mark.vpcf", self, true)

	if self.effect_cast then
	    ParticleManager:DestroyParticle(self.effect_cast, false)
	    ParticleManager:ReleaseParticleIndex(self.effect_cast)
	    self.effect_cast = nil
	end
end

end 

function modifier_drow_ranger_frost_arrows_custom_legendary:OnStackCountChanged(iStackCount)
if not self.effect_cast then return end
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )
end



modifier_drow_ranger_frost_arrows_custom_legendary_active = class(mod_hidden)
function modifier_drow_ranger_frost_arrows_custom_legendary_active:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

if not IsServer() then return end 
self:SetStackCount(table.stack)
self.interval = 0.25

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_drow_ranger_frost_arrows_custom_legendary_active:OnIntervalThink()
if not IsServer() then return end
self:DecrementStackCount()

self.caster:AddNewModifier(self.caster, self.ability, "modifier_drow_ranger_frost_arrows_custom_legendary_damage", {duration = FrameTime()})
self.caster:PerformAttack(self.parent, true, true, true, true, false, false, true)
self.caster:RemoveModifierByName("modifier_drow_ranger_frost_arrows_custom_legendary_damage")
self.parent:EmitSound("Drow.Frost_legendary_active_damage")

if self:GetStackCount() <= 0 then
	self:Destroy()
	return
end

end

modifier_drow_ranger_frost_arrows_custom_legendary_damage = class(mod_hidden)
function modifier_drow_ranger_frost_arrows_custom_legendary_damage:OnCreated()
self.ability = self:GetAbility()
self.damage = self.ability.talents.legendary_damage - 100
end

function modifier_drow_ranger_frost_arrows_custom_legendary_damage:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
}
end

function modifier_drow_ranger_frost_arrows_custom_legendary_damage:GetModifierTotalDamageOutgoing_Percentage(params)
if params.inflictor then return end
return self.damage
end



modifier_drow_ranger_frost_arrows_custom_stun = class(mod_hidden)
function modifier_drow_ranger_frost_arrows_custom_stun:IsStunDebuff() return true end
function modifier_drow_ranger_frost_arrows_custom_stun:IsPurgeException() return true end
function modifier_drow_ranger_frost_arrows_custom_stun:GetStatusEffectName()
return "particles/econ/items/drow/drow_arcana/drow_arcana_status_effect_frost_arrow.vpcf"
end

function modifier_drow_ranger_frost_arrows_custom_stun:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA 
end

function modifier_drow_ranger_frost_arrows_custom_stun:CheckState()
return
{
    [MODIFIER_STATE_FROZEN] = true,
    [MODIFIER_STATE_STUNNED] = true
}
end

function modifier_drow_ranger_frost_arrows_custom_stun:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.parent:EmitSound("Drow.Frost_legendary_stun")
self.parent:GenericParticle("particles/maiden_mark.vpcf", self, true)
self.parent:GenericParticle("particles/drow_ranger/frost_legendary_active.vpcf", self)
end


modifier_drow_ranger_frost_arrows_custom_reduction = class(mod_visible)
function modifier_drow_ranger_frost_arrows_custom_reduction:GetTexture() return "buffs/drow_ranger/hero_1" end
function modifier_drow_ranger_frost_arrows_custom_reduction:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.reduce_damage = self.ability.talents.reduce_damage
self.reduce_heal = self.ability.talents.reduce_heal
self.reduce_health = self.ability.talents.reduce_health
self.reduce_bonus = self.ability.talents.reduce_bonus
end

function modifier_drow_ranger_frost_arrows_custom_reduction:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end

function modifier_drow_ranger_frost_arrows_custom_reduction:GetModifierSpellAmplify_Percentage()
return self.reduce_damage*(self.parent:GetHealthPercent() <= self.reduce_health and self.reduce_bonus or 1)
end

function modifier_drow_ranger_frost_arrows_custom_reduction:GetModifierDamageOutgoing_Percentage()
return self.reduce_damage*(self.parent:GetHealthPercent() <= self.reduce_health and self.reduce_bonus or 1)
end

function modifier_drow_ranger_frost_arrows_custom_reduction:GetModifierLifestealRegenAmplify_Percentage()
return self.reduce_heal*(self.parent:GetHealthPercent() <= self.reduce_health and self.reduce_bonus or 1)
end

function modifier_drow_ranger_frost_arrows_custom_reduction:GetModifierHealChange()
return self.reduce_heal*(self.parent:GetHealthPercent() <= self.reduce_health and self.reduce_bonus or 1)
end

function modifier_drow_ranger_frost_arrows_custom_reduction:GetModifierHPRegenAmplify_Percentage() 
return self.reduce_heal*(self.parent:GetHealthPercent() <= self.reduce_health and self.reduce_bonus or 1)
end


modifier_drow_ranger_frost_arrows_custom_root = class({})
function modifier_drow_ranger_frost_arrows_custom_root:IsHidden() return true end
function modifier_drow_ranger_frost_arrows_custom_root:IsPurgable() return true end
function modifier_drow_ranger_frost_arrows_custom_root:CheckState()
return
{
	[MODIFIER_STATE_ROOTED] = true
}
end

function modifier_drow_ranger_frost_arrows_custom_root:GetEffectName() return "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf" end
function modifier_drow_ranger_frost_arrows_custom_root:GetEffectAttachType() return PATTACH_ABSORIGIN_FOLLOW end


modifier_drow_ranger_frost_arrows_custom_root_cd = class(mod_hidden)
function modifier_drow_ranger_frost_arrows_custom_root_cd:RemoveOnDeath() return false end
function modifier_drow_ranger_frost_arrows_custom_root_cd:OnCreated()
self.RemoveForDuel = true
end

modifier_drow_ranger_frost_arrows_custom_attack_cd = class(mod_cd)
function modifier_drow_ranger_frost_arrows_custom_attack_cd:GetTexture() return "buffs/drow_ranger/frost_3" end

modifier_drow_ranger_frost_arrows_custom_attack_damage = class(mod_hidden)
function modifier_drow_ranger_frost_arrows_custom_attack_damage:IsHidden() return true end
function modifier_drow_ranger_frost_arrows_custom_attack_damage:IsPurgable() return false end
function modifier_drow_ranger_frost_arrows_custom_attack_damage:OnCreated()
self.ability = self:GetAbility()
self.damage = self.ability.talents.proc_damage - 100
end

function modifier_drow_ranger_frost_arrows_custom_attack_damage:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
}
end

function modifier_drow_ranger_frost_arrows_custom_attack_damage:GetModifierTotalDamageOutgoing_Percentage(params)
if params.inflictor then return end
return self.damage
end


modifier_drow_ranger_frost_arrows_custom_shield = class(mod_visible)
function modifier_drow_ranger_frost_arrows_custom_shield:GetTexture() return "buffs/drow_ranger/hero_5" end
function modifier_drow_ranger_frost_arrows_custom_shield:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.shield_talent = "modifier_drow_hero_4"
self.max_shield = self.ability.talents.shield_amount*self.parent:GetMaxHealth()
self.shield = self.max_shield

if not IsServer() then return end

self.pfx = ParticleManager:CreateParticle("particles/drow_ranger/frost_shield.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.pfx, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), false)
self:AddParticle(self.pfx,false, false, -1, false, false)
self.parent:EmitSound("Drow.Frost_shield_start")

self:SetHasCustomTransmitterData(true)
end

function modifier_drow_ranger_frost_arrows_custom_shield:AddCustomTransmitterData() 
return {shield = self.shield}
end

function modifier_drow_ranger_frost_arrows_custom_shield:HandleCustomTransmitterData(data)
self.shield = data.shield
end

function modifier_drow_ranger_frost_arrows_custom_shield:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end

function modifier_drow_ranger_frost_arrows_custom_shield:GetModifierIncomingDamageConstant( params )
if self.shield == 0 then return end

if IsClient() then 
  if params.report_max then 
  	return self.max_shield
  else 
	return self.shield
  end 
end

if not IsServer() then return end

local damage = math.min(params.damage, self.shield)
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self.shield = self.shield - damage
self:SendBuffRefreshToClients()

if self.shield <= 0 then
  self.target = params.attacker
  self:Destroy()
end
return -damage
end

function modifier_drow_ranger_frost_arrows_custom_shield:OnDestroy()
if not IsServer() then return end 
self.parent:AddNewModifier(self.parent, self.ability, "modifier_drow_ranger_frost_arrows_custom_shield_cd", {duration = self.ability.talents.shield_cd})

self.parent:EmitSound("Drow.Frost_shield_end")
if self:GetStackCount() > 0 then return end 

self.parent:EmitSound("Drow.Frost_shield_end2")

local targets = self.parent:FindTargets(self.ability.talents.shield_radius)
local stun = self.ability.talents.shield_stun

if IsValid(self.target) then
	table.insert(targets, self.target)
end

for _,target in pairs(targets) do 
	if not target:HasModifier("modifier_drow_ranger_frost_arrows_custom_shield_stun") then 
		target:AddNewModifier(self.parent, self.ability, "modifier_drow_ranger_frost_arrows_custom_shield_stun", {duration = (1 - target:GetStatusResistance())*stun})
	end
end

local pfx = ParticleManager:CreateParticle("particles/drow_ranger/frost_shield_end.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl( pfx, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl( pfx, 1, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl( pfx, 2, self.parent:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(pfx)
end


function modifier_drow_ranger_frost_arrows_custom_shield:GetStatusEffectName()
return "particles/econ/items/drow/drow_ti9_immortal/status_effect_drow_ti9_frost_arrow.vpcf"
end

function modifier_drow_ranger_frost_arrows_custom_shield:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end


modifier_drow_ranger_frost_arrows_custom_shield_stun = class(mod_hidden)
function modifier_drow_ranger_frost_arrows_custom_shield_stun:IsStunDebuff() return true end
function modifier_drow_ranger_frost_arrows_custom_shield_stun:IsPurgeException() return true end

function modifier_drow_ranger_frost_arrows_custom_shield_stun:GetStatusEffectName()
return "particles/status_fx/status_effect_frost.vpcf"
end
function modifier_drow_ranger_frost_arrows_custom_shield_stun:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end
function modifier_drow_ranger_frost_arrows_custom_shield_stun:CheckState()
return
{
  [MODIFIER_STATE_FROZEN] = true,
  [MODIFIER_STATE_STUNNED] = true
}
end

modifier_drow_ranger_frost_arrows_custom_shield_cd = class(mod_cd)
function modifier_drow_ranger_frost_arrows_custom_shield_cd:GetTexture() return "buffs/drow_ranger/hero_5" end


modifier_drow_ranger_frost_arrows_custom_armor = class(mod_visible)
function modifier_drow_ranger_frost_arrows_custom_armor:GetTexture() return "buffs/drow_ranger/frost_1" end
function modifier_drow_ranger_frost_arrows_custom_armor:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.max = self.ability.talents.q1_max
self.armor = self.ability.talents.q1_armor/self.max

if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_drow_ranger_frost_arrows_custom_armor:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self:GetStackCount() >= self.max and self.ability.talents.has_w7 == 0 then
	self.parent:EmitSound("Item.StarEmblem.Enemy")
	self.parent:GenericParticle("particles/drow_ranger/multi_armor.vpcf", self, true)
end

end

function modifier_drow_ranger_frost_arrows_custom_armor:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end

function modifier_drow_ranger_frost_arrows_custom_armor:GetModifierPhysicalArmorBonus()
return self.armor*self:GetStackCount()
end


modifier_drow_ranger_frost_arrows_custom_haste = class(mod_visible)
function modifier_drow_ranger_frost_arrows_custom_haste:GetTexture() return "buffs/drow_ranger/frost_4" end
function modifier_drow_ranger_frost_arrows_custom_haste:OnCreated() 
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.move = self.ability.talents.haste_move
self.max = self.ability.talents.haste_max
if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_drow_ranger_frost_arrows_custom_haste:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self:GetStackCount() >= self.max then
	self.parent:GenericParticle("particles/drow_ranger/silence_legendary_speed.vpcf", self )
	self.parent:GenericParticle("particles/drow_ranger/silence_legendary_speed_start.vpcf")
	self.parent:EmitSound("Drow.Mark_move")
end

end

function modifier_drow_ranger_frost_arrows_custom_haste:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING
}
end

function modifier_drow_ranger_frost_arrows_custom_haste:GetModifierMoveSpeedBonus_Percentage()
return self.move*self:GetStackCount()
end

function modifier_drow_ranger_frost_arrows_custom_haste:GetModifierSlowResistance_Stacking()
if self:GetStackCount() < self.max then return end
return self.ability.talents.haste_slow_resist
end