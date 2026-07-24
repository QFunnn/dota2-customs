--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_huskar_inner_fire_silence", "abilities/huskar/custom_huskar_inner_fire", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_huskar_inner_fire_coil", "abilities/huskar/custom_huskar_inner_fire", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_huskar_inner_fire_root", "abilities/huskar/custom_huskar_inner_fire", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_huskar_inner_fire_burn_damage", "abilities/huskar/custom_huskar_inner_fire", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_huskar_inner_fire_burn_legendary", "abilities/huskar/custom_huskar_inner_fire", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_huskar_inner_fire_tracker", "abilities/huskar/custom_huskar_inner_fire", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_huskar_inner_fire_legendary", "abilities/huskar/custom_huskar_inner_fire", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_huskar_inner_fire_legendary_magic", "abilities/huskar/custom_huskar_inner_fire", LUA_MODIFIER_MOTION_NONE)

custom_huskar_inner_fire = class({})
custom_huskar_inner_fire.talents = {}

function custom_huskar_inner_fire:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_inner_fire.vpcf", context )
PrecacheResource( "particle", "particles/huskar_silence.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_inner_fire_debuff.vpcf", context )
PrecacheResource( "particle", "particles/huskar_disarm_coil.vpcf", context )
PrecacheResource( "particle", "particles/huskar_disarm_tether.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf", context )
PrecacheResource( "particle", "particles/ember_spirit/attack_slow.vpcf", context )
PrecacheResource( "particle", "particles/status_fx/status_effect_huskar_lifebreak.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_inner_fire_push.vpcf", context )
PrecacheResource( "particle", "particles/huskar/inner_fire_legendary.vpcf", context )
PrecacheResource( "particle", "particles/huskar/inner_fire_charge.vpcf", context )
PrecacheResource( "particle", "particles/huskar_burn_aura.vpcf", context )
PrecacheResource( "particle", "particles/ember_spirit/guard_resist_max.vpcf", context )
end

function custom_huskar_inner_fire:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_q1 = 0,
    q1_damage = 0,
    q1_spell = 0,
    
    has_q2 = 0,
    q2_cd = 0,
    q2_damage_reduce = 0,
    
    has_q3 = 0,
    q3_damage = 0,
    q3_cdr = 0,
    q3_duration = caster:GetTalentValue("modifier_huskar_disarm_3", "duration", true),
    q3_max = caster:GetTalentValue("modifier_huskar_disarm_3", "max", true),
    q3_interval = caster:GetTalentValue("modifier_huskar_disarm_3", "interval", true),
    q3_damage_type = caster:GetTalentValue("modifier_huskar_disarm_3", "damage_type", true),
    q3_legendary_stack = caster:GetTalentValue("modifier_huskar_disarm_3", "legendary_stack", true),
    
    has_q4 = 0,
    q4_leash = caster:GetTalentValue("modifier_huskar_disarm_4", "leash", true),
    q4_knock_dist = caster:GetTalentValue("modifier_huskar_disarm_4", "knock_dist", true),
    q4_radius = caster:GetTalentValue("modifier_huskar_disarm_4", "radius", true),
    q4_range = caster:GetTalentValue("modifier_huskar_disarm_4", "range", true),
    q4_knock_duration = caster:GetTalentValue("modifier_huskar_disarm_4", "knock_duration", true),
    q4_silence = caster:GetTalentValue("modifier_huskar_disarm_4", "silence", true),
    
    has_q7 = 0,
    q7_knock_distance = caster:GetTalentValue("modifier_huskar_disarm_7", "knock_distance", true),
    q7_damage = caster:GetTalentValue("modifier_huskar_disarm_7", "damage", true)/100,
    q7_magic = caster:GetTalentValue("modifier_huskar_disarm_7", "magic", true),
    q7_knock_duration = caster:GetTalentValue("modifier_huskar_disarm_7", "knock_duration", true),
    q7_interval = caster:GetTalentValue("modifier_huskar_disarm_7", "interval", true),
    q7_max = caster:GetTalentValue("modifier_huskar_disarm_7", "max", true),
    q7_health = caster:GetTalentValue("modifier_huskar_disarm_7", "health", true)/100,
    q7_duration = caster:GetTalentValue("modifier_huskar_disarm_7", "duration", true),
    q7_count = caster:GetTalentValue("modifier_huskar_disarm_7", "count", true),

    has_h4 = 0,
    h4_shield = caster:GetTalentValue("modifier_huskar_hero_4", "shield", true)/100,
    h4_base = caster:GetTalentValue("modifier_huskar_hero_4", "base", true),
    h4_duration = caster:GetTalentValue("modifier_huskar_hero_4", "duration", true),
    h4_cast = caster:GetTalentValue("modifier_huskar_hero_4", "cast", true),
    h4_status = caster:GetTalentValue("modifier_huskar_hero_4", "status", true),
  }
end

if caster:HasTalent("modifier_huskar_disarm_1") then
  self.talents.has_q1 = 1
  self.talents.q1_damage = caster:GetTalentValue("modifier_huskar_disarm_1", "damage")/100
  self.talents.q1_spell = caster:GetTalentValue("modifier_huskar_disarm_1", "spell")
end

if caster:HasTalent("modifier_huskar_disarm_2") then
  self.talents.has_q2 = 1
  self.talents.q2_cd = caster:GetTalentValue("modifier_huskar_disarm_2", "cd")
  self.talents.q2_damage_reduce = caster:GetTalentValue("modifier_huskar_disarm_2", "damage_reduce")
end

if caster:HasTalent("modifier_huskar_disarm_3") then
  self.talents.has_q3 = 1
  self.talents.q3_cdr = caster:GetTalentValue("modifier_huskar_disarm_3", "cdr")
  self.talents.q3_damage = caster:GetTalentValue("modifier_huskar_disarm_3", "damage")/100
end

if caster:HasTalent("modifier_huskar_disarm_4") then
  self.talents.has_q4 = 1
end

if caster:HasTalent("modifier_huskar_disarm_7") then
  self.talents.has_q7 = 1
end

if caster:HasTalent("modifier_huskar_hero_4") then
  self.talents.has_h4 = 1
end

end

function custom_huskar_inner_fire:GetAbilityTextureName()
if self:GetCaster():HasModifier("modifier_custom_huskar_inner_fire_legendary") then 
  return "Inner_Fire_Stop"
end 
return wearables_system:GetAbilityIconReplacement(self.caster, "huskar_inner_fire", self)
end 

function custom_huskar_inner_fire:GetAOERadius()
return (self.radius and self.radius or 0)
end
  
function custom_huskar_inner_fire:GetIntrinsicModifierName() 
if not self:GetCaster():IsRealHero() then return end
return "modifier_custom_huskar_inner_fire_tracker"
end

function custom_huskar_inner_fire:GetManaCost(level)
if self:GetCaster():HasModifier("modifier_custom_huskar_inner_fire_legendary") then 
  return 0
end
return self.BaseClass.GetManaCost(self, level)
end

function custom_huskar_inner_fire:GetCastPoint()
if self.talents.has_h4 == 1 then
  return self.talents.h4_cast
end
return self.BaseClass.GetCastPoint(self)
end

function custom_huskar_inner_fire:CastFilterResultTarget(target)
if self.talents.has_q4 == 0 then return true end
local caster = self:GetCaster()
if target:GetTeamNumber() == caster:GetTeamNumber() and caster ~= target then
  return UF_FAIL_FRIENDLY 
end
return UnitFilter(target, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, 0, caster:GetTeamNumber())
end

function custom_huskar_inner_fire:GetBehavior() 
local caster = self:GetCaster()
if self.talents.has_h4 == 1 and caster:IsStunned() then 
  return  DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE + DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE 
end
if caster:HasModifier("modifier_custom_huskar_inner_fire_legendary") then
  return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end
if self.talents.has_q4 == 1 then 
  return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
end 
return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end 

function custom_huskar_inner_fire:GetCastAnimation()
if self.talents.has_h4 == 1 then 
  return 0
end 
return ACT_DOTA_CAST_ABILITY_1
end

function custom_huskar_inner_fire:GetCastRange(vLocation, hTarget)
if self.talents.has_q4 == 1 then 
  return self.talents.q4_range
end 
return (self.radius and self.radius or 0) - self:GetCaster():GetCastRangeBonus()
end

function custom_huskar_inner_fire:GetCooldown(iLevel)
return self.BaseClass.GetCooldown(self, iLevel) + (self.talents.q2_cd and self.talents.q2_cd or 0)
end

function custom_huskar_inner_fire:GetDamage()
return self.damage + self.talents.q1_damage*self:GetCaster():GetMaxMana()
end

function custom_huskar_inner_fire:ApplyBurn(target, is_legendary)
if not IsServer() then return end
if not self:IsTrained() then return end
if self.talents.has_q3 == 0 then return end

if not is_legendary then
  target:AddNewModifier(self.caster, self, "modifier_custom_huskar_inner_fire_burn_damage", {duration = self.talents.q3_duration})
else
  target:AddNewModifier(self.caster, self, "modifier_custom_huskar_inner_fire_burn_legendary", {duration = 4})
end

end

function custom_huskar_inner_fire:OnSpellStart(new_ability, override_point)
local caster = self:GetCaster()
local target = self:GetCursorTarget()

local mod = caster:FindModifierByName("modifier_custom_huskar_inner_fire_legendary")
if mod and not new_ability then
  mod:Destroy()
  return
end

local point = caster:GetAbsOrigin() 
local new_point = false
if self.talents.has_q4 == 1 and not new_ability and (not target or target ~= caster) and not caster:IsStunned() then
  point = self:GetCursorPosition()
  new_point = point
end

if self.talents.has_h4 == 1 and not new_ability then
  if caster:IsStunned() then
    point = caster:GetAbsOrigin()
  else 
    caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1.4)
  end
end 

if override_point then
  point = override_point
end

local damage = self:GetDamage()
local radius = self.radius
local silence_duration = self.silence_duration + (self.talents.has_q4 == 1 and self.talents.q4_silence or 0)

local knockback_duration = self.knockback_duration
local max_distance = self.knockback_distance
local min_distance = 50

local damage_ability = nil
local sound = "Hero_Huskar.Inner_Fire.Cast"
local part = "particles/units/heroes/hero_huskar/huskar_inner_fire.vpcf"

if new_ability == "modifier_huskar_disarm_7" then
  damage_ability = new_ability
  part = "particles/huskar/inner_fire_legendary.vpcf"
  sound = "Huskar.Inner_legendary"

  local health = caster:GetMaxHealth()*self.talents.q7_health
  caster:SetHealth(math.max(1, caster:GetHealth() - health))
  
  knockback_duration = self.talents.q7_knock_duration
  damage = damage*self.talents.q7_damage
end

EmitSoundOnLocationWithCaster(point, sound, caster)

local particle = ParticleManager:CreateParticle(part, PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(particle, 0, point)
ParticleManager:SetParticleControl(particle, 1, Vector(radius, 0, 0))
ParticleManager:SetParticleControl(particle, 3, point)
ParticleManager:ReleaseParticleIndex(particle)

local damageTable = {damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, attacker = caster, ability = self}

for _,enemy in pairs(caster:FindTargets(radius, point)) do
  local status = (1 - enemy:GetStatusResistance())

  damageTable.victim = enemy
  DoDamage(damageTable, damage_ability)  

  self:ApplyBurn(enemy, new_ability == "modifier_huskar_disarm_7")

  local vec = enemy:GetAbsOrigin() - point
  local distance = min_distance

  if new_ability == "modifier_huskar_disarm_7" then
    if vec:Length2D() <= max_distance then
      distance = self.talents.q7_knock_distance
    end
  else
    local target_point = point + vec:Normalized()*max_distance
    if vec:Length2D() <= max_distance then
      distance = (target_point - enemy:GetAbsOrigin()):Length2D()
    end
    knockback_duration = self.knockback_min + (self.knockback_duration - self.knockback_min)*(distance/self.knockback_distance)
  end

  local mod = enemy:AddNewModifier( caster, self, "modifier_generic_knockback",
  { 
    direction_x = vec.x,
    direction_y = vec.y,
    distance = distance*status,
    height = 0, 
    duration = knockback_duration*status,
    IsStun = false,
    IsFlail = true,
    Purgable = 1,
  })

  if mod then
    enemy:GenericParticle("particles/units/heroes/hero_huskar/huskar_inner_fire_push.vpcf", mod)
  end

  if self.talents.has_q4 == 1 and not new_ability and enemy:IsHero() then  
    enemy:AddNewModifier(caster, self, "modifier_custom_huskar_inner_fire_root", {duration = self.talents.q4_leash, x = point.x, y = point.y})
  end 
  if not new_ability then
    enemy:AddNewModifier(caster, self, "modifier_custom_huskar_inner_fire_silence", {duration = silence_duration * status})
  end
  if self.talents.has_q7 == 1 then
    enemy:AddNewModifier(caster, self, "modifier_custom_huskar_inner_fire_legendary_magic", {duration = self.talents.q7_duration})
  end
end

if new_ability then return end

if self.talents.has_q7 == 1 then
  local new_x = new_point and new_point.x or nil
  local new_y = new_point and new_point.y or nil
  caster:AddNewModifier(caster, self, "modifier_custom_huskar_inner_fire_legendary", {new_x = new_x, new_y = new_y})
end

if self.talents.has_h4 == 1 then
  if IsValid(self.active_shield) then
    self.active_shield:Destroy()
  end
  self.active_shield = caster:AddNewModifier(caster, self, "modifier_generic_shield",
  {
    duration = self.talents.h4_duration,
    max_shield = self.talents.h4_base + (caster:GetMaxHealth() - caster:GetHealth())*self.talents.h4_shield,
    start_full = 1,
    shield_talent = "modifier_huskar_hero_4"
  })

  if self.active_shield then 
    self.active_shield:SetFilterFunction(function(params)
      if IsValid(caster) and params.attacker and params.attacker:GetTeamNumber() == caster:GetTeamNumber() then
        return false
      end
      return true
    end)

    self.particle = ParticleManager:CreateParticle("particles/huskar/shard_shield.vpcf" , PATTACH_CUSTOMORIGIN, caster)
    ParticleManager:SetParticleControlEnt( self.particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetOrigin(), true )
    self.active_shield:AddParticle(self.particle, false, false, -1, false, false)
  end
end

if self.talents.has_q4 == 1 then  
  CreateModifierThinker(caser, self, "modifier_custom_huskar_inner_fire_coil",{ duration = self.talents.q4_leash}, point, caster:GetTeamNumber(),false) 
end 
  
end



modifier_custom_huskar_inner_fire_root = class(mod_hidden)
function modifier_custom_huskar_inner_fire_root:OnCreated(params)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

if not IsServer() then return end

self.center = GetGroundPosition(Vector(params.x, params.y, 0), nil)

self.radius = self.ability.talents.q4_radius
self.knock_dist = self.ability.talents.q4_knock_dist
self.knockback_duration = self.ability.talents.q4_knock_duration

local effect_cast = ParticleManager:CreateParticle( "particles/huskar_disarm_tether.vpcf", PATTACH_ABSORIGIN, self.parent )
ParticleManager:SetParticleControl( effect_cast, 0, self.center )
ParticleManager:SetParticleControlEnt(effect_cast, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true)
self:AddParticle(effect_cast,false,false,-1,false,false)

self.interval = 0.1
self:StartIntervalThink(0.1)
end

function modifier_custom_huskar_inner_fire_root:OnIntervalThink()
if not IsServer() then return end
if self.parent:IsCurrentlyHorizontalMotionControlled() or self.parent:IsCurrentlyVerticalMotionControlled() then return end
if self.parent:IsInvulnerable() or self.parent:IsOutOfGame() then return end
if self.parent:IsDebuffImmune() then return end
if (self.parent:GetAbsOrigin() - self.center):Length2D() <= self.radius then return end
  
self.parent:EmitSound("Huskar.Disarm_Legendary") 

local vec = self.center - self.parent:GetAbsOrigin()
local target_point = self.center - vec:Normalized()*self.knock_dist

local mod = self.parent:AddNewModifier( self.caster, self.ability, "modifier_generic_knockback",
{ 
  direction_x = vec.x,
  direction_y = vec.y,
  distance = (target_point - self.parent:GetAbsOrigin()):Length2D(),
  height = 0, 
  duration = self.knockback_duration,
  IsStun = false,
  IsFlail = true,
  Purgable = 1,
})
end

function modifier_custom_huskar_inner_fire_root:CheckState()
return
{
  [MODIFIER_STATE_TETHERED] = true
}
end


modifier_custom_huskar_inner_fire_coil = class(mod_hidden)
function modifier_custom_huskar_inner_fire_coil:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.effect_cast = ParticleManager:CreateParticle( "particles/huskar_disarm_coil.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetOrigin() )
self:AddParticle(self.effect_cast, false, false,-1, false, false)
end






modifier_custom_huskar_inner_fire_tracker  = class(mod_hidden)
function modifier_custom_huskar_inner_fire_tracker:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
  MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
}
end

function modifier_custom_huskar_inner_fire_tracker:GetModifierStatusResistanceStacking()
if self.ability.talents.has_h4 == 0 then return end
return self.ability.talents.h4_status
end

function modifier_custom_huskar_inner_fire_tracker:GetModifierSpellAmplify_Percentage()
return self.ability.talents.q1_spell
end

function modifier_custom_huskar_inner_fire_tracker:GetModifierPercentageCooldown()
return self.ability.talents.q3_cdr
end

function modifier_custom_huskar_inner_fire_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.inner_ability = self.ability

self.ability.damage = self.ability:GetSpecialValueFor("damage")     
self.ability.silence_duration = self.ability:GetSpecialValueFor("silence_duration")   
self.ability.radius = self.ability:GetSpecialValueFor("radius")      
self.ability.knockback_distance = self.ability:GetSpecialValueFor("knockback_distance")
self.ability.knockback_duration = self.ability:GetSpecialValueFor("knockback_duration")
self.ability.knockback_min = self.ability:GetSpecialValueFor("knockback_min")
end

function modifier_custom_huskar_inner_fire_tracker:OnRefresh()
self.ability.damage = self.ability:GetSpecialValueFor("damage")     
self.ability.silence_duration = self.ability:GetSpecialValueFor("silence_duration")   
end


modifier_custom_huskar_inner_fire_burn_damage = class(mod_visible)
function modifier_custom_huskar_inner_fire_burn_damage:GetTexture() return "buffs/huskar/inner_fire_3" end
function modifier_custom_huskar_inner_fire_burn_damage:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.interval = self.ability.talents.q3_interval
self.duration = self.ability.talents.q3_duration
self.max = self.ability.talents.q3_max
self.count = 0
self.damage = self.ability.talents.q3_damage*self.interval

if not IsServer() then return end
self:OnRefresh()

self.parent:GenericParticle("particles/huskar_burn_aura.vpcf", self)
self.damageTable = {victim = self.parent, ability = self.ability, damage_type = self.ability.talents.q3_damage_type, attacker = self.caster}
self:StartIntervalThink(self.interval)
end

function modifier_custom_huskar_inner_fire_burn_damage:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self:GetStackCount() >= self.max then
  self.parent:EmitSound("Huskar.Fire_max")
  self.parent:GenericParticle("particles/ember_spirit/guard_resist_max.vpcf", self)
end

end

function modifier_custom_huskar_inner_fire_burn_damage:OnIntervalThink()
if not IsServer() then return end
self.damageTable.damage = self.ability:GetDamage()*self.damage*self:GetStackCount()
DoDamage(self.damageTable, "modifier_huskar_disarm_3")
end





modifier_custom_huskar_inner_fire_silence  = class({})
function modifier_custom_huskar_inner_fire_silence:IsHidden() return true end
function modifier_custom_huskar_inner_fire_silence:IsPurgable() return true end
function modifier_custom_huskar_inner_fire_silence:CheckState()
return 
{
  [MODIFIER_STATE_SILENCED] = true
}
end

function modifier_custom_huskar_inner_fire_silence:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()
if not self.parent:IsRealHero() then return end

if self.ability.talents.has_q7 == 0 then
  self.parent:GenericParticle("particles/generic_gameplay/generic_silenced.vpcf", self, true)
end

if self.caster:GetQuest() == "Huskar.Quest_5" then 
  self:StartIntervalThink(0.1)
end

end

function modifier_custom_huskar_inner_fire_silence:OnIntervalThink()
if not IsServer() then return end
if self.caster:QuestCompleted() then return end
self.caster:UpdateQuest(0.1)
end

function modifier_custom_huskar_inner_fire_silence:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
}
end

function modifier_custom_huskar_inner_fire_silence:GetModifierDamageOutgoing_Percentage()
return self.ability.talents.q2_damage_reduce
end

function modifier_custom_huskar_inner_fire_silence:GetModifierSpellAmplify_Percentage()
return self.ability.talents.q2_damage_reduce
end


modifier_custom_huskar_inner_fire_legendary = class(mod_hidden)
function modifier_custom_huskar_inner_fire_legendary:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.interval = self.ability.talents.q7_interval
self.max = self.ability.talents.q7_count
self.count = self.max

if not IsServer() then return end
self.new_point = nil
if table.new_x and table.new_y then
  self.new_point = GetGroundPosition(Vector(table.new_x, table.new_y, 0), nil)
end

self:UpdateEffect()

self.ability:EndCd(0.5)
self:StartIntervalThink(self.interval)
end

function modifier_custom_huskar_inner_fire_legendary:OnIntervalThink()
if not IsServer() then return end

self.count = self.count - 1
self:UpdateEffect()

self.ability:OnSpellStart("modifier_huskar_disarm_7", self.new_point)

if self.count <= 0 then
  self:Destroy()
end

end

function modifier_custom_huskar_inner_fire_legendary:UpdateEffect()
if not IsServer() then return end

if not self.particle then
  self.particle = self.parent:GenericParticle("particles/huskar/inner_fire_charge.vpcf", self, true)
end

for i = 1,self.max do 
  if i <= self.count then 
    ParticleManager:SetParticleControl(self.particle, i, Vector(1, 0, 0)) 
  else 
    ParticleManager:SetParticleControl(self.particle, i, Vector(0, 0, 0)) 
  end
end

self.parent:UpdateUIshort({max_time = self.max, time = self.count, stack = self.count, active = 1, priority = 1, style = "HuskarInner"})
end

function modifier_custom_huskar_inner_fire_legendary:OnDestroy()
if not IsServer() then return end
self.ability:StartCd()
self.parent:UpdateUIshort({hide = 1, hide_full = 1, priority = 1, style = "HuskarInner"})
end

modifier_custom_huskar_inner_fire_legendary_magic = class(mod_visible)
function modifier_custom_huskar_inner_fire_legendary_magic:GetTexture() return "huskar_inner_fire" end
function modifier_custom_huskar_inner_fire_legendary_magic:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max = self.ability.talents.q7_max
self.magic = self.ability.talents.q7_magic

if not IsServer() then return end
self.effect_cast = self.parent:GenericParticle("particles/huskar_earth_stack.vpcf", self, true)
self.RemoveForDuel = true
self:SetStackCount(1)
end

function modifier_custom_huskar_inner_fire_legendary_magic:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_custom_huskar_inner_fire_legendary_magic:OnStackCountChanged(iStackCount)
if not IsServer() then return end
if not self.effect_cast then return end
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )
end

function modifier_custom_huskar_inner_fire_legendary_magic:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_custom_huskar_inner_fire_legendary_magic:GetModifierMagicalResistanceBonus()
return self.magic*self:GetStackCount()
end


modifier_custom_huskar_inner_fire_burn_legendary = class(mod_hidden)
function modifier_custom_huskar_inner_fire_burn_legendary:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability.talents.q3_legendary_stack
self:OnRefresh()
end

function modifier_custom_huskar_inner_fire_burn_legendary:OnRefresh()
if not IsServer() then return end
self:IncrementStackCount()

if self:GetStackCount() >= self.max then
  self.ability:ApplyBurn(self.parent)
  self:Destroy()
end

end