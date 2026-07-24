--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_night_stalker_void_custom", "abilities/night_stalker/night_stalker_void_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_night_stalker_void_custom_slow", "abilities/night_stalker/night_stalker_void_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_night_stalker_void_custom_legendary_thinker", "abilities/night_stalker/night_stalker_void_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_night_stalker_void_custom_legendary_buff", "abilities/night_stalker/night_stalker_void_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_night_stalker_void_custom_legendary_cast", "abilities/night_stalker/night_stalker_void_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_night_stalker_void_custom_damage_stack", "abilities/night_stalker/night_stalker_void_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_night_stalker_void_custom_magic", "abilities/night_stalker/night_stalker_void_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_night_stalker_void_custom_move", "abilities/night_stalker/night_stalker_void_custom", LUA_MODIFIER_MOTION_NONE )

night_stalker_void_custom = class({})
night_stalker_void_custom.talents = {}

function night_stalker_void_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "night_stalker_void", self)
end

function night_stalker_void_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/units/heroes/hero_night_stalker/nightstalker_void.vpcf", context )
PrecacheResource( "particle", "particles/night_stalker/void_legendary_orb.vpcf", context )
PrecacheResource( "particle", "particles/night_stalker/void_legendary_area.vpcf", context )
PrecacheResource( "particle", "particles/night_stalker/void_legendary_proj.vpcf", context )
PrecacheResource( "particle", "particles/night_stalker/void_legendary_buff.vpcf", context )
PrecacheResource( "particle", "particles/night_stalker/void_legendary_stack.vpcf", context )
PrecacheResource( "particle", "particles/night_stalker/void_legendary_cast.vpcf", context )
PrecacheResource( "particle", "particles/night_stalker/void_legendary_impact.vpcf", context )
PrecacheResource( "particle", "particles/night_stalker/void_magic.vpcf", context )
PrecacheResource( "particle", "particles/night_stalker/void_delay_damage.vpcf", context )
PrecacheResource( "particle", "particles/night_stalker/void_proc.vpcf", context )
PrecacheResource( "particle", "particles/night_stalker/void_move.vpcf", context )
end

function night_stalker_void_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_q1 = 0,
    q1_spell = 0,
    q1_damage = 0,
    
    has_q2 = 0,
    q2_cd = 0,
    q2_range = 0,
    
    has_q3 = 0,
    q3_magic = 0,
    q3_damage = 0,
    q3_health = caster:GetTalentValue("modifier_stalker_void_3", "health", true),
    q3_cd = caster:GetTalentValue("modifier_stalker_void_3", "cd", true),
    q3_radius = caster:GetTalentValue("modifier_stalker_void_3", "radius", true),
    q3_damage_type = caster:GetTalentValue("modifier_stalker_void_3", "damage_type", true),
    q3_duration = caster:GetTalentValue("modifier_stalker_void_3", "duration", true),
    
    has_q4 = 0,
    q4_cd_items = caster:GetTalentValue("modifier_stalker_void_4", "cd_items", true),
    q4_cast = caster:GetTalentValue("modifier_stalker_void_4", "cast", true),
    q4_cd_legendary = caster:GetTalentValue("modifier_stalker_void_4", "cd_legendary", true),
    
    has_q7 = 0,
    q7_cd = caster:GetTalentValue("modifier_stalker_void_7", "cd", true),
    q7_effect_duration = caster:GetTalentValue("modifier_stalker_void_7", "effect_duration", true),
    q7_check_radius = caster:GetTalentValue("modifier_stalker_void_7", "check_radius", true),
    q7_duration_orb = caster:GetTalentValue("modifier_stalker_void_7", "duration_orb", true),
    q7_duration_orb_creeps = caster:GetTalentValue("modifier_stalker_void_7", "duration_orb_creeps", true),
    q7_spawn_radius = caster:GetTalentValue("modifier_stalker_void_7", "spawn_radius", true),
    q7_mana = caster:GetTalentValue("modifier_stalker_void_7", "mana", true),
    q7_cd_inc = caster:GetTalentValue("modifier_stalker_void_7", "cd_inc", true)/100,
    q7_max = caster:GetTalentValue("modifier_stalker_void_7", "max", true),
    q7_radius = caster:GetTalentValue("modifier_stalker_void_7", "radius", true),
    q7_damage = caster:GetTalentValue("modifier_stalker_void_7", "damage", true)/100,
    q7_void_stack = caster:GetTalentValue("modifier_stalker_void_7", "void_stack", true),
    q7_damage_k = caster:GetTalentValue("modifier_stalker_void_7", "damage_k", true),
    
    has_h4 = 0,
    h4_stun = caster:GetTalentValue("modifier_stalker_hero_4", "stun", true),
    h4_talent_cd = caster:GetTalentValue("modifier_stalker_hero_4", "talent_cd", true),
    h4_move = caster:GetTalentValue("modifier_stalker_hero_4", "move", true),
    h4_duration = caster:GetTalentValue("modifier_stalker_hero_4", "duration", true),
    h4_slow_resist = caster:GetTalentValue("modifier_stalker_hero_4", "slow_resist", true),
  }
end

if caster:HasTalent("modifier_stalker_void_1") then
  self.talents.has_q1 = 1
  self.talents.q1_spell = caster:GetTalentValue("modifier_stalker_void_1", "spell")
  self.talents.q1_damage = caster:GetTalentValue("modifier_stalker_void_1", "damage")/100
  self.talents.q1_creeps = caster:GetTalentValue("modifier_stalker_void_1", "creeps")
end

if caster:HasTalent("modifier_stalker_void_2") then
  self.talents.has_q2 = 1
  self.talents.q2_cd = caster:GetTalentValue("modifier_stalker_void_2", "cd")
  self.talents.q2_range = caster:GetTalentValue("modifier_stalker_void_2", "range")
end

if caster:HasTalent("modifier_stalker_void_3") then
  self.talents.has_q3 = 1
  self.talents.q3_magic = caster:GetTalentValue("modifier_stalker_void_3", "magic")
  self.talents.q3_damage = caster:GetTalentValue("modifier_stalker_void_3", "damage")/100
end

if caster:HasTalent("modifier_stalker_void_4") then
  self.talents.has_q4 = 1
end

if caster:HasTalent("modifier_stalker_void_7") then
  self.talents.has_q7 = 1
  caster:AddDamageEvent_out(self.tracker, true)
  if name == "modifier_stalker_void_7" then
    self.tracker:UpdateUI()
  end
end

if caster:HasTalent("modifier_stalker_hero_4") then
  self.talents.has_h4 = 1
end

end

function night_stalker_void_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_night_stalker_void_custom"
end

function night_stalker_void_custom:GetManaCost(level)
return self.BaseClass.GetManaCost(self, level)
end

function night_stalker_void_custom:GetCooldown(level)
local k = 1
if self.caster:HasShard() and self.caster.dark_ability and self.caster:HasModifier("modifier_night_stalker_darkness_custom_active") then
  k = 1 + self.caster.dark_ability.shard_cd
end
return (self.BaseClass.GetCooldown(self, level) + (self.talents.q2_cd and self.talents.q2_cd or 0))*k
end

function night_stalker_void_custom:GetCastPoint(iLevel)
return self.BaseClass.GetCastPoint(self) + (self.talents.has_q4 == 1 and self.talents.q4_cast or 0)
end

function night_stalker_void_custom:GetAOERadius()
return self.cast_radius and self.cast_radius or 0
end

function night_stalker_void_custom:LegendaryDamage(stack)
return self.talents.q7_damage*math.pow(stack/self.talents.q7_max, self.talents.q7_damage_k)
end

function night_stalker_void_custom:OnSpellStart()
local target = self:GetCursorTarget()

if self.talents.has_q7 == 1 then
  for i = 1, self.talents.q7_void_stack do
    self:CreateOrb(target)
  end
end

if target:TriggerSpellAbsorb(self) then return end

local is_day = not self.caster:IsStalkerNight()
local mod = self.caster:FindModifierByName("modifier_night_stalker_void_custom_legendary_buff")

local duration = self.duration_day
if not is_day then
  duration = self.duration_night
  target:AddNewModifier(caster, self, "modifier_stunned", {duration = 0.1})
end

if self.talents.has_h4 == 1 then
  self.caster:AddNewModifier(self.caster, self, "modifier_night_stalker_void_custom_move", {duration = self.talents.h4_duration})
  if not target:IsDebuffImmune() and target:CheckCd("night_stalker_h4", self.talents.h4_talent_cd) then
    target:GenericParticle("particles/night_stalker/fear_legendary_hit.vpcf")
    target:AddNewModifier(caster, self, "modifier_stunned", {duration = (1 - target:GetStatusResistance())*self.talents.h4_stun})
    target:EmitSound("Stalker.Void_stun")
  end
end

local stack = 0
if mod then
  stack = mod:GetStackCount()
  mod:Destroy()
end

if self.talents.has_q4 == 1 then
  local cd = self.talents.q4_cd_items + stack*self.talents.q4_cd_legendary
  self.caster:CdItems(cd) 
end

local damageTable = {attacker = self.caster, ability = self, damage_type = DAMAGE_TYPE_MAGICAL}
for _,aoe_target in pairs(self.caster:FindTargets(self.cast_radius, target:GetAbsOrigin())) do
  aoe_target:AddNewModifier(self.caster, self, "modifier_night_stalker_void_custom_slow", {duration = duration*(1 - aoe_target:GetStatusResistance())})

  local damage = self.damage
  if self.talents.has_q1 == 1 then
    damage = damage + (aoe_target:IsCreep() and self.talents.q1_creeps or self.talents.q1_damage*aoe_target:GetMaxHealth())
  end
  damage = damage*(1 + self.ability:LegendaryDamage(stack))

  damageTable.damage = damage
  damageTable.victim = aoe_target

  if self.talents.has_q3 == 1 then
    aoe_target:AddNewModifier(self.caster, self, "modifier_night_stalker_void_custom_damage_stack", {duration = self.q3_duration, damage = damage})
  end

  local pfx = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_night_stalker/nightstalker_void_hit.vpcf", self)
  if pfx ~= "particles/units/heroes/hero_night_stalker/nightstalker_void_hit.vpcf" then
    aoe_target:GenericParticle(pfx)
  end

  local real_damage = DoDamage(damageTable)
  if stack >= 2 then
    aoe_target:GenericParticle("particles/night_stalker/void_legendary_impact.vpcf")
    aoe_target:SendNumber(102, real_damage)
  end

  if aoe_target == target then
    local sound = wearables_system:GetSoundReplacement(self.caster, "Hero_Nightstalker.Void", self)
    if stack >= 2 then
      sound = "Hero_Nightstalker.Void"
      target:EmitSound("Stalker.Void_legendary_impact")
    end
    target:EmitSound(sound)
  end
end

end

function night_stalker_void_custom:OnProjectileHit(target, vLocation)
if not target then return end

self.caster:CdAbility(self, self:GetEffectiveCooldown(self:GetLevel())*self.talents.q7_cd_inc)

self.caster:AddNewModifier(self.caster, self, "modifier_night_stalker_void_custom_legendary_buff", {duration = self.talents.q7_effect_duration})
self.caster:GenericParticle("particles/night_stalker/void_legendary_buff.vpcf")
self.caster:EmitSound("Stalker.Void_legendary_buff")
end

function night_stalker_void_custom:CreateOrb(target)
if not IsServer() then return end

local point = GetGroundPosition(self.parent:GetAbsOrigin() + RandomVector(self.ability.talents.q7_spawn_radius), nil)
local duration = target:IsCreep() and self.ability.talents.q7_duration_orb_creeps or self.ability.talents.q7_duration_orb

target:EmitSound("Stalker.Void_legendary_orb")
CreateModifierThinker(self.parent, self.ability, "modifier_night_stalker_void_custom_legendary_thinker", {target = self.parent:entindex(), duration = duration}, point, self.parent:GetTeamNumber(), false)
end


modifier_night_stalker_void_custom = class(mod_hidden)
function modifier_night_stalker_void_custom:IsHidden() return self.ability.talents.has_q7 == 0 end
function modifier_night_stalker_void_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.void_ability = self.ability
self.active_legendary = {}

self.legendary_ability = self.parent:FindAbilityByName("night_stalker_void_custom_legendary")
if self.legendary_ability then
  self.legendary_ability:UpdateTalents()
end

self.visual_max = 6

self.ability.damage = self.ability:GetSpecialValueFor("damage") 
self.ability.duration_night = self.ability:GetSpecialValueFor("duration_night")
self.ability.duration_day   = self.ability:GetSpecialValueFor("duration_day") 
self.ability.movespeed_slow = self.ability:GetSpecialValueFor("movespeed_slow")
self.ability.attackspeed_slow = self.ability:GetSpecialValueFor("attackspeed_slow")
self.ability.cast_radius = self.ability:GetSpecialValueFor("cast_radius")
end

function modifier_night_stalker_void_custom:OnRefresh(table)
self.ability.damage = self.ability:GetSpecialValueFor("damage") 
self.ability.duration_night = self.ability:GetSpecialValueFor("duration_night")
end

function modifier_night_stalker_void_custom:DamageEvent_out(params)
if not IsServer() then return end
if not params.unit:IsUnit() then return end
if self.parent ~= params.attacker then return end

local target = params.unit

if self.ability.talents.has_q7 == 0 then return end
if params.inflictor and params.inflictor:GetName() ~= "night_stalker_crippling_fear_custom" then return end
if not self.parent:CheckCd("night_stalker_q7", self.ability.talents.q7_cd) then return end

self.ability:CreateOrb(target)
end

function modifier_night_stalker_void_custom:UpdateUI()
if not IsServer() then return end
if not self.ability.talents.has_q7 == 0 then return end

local stack = 0
local mod = self.parent:FindModifierByName("modifier_night_stalker_void_custom_legendary_buff")

if mod then
  stack = mod:GetStackCount()
  if self.particle then
    ParticleManager:DestroyParticle(self.particle, true)
    ParticleManager:ReleaseParticleIndex(self.particle)
    self.particle = nil
  end
else
  if not self.particle then
    self.particle = self.parent:GenericParticle("particles/night_stalker/void_legendary_stack.vpcf", self, true)
    for i = 1, self.visual_max do 
      ParticleManager:SetParticleControl(self.particle, i, Vector(0, 0, 0)) 
    end
  end
end

self.parent:UpdateUIlong({stack = stack, override_stack = math.floor(self.ability:LegendaryDamage(stack)*100).."%", max = self.ability.talents.q7_max, style = "StalkerVoid"})
end

function modifier_night_stalker_void_custom:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
  MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING
}
end

function modifier_night_stalker_void_custom:GetModifierSpellAmplify_Percentage()
return self.ability.talents.q1_spell
end

function modifier_night_stalker_void_custom:GetModifierCastRangeBonusStacking()
return self.ability.talents.q2_range
end

function modifier_night_stalker_void_custom:IsAura() return IsServer() and self.parent:IsAlive() and self.ability.talents.has_q3 == 1 end
function modifier_night_stalker_void_custom:GetAuraDuration() return 0.2 end
function modifier_night_stalker_void_custom:GetAuraRadius() return self.ability.talents.q3_radius end
function modifier_night_stalker_void_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_night_stalker_void_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_night_stalker_void_custom:GetModifierAura() return "modifier_night_stalker_void_custom_magic" end
function modifier_night_stalker_void_custom:GetAuraEntityReject(hEntity)
if hEntity:IsFieldInvun(self.parent) then return true end
return hEntity:GetHealthPercent() > self.ability.talents.q3_health
end

modifier_night_stalker_void_custom_slow = class(mod_visible)
function modifier_night_stalker_void_custom_slow:IsPurgable() return true end
function modifier_night_stalker_void_custom_slow:RemoveOnDeath() return false end
function modifier_night_stalker_void_custom_slow:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.slow = self.ability.movespeed_slow
self.attack_slow = self.ability.attackspeed_slow
if not IsServer() then return end

if IsValid(self.caster.fear_ability) then
  self.caster.fear_ability:CheckRegen(self)
end

local pfx = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_night_stalker/nightstalker_void.vpcf", self)
self.parent:GenericParticle(pfx, self)
end

function modifier_night_stalker_void_custom_slow:OnDestroy()
if not IsServer() then return end
if not IsValid(self.caster.fear_ability) then return end
self.caster.fear_ability:CheckRegen(self, true)
end

function modifier_night_stalker_void_custom_slow:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_night_stalker_void_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_night_stalker_void_custom_slow:GetModifierAttackSpeedBonus_Constant()
return self.attack_slow
end


modifier_night_stalker_void_custom_legendary_thinker = class(mod_hidden)
function modifier_night_stalker_void_custom_legendary_thinker:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.point = self.parent:GetAbsOrigin()

self.radius = self.ability.talents.q7_radius
self.target = EntIndexToHScript(table.target)

self.start_interval = 0.3 
self.interval = 0.1
self.speed = 1800

self.effect = ParticleManager:CreateParticle("particles/night_stalker/void_legendary_orb.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.effect, 0, self.target, PATTACH_POINT_FOLLOW, "attach_hitloc", self.target:GetAbsOrigin(), false)
ParticleManager:SetParticleControlEnt(self.effect, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetAbsOrigin(), false)
ParticleManager:SetParticleControl(self.effect, 2, self.point)
ParticleManager:SetParticleControl(self.effect, 3, self.point)
self:AddParticle( self.effect, false, false, -1, false, false )

if self.ability.tracker then
  self.ability.tracker.active_legendary[self] = true
  self.ability.tracker:IncrementStackCount()
end

self:StartIntervalThink(self.start_interval)
end

function modifier_night_stalker_void_custom_legendary_thinker:OnDestroy()
if not IsServer() then return end
if self.ability.tracker then
  self.ability.tracker.active_legendary[self] = nil
  self.ability.tracker:DecrementStackCount()
end

local particle = ParticleManager:CreateParticle("particles/night_stalker/void_legendary_projf.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(particle, 0, self.point + Vector(0, 0, 60))
ParticleManager:SetParticleControl(particle, 1, self.point + Vector(0, 0, 60))
ParticleManager:ReleaseParticleIndex(particle)
end

function modifier_night_stalker_void_custom_legendary_thinker:OnIntervalThink()
if not IsServer() then return end
if not IsValid(self.caster) or not self.caster:IsAlive() then
  self:Destroy()
  return
end

AddFOWViewer(self.caster:GetTeamNumber(), self.point, self.radius, self.interval*2, false)

if not self.start_init then
  self.start_init = true
  self.particle = ParticleManager:CreateParticle("particles/night_stalker/void_legendary_area.vpcf", PATTACH_WORLDORIGIN, nil)
  ParticleManager:SetParticleControl(self.particle, 0, self.point)
  ParticleManager:SetParticleControl( self.particle, 1, self.point)
  ParticleManager:SetParticleControl( self.particle, 2, Vector(self.radius, self.radius, self.radius) )
  self:AddParticle(self.particle, false, false, -1, false, false) 
end

if ((self.caster:GetAbsOrigin() - self.point):Length2D() <= self.radius*1.2 or self.force_ended) and not self.ended then
  self.ended = true

  self.parent:EmitSound("Stalker.Void_legendary_launch")

  local info = {
    vSourceLoc = self.parent:GetAbsOrigin(),
    Ability = self.ability, 
    
    EffectName = "particles/night_stalker/void_legendary_proj.vpcf",
    iMoveSpeed = self.speed,
    bDodgeable = false, 
    Target = self.caster,
  }
  ProjectileManager:CreateTrackingProjectile(info)

  if self.particle then
    ParticleManager:DestroyParticle(self.particle, false)
    ParticleManager:ReleaseParticleIndex(self.particle)
    self.particle = nil
  end

  if self.effect then
    ParticleManager:DestroyParticle(self.effect, false)
    ParticleManager:ReleaseParticleIndex(self.effect)
    self.effect = nil
  end
  self:Destroy()
  return
end

self:StartIntervalThink(self.interval)
end



night_stalker_void_custom_legendary = class(mod_hidden)
function night_stalker_void_custom_legendary:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    q7_talent_cd = caster:GetTalentValue("modifier_stalker_void_7", "talent_cd", true),
    q7_max = caster:GetTalentValue("modifier_stalker_void_7", "max", true),
  }
end

end

function night_stalker_void_custom_legendary:Init()
self.caster = self:GetCaster()
end

function night_stalker_void_custom_legendary:GetCooldown(level)
return (self.talents.q7_talent_cd and self.talents.q7_talent_cd or 0)
end

function night_stalker_void_custom_legendary:OnAbilityPhaseStart()
self.caster:AddNewModifier(self.caster, self.ability, "modifier_night_stalker_void_custom_legendary_cast", {})
self.caster:StartGesture(ACT_DOTA_CAST_ABILITY_1)
return true
end

function night_stalker_void_custom_legendary:OnAbilityPhaseInterrupted()
self.caster:RemoveModifierByName("modifier_night_stalker_void_custom_legendary_cast")
self.caster:FadeGesture(ACT_DOTA_CAST_ABILITY_1)
return true
end

function night_stalker_void_custom_legendary:OnSpellStart()
self.caster:RemoveModifierByName("modifier_night_stalker_void_custom_legendary_cast")

if not self.caster.void_ability then return end
if not self.caster.void_ability.tracker then return end

local legendary = self.caster:FindModifierByName("modifier_night_stalker_void_custom_legendary_buff")
local count = 0
local max = self.talents.q7_max
if legendary then
  max = self.talents.q7_max - legendary:GetStackCount()
end

for mod,_ in pairs(self.caster.void_ability.tracker.active_legendary) do
  if IsValid(mod) then
    if count >= max then
      break
    end

    mod.force_ended = true
    mod:OnIntervalThink()
    count = count + 1
  end
end

self.caster:GenericParticle("particles/night_stalker/void_legendary_cast.vpcf")
self.caster:EmitSound("Stalker.Void_legendary_active")
self.caster:EmitSound("Stalker.Void_legendary_active2")
end

modifier_night_stalker_void_custom_legendary_cast = class(mod_hidden)
function modifier_night_stalker_void_custom_legendary_cast:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
}
end

function modifier_night_stalker_void_custom_legendary_cast:GetActivityTranslationModifiers()
return "nihility"
end

modifier_night_stalker_void_custom_legendary_buff = class(mod_hidden)
function modifier_night_stalker_void_custom_legendary_buff:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability.talents.q7_max
self.visual_max = 6
self.particle = self.parent:GenericParticle("particles/night_stalker/void_legendary_stack.vpcf", self, true)

self:IncrementStackCount()
self:StartIntervalThink(0.5)
end

function modifier_night_stalker_void_custom_legendary_buff:OnIntervalThink()
if not IsServer() then return end

for _,player in pairs(players) do
  if player:IsAlive() and player:GetTeamNumber() ~= self.parent:GetTeamNumber() and (player:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() <= self.ability.talents.q7_check_radius then
    self:SetDuration(self.ability.talents.q7_effect_duration, true)
    break
  end
end

end

function modifier_night_stalker_void_custom_legendary_buff:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_night_stalker_void_custom_legendary_buff:OnStackCountChanged()
if not IsServer() then return end

if self.ability.tracker then
  self.ability.tracker:UpdateUI()
end

if not self.particle then return end

for i = 1,self.visual_max do 
  if i <= math.floor(self:GetStackCount()/(self.max/self.visual_max)) then 
    ParticleManager:SetParticleControl(self.particle, i, Vector(1, 0, 0)) 
  else 
    ParticleManager:SetParticleControl(self.particle, i, Vector(0, 0, 0)) 
  end
end

end

function modifier_night_stalker_void_custom_legendary_buff:OnDestroy()
if not IsServer() then return end
if not self.ability.tracker then return end
self.ability.tracker:UpdateUI()
end


modifier_night_stalker_void_custom_damage_stack = class(mod_hidden)
function modifier_night_stalker_void_custom_damage_stack:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = self.ability.talents.q3_damage_type}

self.stack = 0
self.interval = 0.3
self:AddStack(table.damage)
end

function modifier_night_stalker_void_custom_damage_stack:OnRefresh(table)
if not IsServer() then return end
self:AddStack(table.damage)
end

function modifier_night_stalker_void_custom_damage_stack:AddStack(damage)
if not IsServer() then return end
self.stack = self.stack + damage*self.ability.talents.q3_damage
self:StartIntervalThink(self.interval)
end

function modifier_night_stalker_void_custom_damage_stack:OnIntervalThink()
if not IsServer() then return end
if self.parent:GetHealthPercent() > self.ability.talents.q3_health then return end
if not self.parent:CheckCd("night_stalker_q3", self.ability.talents.q3_cd) then return end

self.damageTable.damage = self.stack
DoDamage(self.damageTable, "modifier_stalker_void_3")

self.parent:GenericParticle("particles/night_stalker/void_proc.vpcf")
if self.stack > 100 then
  self.parent:EmitSound("Stalker.Void_proc")
end

self:Destroy()
end


modifier_night_stalker_void_custom_magic = class(mod_visible)
function modifier_night_stalker_void_custom_magic:GetTexture() return "buffs/night_stalker/void_3" end
function modifier_night_stalker_void_custom_magic:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.magic = self.ability.talents.q3_magic
if not IsServer() then return end
self.parent:GenericParticle("particles/night_stalker/void_magic.vpcf", self)
end 

function modifier_night_stalker_void_custom_magic:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_night_stalker_void_custom_magic:GetModifierMagicalResistanceBonus()
return self.magic
end



modifier_night_stalker_void_custom_move = class(mod_hidden)
function modifier_night_stalker_void_custom_move:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.move = self.ability.talents.h4_move
self.slow_resist = self.ability.talents.h4_slow_resist
if not IsServer() then return end
self.parent:GenericParticle("particles/night_stalker/void_move.vpcf", self)
end

function modifier_night_stalker_void_custom_move:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
  MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING
}
end

function modifier_night_stalker_void_custom_move:GetModifierMoveSpeedBonus_Percentage()
return self.move
end

function modifier_night_stalker_void_custom_move:GetModifierSlowResistance_Stacking()
return self.slow_resist
end