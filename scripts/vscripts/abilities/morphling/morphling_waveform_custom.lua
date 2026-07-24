--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_morphling_waveform_custom", "abilities/morphling/morphling_waveform_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_morphling_waveform_custom_tracker", "abilities/morphling/morphling_waveform_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_morphling_waveform_custom_legendary", "abilities/morphling/morphling_waveform_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_morphling_waveform_custom_legendary_effect", "abilities/morphling/morphling_waveform_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_morphling_waveform_custom_trail_thinker", "abilities/morphling/morphling_waveform_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_morphling_waveform_custom_trail_aura", "abilities/morphling/morphling_waveform_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_morphling_waveform_custom_magic_reduce", "abilities/morphling/morphling_waveform_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_morphling_waveform_custom_bonus", "abilities/morphling/morphling_waveform_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_morphling_waveform_custom_silence_cd", "abilities/morphling/morphling_waveform_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_morphling_waveform_custom_silence", "abilities/morphling/morphling_waveform_custom", LUA_MODIFIER_MOTION_NONE )

morphling_waveform_custom = class({})
morphling_waveform_custom.talents = {}

function morphling_waveform_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_waveform.vpcf", context )
PrecacheResource( "particle", "particles/morphling/wave_legendary_stack.vpcf", context )
PrecacheResource( "particle", "particles/morphling/wave_legendary_attack.vpcf", context )
PrecacheResource( "particle", "particles/morphling/wave_trail.vpcf", context )
PrecacheResource( "particle", "particles/morphling/wave_trail_effect.vpcf", context )
PrecacheResource( "particle", "particles/morphling/wave_health_reduce.vpcf", context )
PrecacheResource( "particle", "particles/econ/items/slardar/slardar_back_ti9/slardar_back_ti9_sprint.vpcf", context )
PrecacheResource( "particle", "particles/morphling/waveform_target.vpcf", context )
PrecacheResource( "particle", "particles/tinker/laser_mark.vpcf", context )
PrecacheResource( "particle", "particles/morphling/wave_health_reducea.vpcf", context )
dota1x6:PrecacheShopItems("npc_dota_hero_morphling", context)
end

function morphling_waveform_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_q1 = 0,
    q1_damage = 0,
    q1_linger = caster:GetTalentValue("modifier_morphling_wave_1", "linger", true),
    q1_radius = caster:GetTalentValue("modifier_morphling_wave_1", "radius", true),
    q1_distance = caster:GetTalentValue("modifier_morphling_wave_1", "distance", true),
    q1_duration = caster:GetTalentValue("modifier_morphling_wave_1", "duration", true),
    q1_damage_type = caster:GetTalentValue("modifier_morphling_wave_1", "damage_type", true),
    q1_interval = caster:GetTalentValue("modifier_morphling_wave_1", "interval", true),
    
    has_q2 = 0,
    q2_move = 0,
    q2_range = 0,
    
    has_q3 = 0,
    q3_spell = 0,
    q3_magic = 0,
    q3_duration = caster:GetTalentValue("modifier_morphling_wave_3", "duration", true),
    q3_max = caster:GetTalentValue("modifier_morphling_wave_3", "max", true),
    
    has_q4 = 0,
    q4_cd = caster:GetTalentValue("modifier_morphling_wave_4", "cd", true),
    q4_duration = caster:GetTalentValue("modifier_morphling_wave_4", "duration", true),
    q4_cd_items = caster:GetTalentValue("modifier_morphling_wave_4", "cd_items", true),
    q4_slow_resist = caster:GetTalentValue("modifier_morphling_wave_4", "slow_resist", true),
    
    has_q7 = 0,
    q7_effect_duration = caster:GetTalentValue("modifier_morphling_wave_7", "effect_duration", true),
    q7_cd_inc = caster:GetTalentValue("modifier_morphling_wave_7", "cd_inc", true)/100,
    q7_health_reduce = caster:GetTalentValue("modifier_morphling_wave_7", "health_reduce", true),
    q7_max = caster:GetTalentValue("modifier_morphling_wave_7", "max", true),
    q7_duration = caster:GetTalentValue("modifier_morphling_wave_7", "duration", true),
    q7_distance = caster:GetTalentValue("modifier_morphling_wave_7", "distance", true),
    
    has_h4 = 0,
    h4_speed = caster:GetTalentValue("modifier_morphling_hero_4", "speed", true)/100,
    h4_silence = caster:GetTalentValue("modifier_morphling_hero_4", "silence", true),
    h4_miss = caster:GetTalentValue("modifier_morphling_hero_4", "miss", true),
    h4_talent_cd = caster:GetTalentValue("modifier_morphling_hero_4", "talent_cd", true),

    has_w1 = 0,
    w1_damage = 0,
  }
end

if caster:HasTalent("modifier_morphling_wave_1") then
  self.talents.has_q1 = 1
  self.talents.q1_damage = caster:GetTalentValue("modifier_morphling_wave_1", "damage")
end

if caster:HasTalent("modifier_morphling_wave_2") then
  self.talents.has_q2 = 1
  self.talents.q2_move = caster:GetTalentValue("modifier_morphling_wave_2", "move")
  self.talents.q2_range = caster:GetTalentValue("modifier_morphling_wave_2", "range")
end

if caster:HasTalent("modifier_morphling_wave_3") then
  self.talents.has_q3 = 1
  self.talents.q3_spell = caster:GetTalentValue("modifier_morphling_wave_3", "spell")
  self.talents.q3_magic = caster:GetTalentValue("modifier_morphling_wave_3", "magic")
end

if caster:HasTalent("modifier_morphling_wave_4") then
  self.talents.has_q4 = 1
  caster:AddSpellEvent(self.tracker, true)
end

if caster:HasTalent("modifier_morphling_wave_7") then
  self.talents.has_q7 = 1
  if IsServer() and self.tracker and not self.q7_init then
    self.q7_init = true
    self.tracker.interval = 0.1
    self.tracker.distance = 0
    self.tracker.pos = caster:GetAbsOrigin()
    self.tracker:StartIntervalThink(self.tracker.interval)
  end
end

if caster:HasTalent("modifier_morphling_hero_4") then
  self.talents.has_h4 = 1
end

if caster:HasTalent("modifier_morphling_adaptive_1") then
  self.talents.has_w1 = 1
  self.talents.w1_damage = caster:GetTalentValue("modifier_morphling_adaptive_1", "damage")/100
end

end

function morphling_waveform_custom:GetAbilityTextureName()
local caster = self:GetCaster()
if caster:HasModifier("modifier_morphling_morph_custom_legendary") then
  return "kunkka_tidal_wave"
end
return wearables_system:GetAbilityIconReplacement(self.caster, "morphling_waveform", self)
end

function morphling_waveform_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_morphling_waveform_custom_tracker"
end

function morphling_waveform_custom:GetCooldown(level)
return self.BaseClass.GetCooldown( self, level ) + (self.talents.has_q4 == 1 and self.talents.q4_cd or 0)
end

function morphling_waveform_custom:GetCastRange(vLocation, hTarget)
return IsClient() and self:GetRange() or 99999
end

function morphling_waveform_custom:GetRange()
return self.AbilityCastRange
end

function morphling_waveform_custom:GetManaCost(level)
return self.BaseClass.GetManaCost(self,level) 
end

function morphling_waveform_custom:GetCastPoint(iLevel)
return self.BaseClass.GetCastPoint(self)
end

function morphling_waveform_custom:GetBehavior()
return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
end

function morphling_waveform_custom:ApplyResist(target)
if not IsServer() then return end
if not self:IsTrained() then return end
if self.talents.has_q3 == 0 then return end

local caster = self:GetCaster()
target:AddNewModifier(caster, self, "modifier_morphling_waveform_custom_magic_reduce", {duration = self.talents.q3_duration})
end

function morphling_waveform_custom:OnSpellStart()
local caster = self:GetCaster()
local point = self:GetCursorPosition()
local origin = caster:GetAbsOrigin()

if caster == point then
  point = origin + caster:GetForwardVector()*10
end

local range = self:GetRange() + caster:GetCastRangeBonus()
local vec = point - origin
local radius = self.width
local speed = self.speed
local min_range = 100

if self.talents.has_h4 == 1 then
  speed = speed*(1 + self.talents.h4_speed)
end

if vec:Length2D() > range then
  point = origin + vec:Normalized()*range
elseif vec:Length2D() <= min_range then
  point = origin + vec:Normalized()*min_range
end 

vec = point - origin

local distance = vec:Length2D()
local direction = vec:Normalized()
direction.z = 0

local info = 
{
  EffectName = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_morphling/morphling_waveform.vpcf", self),
  Ability = self,
  vSpawnOrigin = caster:GetOrigin(), 
  fStartRadius = radius,
  fEndRadius = radius,
  vVelocity = direction * speed,
  fDistance = distance,
  Source = caster,
  bDeleteOnHit = faceless_void_backtrack,
  iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
  iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
  ExtraData = 
  {
    start_x = origin.x,
    start_y = origin.y
  }
}
ProjectileManager:CreateLinearProjectile(info)

caster:EmitSound("Hero_Morphling.Waveform")
ProjectileManager:ProjectileDodge(caster)

caster:AddNewModifier(caster, self, "modifier_morphling_waveform_custom", {duration = 5})
end

function morphling_waveform_custom:OnProjectileThink(location)
if not IsServer() then return end
local caster = self:GetCaster()

if not caster:HasModifier("modifier_morphling_waveform_custom") then return end
caster:SetAbsOrigin(GetGroundPosition(location, nil))
end

function morphling_waveform_custom:OnProjectileHit_ExtraData(target, vLocation, table)
local caster = self:GetCaster()
local mod = caster:FindModifierByName("modifier_morphling_waveform_custom")

if not target then 
  if mod then
    mod:Destroy()
  end
  if self.talents.has_q4 == 1 then
    caster:AddNewModifier(caster, self, "modifier_morphling_waveform_custom_bonus", {duration = self.talents.q4_duration})
  end
  return 
end
if mod then
  mod.hit = true
end
self:DealDamage(target)
end

function morphling_waveform_custom:DealDamage(target)
if not IsServer() then return end
local caster = self:GetCaster()

if target:IsRealHero() and caster:GetQuest() == "Morphling.Quest_5" and not caster:QuestCompleted() then
  caster:UpdateQuest(1)
end

target:EmitSound("Morph.Wave_legendary_attack")
target:EmitSound("Hero_Morphling.attack")

if self.talents.has_q7 == 1 and not target:HasModifier("modifier_morphling_waveform_custom_legendary_effect") then
  target:AddNewModifier(caster, self, "modifier_morphling_waveform_custom_legendary", {duration = self.talents.q7_duration})
end

self:ApplyResist(target)

local pfx_dmg = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_morphling/morphling_waveform_dmg.vpcf", self)
if pfx_dmg == "particles/econ/items/morphling/morphling_crown_of_tears/morphling_crown_waveform_dmg.vpcf" then
    target:GenericParticle("particles/econ/items/morphling/morphling_crown_of_tears/morphling_crown_waveform_dmg.vpcf")
end

if self.talents.has_h4 == 1 and not target:HasModifier("modifier_morphling_waveform_custom_silence_cd") and not target:IsDebuffImmune() then
  target:AddNewModifier(caster, self, "modifier_morphling_waveform_custom_silence_cd", {duration = self.talents.h4_talent_cd})
  target:AddNewModifier(caster, self, "modifier_morphling_waveform_custom_silence", {duration = (1 - target:GetStatusResistance())*self.talents.h4_silence})
  target:EmitSound("Sf.Raze_Silence")
end 

DoDamage({victim = target, attacker = caster, damage = self.damage*(1 + self.talents.w1_damage), ability = self, damage_type = DAMAGE_TYPE_MAGICAL})

if IsValid(caster.adaptive_ability) then
  caster.adaptive_ability:ProcAuto(target, true)
end

end



modifier_morphling_waveform_custom = class(mod_hidden)
function modifier_morphling_waveform_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self.parent:AddNoDraw()
self.parent:NoDraw(self)

if self.ability.talents.has_q1 == 0 then return end

self.pass = 0
self.interval = 0.2
self.pos = self.parent:GetAbsOrigin()

self:OnIntervalThink(true)
self:StartIntervalThink(self.interval)
end

function modifier_morphling_waveform_custom:OnIntervalThink(force)
if not IsServer() then return end
if self.ability.talents.has_q1 == 0 then return end

local pass = (self.parent:GetAbsOrigin() - self.pos):Length2D()
self.pos = self.parent:GetAbsOrigin()

self.pass = self.pass + pass

if self.pass >= self.ability.talents.q1_distance or force then 
  self.pass = 0
  CreateModifierThinker(self.parent, self.ability, "modifier_morphling_waveform_custom_trail_thinker", {duration = self.ability.talents.q1_duration}, self.pos, self.parent:GetTeamNumber(), false)
end 

end

function modifier_morphling_waveform_custom:OnDestroy()
if not IsServer() then return end
self:OnIntervalThink(true)

if self.hit and self.parent.adaptive_ability then
  self.parent.adaptive_ability:AbilityHit()
end

FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), false)
self.parent:StartGesture(ACT_WAVEFORM_END)
self.parent:RemoveNoDraw()
end

function modifier_morphling_waveform_custom:CheckState()
return
{
  [MODIFIER_STATE_ROOTED] = true,
  [MODIFIER_STATE_INVULNERABLE] = true,
  [MODIFIER_STATE_OUT_OF_GAME] = true,
}
end


modifier_morphling_waveform_custom_tracker = class(mod_hidden)
function modifier_morphling_waveform_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self

self.interval = 0.1
self.distance = 0
self.pos = self.parent:GetAbsOrigin()

self.ability:UpdateTalents()

self.parent.wave_ability = self.ability

self.ability.speed = self.ability:GetSpecialValueFor("speed")     
self.ability.damage = self.ability:GetSpecialValueFor("damage")       
self.ability.width = self.ability:GetSpecialValueFor("width")        
self.ability.AbilityCastRange = self.ability:GetSpecialValueFor("AbilityCastRange")
end

function modifier_morphling_waveform_custom_tracker:OnRefresh()
self.ability.damage = self.ability:GetSpecialValueFor("damage")   
self.ability.AbilityCastRange = self.ability:GetSpecialValueFor("AbilityCastRange")
end

function modifier_morphling_waveform_custom_tracker:SpellEvent(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end

if self.ability.talents.has_q4 == 1 and not params.ability:IsItem() then
  self.parent:CdItems(self.ability.talents.q4_cd_items)
end

end

function modifier_morphling_waveform_custom_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
  MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_morphling_waveform_custom_tracker:GetModifierSpellAmplify_Percentage()
return self.ability.talents.q3_spell
end

function modifier_morphling_waveform_custom_tracker:GetModifierMoveSpeedBonus_Constant()
return self.ability.talents.q2_move
end

function modifier_morphling_waveform_custom_tracker:GetModifierCastRangeBonusStacking()
return self.ability.talents.q2_range
end

function modifier_morphling_waveform_custom_tracker:OnIntervalThink()
if not IsServer() then return end
if self.ability.talents.has_q7 == 0 then return end

local pass = (self.parent:GetAbsOrigin() - self.pos):Length2D()
self.pos = self.parent:GetAbsOrigin()

if self.parent:HasModifier("modifier_morphling_waveform_custom") then return end
if self.ability:GetCooldownTimeRemaining() <= 0 then 
  self.distance = 0
  return 
end

local final = self.distance + pass

if final >= self.ability.talents.q7_distance then 
    local cd = self.ability:GetEffectiveCooldown(self.ability:GetLevel())
    local delta = math.floor(final/self.ability.talents.q7_distance)
    for i = 1, delta do 
      self.parent:CdAbility(self.ability, cd*self.ability.talents.q7_cd_inc)
    end 
    self.distance = final - delta*self.ability.talents.q7_distance
else 
    self.distance = final
end 

end



modifier_morphling_waveform_custom_legendary = class(mod_hidden)
function modifier_morphling_waveform_custom_legendary:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max = self.ability.talents.q7_max

self.RemoveForDuel = true
self.effect = self.parent:GenericParticle("particles/morphling/wave_legendary_stack.vpcf", self, true)
self:SetStackCount(1)
end

function modifier_morphling_waveform_custom_legendary:OnRefresh(table)
if not IsServer() then return end
self:IncrementStackCount()

if self:GetStackCount() >= self.max then 
  self.parent:AddNewModifier(self.caster, self.caster:BkbAbility(self.ability, true), "modifier_morphling_waveform_custom_legendary_effect", {duration = self.ability.talents.q7_effect_duration})
  self:Destroy()
end

end

function modifier_morphling_waveform_custom_legendary:OnStackCountChanged(iStackCount)
if not IsServer() then return end
if not self.effect then return end
ParticleManager:SetParticleControl(self.effect, 1, Vector(0, self:GetStackCount(), 0))
end

modifier_morphling_waveform_custom_legendary_effect = class(mod_visible)
function modifier_morphling_waveform_custom_legendary_effect:GetTexture() return "morphling_waveform" end
function modifier_morphling_waveform_custom_legendary_effect:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self.caster.wave_ability

if not self.ability then 
  self:Destroy()
  return
end

self.health_reduce = self.ability.talents.q7_health_reduce*self.parent:GetMaxHealth()/100
if not IsServer() then return end

self.RemoveForDuel = true

self.parent:EmitSound("Morph.Wave_legendary_proc")
self.parent:EmitSound("Morph.Wave_legendary_proc2")
self.parent:GenericParticle("particles/tinker/laser_mark.vpcf", self, true)

self.particle = ParticleManager:CreateParticle("particles/morphling/wave_health_reduce.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt( self.particle, 0, self.parent, PATTACH_OVERHEAD_FOLLOW, "", self.parent:GetOrigin(), true )
ParticleManager:SetParticleControlEnt( self.particle, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, "", self.parent:GetOrigin(), true )
self:AddParticle(self.particle, false, false, -1, false, false)

if not self.parent:IsRealHero() then return end
self.parent:CalculateStatBonus(true)

if IsValid(self.ability.legendary_mod) then return end
self.ability.legendary_mod = self

self.max_time = self:GetRemainingTime()

self:OnIntervalThink(true)
self:StartIntervalThink(0.1)
end

function modifier_morphling_waveform_custom_legendary_effect:OnIntervalThink(first)
if not IsServer() then return end
self.caster:UpdateUIshort({max_time = self.max_time, time = self:GetRemainingTime(), stack = self.ability.talents.q7_health_reduce.."%", style = "MorphWave"})
end

function modifier_morphling_waveform_custom_legendary_effect:OnDestroy()
if not IsServer() then return end

if IsValid(self.ability.legendary_mod) and self.ability.legendary_mod == self then
  self.caster:UpdateUIshort({hide = 1, hide_full = 1, style = "MorphWave"})
  self.ability.legendary_mod = nil
end

end

function modifier_morphling_waveform_custom_legendary_effect:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_HEALTH_BONUS
}
end

function modifier_morphling_waveform_custom_legendary_effect:GetModifierHealthBonus()
return self.health_reduce
end


modifier_morphling_waveform_custom_trail_thinker = class(mod_hidden)
function modifier_morphling_waveform_custom_trail_thinker:IsAura() return true end
function modifier_morphling_waveform_custom_trail_thinker:GetAuraDuration() return self.ability.talents.q1_linger end
function modifier_morphling_waveform_custom_trail_thinker:GetAuraRadius() return self.radius end
function modifier_morphling_waveform_custom_trail_thinker:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_morphling_waveform_custom_trail_thinker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_morphling_waveform_custom_trail_thinker:GetModifierAura() return "modifier_morphling_waveform_custom_trail_aura" end
function modifier_morphling_waveform_custom_trail_thinker:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.radius = self.ability.talents.q1_radius

if not IsServer() then return end
self.puddle_particle = ParticleManager:CreateParticle("particles/morphling/wave_trail.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(self.puddle_particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.puddle_particle, 1, Vector(self.radius, 0, 0))
self:AddParticle(self.puddle_particle, false, false, -1, false, false)
end

modifier_morphling_waveform_custom_trail_aura = class(mod_hidden)
function modifier_morphling_waveform_custom_trail_aura:GetStatusEffectName() return "particles/status_fx/status_effect_naga_riptide.vpcf" end
function modifier_morphling_waveform_custom_trail_aura:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH  end
function modifier_morphling_waveform_custom_trail_aura:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.interval = 0.5
self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = self.ability.talents.q1_damage_type, damage = self.ability.talents.q1_damage*self.interval}

self.parent:GenericParticle("particles/morphling/wave_trail_effect.vpcf", self)
self:StartIntervalThink(self.interval - 0.01)
end

function modifier_morphling_waveform_custom_trail_aura:OnIntervalThink()
if not IsServer() then return end
DoDamage(self.damageTable, "modifier_morphling_wave_1")
end



modifier_morphling_waveform_custom_magic_reduce = class(mod_visible)
function modifier_morphling_waveform_custom_magic_reduce:GetTexture() return "buffs/morphling/wave_3" end
function modifier_morphling_waveform_custom_magic_reduce:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max = self.ability.talents.q3_max
self.magic = self.ability.talents.q3_magic/self.max

if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_morphling_waveform_custom_magic_reduce:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self:GetStackCount() >= self.max and self.ability.talents.has_q7 == 0 then
  self.parent:EmitSound("Morph.Wave_armor")
  self.parent:GenericParticle("particles/morphling/wave_health_reducea.vpcf", self, true)
end

end

function modifier_morphling_waveform_custom_magic_reduce:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_morphling_waveform_custom_magic_reduce:GetModifierMagicalResistanceBonus()
return self:GetStackCount()*self.magic
end


modifier_morphling_waveform_custom_bonus = class(mod_visible)
function modifier_morphling_waveform_custom_bonus:GetEffectName() return "particles/econ/items/slardar/slardar_back_ti9/slardar_back_ti9_sprint.vpcf" end
function modifier_morphling_waveform_custom_bonus:GetTexture() return "buffs/morphling/wave_4" end
function modifier_morphling_waveform_custom_bonus:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
if not IsServer() then return end
end

function modifier_morphling_waveform_custom_bonus:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING
}
end

function modifier_morphling_waveform_custom_bonus:GetModifierSlowResistance_Stacking()
if self.ability.talents.has_q4 == 0 then return end
return self.ability.talents.q4_slow_resist
end




modifier_morphling_waveform_custom_silence_cd = class(mod_hidden)
function modifier_morphling_waveform_custom_silence_cd:OnCreated()
self.RemoveForDuel = true
end



modifier_morphling_waveform_custom_silence = class({})
function modifier_morphling_waveform_custom_silence:IsHidden() return true end
function modifier_morphling_waveform_custom_silence:IsPurgable() return true end
function modifier_morphling_waveform_custom_silence:GetEffectName() return "particles/generic_gameplay/generic_silenced.vpcf" end
function modifier_morphling_waveform_custom_silence:ShouldUseOverheadOffset() return true end
function modifier_morphling_waveform_custom_silence:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end
function modifier_morphling_waveform_custom_silence:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.miss = self.ability.talents.h4_miss
end

function modifier_morphling_waveform_custom_silence:CheckState()
return
{
  [MODIFIER_STATE_SILENCED] = true,
}
end

function modifier_morphling_waveform_custom_silence:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MISS_PERCENTAGE
}
end

function modifier_morphling_waveform_custom_silence:GetModifierMiss_Percentage()
return self.miss
end