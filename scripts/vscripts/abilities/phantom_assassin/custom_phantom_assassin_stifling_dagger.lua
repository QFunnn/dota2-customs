--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_phantom_assassin_stifling_dagger_attack", "abilities/phantom_assassin/custom_phantom_assassin_stifling_dagger", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_phantom_assassin_stifling_dagger_slow", "abilities/phantom_assassin/custom_phantom_assassin_stifling_dagger", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_phantom_assassin_stifling_dagger_tracker", "abilities/phantom_assassin/custom_phantom_assassin_stifling_dagger", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_phantom_assassin_stifling_dagger_poisonstack", "abilities/phantom_assassin/custom_phantom_assassin_stifling_dagger", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_phantom_assassin_stifling_legendary_cast", "abilities/phantom_assassin/custom_phantom_assassin_stifling_dagger", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_phantom_assassin_stifling_double_proc", "abilities/phantom_assassin/custom_phantom_assassin_stifling_dagger", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_phantom_assassin_stifling_vision", "abilities/phantom_assassin/custom_phantom_assassin_stifling_dagger", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_phantom_assassin_stifling_heal", "abilities/phantom_assassin/custom_phantom_assassin_stifling_dagger", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_phantom_assassin_stifling_absorb", "abilities/phantom_assassin/custom_phantom_assassin_stifling_dagger", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_phantom_assassin_stifling_absorb_cd", "abilities/phantom_assassin/custom_phantom_assassin_stifling_dagger", LUA_MODIFIER_MOTION_NONE)


custom_phantom_assassin_stifling_dagger = class({})



custom_phantom_assassin_stifling_dagger.legendary_proj = {}


function custom_phantom_assassin_stifling_dagger:CreateTalent()
local caster = self:GetCaster()
local ability = caster:FindAbilityByName("custom_phantom_assassin_stifling_dagger_legendary")

if ability then 
  ability:SetHidden(false)
end

end



function custom_phantom_assassin_stifling_dagger:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger_debuff.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_phantom_assassin/phantom_assassin_shard_fan_of_knives.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_sleep.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_centaur/centaur_shard_buff_strength_counter_stack.vpcf", context )
PrecacheResource( "particle","particles/items_fx/force_staff.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_forcestaff.vpcf", context )

PrecacheResource( "particle","particles/phantom_assassin/dagger_linear.vpcf", context )
PrecacheResource( "particle","particles/phantom_assassin/dagger_stack.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_venomancer/venomancer_poison_debuff.vpcf", context )
PrecacheResource( "particle","particles/blur_linken.vpcf", context )


dota1x6:PrecacheShopItems("npc_dota_hero_phantom_assassin", context)
end




function custom_phantom_assassin_stifling_dagger:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "phantom_assassin_stifling_dagger", self)
end


function custom_phantom_assassin_stifling_dagger:GetCooldown(iLevel)
local upgrade_cooldown = 0 
if self:GetCaster():HasTalent("modifier_phantom_assassin_dagger_1") then 
  upgrade_cooldown = self:GetCaster():GetTalentValue("modifier_phantom_assassin_dagger_1", "cd")
end
return self.BaseClass.GetCooldown(self, iLevel) + upgrade_cooldown
end

function custom_phantom_assassin_stifling_dagger:GetCastPoint()
local bonus = 0
if self:GetCaster():HasTalent("modifier_phantom_assassin_dagger_1") then 
  bonus = self:GetCaster():GetTalentValue("modifier_phantom_assassin_dagger_1", "cast")
end
return self.BaseClass.GetCastPoint(self) + bonus
end

function custom_phantom_assassin_stifling_dagger:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_custom_phantom_assassin_stifling_dagger_tracker"
end

function custom_phantom_assassin_stifling_dagger:GetAOERadius()
return self:GetSpecialValueFor("additional_targets_radius")
end

function custom_phantom_assassin_stifling_dagger:GetBehavior()
return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end


function custom_phantom_assassin_stifling_dagger:OnSpellStart(new_target)
  
local caster = self:GetCaster() 

local target = self:GetCursorTarget()
if new_target ~= nil then 
  target = new_target
end


if caster:HasTalent("modifier_phantom_assassin_dagger_2") and not new_target then 
  caster:AddNewModifier(caster, self, "modifier_custom_phantom_assassin_stifling_heal", {duration = caster:GetTalentValue("modifier_phantom_assassin_dagger_2", "duration")})
end

local blur = caster:FindModifierByName("modifier_phantom_assassin_phantom_smoke")
if blur and not new_target then 
  blur:SetEnd()
end

local projectile_name = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger.vpcf", self)

local info = 
{
  Target = target,
  Source = caster,
  Ability = self, 
  EffectName = projectile_name,
  iMoveSpeed = self:GetSpecialValueFor("speed"),
  bReplaceExisting = false,                         
  bProvidesVision = true,                           
  iVisionRadius = 450,   
  bDodgeable = not caster:HasTalent("modifier_phantom_assassin_dagger_5"),     
  iVisionTeamNumber = caster:GetTeamNumber() ,
  ExtraData = {}       
}
ProjectileManager:CreateTrackingProjectile(info)

caster:EmitSound("Hero_PhantomAssassin.Dagger.Cast")
end







function custom_phantom_assassin_stifling_dagger:DestroyProj(index)
if not index or not self.legendary_proj[index] then return end 

ProjectileManager:DestroyLinearProjectile(self.legendary_proj[index])
self.legendary_proj[index] = nil
end


function custom_phantom_assassin_stifling_dagger:OnProjectileHit_ExtraData(hTarget, vLocation, table)
if not hTarget then 
  self:DestroyProj(table.legendary_index)
  return 
end

local caster = self:GetCaster()

if not table.legendary_index then 
  if hTarget:TriggerSpellAbsorb( self ) then return end

  local mod = caster:FindModifierByName("modifier_custom_phantom_assassin_stifling_dagger_tracker")
  if mod and hTarget:IsRealHero() then 
    mod:AddStack()
  end
end

local duration = self:GetSpecialValueFor("duration")
local modifier = caster:AddNewModifier(caster,self,"modifier_custom_phantom_assassin_stifling_dagger_attack", {})

hTarget:AddNewModifier(caster, caster:BkbAbility(self, caster:HasTalent("modifier_phantom_assassin_dagger_5")) ,"modifier_custom_phantom_assassin_stifling_dagger_slow", {duration = duration* (1-hTarget:GetStatusResistance())})

if caster:GetQuest() == "Phantom.Quest_5" and (hTarget:GetAbsOrigin() - caster:GetAbsOrigin()):Length2D() >= caster.quest.number and hTarget:IsRealHero() then 
  caster:UpdateQuest(1)
end
caster:PerformAttack(hTarget,true,true,true,caster:HasTalent("modifier_phantom_assassin_dagger_5"),false,false,true)

if modifier then 
  modifier:Destroy()
end


hTarget:EmitSound("Hero_PhantomAssassin.Dagger.Target")

self:DestroyProj(table.legendary_index)
end




modifier_custom_phantom_assassin_stifling_dagger_attack = class({})
function modifier_custom_phantom_assassin_stifling_dagger_attack:IsHidden() return true end
function modifier_custom_phantom_assassin_stifling_dagger_attack:IsPurgable() return false end
function modifier_custom_phantom_assassin_stifling_dagger_attack:OnCreated( kv )
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.base_damage = self.ability:GetSpecialValueFor( "base_damage" )  
self.attack_factor = self.ability:GetSpecialValueFor( "attack_factor" )

end


function modifier_custom_phantom_assassin_stifling_dagger_attack:DeclareFunctions()
return   
{
  MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
  MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
}
end

function modifier_custom_phantom_assassin_stifling_dagger_attack:GetModifierDamageOutgoing_Percentage( params )
if not IsServer() then return end
return self.attack_factor
end

function modifier_custom_phantom_assassin_stifling_dagger_attack:GetModifierPreAttack_BonusDamage( params )
if not IsServer() then return end
return self.base_damage * 100/(100+self.attack_factor)
end




modifier_custom_phantom_assassin_stifling_dagger_slow = class({})
function modifier_custom_phantom_assassin_stifling_dagger_slow:IsHidden() return false end
function modifier_custom_phantom_assassin_stifling_dagger_slow:IsPurgable() return true end 
function modifier_custom_phantom_assassin_stifling_dagger_slow:GetTexture() return "phantom_assassin_stifling_dagger" end
function modifier_custom_phantom_assassin_stifling_dagger_slow:OnCreated( kv )
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self.caster:FindAbilityByName("custom_phantom_assassin_stifling_dagger")
if not self.ability then 
  self:Destroy()
  return
end

self.move_slow = self.ability:GetSpecialValueFor( "move_slow" )

if not IsServer() then return end

local particle_name = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger_debuff.vpcf", self)

self.parent:GenericParticle(particle_name, self)

if self.caster:HasTalent("modifier_phantom_assassin_dagger_5") then 
  self.parent:AddNewModifier(self.caster, self.ability, "modifier_custom_phantom_assassin_stifling_vision", {duration = self.caster:GetTalentValue("modifier_phantom_assassin_dagger_5", "duration")})
else 
  self:StartIntervalThink(FrameTime())
end

end

function modifier_custom_phantom_assassin_stifling_dagger_slow:OnIntervalThink()
if not IsServer() then return end
AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), 10, FrameTime(), false)
end

function modifier_custom_phantom_assassin_stifling_dagger_slow:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_custom_phantom_assassin_stifling_dagger_slow:GetModifierMoveSpeedBonus_Percentage()
return self.move_slow
end







modifier_custom_phantom_assassin_stifling_dagger_poisonstack = class({})
function modifier_custom_phantom_assassin_stifling_dagger_poisonstack:IsPurgable() return true end
function modifier_custom_phantom_assassin_stifling_dagger_poisonstack:IsHidden() return false end
function modifier_custom_phantom_assassin_stifling_dagger_poisonstack:GetTexture() return "buffs/dagger_damage" end

function modifier_custom_phantom_assassin_stifling_dagger_poisonstack:OnCreated(table) 

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.interval = 1
self.duration = self.caster:GetTalentValue("modifier_phantom_assassin_dagger_3", "duration")
self.damage = self.interval*(self.caster:GetTalentValue("modifier_phantom_assassin_dagger_3", "damage")/self.duration)

self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}

if not IsServer() then return end

for i = 1,2 do 
  self.parent:GenericParticle("particles/units/heroes/hero_venomancer/venomancer_poison_debuff.vpcf", self)
end 

self:AddStack()
self:StartIntervalThink(self.interval)
end

function modifier_custom_phantom_assassin_stifling_dagger_poisonstack:OnIntervalThink()
if not IsServer() then return end

local damage = self.damage*self:GetStackCount()
self.damageTable.damage = damage

DoDamage(self.damageTable, "modifier_phantom_assassin_dagger_3")
self.parent:SendNumber(9, damage)
end

function modifier_custom_phantom_assassin_stifling_dagger_poisonstack:OnRefresh(table) 
if not IsServer() then return end
self:AddStack()
end


function modifier_custom_phantom_assassin_stifling_dagger_poisonstack:AddStack()
if not IsServer() then return end 

self:IncrementStackCount()

local duration = self.duration + FrameTime()
Timers:CreateTimer(duration, function()
  if self and not self:IsNull() then 
    self:DecrementStackCount()
    if self:GetStackCount() <= 0 then 
      self:Destroy()
    end
  end
end)

end






modifier_custom_phantom_assassin_stifling_dagger_tracker = class({})
function modifier_custom_phantom_assassin_stifling_dagger_tracker:IsHidden() return not self:GetParent():HasTalent("modifier_phantom_assassin_dagger_7") end
function modifier_custom_phantom_assassin_stifling_dagger_tracker:IsPurgable() return false end
function modifier_custom_phantom_assassin_stifling_dagger_tracker:DestroyOnExpire() return false end
function modifier_custom_phantom_assassin_stifling_dagger_tracker:RemoveOnDeath() return false end

function modifier_custom_phantom_assassin_stifling_dagger_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.double_radius = self.parent:GetTalentValue("modifier_phantom_assassin_dagger_4", "radius", true)
self.auto_delay = self.parent:GetTalentValue("modifier_phantom_assassin_dagger_4", "delay", true)

self.legendary_max = self.parent:GetTalentValue("modifier_phantom_assassin_dagger_7", "stack_max", true)
self.legendary_timer = self.parent:GetTalentValue("modifier_phantom_assassin_dagger_7", "timer", true)
self.active = false

self.poison_duration = self.parent:GetTalentValue("modifier_phantom_assassin_dagger_3", "duration", true) + FrameTime()*2
self.poison_bonus = self.parent:GetTalentValue("modifier_phantom_assassin_dagger_3", "bonus", true)

self.range_bonus = self.parent:GetTalentValue("modifier_phantom_assassin_dagger_5", "range", true)

self.block_cd = self.parent:GetTalentValue("modifier_phantom_assassin_dagger_6", "cd", true)
self.block_duration = self.parent:GetTalentValue("modifier_phantom_assassin_dagger_6", "duration", true)

if not IsServer() then return end 
self.parent:AddSpellEvent(self)
self.parent:AddAttackEvent_out(self)
end


function modifier_custom_phantom_assassin_stifling_dagger_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
  MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
  MODIFIER_PROPERTY_ABSORB_SPELL,
}
end



function modifier_custom_phantom_assassin_stifling_dagger_tracker:GetAbsorbSpell(params) 
if not IsServer() then return end
if self.parent:PassivesDisabled() then return end
if not self.parent:HasTalent("modifier_phantom_assassin_dagger_6") then return end
if self.parent:HasModifier("modifier_custom_phantom_assassin_stifling_absorb_cd") then return end
if params.ability:GetCaster():GetTeamNumber() == self.parent:GetTeamNumber() then return end
if params.ability:GetCaster():IsCreep() then return end

local particle = ParticleManager:CreateParticle("particles/blur_linken.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(particle)

self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_phantom_assassin_stifling_absorb_cd", {duration = self.block_cd})
self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_phantom_assassin_stifling_absorb", {duration = self.block_duration})
self.parent:EmitSound("PA.Blur_absorb")
return 0
end


function modifier_custom_phantom_assassin_stifling_dagger_tracker:GetModifierCastRangeBonusStacking()
if not self.parent:HasTalent("modifier_phantom_assassin_dagger_5") then return end 
return self.range_bonus
end



function modifier_custom_phantom_assassin_stifling_dagger_tracker:GetModifierPercentageCooldown()
if not self.parent:HasTalent("modifier_phantom_assassin_dagger_4") then return end
return self.parent:GetTalentValue("modifier_phantom_assassin_dagger_4", "cdr")
end


function modifier_custom_phantom_assassin_stifling_dagger_tracker:AttackEvent_out(params)
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_phantom_assassin_dagger_3") then return end 
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end 

local stack = 1
if self.parent:HasModifier("modifier_custom_phantom_assassin_stifling_dagger_attack") then 
  params.target:EmitSound("Phantom_Assassin.PoisonImpact")
  stack = self.poison_bonus
end

for i = 1,stack do 
  params.target:AddNewModifier(self.parent, self.ability, "modifier_custom_phantom_assassin_stifling_dagger_poisonstack", {duration = self.poison_duration})
end

end



function modifier_custom_phantom_assassin_stifling_dagger_tracker:SpellEvent(params)
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_phantom_assassin_dagger_4") then return end
if params.unit ~= self.parent then return end

local chance = self.parent:GetTalentValue("modifier_phantom_assassin_dagger_4", "chance")
if not RollPseudoRandomPercentage(chance, 1923, self.parent) then return end

local target = self.parent:RandomTarget(self.double_radius)

if target then
  if params.ability == self.ability then  
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_phantom_assassin_stifling_double_proc", {target = target:entindex(), duration = self.auto_delay})
  else 
    self.ability:OnSpellStart(target)
  end 
end 

end



function modifier_custom_phantom_assassin_stifling_dagger_tracker:OnIntervalThink()
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_phantom_assassin_dagger_7") then return end
if self:GetStackCount() <= 0 then return end 
self.active = false

if self:GetStackCount() > 0 then 
  self:DecrementStackCount()
end

self:StartIntervalThink(0.3)
end


function modifier_custom_phantom_assassin_stifling_dagger_tracker:AddStack()
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_phantom_assassin_dagger_7") then return end

self.active = true
self:StartIntervalThink(self.legendary_timer)
self:SetDuration(self.legendary_timer, true)

if self:GetStackCount() >= self.legendary_max then return end 
self:IncrementStackCount()
end



function modifier_custom_phantom_assassin_stifling_dagger_tracker:OnStackCountChanged()
if not IsServer() then return end 

if self:GetStackCount() == 0 then 
  self:SetDuration(-1, true)
end

if not self.particle then 
  self.particle = self.parent:GenericParticle("particles/phantom_assassin/dagger_stack.vpcf", self, true)
end

for i = 1, self.legendary_max do 
  if i <= self:GetStackCount() then 
    ParticleManager:SetParticleControl(self.particle, i, Vector(1, 0, 0))   
  else 
    ParticleManager:SetParticleControl(self.particle, i, Vector(0, 0, 0))   
  end
end

end







custom_phantom_assassin_stifling_dagger_legendary = class({})

function custom_phantom_assassin_stifling_dagger_legendary:GetCooldown()
return self:GetCaster():GetTalentValue("modifier_phantom_assassin_dagger_7", "cd")
end

function custom_phantom_assassin_stifling_dagger_legendary:GetChannelTime()
return self:GetDuration() + FrameTime()*2
end

function custom_phantom_assassin_stifling_dagger_legendary:GetCastAnimation()
return 0
end

function custom_phantom_assassin_stifling_dagger_legendary:GetDuration()
local caster = self:GetCaster()
local time = caster:GetTalentValue("modifier_phantom_assassin_dagger_7", "cast") 
local cast_inc = caster:GetTalentValue("modifier_phantom_assassin_dagger_7", "cast_inc")

if caster:HasModifier("modifier_custom_phantom_assassin_stifling_dagger_tracker") then 
  time = time + cast_inc*caster:GetUpgradeStack("modifier_custom_phantom_assassin_stifling_dagger_tracker")
end

return time
end


function custom_phantom_assassin_stifling_dagger_legendary:OnSpellStart()
local caster = self:GetCaster()
local duration = self:GetDuration()
local point = self:GetCursorPosition()

if point == caster:GetAbsOrigin() then 
  point = caster:GetAbsOrigin() + caster:GetForwardVector()*10
end

local dir = (point - caster:GetAbsOrigin()):Normalized()
dir.z = 0

caster:SetForwardVector(dir)
caster:FaceTowards(caster:GetAbsOrigin() + dir*10)

caster:AddNewModifier(caster, self, "modifier_custom_phantom_assassin_stifling_legendary_cast", {})
end


function custom_phantom_assassin_stifling_dagger_legendary:OnChannelFinish(bInterrupted)
local caster = self:GetCaster()
local mod = caster:FindModifierByName("modifier_custom_phantom_assassin_stifling_dagger_tracker")
if mod then 
  mod:SetStackCount(0)
end
caster:RemoveModifierByName("modifier_custom_phantom_assassin_stifling_legendary_cast")
end


modifier_custom_phantom_assassin_stifling_legendary_cast = class({})
function modifier_custom_phantom_assassin_stifling_legendary_cast:IsHidden() return true end
function modifier_custom_phantom_assassin_stifling_legendary_cast:IsPurgable() return false end
function modifier_custom_phantom_assassin_stifling_legendary_cast:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.dagger = self.parent:FindAbilityByName("custom_phantom_assassin_stifling_dagger")

if not self.dagger then
  self:Destroy()
  self.parent:Interrupt()
  return
end

if not IsServer() then return end 

self.speed = self.dagger:GetSpecialValueFor("speed")*(1 + self.ability:GetSpecialValueFor("speed")/100)

self.width = self.ability:GetSpecialValueFor("width")
self.random_dist = self.ability:GetSpecialValueFor("random_dist")
self.distance = self.ability:GetSpecialValueFor("AbilityCastRange") + self.parent:GetCastRangeBonus()

self.max = self.parent:GetTalentValue("modifier_phantom_assassin_dagger_7", "max")
self.max_duration = self.ability:GetDuration()

self.interval = self.max_duration/self.max
self.anim_rate = math.min(0.35/self.interval, 1.4)
self.no_anim = false

if self.max_duration <= 1.1 then 
  self.no_anim = true
  self.parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 0.8)
else
  self.parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, self.anim_rate)
end

self:SetStackCount(self.max)
self:StartIntervalThink(self.interval)
end



function modifier_custom_phantom_assassin_stifling_legendary_cast:OnIntervalThink()
if not IsServer() then return end 

if not self.dagger then
  self:Destroy()
  self.parent:Interrupt()
  return
end

if not self.no_anim then 
  self.parent:FadeGesture(ACT_DOTA_CAST_ABILITY_1)
  self.parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, self.anim_rate)
end

local start_abs = self.parent:GetAbsOrigin()
local point = start_abs + self.parent:GetForwardVector() * self.distance
local index = #self.dagger.legendary_proj + 1

local point = point + RandomVector(RandomInt(1, self.random_dist))

local projectile = 
{
  EffectName = "particles/phantom_assassin/dagger_linear.vpcf",
  Ability = self.dagger,
  vSpawnOrigin = start_abs + Vector(0,0,130),
  fStartRadius = self.width,
  fEndRadius = self.width,
  vVelocity = (point - start_abs):Normalized() * self.speed,
  fDistance = self.distance,
  Source = self.parent,
  iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
  iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
  iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
  bProvidesVision = true,
  bDeleteOnHit    = true,
  iVisionTeamNumber = self.parent:GetTeamNumber(),
  iVisionRadius = self.width*2,
  ExtraData = {legendary_index = index}
}

self.parent:EmitSound("Hero_PhantomAssassin.Dagger.Cast")
self.dagger.legendary_proj[index] = ProjectileManager:CreateLinearProjectile(projectile)


self:DecrementStackCount()
if self:GetStackCount() == 0 then 
  self.parent:Interrupt()
  self:Destroy()
end

end



function modifier_custom_phantom_assassin_stifling_legendary_cast:OnDestroy()
if not IsServer() then return end

self.parent:FadeGesture(ACT_DOTA_CAST_ABILITY_1)
end







modifier_custom_phantom_assassin_stifling_double_proc = class({})
function modifier_custom_phantom_assassin_stifling_double_proc:IsHidden() return true end
function modifier_custom_phantom_assassin_stifling_double_proc:IsPurgable() return false end
function modifier_custom_phantom_assassin_stifling_double_proc:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_custom_phantom_assassin_stifling_double_proc:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end 

self.target = EntIndexToHScript(table.target)
end

function modifier_custom_phantom_assassin_stifling_double_proc:OnDestroy()
if not IsServer() then return end 
if not self.target or self.target:IsNull() then return end 

self.ability:OnSpellStart(self.target)
end 



modifier_custom_phantom_assassin_stifling_vision = class({})
function modifier_custom_phantom_assassin_stifling_vision:IsHidden() return false end
function modifier_custom_phantom_assassin_stifling_vision:IsPurgable() return false end
function modifier_custom_phantom_assassin_stifling_vision:GetTexture() return "buffs/odds_mark" end
function modifier_custom_phantom_assassin_stifling_vision:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
if not IsServer() then return end 
self:StartIntervalThink(0.1)
end

function modifier_custom_phantom_assassin_stifling_vision:OnIntervalThink()
if not IsServer() then return end
AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), 50, 0.3, false)
end




modifier_custom_phantom_assassin_stifling_heal = class({})
function modifier_custom_phantom_assassin_stifling_heal:IsHidden() return false end
function modifier_custom_phantom_assassin_stifling_heal:IsPurgable() return false end
function modifier_custom_phantom_assassin_stifling_heal:GetTexture() return "buffs/phantom_slow" end
function modifier_custom_phantom_assassin_stifling_heal:OnCreated()
self.parent = self:GetParent()

self.move = self.parent:GetTalentValue("modifier_phantom_assassin_dagger_2", "move")
self.regen = self.parent:GetTalentValue("modifier_phantom_assassin_dagger_2", "heal")
self.max = self.parent:GetTalentValue("modifier_phantom_assassin_dagger_2", "max")

self:SetStackCount(1)
end

function modifier_custom_phantom_assassin_stifling_heal:OnRefresh()
if not IsServer() then return end 
if self:GetStackCount() >= self.max then return end 

self:IncrementStackCount()

if self:GetStackCount() >= self.max then 
  self.parent:GenericParticle("particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", self )
end

end


function modifier_custom_phantom_assassin_stifling_heal:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_custom_phantom_assassin_stifling_heal:GetModifierConstantHealthRegen()
return self:GetStackCount()*self.regen
end


function modifier_custom_phantom_assassin_stifling_heal:GetModifierMoveSpeedBonus_Percentage()
return self:GetStackCount()*self.move
end









modifier_custom_phantom_assassin_stifling_absorb_cd = class({})

function modifier_custom_phantom_assassin_stifling_absorb_cd:IsPurgable() return false end
function modifier_custom_phantom_assassin_stifling_absorb_cd:IsHidden() return false end
function modifier_custom_phantom_assassin_stifling_absorb_cd:GetTexture() return "buffs/sprout_move" end
function modifier_custom_phantom_assassin_stifling_absorb_cd:IsDebuff() return true end
function modifier_custom_phantom_assassin_stifling_absorb_cd:OnCreated(table)
self.RemoveForDuel = true
end



modifier_custom_phantom_assassin_stifling_absorb = class({})
function modifier_custom_phantom_assassin_stifling_absorb:IsHidden() return true end
function modifier_custom_phantom_assassin_stifling_absorb:IsPurgable() return false end
function modifier_custom_phantom_assassin_stifling_absorb:GetTexture() return "buffs/sprout_move" end
function modifier_custom_phantom_assassin_stifling_absorb:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
  MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
}
end

function modifier_custom_phantom_assassin_stifling_absorb:GetModifierStatusResistanceStacking()
return self.status
end

function modifier_custom_phantom_assassin_stifling_absorb:GetModifierIncomingDamage_Percentage()
return self.damage
end

function modifier_custom_phantom_assassin_stifling_absorb:OnCreated(table)
self.parent = self:GetParent()

self.status = self.parent:GetTalentValue("modifier_phantom_assassin_dagger_6", "status")
self.damage = self.parent:GetTalentValue("modifier_phantom_assassin_dagger_6", "damage_reduce")
if not IsServer() then return end
self.parent:GenericParticle("particles/blur_absorb.vpcf", self)
end

function modifier_custom_phantom_assassin_stifling_absorb:GetStatusEffectName()
return "particles/status_fx/status_effect_muerta_parting_shot.vpcf"
end

function modifier_custom_phantom_assassin_stifling_absorb:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA 
end

