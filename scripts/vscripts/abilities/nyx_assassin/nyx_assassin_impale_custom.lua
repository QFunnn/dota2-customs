--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_nyx_assassin_impale_custom_tracker", "abilities/nyx_assassin/nyx_assassin_impale_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nyx_assassin_impale_custom_stun", "abilities/nyx_assassin/nyx_assassin_impale_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nyx_assassin_impale_custom_legendary_thinker", "abilities/nyx_assassin/nyx_assassin_impale_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nyx_assassin_impale_custom_legendary_slow", "abilities/nyx_assassin/nyx_assassin_impale_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nyx_assassin_impale_custom_legendary_stack", "abilities/nyx_assassin/nyx_assassin_impale_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nyx_assassin_impale_custom_legendary_damage", "abilities/nyx_assassin/nyx_assassin_impale_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nyx_assassin_impale_custom_burn", "abilities/nyx_assassin/nyx_assassin_impale_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nyx_assassin_impale_custom_damage_reduce", "abilities/nyx_assassin/nyx_assassin_impale_custom", LUA_MODIFIER_MOTION_NONE )

nyx_assassin_impale_custom = class({})
nyx_assassin_impale_custom.talents = {}
nyx_assassin_impale_custom.active_damage_mod = nil
nyx_assassin_impale_custom.hit_array = {}
nyx_assassin_impale_custom.current_index = 0

function nyx_assassin_impale_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/nyx_assassin/impale_base.vpcf", context )
PrecacheResource( "particle", "particles/nyx_assassin/impale_legendary_spike.vpcf", context )
PrecacheResource( "particle", "particles/nyx_assassin/impale_legendary_aoe.vpcf", context )
PrecacheResource( "particle", "particles/nyx_assassin/impale_legendary_hit.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_debuff.vpcf", context )
PrecacheResource( "particle", "particles/sand_king/stinger_stack.vpcf", context )
PrecacheResource( "particle", "particles/nyx_assassin/impale_delay_aoe.vpcf", context )
PrecacheResource( "particle", "particles/nyx_assassin/impale_base_hit.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_inner_fire_debuff.vpcf", context )
end

function nyx_assassin_impale_custom:GetAbilityTextureName()
local caster = self:GetCaster()
return wearables_system:GetAbilityIconReplacement(self.caster, "nyx_assassin_impale", self)
end

function nyx_assassin_impale_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    damage_inc = 0,

    cd_inc = 0,
    stun_inc = 0,

    has_burn = 0,
    burn_damage = 0,
    burn_spell = 0,
    burn_interval = caster:GetTalentValue("modifier_nyx_impale_3", "interval", true),
    burn_duration = caster:GetTalentValue("modifier_nyx_impale_3", "duration", true),
    burn_damage_type = caster:GetTalentValue("modifier_nyx_impale_3", "damage_type", true),

    has_q4 = 0,
    q4_cast = caster:GetTalentValue("modifier_nyx_impale_4", "cast", true),
    q4_cd_items = caster:GetTalentValue("modifier_nyx_impale_4", "cd_items", true),
    q4_damage_reduce = caster:GetTalentValue("modifier_nyx_impale_4", "damage_reduce", true),
    q4_duration = caster:GetTalentValue("modifier_nyx_impale_4", "duration", true),
  }
end

if caster:HasTalent("modifier_nyx_impale_1") then
  self.talents.damage_inc = caster:GetTalentValue("modifier_nyx_impale_1", "damage")/100
end

if caster:HasTalent("modifier_nyx_impale_2") then
  self.talents.cd_inc = caster:GetTalentValue("modifier_nyx_impale_2", "cd")
  self.talents.stun_inc = caster:GetTalentValue("modifier_nyx_impale_2", "stun")
end

if caster:HasTalent("modifier_nyx_impale_3") then
  self.talents.has_burn = 1
  self.talents.burn_damage = caster:GetTalentValue("modifier_nyx_impale_3", "damage")/100
  self.talents.burn_spell = caster:GetTalentValue("modifier_nyx_impale_3", "spell")
end

if caster:HasTalent("modifier_nyx_impale_4") then
  self.talents.has_q4 = 1
end

end

function nyx_assassin_impale_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_nyx_assassin_impale_custom_tracker"
end

function nyx_assassin_impale_custom:GetCastPoint(iLevel)
return self.BaseClass.GetCastPoint(self) + (self.talents.has_q4 == 1 and self.talents.q4_cast or 0)
end

function nyx_assassin_impale_custom:GetCooldown(level)
return self.BaseClass.GetCooldown( self, level ) + (self.talents.cd_inc and self.talents.cd_inc or 0)
end

function nyx_assassin_impale_custom:GetIndex()
local index = self.current_index
self.current_index = self.current_index + 1
if self.current_index >= 10 then
  self.current_index = 0
end
return index
end

function nyx_assassin_impale_custom:GetEffect()
local caster = self:GetCaster()
local particle = "particles/nyx_assassin/impale_base.vpcf"
local particle_dota = wearables_system:GetParticleReplacementAbility(self:GetCaster(), "particles/units/heroes/hero_nyx_assassin/nyx_assassin_impale.vpcf", self)
if particle_dota ~= "particles/units/heroes/hero_nyx_assassin/nyx_assassin_impale.vpcf" then
    particle = particle_dota
end
return particle
end

function nyx_assassin_impale_custom:OnSpellStart()
local caster = self:GetCaster()
local point = self:GetCursorPosition()
local origin = caster:GetAbsOrigin()

if point == origin then
  point = origin + caster:GetForwardVector()*10
end

local distance = self.length + caster:GetCastRangeBonus()
local vec = (point - origin):Normalized()

local particle = self:GetEffect()

caster:EmitSound("Hero_NyxAssassin.Impale")

local index = self:GetIndex()
self.hit_array[index] = 0

local info = {
  Source = caster,
  Ability = self,
  vSpawnOrigin = caster:GetAbsOrigin(),
  bDeleteOnHit = false,
  iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
  iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
  EffectName = particle,
  fDistance = distance,
  fStartRadius = self.width,
  fEndRadius = self.width,
  vVelocity = vec * self.speed,
  bProvidesVision = true,                           
  iVisionRadius = self.width,        
  iVisionTeamNumber = caster:GetTeamNumber(),  
  ExtraData =
  {
    is_auto = 0,
    index = index,
  }
}

ProjectileManager:CreateLinearProjectile(info)
end

function nyx_assassin_impale_custom:OnProjectileHit_ExtraData(target, location, table)
local caster = self:GetCaster()
local is_auto = table.is_auto
local index = table.index

if not target then
  if index then
    self.hit_array[index] = nil
  end
  return 
end

local damage = self:GetDamage(target)
local stun = self.duration + self.talents.stun_inc
local damage_ability = nil

local damageTable = {victim = target, attacker = caster, ability = self, damage_type = DAMAGE_TYPE_MAGICAL, damage = damage}
DoDamage(damageTable, damage_ability)

self:AbilityHit(target)

local hit_effect = "particles/nyx_assassin/impale_base_hit.vpcf"
local hit_dota = wearables_system:GetParticleReplacementAbility(self:GetCaster(), "particles/units/heroes/hero_nyx_assassin/nyx_assassin_impale_hit.vpcf", self)
if hit_dota ~= "particles/units/heroes/hero_nyx_assassin/nyx_assassin_impale_hit.vpcf" then
  hit_effect = hit_dota
end
target:GenericParticle(hit_effect)
target:AddNewModifier(caster, self, "modifier_nyx_assassin_impale_custom_stun", {is_auto = is_auto, duration = stun*(1 - target:GetStatusResistance())})

if self.talents.has_q4 == 1 then
  target:AddNewModifier(caster, self, "modifier_nyx_assassin_impale_custom_damage_reduce", {duration = self.talents.q4_duration})
end

if target:IsRealHero() then
  if caster:GetQuest() == "Nyx.Quest_5" and not caster:QuestCompleted() then
    caster:UpdateQuest(1)
  end
end

if index and self.hit_array[index] == 0 then
  self.hit_array[index] = 1

  self:ProcCd()

  if IsValid(self.caster.carapace_ability) then
    self.caster.carapace_ability:SpeedStack()
  end
end

end

function nyx_assassin_impale_custom:GetDamage(target)
local bonus = target:IsCreep() and (self.damage_creeps + 1) or 1
return (self.impale_damage + self.talents.damage_inc*self:GetCaster():GetIntellect(false))*bonus
end

function nyx_assassin_impale_custom:ProcCd()
if not IsServer() then return end
if not self:IsTrained() then return end
if self.talents.has_q4 == 0 then return end

self.caster:CdItems(self.talents.q4_cd_items)
end

function nyx_assassin_impale_custom:AbilityHit(target)
if not IsServer() then return end
if not self:IsTrained() or self.talents.has_burn == 0 then return end
local caster = self:GetCaster()

target:AddNewModifier(caster, self, "modifier_nyx_assassin_impale_custom_burn", {})
end


modifier_nyx_assassin_impale_custom_stun = class({})
function modifier_nyx_assassin_impale_custom_stun:IsPurgable() return false end
function modifier_nyx_assassin_impale_custom_stun:IsPurgeException() return true end
function modifier_nyx_assassin_impale_custom_stun:IsStunDebuff() return true end
function modifier_nyx_assassin_impale_custom_stun:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

if not self.parent:IsDebuffImmune() then
  self.parent:InterruptMotionControllers(false)
end

if self.parent:IsCreep() then 
  local damageTable = {victim = self.parent, attacker = self.caster, damage = 1, damage_type = DAMAGE_TYPE_PURE, ability = self.ability , }
  DoDamage(damageTable)
end

local height = 350
local anim_time = 0.5
if table.is_auto == 1 then
  anim_time = 0.3
  height = 200
end

self.mod = self.parent:AddNewModifier( self.caster, self.ability,
"modifier_knockback",
{ 
  center_x = self.parent:GetAbsOrigin().x,
  center_y = self.parent:GetAbsOrigin().y,
  center_z = self.parent:GetAbsOrigin().z,
  knockback_distance = 0,
  knockback_height = height,  
  duration = anim_time,
  knockback_duration = anim_time,
  should_stun = true,
})

self.parent:StartGesture(ACT_DOTA_FLAIL)
self:StartIntervalThink(anim_time)
end

function modifier_nyx_assassin_impale_custom_stun:OnIntervalThink()
if not IsServer() then return end
self.parent:RemoveGesture(ACT_DOTA_FLAIL)
self.parent:StartGesture(ACT_DOTA_DISABLED)
self:StartIntervalThink(-1)
end

function modifier_nyx_assassin_impale_custom_stun:CheckState()
return
{
  [MODIFIER_STATE_STUNNED] = true
}
end

function modifier_nyx_assassin_impale_custom_stun:OnDestroy()
if not IsServer() then return end 

if IsValid(self.mod) then 
  self.mod:Destroy()
end 

self.parent:FadeGesture(ACT_DOTA_DISABLED)
end

function modifier_nyx_assassin_impale_custom_stun:GetEffectName()
return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_nyx_assassin_impale_custom_stun:GetEffectAttachType()
return PATTACH_OVERHEAD_FOLLOW
end



modifier_nyx_assassin_impale_custom_tracker = class(mod_hidden)
function modifier_nyx_assassin_impale_custom_tracker:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.impale_ability = self.ability

self.legendary_ability = self.parent:FindAbilityByName("nyx_assassin_impale_custom_legendary")
if self.legendary_ability then
  self.legendary_ability:UpdateTalents()
end

self.ability.width = self.ability:GetSpecialValueFor("width")   
self.ability.impale_damage = self.ability:GetSpecialValueFor("impale_damage")   
self.ability.duration = self.ability:GetSpecialValueFor("duration")
self.ability.length = self.ability:GetSpecialValueFor("length")
self.ability.speed = self.ability:GetSpecialValueFor("speed")
self.ability.damage_creeps = self.ability:GetSpecialValueFor("damage_creeps")/100
end

function modifier_nyx_assassin_impale_custom_tracker:OnRefresh()
self.ability.width = self.ability:GetSpecialValueFor("width")   
self.ability.impale_damage = self.ability:GetSpecialValueFor("impale_damage")   
end

function modifier_nyx_assassin_impale_custom_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
}
end

function modifier_nyx_assassin_impale_custom_tracker:GetModifierSpellAmplify_Percentage()
return self.ability.talents.burn_spell
end



nyx_assassin_impale_custom_legendary = class({})
function nyx_assassin_impale_custom_legendary:CreateTalent()
self:SetHidden(false)
end

function nyx_assassin_impale_custom_legendary:UpdateTalents()
local caster = self:GetCaster()
if not self.init and caster:HasTalent("modifier_nyx_impale_7") then
  self.init = true
  self.cd = caster:GetTalentValue("modifier_nyx_impale_7", "talent_cd")
  self.radius = caster:GetTalentValue("modifier_nyx_impale_7", "radius")
  self.damage = caster:GetTalentValue("modifier_nyx_impale_7", "damage")/100
  self.delay = caster:GetTalentValue("modifier_nyx_impale_7", "delay")
  self.slow_duration = caster:GetTalentValue("modifier_nyx_impale_7", "slow_duration")
  self.slow = caster:GetTalentValue("modifier_nyx_impale_7", "slow")
  self.max = caster:GetTalentValue("modifier_nyx_impale_7", "max")
  self.stack_duration = caster:GetTalentValue("modifier_nyx_impale_7", "stack_duration")
  self.effect_duration = caster:GetTalentValue("modifier_nyx_impale_7", "effect_duration")
  self.stun = caster:GetTalentValue("modifier_nyx_impale_7", "stun")
  self.stun_full = caster:GetTalentValue("modifier_nyx_impale_7", "stun_full")
  self.damage_inc = caster:GetTalentValue("modifier_nyx_impale_7", "damage_inc")
end

end

function nyx_assassin_impale_custom_legendary:GetAOERadius()
return self.radius and self.radius or 0
end

function nyx_assassin_impale_custom_legendary:GetCooldown(level)
return (self.cd and self.cd or 0)/self.caster:GetCooldownReduction()
end

function nyx_assassin_impale_custom_legendary:OnSpellStart()
local caster = self:GetCaster()
local point = self:GetCursorPosition()

local caster_point = caster:GetAbsOrigin() + caster:GetForwardVector()*80

caster:EmitSound("Nyx.Impale_legendary_cast")
local effect_cast = ParticleManager:CreateParticle( "particles/sand_king/sand_king_wave.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast, 0, caster_point)
ParticleManager:SetParticleControl( effect_cast, 1, Vector(150,1,1))
ParticleManager:ReleaseParticleIndex( effect_cast )

self:EndCd(self.cd)

CreateModifierThinker(caster, self, "modifier_nyx_assassin_impale_custom_legendary_thinker", {duration = self.delay}, point, caster:GetTeamNumber(), false)
end


modifier_nyx_assassin_impale_custom_legendary_thinker = class(mod_hidden)
function modifier_nyx_assassin_impale_custom_legendary_thinker:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.point = self.parent:GetAbsOrigin()

self.radius = self.ability.radius
self.slow_duration = self.ability.slow_duration
self.stack_duration = self.ability.stack_duration
self.delay = self.ability.delay
self.damage = self.ability.damage

self.max = self.ability.max
self.stun = self.ability.stun
self.stun_full = self.ability.stun_full
self.effect_duration = self.ability.effect_duration

if not IsServer() then return end
self.impale = self.caster.impale_ability
AddFOWViewer(self.caster:GetTeamNumber(), self.point, self.radius, self:GetRemainingTime() + 1, false)

local effect_cast = ParticleManager:CreateParticle( "particles/nyx_assassin/impale_legendary_aoe.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast, 0, self.point )
ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 0, 0 ) )
ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_nyx_assassin_impale_custom_legendary_thinker:OnDestroy()
if not IsServer() then return end
if not self.impale or not self.impale:IsTrained() then return end

EmitSoundOnLocationWithCaster(self.point, "Nyx.Impale_legendary_hit", self.caster)
EmitSoundOnLocationWithCaster(self.point, "Nyx.Impale_legendary_hit2", self.caster)

local effect_cast = ParticleManager:CreateParticle( "particles/sand_king/sand_king_wave.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast, 0, self.point)
ParticleManager:SetParticleControl( effect_cast, 1, Vector(self.radius*2,1,1))
ParticleManager:ReleaseParticleIndex( effect_cast )

effect_cast = ParticleManager:CreateParticle( "particles/nyx_assassin/impale_legendary_hit.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl( effect_cast, 1, Vector(self.radius,1,1))
ParticleManager:ReleaseParticleIndex( effect_cast )

local damageTable = {attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}
local targets = self.caster:FindTargets(self.radius, self.point)

for _,target in pairs(targets) do
  local mod
  if not target:HasModifier("modifier_nyx_assassin_impale_custom_legendary_damage") then
    mod = target:AddNewModifier(self.caster, self.ability, "modifier_nyx_assassin_impale_custom_legendary_stack", {duration = self.stack_duration})
  end

  local knock_duration = 0.2
  local height = 100
  local stun = self.stun

  if mod and mod:GetStackCount() >= self.max then
    mod:Destroy()
    knock_duration = 0.4
    height = 220
    stun = (1 - target:GetStatusResistance())*self.stun_full

    target:EmitSound("Nyx.Impale_legendary_stun")
    target:EmitSound("Nyx.Impale_legendary_stun2")
    target:AddNewModifier(self.caster, self.ability, "modifier_nyx_assassin_impale_custom_legendary_damage", {duration = self.effect_duration})
  end

  local knockbackProperties =
  {
    center_x = target:GetOrigin().x,
    center_y = target:GetOrigin().y,
    center_z = target:GetOrigin().z,
    duration = knock_duration,
    knockback_duration = knock_duration,
    knockback_distance = 0,
    knockback_height = height
  }
  target:AddNewModifier(self.caster, self.ability, "modifier_knockback", knockbackProperties )
  target:AddNewModifier(self.caster, self.ability, "modifier_stunned", {duration = stun})

  damageTable.damage = self.impale:GetDamage(target)*self.damage
  damageTable.victim = target
  DoDamage(damageTable)
  target:AddNewModifier(self.caster, self.ability, "modifier_nyx_assassin_impale_custom_legendary_slow", {duration = self.slow_duration})

  if IsValid(self.caster.impale_ability) then
    self.caster.impale_ability:AbilityHit(target)
  end

  local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_sandking/sandking_sandstorm_burrowstrike_field_explosion.vpcf", PATTACH_WORLDORIGIN, nil )
  ParticleManager:SetParticleControl( effect_cast, 0, target:GetAbsOrigin())
  ParticleManager:ReleaseParticleIndex( effect_cast )
end

if #targets > 0 then
  if IsValid(self.caster.impale_ability) then
    self.caster.impale_ability:ProcCd()
  end
  
  if IsValid(self.caster.carapace_ability) then
    self.caster.carapace_ability:SpeedStack()
  end
  EmitSoundOnLocationWithCaster(self.point, "Nyx.Impale_legendary_target", self.caster)
end

end


modifier_nyx_assassin_impale_custom_legendary_slow = class(mod_hidden)
function modifier_nyx_assassin_impale_custom_legendary_slow:IsPurgable() return true end
function modifier_nyx_assassin_impale_custom_legendary_slow:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.slow = self.ability.slow
end

function modifier_nyx_assassin_impale_custom_legendary_slow:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_nyx_assassin_impale_custom_legendary_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_nyx_assassin_impale_custom_legendary_slow:GetEffectName()
return "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_debuff.vpcf"
end

function modifier_nyx_assassin_impale_custom_legendary_slow:GetEffectAttachType()
return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_nyx_assassin_impale_custom_legendary_slow:GetStatusEffectName()
return "particles/status_fx/status_effect_snapfire_slow.vpcf"
end

function modifier_nyx_assassin_impale_custom_legendary_slow:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL
end



modifier_nyx_assassin_impale_custom_legendary_stack = class(mod_visible)
function modifier_nyx_assassin_impale_custom_legendary_stack:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

if not IsServer() then return end
self.particle = self.parent:GenericParticle("particles/sand_king/stinger_stack.vpcf", self, true)
self:SetStackCount(1)
end

function modifier_nyx_assassin_impale_custom_legendary_stack:OnRefresh()
if not IsServer() then return end
self:IncrementStackCount()
end


function modifier_nyx_assassin_impale_custom_legendary_stack:OnStackCountChanged(iStackCount)
if not IsServer() then return end 
if not self.particle then return end 
ParticleManager:SetParticleControl(self.particle, 1, Vector(0, self:GetStackCount(), 0))
end



modifier_nyx_assassin_impale_custom_legendary_damage = class(mod_visible)
function modifier_nyx_assassin_impale_custom_legendary_damage:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.damage = self.ability.damage_inc

if not IsServer() then return end

self.max_time = self:GetRemainingTime()
if self.parent:IsRealHero() and not IsValid(self.ability.active_damage_mod) then
  self.ability.active_damage_mod = self
  self:OnIntervalThink()
  self:StartIntervalThink(0.1)
end

self.parent:GenericParticle("particles/general/generic_armor_reduction.vpcf", self, true)
end

function modifier_nyx_assassin_impale_custom_legendary_damage:OnIntervalThink()
if not IsServer() then return end

self.caster:UpdateUIshort({max_time = self.max_time, time = self:GetRemainingTime(), stack = "+"..self.damage.."%", style = "NyxImpale"})
end

function modifier_nyx_assassin_impale_custom_legendary_damage:OnDestroy()
if not IsServer() then return end

if self == self.ability.active_damage_mod then
  self.ability.active_damage_mod = nil
  self.caster:UpdateUIshort({hide = 1, hide_full = 1, style = "NyxImpale"})
end

end

function modifier_nyx_assassin_impale_custom_legendary_damage:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_nyx_assassin_impale_custom_legendary_damage:GetModifierIncomingDamage_Percentage(params)
if IsServer() and (not params.attacker or params.attacker:FindOwner() ~= self.caster) then return end 

if IsServer() then
  local hit_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
  ParticleManager:SetParticleControlEnt(hit_effect, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), false) 
  ParticleManager:SetParticleControlEnt(hit_effect, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), false) 
  ParticleManager:ReleaseParticleIndex(hit_effect)
  self.parent:EmitSound("Nyx.Impale_legendary_damage")
end

return self.damage
end

function modifier_nyx_assassin_impale_custom_legendary_damage:GetStatusEffectName()
return "particles/status_fx/status_effect_rupture.vpcf"
end

function modifier_nyx_assassin_impale_custom_legendary_damage:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA
end


modifier_nyx_assassin_impale_custom_burn = class(mod_visible)
function modifier_nyx_assassin_impale_custom_burn:GetTexture() return "buffs/nyx_assassin/impale_3" end
function modifier_nyx_assassin_impale_custom_burn:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.duration = self.ability.talents.burn_duration
self.interval = self.ability.talents.burn_interval
self.total_damage = 0
self.ticks = self.duration/self.interval

if not IsServer() then return end
self.parent:GenericParticle("particles/items2_fx/sange_maim.vpcf", self)
self.parent:GenericParticle("particles/status_fx/status_effect_snapfire_slow.vpcf", self)

self.count = self.ticks
self.RemoveForDuel = true
self:AddDamage()

self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = self.ability.talents.burn_damage_type}
self:StartIntervalThink(self.interval)
end

function modifier_nyx_assassin_impale_custom_burn:OnRefresh(table)
if not IsServer() then return end
self:AddDamage()
end

function modifier_nyx_assassin_impale_custom_burn:AddDamage()
if not IsServer() then return end
self.count = self.ticks
self:SetDuration(self.duration + 0.1, true)
self.total_damage = self.total_damage + self.ability:GetDamage(self.parent)*self.ability.talents.burn_damage
self.tick_damage = self.total_damage/self.ticks
end

function modifier_nyx_assassin_impale_custom_burn:OnIntervalThink()
if not IsServer() then return end
self.damageTable.damage = self.tick_damage
self.total_damage = self.total_damage - self.tick_damage

local real_damage = DoDamage(self.damageTable, "modifier_nyx_impale_3")

self.count = self.count - 1
if self.count <= 0 then
  self:Destroy()
  return
end

end

modifier_nyx_assassin_impale_custom_damage_reduce = class(mod_hidden)
function modifier_nyx_assassin_impale_custom_damage_reduce:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.damage_reduce = self.ability.talents.q4_damage_reduce
if not IsServer() then return end
self.parent:GenericParticle("particles/units/heroes/hero_huskar/huskar_inner_fire_debuff.vpcf", self, true)
end

function modifier_nyx_assassin_impale_custom_damage_reduce:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
}
end

function modifier_nyx_assassin_impale_custom_damage_reduce:GetModifierDamageOutgoing_Percentage()
return self.damage_reduce
end

function modifier_nyx_assassin_impale_custom_damage_reduce:GetModifierSpellAmplify_Percentage()
return self.damage_reduce
end