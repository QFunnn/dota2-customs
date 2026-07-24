--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skywrath_mage_concussive_shot_custom_slow", "abilities/skywrath_mage/skywrath_mage_concussive_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_concussive_shot_custom_tracker", "abilities/skywrath_mage/skywrath_mage_concussive_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_concussive_shot_custom_legendary_stack", "abilities/skywrath_mage/skywrath_mage_concussive_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_concussive_shot_custom_legendary_effect", "abilities/skywrath_mage/skywrath_mage_concussive_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_concussive_shot_custom_burn", "abilities/skywrath_mage/skywrath_mage_concussive_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_concussive_shot_custom_burn_tracker", "abilities/skywrath_mage/skywrath_mage_concussive_shot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skywrath_mage_concussive_shot_custom_haste", "abilities/skywrath_mage/skywrath_mage_concussive_shot_custom", LUA_MODIFIER_MOTION_NONE)

skywrath_mage_concussive_shot_custom = class({})

function skywrath_mage_concussive_shot_custom:GetAbilityTextureName()
    return wearables_system:GetAbilityIconReplacement(self.caster, "skywrath_mage_concussive_shot", self)
end

function skywrath_mage_concussive_shot_custom:CreateTalent(name)

if name == "modifier_sky_concussive_7" then
	local mod = self:GetCaster():FindModifierByName("modifier_skywrath_mage_concussive_shot_custom_tracker")
	if mod then 
		mod:UpdateEffect()
	end
end

if name == "modifier_sky_concussive_6" then
	self:ToggleAutoCast()
end

end

function skywrath_mage_concussive_shot_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot_failure.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot_cast.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot_slow_debuff.vpcf", context )
PrecacheResource( "particle","particles/skymage/bolt_slow.vpcf", context )
PrecacheResource( "particle","particles/skywrath/shot_legendary_stack.vpcf", context )
PrecacheResource( "particle","particles/skymage/shot_burn.vpcf", context )
PrecacheResource( "particle","particles/skymage/shot_haste.vpcf", context )
PrecacheResource( "particle","particles/skywrath/shot_legendary.vpcf", context )
end




function skywrath_mage_concussive_shot_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_skywrath_mage_concussive_shot_custom_tracker"
end

function skywrath_mage_concussive_shot_custom:GetAbilityTargetFlags()
if self:GetCaster():HasShard() then 
  return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
else 
  return DOTA_UNIT_TARGET_FLAG_NONE
end

end



function skywrath_mage_concussive_shot_custom:GetBehavior()
local auto = 0
if self:GetCaster():HasTalent("modifier_sky_concussive_6") then 
	auto = DOTA_ABILITY_BEHAVIOR_AUTOCAST
end 
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + auto
end



function skywrath_mage_concussive_shot_custom:GetCooldown(level)
local bonus = 0
if self:GetCaster():HasTalent("modifier_sky_concussive_3") then 
	bonus = self:GetCaster():GetTalentValue("modifier_sky_concussive_3", "cd")
end 
return self.BaseClass.GetCooldown( self, level ) + bonus
end

function skywrath_mage_concussive_shot_custom:ApplyBurn(target)
local caster = self:GetCaster()
if not caster:HasTalent("modifier_sky_concussive_4") then return end
local duration = caster:GetTalentValue("modifier_sky_concussive_4", "duration")

target:AddNewModifier(caster, self, "modifier_skywrath_mage_concussive_shot_custom_burn", {duration = duration})
target:AddNewModifier(caster, self, "modifier_skywrath_mage_concussive_shot_custom_burn_tracker", {duration = duration})
end


function skywrath_mage_concussive_shot_custom:OnSpellStart()
local caster = self:GetCaster()

if not caster:HasModifier("modifier_skywrath_mage_mystic_flare_custom_legendary_caster") then
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_2)
end

if caster:HasTalent("modifier_sky_concussive_5") then 
	caster:Purge(false, true, false, false, false)
	caster:AddNewModifier(caster, self, "modifier_skywrath_mage_concussive_shot_custom_haste", {duration = caster:GetTalentValue("modifier_sky_concussive_5", "duration")})
end

local search_radius = self:GetSpecialValueFor("launch_radius")

local heroes = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, search_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS, FIND_CLOSEST, false)
local creeps = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, search_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false)

local target = nil
if #heroes > 0 then 
	target = heroes[1]
elseif #creeps > 0 then 
	target = creeps[1]
end

local failure_fx = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot_failure.vpcf", self)

if target == nil then 
	local particle_fail_fx = ParticleManager:CreateParticle(failure_fx, PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(particle_fail_fx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_fail_fx, 1, caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle_fail_fx)
    return
end

self:LaunchShot(target)
end



function skywrath_mage_concussive_shot_custom:LaunchShot(target, legendary)
local caster = self:GetCaster()
local speed = self:GetSpecialValueFor("speed")
local cast_ability = nil
if legendary then 
	cast_ability = "modifier_sky_concussive_7"
end

local cast_fx = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot_cast.vpcf", self)
local particle_projectile = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot.vpcf", self)

local particle_fail_fx = ParticleManager:CreateParticle(cast_fx, PATTACH_ABSORIGIN, caster)
ParticleManager:SetParticleControlEnt(particle_fail_fx, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
ParticleManager:SetParticleControlEnt(particle_fail_fx, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
ParticleManager:SetParticleControl(particle_fail_fx, 2,  Vector( speed, 0, 0 ))
ParticleManager:ReleaseParticleIndex(particle_fail_fx)

caster:EmitSound("Hero_SkywrathMage.ConcussiveShot.Cast")


local shot_vision = self:GetSpecialValueFor("shot_vision")  

local concussive_projectile = {
  Target = target,
  Source = caster,
  Ability = self,
  EffectName = particle_projectile,
  iMoveSpeed = speed,
  bDodgeable = true, 
  bVisibleToEnemies = true,
  bReplaceExisting = false,
  bProvidesVision = true,
  iVisionRadius = shot_vision,
  iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION, 
  iVisionTeamNumber = caster:GetTeamNumber(),
  ExtraData = {cast_ability = cast_ability}                           
}

ProjectileManager:CreateTrackingProjectile(concussive_projectile)
end



function skywrath_mage_concussive_shot_custom:OnProjectileHit_ExtraData(target, location, extra_data)
if not target then return nil end

local caster = self:GetCaster()   

local slow_radius = self:GetSpecialValueFor("slow_radius")
local damage = self:GetSpecialValueFor("damage") + caster:GetTalentValue("modifier_sky_concussive_1", "damage")*caster:GetAverageTrueAttackDamage(nil)/100
local slow_duration = self:GetSpecialValueFor("slow_duration") + caster:GetTalentValue("modifier_sky_concussive_3", "duration")
local shot_vision = self:GetSpecialValueFor("shot_vision")
local vision_duration = self:GetSpecialValueFor("vision_duration")

local knock_dist = caster:GetTalentValue("modifier_sky_concussive_6", "range")
local knock_duration = caster:GetTalentValue("modifier_sky_concussive_6", "duration")
local knock_range = caster:GetTalentValue("modifier_sky_concussive_6", "knock_distance")
local vec = (target:GetAbsOrigin() - caster:GetAbsOrigin())
local knock = caster:HasTalent("modifier_sky_concussive_6") and vec:Length2D() <= knock_dist and self:GetAutoCastState() == true
local center = target:GetAbsOrigin() + vec:Normalized()*-10

local shard_stun = self:GetSpecialValueFor("shard_stun")

local cast_ability = nil
if extra_data.cast_ability then 
	cast_ability = extra_data.cast_ability
end

if cast_ability == "modifier_sky_concussive_7" then 
	knock_range = caster:GetTalentValue("modifier_sky_concussive_6", "knock_distance_legendary")
end

if target:IsRealHero() and caster:GetQuest() == "Sky.Quest_6" and (vec:Length2D() >= caster.quest.number) then 
	caster:UpdateQuest(1)
end

target:EmitSound("Hero_SkywrathMage.ConcussiveShot.Target")

AddFOWViewer(caster:GetTeamNumber(), location, shot_vision, vision_duration, false)
local damageTable = {attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self }

for _,enemy in pairs(caster:FindTargets(slow_radius, target:GetAbsOrigin())) do 

	if caster:HasTalent("modifier_sky_flare_4") then 
		enemy:AddNewModifier(caster, self, "modifier_skywrath_mage_mystic_flare_custom_damage_inc", {duration = caster:GetTalentValue("modifier_sky_flare_4", "duration")})
	end

	enemy:AddNewModifier(caster, caster:BkbAbility(self, caster:HasShard()), "modifier_skywrath_mage_concussive_shot_custom_slow", {duration = (1 - enemy:GetStatusResistance())*slow_duration})
	damageTable.victim = enemy

	if caster:HasShard() and cast_ability == nil then
		enemy:AddNewModifier(caster, caster:BkbAbility(self, caster:HasShard()), "modifier_stunned", {duration = (1 - enemy:GetStatusResistance())*shard_stun})
	end

	if knock == true and not enemy:IsCurrentlyHorizontalMotionControlled() and not enemy:IsCurrentlyVerticalMotionControlled()then 

		local knockback =	
		{
		    should_stun = 0,
		    knockback_duration = knock_duration,
		    duration = knock_duration,
		    knockback_distance = knock_range,
		    knockback_height = 0,
		    center_x = center.x,
		    center_y = center.y,
		    center_z = center.z,
		}

		local mod = enemy:AddNewModifier(caster, caster:BkbAbility(self, caster:HasShard()), "modifier_knockback", knockback)
		if mod then 
			enemy:GenericParticle("particles/skymage/bolt_slow.vpcf", mod)
		end
	end

	self:ApplyBurn(enemy)
	DoDamage(damageTable, cast_ability)
end

end



modifier_skywrath_mage_concussive_shot_custom_slow = class({})

function modifier_skywrath_mage_concussive_shot_custom_slow:IsHidden() return false end
function modifier_skywrath_mage_concussive_shot_custom_slow:IsPurgable() return not self:GetCaster():HasShard() end
function modifier_skywrath_mage_concussive_shot_custom_slow:GetTexture() return "skywrath_mage_concussive_shot" end


function modifier_skywrath_mage_concussive_shot_custom_slow:OnCreated()
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self.caster:FindAbilityByName("skywrath_mage_concussive_shot_custom")
if not self.ability then 
	self:Destroy()
	return
end

self.damage_reduce = self.caster:GetTalentValue("modifier_sky_concussive_2", "damage_reduce")

self.attack_range = self.caster:GetTalentValue("modifier_sky_concussive_6", "attack_range")/100
self.cast_range = self.caster:GetTalentValue("modifier_sky_concussive_6", "cast_range")

self.movement_speed_pct = self.ability:GetSpecialValueFor("movement_speed_pct") + self.caster:GetTalentValue("modifier_sky_concussive_2", "slow")

if not IsServer() then return end

local slow_fx = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot_slow_debuff.vpcf", self)
local particle = ParticleManager:CreateParticle(slow_fx, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
self:AddParticle(particle, false, false, -1, false, false)

if not self.caster:HasTalent("modifier_sky_concussive_6") then return end
self:SetHasCustomTransmitterData(true)
self:OnIntervalThink() 
self:StartIntervalThink(0.2)
end

function modifier_skywrath_mage_concussive_shot_custom_slow:OnIntervalThink()
if not IsServer() then return end 

self.range = 0
self.range = self.parent:Script_GetAttackRange()*self.attack_range
self:SendBuffRefreshToClients()
end

function modifier_skywrath_mage_concussive_shot_custom_slow:AddCustomTransmitterData() 
return 
{
    range = self.range,
} 
end

function modifier_skywrath_mage_concussive_shot_custom_slow:HandleCustomTransmitterData(data)
self.range = data.range
end

function modifier_skywrath_mage_concussive_shot_custom_slow:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
  	MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
  	MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
}    
end    

function modifier_skywrath_mage_concussive_shot_custom_slow:GetModifierAttackRangeBonus()
if not self.caster:HasTalent("modifier_sky_concussive_6") then return end
return self.range
end

function modifier_skywrath_mage_concussive_shot_custom_slow:GetModifierCastRangeBonusStacking()
if not self.caster:HasTalent("modifier_sky_concussive_6") then return end
return self.cast_range
end

function modifier_skywrath_mage_concussive_shot_custom_slow:GetModifierDamageOutgoing_Percentage()
if not self.caster:HasTalent("modifier_sky_concussive_2") then return end
return self.damage_reduce
end

function modifier_skywrath_mage_concussive_shot_custom_slow:GetModifierSpellAmplify_Percentage()
if not self.caster:HasTalent("modifier_sky_concussive_2") then return end
return self.damage_reduce
end

function modifier_skywrath_mage_concussive_shot_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.movement_speed_pct 
end



modifier_skywrath_mage_concussive_shot_custom_tracker = class({})
function modifier_skywrath_mage_concussive_shot_custom_tracker:IsHidden() return true end
function modifier_skywrath_mage_concussive_shot_custom_tracker:IsPurgable() return false end
function modifier_skywrath_mage_concussive_shot_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:AddSpellEvent(self)
self.parent:AddAttackEvent_out(self)
self.parent:AddAttackStartEvent_out(self)

if not IsServer() then return end

self.player = PlayerResource:GetPlayer(self.parent:GetPlayerOwnerID())

self.legendary_count = self.parent:GetTalentValue("modifier_sky_concussive_7", "count", true)
self.legendary_duration = self.parent:GetTalentValue("modifier_sky_concussive_7", "duration", true)
self.legendary_effect_duration = self.parent:GetTalentValue("modifier_sky_concussive_7", "effect_duration", true)
self.legendary_max = self.parent:GetTalentValue("modifier_sky_concussive_7", "max", true)
end

function modifier_skywrath_mage_concussive_shot_custom_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
}
end

function modifier_skywrath_mage_concussive_shot_custom_tracker:GetModifierBonusStats_Intellect()
if not self.parent:HasTalent("modifier_sky_concussive_1") then return end 
return (self.parent:GetStrength() + self.parent:GetAgility())*self.parent:GetTalentValue("modifier_sky_concussive_1", "int")/100
end


function modifier_skywrath_mage_concussive_shot_custom_tracker:AttackStartEvent_out(params)
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_sky_concussive_7") then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

local mod = self.parent:FindModifierByName("modifier_skywrath_mage_concussive_shot_custom_legendary_effect")
if not mod then return end

mod.count = mod.count + 1 
if mod.count >= self.legendary_count then 
	mod.count = 0
	self.ability:LaunchShot(params.target, true)
end

end


function modifier_skywrath_mage_concussive_shot_custom_tracker:AttackEvent_out(params)
if not IsServer() then return end
if not self.parent:HasTalent("modifier_sky_concussive_4") then return end 
if self.parent ~= params.attacker then return end 
if not params.target:IsUnit() then return end 

self.ability:ApplyBurn(params.target)
end


function modifier_skywrath_mage_concussive_shot_custom_tracker:SpellEvent(params)
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_sky_concussive_7") then return end
if self.parent:HasModifier("modifier_skywrath_mage_concussive_shot_custom_legendary_effect") then return end
if self.parent ~= params.unit then return end
if params.ability:IsItem() then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_skywrath_mage_concussive_shot_custom_legendary_stack", {duration = self.legendary_duration})
end


function modifier_skywrath_mage_concussive_shot_custom_tracker:UpdateEffect()
if not IsServer() then return end

local stack = 0
local max = self.legendary_max
local stage = 0
local mod = self.parent:FindModifierByName("modifier_skywrath_mage_concussive_shot_custom_legendary_stack")
local active = self.parent:FindModifierByName("modifier_skywrath_mage_concussive_shot_custom_legendary_effect")

if active or mod then 
	if self.effect then 
		ParticleManager:DestroyParticle(self.effect, true)
		ParticleManager:ReleaseParticleIndex(self.effect)
		self.effect = nil
	end
end

if active then 
	stack = active:GetRemainingTime()
	max = self.legendary_effect_duration
	stage = 1
elseif mod then 
	stack = mod:GetStackCount()
else 
	if not self.effect then 
		self.effect = self.parent:GenericParticle("particles/skywrath/shot_legendary_stack.vpcf", self, true)
		for i = 1,self.legendary_max do 
			ParticleManager:SetParticleControl(self.effect, i, Vector(0, 0, 0))	
		end
	end
end

self.parent:UpdateUIlong({max = max, stack = stack, active = stage, use_zero = stage, style = "SkyShot"})
end


modifier_skywrath_mage_concussive_shot_custom_legendary_stack = class({})
function modifier_skywrath_mage_concussive_shot_custom_legendary_stack:IsHidden() return true end
function modifier_skywrath_mage_concussive_shot_custom_legendary_stack:IsPurgable() return false end
function modifier_skywrath_mage_concussive_shot_custom_legendary_stack:OnCreated()
self.parent = self:GetParent()
self.max = self.parent:GetTalentValue("modifier_sky_concussive_7", "max")

self.count = 0
if not IsServer() then return end
self.effect = self.parent:GenericParticle("particles/skywrath/shot_legendary_stack.vpcf", self, true)
self:SetStackCount(1)
end

function modifier_skywrath_mage_concussive_shot_custom_legendary_stack:OnRefresh(table)
if not IsServer() then return end 
self:IncrementStackCount()

if self:GetStackCount() >= self.max then 

	self.parent:AddNewModifier(self.parent, self.ability, "modifier_skywrath_mage_concussive_shot_custom_legendary_effect",  {duration = self.parent:GetTalentValue("modifier_sky_concussive_7", "effect_duration")})
	self:Destroy()
end

end

function modifier_skywrath_mage_concussive_shot_custom_legendary_stack:OnStackCountChanged(iStackCount)
if not IsServer() then return end
local mod = self.parent:FindModifierByName("modifier_skywrath_mage_concussive_shot_custom_tracker")
if mod then 
	mod:UpdateEffect()
end

if self.effect then 
	for i = 1,self.max do 
		if i <= self:GetStackCount() then 
			ParticleManager:SetParticleControl(self.effect, i, Vector(1, 0, 0))	
		else 
			ParticleManager:SetParticleControl(self.effect, i, Vector(0, 0, 0))	
		end
	end
end

end


function modifier_skywrath_mage_concussive_shot_custom_legendary_stack:OnDestroy()
self:OnStackCountChanged()
end




modifier_skywrath_mage_concussive_shot_custom_legendary_effect = class({})
function modifier_skywrath_mage_concussive_shot_custom_legendary_effect:IsHidden() return true end
function modifier_skywrath_mage_concussive_shot_custom_legendary_effect:IsPurgable() return false end
function modifier_skywrath_mage_concussive_shot_custom_legendary_effect:OnCreated()
self.parent = self:GetParent()
self.speed = self.parent:GetTalentValue("modifier_sky_concussive_7", "speed")
self.range = self.parent:GetTalentValue("modifier_sky_concussive_7", "range")

self.count = 0
if not IsServer() then return end

self.parent:GenericParticle("particles/skymage/bolt_lethalh.vpcf", self, true)

local particle_peffect = ParticleManager:CreateParticle("particles/skywrath/shot_legendary.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(particle_peffect, 0, self.parent:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(particle_peffect)

self.parent:EmitSound("Sky.Shot_legendary")
self:OnIntervalThink()
self:StartIntervalThink(0.01)
end

function modifier_skywrath_mage_concussive_shot_custom_legendary_effect:OnIntervalThink()
if not IsServer() then return end 
self:OnDestroy()
end


function modifier_skywrath_mage_concussive_shot_custom_legendary_effect:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
}
end

function modifier_skywrath_mage_concussive_shot_custom_legendary_effect:GetModifierAttackSpeedBonus_Constant()
return self.speed
end

function modifier_skywrath_mage_concussive_shot_custom_legendary_effect:GetModifierAttackRangeBonus()
return self.range
end

function modifier_skywrath_mage_concussive_shot_custom_legendary_effect:OnDestroy()
if not IsServer() then return end
local mod = self.parent:FindModifierByName("modifier_skywrath_mage_concussive_shot_custom_tracker")
if mod then 
	mod:UpdateEffect()
end
end






modifier_skywrath_mage_concussive_shot_custom_burn = class({})
function modifier_skywrath_mage_concussive_shot_custom_burn:IsHidden() return true end
function modifier_skywrath_mage_concussive_shot_custom_burn:IsPurgable() return false end
function modifier_skywrath_mage_concussive_shot_custom_burn:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_skywrath_mage_concussive_shot_custom_burn:OnCreated()
self.parent = self:GetParent()
end

function modifier_skywrath_mage_concussive_shot_custom_burn:OnDestroy()
if not IsServer() then return end 
local mod = self.parent:FindModifierByName("modifier_skywrath_mage_concussive_shot_custom_burn_tracker")

if mod then 
	mod:DecrementStackCount()
	if mod:GetStackCount() <= 0 then 
		mod:Destroy()
	end
end

end


modifier_skywrath_mage_concussive_shot_custom_burn_tracker = class({})
function modifier_skywrath_mage_concussive_shot_custom_burn_tracker:IsHidden() return false end
function modifier_skywrath_mage_concussive_shot_custom_burn_tracker:IsPurgable() return false end
function modifier_skywrath_mage_concussive_shot_custom_burn_tracker:GetTexture() return "buffs/shot_burn" end
function modifier_skywrath_mage_concussive_shot_custom_burn_tracker:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()
if not IsServer() then return end 

self.interval = self.caster:GetTalentValue("modifier_sky_concussive_4", "interval")
self.duration = self.caster:GetTalentValue("modifier_sky_concussive_4", "duration")
self.damage = (self.caster:GetTalentValue("modifier_sky_concussive_4", "damage")/self.duration)*self.interval
self.mana = (self.caster:GetTalentValue("modifier_sky_concussive_4", "mana")/self.duration)*self.interval

self:SetStackCount(1)
self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}
self:StartIntervalThink(self.interval - FrameTime())
end

function modifier_skywrath_mage_concussive_shot_custom_burn_tracker:OnIntervalThink()
if not IsServer() then return end

self.damageTable.damage = self:GetStackCount()*self.damage*self.caster:GetAverageTrueAttackDamage(nil)/100

DoDamage(self.damageTable, "modifier_sky_concussive_4")
if not self.parent:IsDebuffImmune() then 
    self.parent:Script_ReduceMana(self.mana*self:GetStackCount(), self.ability)
end

end

function modifier_skywrath_mage_concussive_shot_custom_burn_tracker:OnRefresh()
if not IsServer() then return end
self:IncrementStackCount()
end

function modifier_skywrath_mage_concussive_shot_custom_burn_tracker:GetEffectName()
return "particles/skymage/shot_burn.vpcf"
end





modifier_skywrath_mage_concussive_shot_custom_haste = class({})
function modifier_skywrath_mage_concussive_shot_custom_haste:IsHidden() return false end
function modifier_skywrath_mage_concussive_shot_custom_haste:IsPurgable() return false end
function modifier_skywrath_mage_concussive_shot_custom_haste:GetTexture() return "buffs/shot_haste" end
function modifier_skywrath_mage_concussive_shot_custom_haste:OnCreated()
self.caster = self:GetCaster()
self.speed = self.caster:GetTalentValue("modifier_sky_concussive_5", "move")
end

function modifier_skywrath_mage_concussive_shot_custom_haste:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_VISUAL_Z_DELTA
}
end

function modifier_skywrath_mage_concussive_shot_custom_haste:GetModifierMoveSpeedBonus_Percentage()
return self.speed
end

function modifier_skywrath_mage_concussive_shot_custom_haste:GetVisualZDelta()
return 50
end

function modifier_skywrath_mage_concussive_shot_custom_haste:CheckState()
return
{
	[MODIFIER_STATE_UNSLOWABLE] = true,
	[MODIFIER_STATE_FORCED_FLYING_VISION] = true,
	[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true
}
end


function modifier_skywrath_mage_concussive_shot_custom_haste:GetEffectName()
return "particles/skymage/shot_haste.vpcf"
end