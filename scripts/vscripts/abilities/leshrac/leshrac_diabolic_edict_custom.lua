--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_leshrac_diabolic_edict_custom", "abilities/leshrac/leshrac_diabolic_edict_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_leshrac_diabolic_edict_custom_speed", "abilities/leshrac/leshrac_diabolic_edict_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_leshrac_diabolic_edict_custom_legendary", "abilities/leshrac/leshrac_diabolic_edict_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_leshrac_diabolic_edict_custom_legendary_damage", "abilities/leshrac/leshrac_diabolic_edict_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_leshrac_diabolic_edict_custom_proc", "abilities/leshrac/leshrac_diabolic_edict_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_leshrac_diabolic_edict_custom_tracker", "abilities/leshrac/leshrac_diabolic_edict_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_leshrac_diabolic_edict_custom_slow", "abilities/leshrac/leshrac_diabolic_edict_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_leshrac_diabolic_edict_custom_damage_stack", "abilities/leshrac/leshrac_diabolic_edict_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_leshrac_diabolic_edict_custom_root_cd", "abilities/leshrac/leshrac_diabolic_edict_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_leshrac_diabolic_edict_custom_root", "abilities/leshrac/leshrac_diabolic_edict_custom", LUA_MODIFIER_MOTION_NONE )


leshrac_diabolic_edict_custom = class({})
leshrac_diabolic_edict_custom.talents = {}
leshrac_diabolic_edict_custom.active_mods = {}
leshrac_diabolic_edict_custom.count = 0

function leshrac_diabolic_edict_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/units/heroes/hero_leshrac/leshrac_diabolic_edict.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_leshrac/leshrac_diabolic_edict.vpcf", context )
PrecacheResource( "particle", "particles/leshrac_diabolic_legendary_damage.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", context )
PrecacheResource( "particle", "particles/leshrac/edict_proc.vpcf", context )
PrecacheResource( "particle", "particles/items3_fx/star_emblem_friend.vpcf", context )
PrecacheResource( "particle", "particles/leshrac/edict_speed.vpcf", context )
PrecacheResource( "particle", "particles/leshrac_edict_legendary.vpcf", context )
PrecacheResource( "particle", "particles/lesh_edict_stun.vpcf", context )
PrecacheResource( "particle", "particles/leshrac_edict_mark.vpcf", context )
PrecacheResource( "particle", "particles/cleance_blade.vpcf", context )
PrecacheResource( "particle", "particles/leshrac/edict_shield.vpcf", context )
PrecacheResource( "particle", "particles/juggernaut/omni_root.vpcf", context )
end

function leshrac_diabolic_edict_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_w1 = 0,
    w1_slow = 0,
    w1_damage = 0,
    w1_max = caster:GetTalentValue("modifier_leshrac_edict_1", "max", true),
    w1_duration = caster:GetTalentValue("modifier_leshrac_edict_1", "duration", true),
    
    has_w2 = 0,
    w2_duration = 0,
    w2_cd = 0,
    
    has_w3 = 0,
    w3_damage = 0,
    w3_count = 0,
    w3_talent_cd = caster:GetTalentValue("modifier_leshrac_edict_3", "talent_cd", true),
    w3_max = caster:GetTalentValue("modifier_leshrac_edict_3", "max", true),
    
    has_w4 = 0,
    w4_root = caster:GetTalentValue("modifier_leshrac_edict_4", "root", true),
    w4_talent_cd = caster:GetTalentValue("modifier_leshrac_edict_4", "talent_cd", true),
    w4_cd_items = caster:GetTalentValue("modifier_leshrac_edict_4", "cd_items", true),
    w4_count = caster:GetTalentValue("modifier_leshrac_edict_4", "count", true),
    
    has_w7 = 0,
    w7_effect_duration = caster:GetTalentValue("modifier_leshrac_edict_7", "effect_duration", true),
    w7_duration = caster:GetTalentValue("modifier_leshrac_edict_7", "duration", true),
    w7_stun = caster:GetTalentValue("modifier_leshrac_edict_7", "stun", true),
    w7_magic = caster:GetTalentValue("modifier_leshrac_edict_7", "magic", true),
    
    has_h5 = 0,
    h5_speed = caster:GetTalentValue("modifier_leshrac_hero_5", "speed", true),
    h5_duration = caster:GetTalentValue("modifier_leshrac_hero_5", "duration", true),
    h5_cdr = caster:GetTalentValue("modifier_leshrac_hero_5", "cdr", true),
    h5_cd = caster:GetTalentValue("modifier_leshrac_hero_5", "cd", true), 

    has_r4 = 0,
    r4_shield = caster:GetTalentValue("modifier_leshrac_nova_4", "shield", true)/100,

    has_q7 = 0,
  }
end

if caster:HasTalent("modifier_leshrac_edict_1") then
  self.talents.has_w1 = 1
  self.talents.w1_slow = caster:GetTalentValue("modifier_leshrac_edict_1", "slow")
  self.talents.w1_damage = caster:GetTalentValue("modifier_leshrac_edict_1", "damage")
end

if caster:HasTalent("modifier_leshrac_edict_2") then
  self.talents.has_w2 = 1
  self.talents.w2_duration = caster:GetTalentValue("modifier_leshrac_edict_2", "duration")/100
  self.talents.w2_cd = caster:GetTalentValue("modifier_leshrac_edict_2", "cd")
end

if caster:HasTalent("modifier_leshrac_edict_3") then
  self.talents.has_w3 = 1
  self.talents.w3_damage = caster:GetTalentValue("modifier_leshrac_edict_3", "damage")
  self.talents.w3_count = caster:GetTalentValue("modifier_leshrac_edict_3", "count")
  caster:AddSpellEvent(self.tracker, true)
end

if caster:HasTalent("modifier_leshrac_edict_4") then
  self.talents.has_w4 = 1
  caster:AddSpellEvent(self.tracker, true)
end

if caster:HasTalent("modifier_leshrac_edict_7") then
  self.talents.has_w7 = 1
end

if caster:HasTalent("modifier_leshrac_hero_5") then
  self.talents.has_h5 = 1
end

if caster:HasTalent("modifier_leshrac_nova_4") then
  self.talents.has_r4 = 1
end

if caster:HasTalent("modifier_leshrac_earth_7") then
  self.talents.has_q7 = 1
end

end

function leshrac_diabolic_edict_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_leshrac_diabolic_edict_custom_tracker"
end

function leshrac_diabolic_edict_custom:GetAbilityTextureName()
if self.parent:HasModifier("modifier_leshrac_diabolic_edict_custom") and self.ability.talents.has_w7 == 1 then
  return "stop_icons/leshrac_diabolic_edict"
end
return wearables_system:GetAbilityIconReplacement(self.caster, "leshrac_diabolic_edict", self)
end

function leshrac_diabolic_edict_custom:GetRadius()
return (self.radius and self.radius or 0) + (self.caster.leshrac_innate and self.caster.leshrac_innate:GetRange() or 0)
end

function leshrac_diabolic_edict_custom:GetCastRange(vLocation, hTarget)
return self:GetRadius() - self.caster:GetCastRangeBonus()
end

function leshrac_diabolic_edict_custom:GetCooldown(iLevel)
return self.BaseClass.GetCooldown(self, iLevel) + (self.talents.w2_cd and self.talents.w2_cd or 0)
end

function leshrac_diabolic_edict_custom:GetBehavior()
if self.ability.talents.has_h5 == 1 or (self.parent:HasModifier("modifier_leshrac_diabolic_edict_custom") and self.ability.talents.has_w7 == 1) then 
  return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end
return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function leshrac_diabolic_edict_custom:GetManaCost(iLevel)
if self.parent:HasModifier("modifier_leshrac_diabolic_edict_custom") and self.ability.talents.has_w7 == 1 then
  return 0
end
return self.BaseClass.GetManaCost(self, iLevel)
end

function leshrac_diabolic_edict_custom:OnSpellStart()

local mod = self.caster:FindModifierByName("modifier_leshrac_diabolic_edict_custom")
if mod and self.ability.talents.has_w7 == 1 then
  mod:Destroy()
  return
end

if self.ability.talents.has_h5 == 1 then 
  self.caster:StartGesture(ACT_DOTA_CAST_ABILITY_4)
end

for mod,_ in pairs(self.active_mods) do
  if IsValid(mod) then
    mod:Destroy()
  end
end

if self.ability.talents.has_w7 == 1 then
  local enemies = self.caster:FindTargets(self:GetRadius())
  for _,enemy in pairs(enemies) do 
    enemy:AddNewModifier(self.caster, self.caster:BkbAbility(self, true), "modifier_leshrac_diabolic_edict_custom_legendary", {duration = self.talents.w7_duration})
  end
  if #enemies > 0 then 
    self.caster:EmitSound("Leshrac.Edict_legendary_link")
  end
end

self.caster:AddNewModifier(self.caster, self, "modifier_leshrac_diabolic_edict_custom", { duration = self.duration * (1 + self.talents.w2_duration) + 0.1})
end

function leshrac_diabolic_edict_custom:DealDamage(proc)
local enemies = self.caster:FindTargets(self:GetRadius(), nil, FIND_ANY_ORDER)
local damage = self.ability.damage + self.ability.talents.w1_damage
local max = self.ability.targets
local count = 0

local legendary_effect = nil
local damage_ability = nil
local damageTable = {attacker = self.caster, damage = damage, damage_type = self.ability.talents.has_q7 == 1 and DAMAGE_TYPE_PHYSICAL or DAMAGE_TYPE_MAGICAL, ability = self}

if proc then 
  damage_ability = "modifier_leshrac_edict_3"
  max = 1
end 

if self.ability.talents.has_w4 == 1 and #enemies > 0 then
  self.count = self.count + 1
  if self.count >= self.ability.talents.w4_count then
    self.count = 0
    self.caster:CdItems(self.ability.talents.w4_cd_items)
  end
end

for _,enemy in pairs(enemies) do 
  local mod = enemy:FindModifierByName("modifier_leshrac_diabolic_edict_custom_legendary_damage")
  if mod and self.caster:HasModifier("modifier_leshrac_diabolic_edict_custom") then 
    mod:IncrementStackCount()
    mod:SetDuration(self.ability.talents.w7_effect_duration, true)
    legendary_effect = true
  end
  damageTable.victim = enemy
  DoDamage(damageTable, damage_ability)
  self:PlayEffects(enemy, legendary_effect)

  if self.talents.has_w1 == 1 then
    enemy:AddNewModifier(self.caster, self.ability, "modifier_leshrac_diabolic_edict_custom_slow", {duration = self.ability.talents.w1_duration})
  end

  if enemy:IsRealHero() then
    self.caster:AddNewModifier(self.caster, self.ability, "modifier_leshrac_diabolic_edict_custom_damage_stack", {})
  end

  count = count + 1
  if count >= max then
    break
  end
end

if count == 0 then 
  self:PlayEffects(nil)
end

end

function leshrac_diabolic_edict_custom:PlayEffects( unit, legendary_effect)
local particle_cast = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_leshrac/leshrac_diabolic_edict.vpcf", self.ability, "leshrac_diabolic_edict_custom")
local sound_cast = "Hero_Leshrac.Diabolic_Edict"

local effect_cast 
local point

if unit then
  if legendary_effect then 
    EmitSoundOnLocationWithCaster(unit:GetAbsOrigin(), "Leshrac.Edict_legendary_break_active"..RandomInt(1, 4), self.caster)
    local effect_cast_2 = ParticleManager:CreateParticle( "particles/leshrac_diabolic_legendary_damage.vpcf", PATTACH_ABSORIGIN, unit )
    ParticleManager:SetParticleControlEnt( effect_cast_2, 1, unit, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
    ParticleManager:ReleaseParticleIndex( effect_cast_2 )

    local abs = unit:GetAbsOrigin()
    abs.z = abs.z + RandomInt(-20, 130)
    local hit_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
    ParticleManager:SetParticleControl(hit_effect, 1, abs)
    ParticleManager:ReleaseParticleIndex(hit_effect)
  end
  
  effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, unit )
  ParticleManager:SetParticleControlEnt( effect_cast, 1, unit, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
else
  effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
  point = self.caster:GetOrigin() + RandomVector(RandomInt(0, self:GetRadius()))
  ParticleManager:SetParticleControl( effect_cast, 1, point )
end

ParticleManager:ReleaseParticleIndex( effect_cast )

if unit then
  unit:EmitSound(sound_cast)
else
  EmitSoundOnLocationWithCaster(point, sound_cast, self.caster)
end

end

modifier_leshrac_diabolic_edict_custom = class(mod_visible)
function modifier_leshrac_diabolic_edict_custom:RemoveOnDeath() return false end
function modifier_leshrac_diabolic_edict_custom:OnCreated( kv )
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.count = 0

if not IsServer() then return end
self.ability:EndCd(self.ability.talents.has_w7 == 1 and 1 or nil)
self.RemoveForDuel = true

local duration_k = 1 + self.ability.talents.w2_duration
self.explosion = self.ability.num_explosions*duration_k
local duration = self.ability.duration*duration_k
local interval = duration/self.explosion 
self.parent:EmitSound("Hero_Leshrac.Diabolic_Edict_lp")

if self.ability.talents.has_r4 == 1 then
  if IsValid(self.ability.shield_mod) then
    self.ability.shield_mod:Destroy()
  end

  self.ability.shield_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_shield",
  {
    max_shield = self.parent:GetMaxMana()*self.ability.talents.r4_shield,
    start_full = 1,
    shield_talent = "modifier_leshrac_nova_4",
    dont_destroy = 1,
  })

  if self.ability.shield_mod then
    self.parent:EmitSound("Leshrac.Edict_shield")
    local effect_cast = ParticleManager:CreateParticle( "particles/leshrac/edict_shield.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControl(effect_cast, 0, self.parent:GetAbsOrigin())
    ParticleManager:SetParticleControlEnt(effect_cast, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
    self.ability.shield_mod:AddParticle( effect_cast, false, false, -1, false, false )
  end
end

self:CheckSpeed()
self:StartIntervalThink( interval )
end

function modifier_leshrac_diabolic_edict_custom:OnDestroy()
if not IsServer() then return end

if IsValid(self.ability.shield_mod) then
  self.ability.shield_mod:Destroy()
end

self.ability:StartCd()
self.parent:StopSound("Hero_Leshrac.Diabolic_Edict_lp")
end

function modifier_leshrac_diabolic_edict_custom:OnIntervalThink()
if not IsServer() then return end
self:CheckSpeed()

if self.count >= self.explosion then return end

self.count = self.count + 1
self.ability:DealDamage()
end

function modifier_leshrac_diabolic_edict_custom:CheckSpeed()
if not IsServer() then return end
if self.ability.talents.has_h5 == 0 then return end
if not self.parent:CheckCd("leshrac_h5", self.ability.talents.h5_cd) then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_leshrac_diabolic_edict_custom_speed", {duration = self.ability.talents.h5_duration})
end



modifier_leshrac_diabolic_edict_custom_speed = class(mod_visible)
function modifier_leshrac_diabolic_edict_custom_speed:GetTexture() return "buffs/leshrac/hero_5" end
function modifier_leshrac_diabolic_edict_custom_speed:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.speed = self.ability.talents.h5_speed

if not IsServer() then return end
self.parent:EmitSound("Leshrac.Edict_purge")
self.parent:GenericParticle("particles/leshrac/edict_speed.vpcf", self)
self.parent:GenericParticle("particles/leshrac_speed.vpcf", self)
end

function modifier_leshrac_diabolic_edict_custom_speed:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE
}
end

function modifier_leshrac_diabolic_edict_custom_speed:GetModifierMoveSpeed_Absolute()
return self.speed
end

function modifier_leshrac_diabolic_edict_custom_speed:CheckState()
return
{
  [MODIFIER_STATE_NO_UNIT_COLLISION] = true
}
end


modifier_leshrac_diabolic_edict_custom_legendary = class(mod_hidden)
function modifier_leshrac_diabolic_edict_custom_legendary:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self.caster.edict_ability
if not self.ability then
  self:Destroy()
  return
end

self.radius = self.ability:GetRadius() + 50
self.stun = self.ability.talents.w7_stun

local effect_cast = ParticleManager:CreateParticle( "particles/leshrac_edict_legendary.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt(effect_cast,0,self.caster,PATTACH_POINT_FOLLOW,"attach_hitloc",self.caster:GetOrigin(),true)
ParticleManager:SetParticleControlEnt(effect_cast,1,self.parent,PATTACH_POINT_FOLLOW,"attach_hitloc",self.parent:GetOrigin(),true)
self:AddParticle(effect_cast,false,false,-1,false,false)

self:StartIntervalThink(FrameTime()*3)
end

function modifier_leshrac_diabolic_edict_custom_legendary:CheckState()
return
{
  [MODIFIER_STATE_TETHERED] = true
}
end

function modifier_leshrac_diabolic_edict_custom_legendary:OnIntervalThink()
if not IsServer() then return end
AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), 10, FrameTime()*4, false)

if (self.caster:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > self.radius or not self.caster:IsAlive() or not self.caster:HasModifier("modifier_leshrac_diabolic_edict_custom") then
  self:Destroy()
end

end

function modifier_leshrac_diabolic_edict_custom_legendary:OnDestroy()
if not IsServer() then return end

if self:GetRemainingTime() > 0.1 then
  self.parent:EmitSound("Leshrac.Edict_legendary_break")
  return
end

self.parent:EmitSound("Leshrac.Edict_legendary_stun")
self.parent:GenericParticle("particles/lesh_edict_stun.vpcf")

local mod = self.caster:FindModifierByName("modifier_leshrac_diabolic_edict_custom")
if mod then 
  self.parent:AddNewModifier(self.caster, self.ability, "modifier_leshrac_diabolic_edict_custom_legendary_damage", {duration = self.ability.talents.w7_effect_duration})
end

self.parent:AddNewModifier(self.caster, self.caster:BkbAbility(self.ability, true), "modifier_stunned", {duration = self.stun*(1 - self.parent:GetStatusResistance())})
end


modifier_leshrac_diabolic_edict_custom_legendary_damage = class(mod_visible)
function modifier_leshrac_diabolic_edict_custom_legendary_damage:GetEffectName() return "particles/leshrac_edict_mark.vpcf" end
function modifier_leshrac_diabolic_edict_custom_legendary_damage:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end
function modifier_leshrac_diabolic_edict_custom_legendary_damage:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_leshrac_diabolic_edict_custom_legendary_damage:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.magic = self.ability.talents.w7_magic
if not IsServer() then return end
self.ability.active_mods[self] = true

self.max_time = self.ability.talents.w7_effect_duration

if not IsValid(self.ability.active_mod) and self.parent:IsRealHero() then
  self.ability.active_mod = self
  self:OnIntervalThink()
  self:StartIntervalThink(0.1)
end

end

function modifier_leshrac_diabolic_edict_custom_legendary_damage:OnIntervalThink()
if not IsServer() then return end
self.caster:UpdateUIshort({max_time = self.max_time, time = self:GetRemainingTime(), stack = math.floor(self:GetStackCount()*self.magic).."%", style = "LeshracEdict"})
end

function modifier_leshrac_diabolic_edict_custom_legendary_damage:OnDestroy()
if not IsServer() then return end
self.ability.active_mods[self] = nil

if self ~= self.ability.active_mod then return end
self.caster:UpdateUIshort({hide = 1, hide_full = 1, style = "LeshracEdict"})
end

function modifier_leshrac_diabolic_edict_custom_legendary_damage:GetModifierMagicalResistanceBonus()
return self.magic*self:GetStackCount()
end


modifier_leshrac_diabolic_edict_custom_tracker = class(mod_hidden)
function modifier_leshrac_diabolic_edict_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.edict_ability = self.ability

self.ability.damage = self.ability:GetSpecialValueFor("damage")
self.ability.num_explosions = self.ability:GetSpecialValueFor("num_explosions")
self.ability.radius = self.ability:GetSpecialValueFor("radius")
self.ability.duration = self.ability:GetSpecialValueFor("duration")
self.ability.interval = self.ability:GetSpecialValueFor("interval")
self.ability.targets = self.ability:GetSpecialValueFor("targets")
end 

function modifier_leshrac_diabolic_edict_custom_tracker:OnRefresh()
self.ability.damage = self.ability:GetSpecialValueFor("damage")
end

function modifier_leshrac_diabolic_edict_custom_tracker:SpellEvent(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end

if self.ability.talents.has_w3 == 1 and self.parent:CheckCd("leshrac_w3", self.ability.talents.w3_talent_cd) then
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_leshrac_diabolic_edict_custom_proc", {})
end

if self.ability.talents.has_w4 == 0 then return end

local target = params.target
if not target or target:IsCreep() then return end
if target:IsDebuffImmune() then return end
if target:GetTeamNumber() == self.parent:GetTeamNumber() then return end
if not target:IsUnit() then return end
if self.parent:HasModifier("modifier_leshrac_diabolic_edict_custom_root_cd") then return end
if target:HasModifier("modifier_leshrac_diabolic_edict_custom_legendary") then return end

target:AddNewModifier(self.parent, self.ability, "modifier_leshrac_diabolic_edict_custom_root", {duration = (1 - target:GetStatusResistance())*self.ability.talents.w4_root})
self.parent:AddNewModifier(self.parent, self.ability, "modifier_leshrac_diabolic_edict_custom_root_cd", {duration = self.ability.talents.w4_talent_cd})
end

function modifier_leshrac_diabolic_edict_custom_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
}
end

function modifier_leshrac_diabolic_edict_custom_tracker:GetModifierPercentageCooldown()
if self.ability.talents.has_h5 == 0 then return end
return self.ability.talents.h5_cdr
end



modifier_leshrac_diabolic_edict_custom_proc = class(mod_hidden)
function modifier_leshrac_diabolic_edict_custom_proc:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.count = 0
if not IsServer() then return end 
self:OnRefresh()
self:StartIntervalThink(self.ability.interval)
end 

function modifier_leshrac_diabolic_edict_custom_proc:OnRefresh()
if not IsServer() then return end
self.count = self.count + self.ability.talents.w3_count
end

function modifier_leshrac_diabolic_edict_custom_proc:OnIntervalThink()
if not IsServer() then return end 
self.ability:DealDamage(true)

self.count = self.count - 1
if self.count <= 0 then
  self:Destroy()
end

end 


modifier_leshrac_diabolic_edict_custom_damage_stack = class(mod_hidden)
function modifier_leshrac_diabolic_edict_custom_damage_stack:IsHidden() return self.ability.talents.has_w3 == 0 or self:GetStackCount() >= self.max end
function modifier_leshrac_diabolic_edict_custom_damage_stack:RemoveOnDeath() return false end
function modifier_leshrac_diabolic_edict_custom_damage_stack:GetTexture() return "buffs/leshrac/edict_3" end
function modifier_leshrac_diabolic_edict_custom_damage_stack:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability.talents.w3_max

if not IsServer() then return end
self:OnRefresh()
self:StartIntervalThink(2)
end

function modifier_leshrac_diabolic_edict_custom_damage_stack:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_leshrac_diabolic_edict_custom_damage_stack:OnIntervalThink()
if not IsServer() then return end
if self.ability.talents.has_w3 == 0 then return end 
if self:GetStackCount() < self.max then return end 

self:GetParent():EmitSound("BS.Thirst_legendary_active")
self.parent:GenericParticle("particles/leshrac/edict_proc.vpcf")  
self:StartIntervalThink(-1)
end 

function modifier_leshrac_diabolic_edict_custom_damage_stack:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_leshrac_diabolic_edict_custom_damage_stack:GetModifierSpellAmplify_Percentage()
return self:GetStackCount()*(self.ability.talents.w3_damage/self.max)
end 



modifier_leshrac_diabolic_edict_custom_slow = class(mod_hidden)
function modifier_leshrac_diabolic_edict_custom_slow:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.slow = self.ability.talents.w1_slow
self.max = self.ability.talents.w1_max
self:OnRefresh()
end

function modifier_leshrac_diabolic_edict_custom_slow:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self:GetStackCount() < self.max then return end
self.parent:GenericParticle("particles/lina_attack_slow.vpcf", self)
end

function modifier_leshrac_diabolic_edict_custom_slow:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_leshrac_diabolic_edict_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self:GetStackCount()*self.slow
end


modifier_leshrac_diabolic_edict_custom_root_cd = class(mod_cd)
function modifier_leshrac_diabolic_edict_custom_root_cd:GetTexture() return "buffs/leshrac/edict_4" end

modifier_leshrac_diabolic_edict_custom_root = class(mod_hidden)
function modifier_leshrac_diabolic_edict_custom_root:IsPurgable() return true end
function modifier_leshrac_diabolic_edict_custom_root:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
if not IsServer() then return end
self.parent:EmitSound("Leshrac.Edict_root")
self.parent:GenericParticle("particles/juggernaut/omni_root.vpcf", self)
end

function modifier_leshrac_diabolic_edict_custom_root:CheckState()
return
{
  [MODIFIER_STATE_ROOTED] = true
}
end