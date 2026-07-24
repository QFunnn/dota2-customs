--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_jakiro_dual_breath_custom_tracker", "abilities/jakiro/jakiro_dual_breath_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_dual_breath_custom_fire_debuff", "abilities/jakiro/jakiro_dual_breath_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_dual_breath_custom_ice_debuff", "abilities/jakiro/jakiro_dual_breath_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_dual_breath_custom_heal_reduce", "abilities/jakiro/jakiro_dual_breath_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_dual_breath_custom_magic_reduce", "abilities/jakiro/jakiro_dual_breath_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_dual_breath_custom_disarm", "abilities/jakiro/jakiro_dual_breath_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_dual_breath_custom_legendary_mark", "abilities/jakiro/jakiro_dual_breath_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_dual_breath_custom_legendary_damage", "abilities/jakiro/jakiro_dual_breath_custom", LUA_MODIFIER_MOTION_NONE )

jakiro_dual_breath_custom = class({})
jakiro_dual_breath_custom.talents = {}

function jakiro_dual_breath_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/units/heroes/hero_jakiro/jakiro_dual_breath_fire.vpcf", context )
PrecacheResource( "particle", "particles/jakiro/dual_breath_ice/jakiro_dual_breath_ice.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf", context )
PrecacheResource( "particle", "particles/ember_spirit/guard_resist_max.vpcf", context )
PrecacheResource( "particle", "particles/tormentor/tormentor_marka.vpcf", context )
PrecacheResource( "particle", "particles/invoker/meteor_mark.vpcf", context )
PrecacheResource( "particle", "particles/jakiro/dual_legendary_number.vpcf", context )
PrecacheResource( "particle", "particles/jakiro/dual_legendary_proc.vpcf", context )
PrecacheResource( "particle", "particles/jakiro/macropyre_refresh_ice.vpcf", context )
PrecacheResource( "particle", "particles/jakiro/macropyre_refresh_fire.vpcf", context )
end

function jakiro_dual_breath_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_q1 = 0,
    q1_damage = 0,
    q1_spell = 0,
    q1_damage_ice = caster:GetTalentValue("modifier_jakiro_dual_1", "damage_ice", true),
    
    has_q2 = 0,
    q2_slow = 0,
    q2_cd = 0,
    
    has_q3 = 0,
    q3_magic = 0,
    q3_heal_reduce = 0,
    q3_duration = caster:GetTalentValue("modifier_jakiro_dual_3", "duration", true),
    
    has_q4 = 0,
    q4_duration = caster:GetTalentValue("modifier_jakiro_dual_4", "duration", true),
    
    has_q7 = 0,
    q7_damage = caster:GetTalentValue("modifier_jakiro_dual_7", "damage", true)/100,
    q7_stack_max = caster:GetTalentValue("modifier_jakiro_dual_7", "stack_max", true),
    q7_range = caster:GetTalentValue("modifier_jakiro_dual_7", "range", true),
    q7_timer = caster:GetTalentValue("modifier_jakiro_dual_7", "timer", true),
    q7_max = caster:GetTalentValue("modifier_jakiro_dual_7", "max", true),
    q7_mana = caster:GetTalentValue("modifier_jakiro_dual_7", "mana", true)/100,
    q7_speed = caster:GetTalentValue("modifier_jakiro_dual_7", "speed", true)/100,

    has_w7 = 0,

    has_e7 = 0,

    has_r7 = 0,
    r7_stack_max = caster:GetTalentValue("modifier_jakiro_macropyre_7", "stack_max", true),
  }
end

if caster:HasTalent("modifier_jakiro_dual_1") then
  self.talents.has_q1 = 1
  self.talents.q1_damage = caster:GetTalentValue("modifier_jakiro_dual_1", "damage")/100
  self.talents.q1_spell = caster:GetTalentValue("modifier_jakiro_dual_1", "spell")
end

if caster:HasTalent("modifier_jakiro_dual_2") then
  self.talents.has_q2 = 1
  self.talents.q2_slow = caster:GetTalentValue("modifier_jakiro_dual_2", "slow")
  self.talents.q2_cd = caster:GetTalentValue("modifier_jakiro_dual_2", "cd")
end

if caster:HasTalent("modifier_jakiro_dual_3") then
  self.talents.has_q3 = 1
  self.talents.q3_magic = caster:GetTalentValue("modifier_jakiro_dual_3", "magic")
  self.talents.q3_heal_reduce = caster:GetTalentValue("modifier_jakiro_dual_3", "heal_reduce")
end

if caster:HasTalent("modifier_jakiro_dual_4") then
  self.talents.has_q4 = 1
end

if caster:HasTalent("modifier_jakiro_dual_7") then
  self.talents.has_q7 = 1

  if IsServer() then
    self.tracker:UpdateUI()
    if name == "modifier_jakiro_dual_7" and dota1x6.current_wave >= upgrade_orange then
      caster:AddNewModifier(caster, self, "modifier_jakiro_dual_breath_custom_legendary_damage", {stack = self.talents.q7_stack_max})
    end
  end
end

if caster:HasTalent("modifier_jakiro_path_7") then
  self.talents.has_w7 = 1
end

if caster:HasTalent("modifier_jakiro_liquid_7") then
  self.talents.has_e7 = 1
end

if caster:HasTalent("modifier_jakiro_macropyre_7") then
  self.talents.has_r7 = 1
end

end

function jakiro_dual_breath_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_jakiro_dual_breath_custom_tracker"
end

function jakiro_dual_breath_custom:GetAbilityTextureName()
if self.caster:HasModifier("modifier_jakiro_liquid_fire_custom_legendary_acitve") then
  return "jakiro_dual_breath"
end
if self.caster:HasModifier("modifier_jakiro_innate_custom_active_frost") then
  return wearables_system:GetAbilityIconReplacement(self.caster, "jakiro_dual_breath_ice", self)
end
return wearables_system:GetAbilityIconReplacement(self.caster, "jakiro_dual_breath_fire", self)
end

function jakiro_dual_breath_custom:GetCastRange(vLocation, hTarget)
return self:GetRange()
end

function jakiro_dual_breath_custom:GetRange()
return (self.AbilityCastRange and self.AbilityCastRange or 0) + self.parent:GetUpgradeStack("modifier_jakiro_dual_breath_custom_legendary_damage")*(self.talents.q7_range and self.talents.q7_range or 0)
end

function jakiro_dual_breath_custom:GetManaCost(level)
return self.BaseClass.GetManaCost(self, level)*(1 + (self.talents.has_q7 == 1 and self.talents.q7_mana or 0))
end

function jakiro_dual_breath_custom:GetCooldown(iLevel)
return self.BaseClass.GetCooldown(self, iLevel) + (self.talents.q2_cd and self.talents.q2_cd or 0)
end

function jakiro_dual_breath_custom:GetDuration()
return (self.slow_duration and self.slow_duration or 0) + (self.talents.has_q4 == 1 and self.talents.q4_duration or 0)
end

function jakiro_dual_breath_custom:GetDamage(is_ice)
local damage = self.fire_damage
local bonus = self.talents.q1_damage*self.caster:GetIntellect(false)
if is_ice then
  damage = self.frost_damage
  bonus = bonus*self.talents.q1_damage_ice
end
damage = damage + bonus

local mod = self.caster:FindModifierByName("modifier_jakiro_dual_breath_custom_legendary_damage")
if mod then
  damage = damage * (1 + mod:GetStackCount()*self.talents.q7_damage)
end
return damage
end


function jakiro_dual_breath_custom:OnSpellStart(new_point)
local point = self.caster:CastPosition(self:GetCursorPosition())
if new_point then
  point = new_point
end
local origin = self.caster:GetAbsOrigin()
local new_spell = 0

local projectile_distance = self:GetRange() + self.caster:GetCastRangeBonus()
local projectile_direction = point - origin
projectile_direction.z = 0
projectile_direction = projectile_direction:Normalized()

local proj_particle = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_jakiro/jakiro_dual_breath_fire.vpcf", self.ability, "jakiro_dual_breath_custom")
local is_ice = 0
local sound = wearables_system:GetSoundReplacement(self.caster, "Jakiro.DualBreath_fire", self)


if self.caster:HasModifier("modifier_jakiro_liquid_fire_custom_legendary_acitve") and not new_point then
  Timers:CreateTimer(0.2, function()
    self:OnSpellStart(point)
  end)
elseif new_point or self.caster:HasModifier("modifier_jakiro_innate_custom_active_frost") then
  proj_particle = wearables_system:GetParticleReplacementAbility(self.caster, "particles/jakiro/dual_breath_ice/jakiro_dual_breath_ice.vpcf", self.ability, "jakiro_dual_breath_custom")
  is_ice = 1
  sound = "Jakiro.DualBreath_ice"
end

if not new_point then
  self.caster:EmitSound("Hero_Jakiro.DualBreath.Cast")
  if IsValid(self.caster.jakiro_innate) then
    self.caster.jakiro_innate:SpellCast(self, is_ice)
  end
end

local speed = self.speed * (1 + (self.talents.has_q7 == 1 and self.talents.q7_speed or 0))
local spawn_origin = self.caster:GetAttachmentOrigin(self.caster:ScriptLookupAttachment("attach_attack1"))

local particle = ParticleManager:CreateParticle(proj_particle, PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(particle, 0, spawn_origin)
ParticleManager:SetParticleControl(particle, 1, projectile_direction * speed)
ParticleManager:SetParticleControl(particle, 2, Vector(0, self.start_radius, 0))
ParticleManager:SetParticleControl(particle, 9, spawn_origin)

local info = {
  Source = self.caster,
  Ability = self,
  vSpawnOrigin = origin,

  bDeleteOnHit = false,

  iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
  iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,

  fDistance = projectile_distance,
  fStartRadius = self.start_radius,
  fEndRadius = self.end_radius,
  vVelocity = projectile_direction * speed,
  ExtraData = 
  {
    x = origin.x,
    y = origin.y,
    is_ice = is_ice,
    particle = particle,
  }
}

ProjectileManager:CreateLinearProjectile(info)
self.caster:EmitSound(sound)
end

function jakiro_dual_breath_custom:OnProjectileHit_ExtraData(target, vLocation, table)
if not IsServer() then return end
if not target then
  if table.particle then
    ParticleManager:DestroyParticle(table.particle, false)
    ParticleManager:ReleaseParticleIndex(table.particle)
  end
 return 
end

local mod_name = "modifier_jakiro_dual_breath_custom_fire_debuff"
local duration = nil

if table.is_ice == 1 then
  mod_name = "modifier_jakiro_dual_breath_custom_ice_debuff"
  duration = self:GetDuration()

  local start_point = Vector(table.x, table.y, 0)

  local vec = target:GetOrigin() - start_point
  vec.z = 0

  local distance = vec:Length2D()
  vec = vec:Normalized()

  local max_dist = self.frost_knock

  local dist_k = math.max(0, (1 - distance/self.AbilityCastRange))
  distance = math.max(50, dist_k*max_dist)

  local mod = target:AddNewModifier(self.caster, self, "modifier_generic_knockback",
  { 
    direction_x = vec.x,
    direction_y = vec.y,
    distance = distance,
    height = 0, 
    duration = self.frost_knock_duration*(1 - target:GetStatusResistance()),
    IsStun = false,
    IsFlail = true,
    Purgable = 1,
  })

  DoDamage({victim = target, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL, damage = self:GetDamage(true)})
end

if IsValid(self.caster.jakiro_innate) then
  self.caster.jakiro_innate:AbilityHit(target, self, table.is_ice)
end

if self.ability.talents.has_r7 == 1 and target:IsRealHero() and self.caster.macropyre_ability then
  local mod = target:FindModifierByName("modifier_jakiro_macropyre_custom_legendary_damage")
  if mod and mod:GetStackCount() >= self.ability.talents.r7_stack_max then

    local particle = table.is_ice == 1 and "particles/jakiro/macropyre_refresh_ice.vpcf" or "particles/jakiro/macropyre_refresh_fire.vpcf"
    self.caster.macropyre_ability:AddCharge(1, particle)
  end
end

target:AddNewModifier(self.caster, self, mod_name, {duration = duration}) 

if self.talents.has_q7 == 0 then return end
if not target:IsRealHero() then return end

local legendary_mod = self.caster:FindModifierByName("modifier_jakiro_dual_breath_custom_legendary_damage")
if legendary_mod and legendary_mod:GetStackCount() >= self.talents.q7_max then return end

local mod = target:FindModifierByName("modifier_jakiro_dual_breath_custom_legendary_mark")

if mod then
  mod:Destroy()
  self.parent:AddNewModifier(self.caster, self, "modifier_jakiro_dual_breath_custom_legendary_damage", {})
else
  target:AddNewModifier(self.caster, self, "modifier_jakiro_dual_breath_custom_legendary_mark", {duration = self.talents.q7_timer, is_ice = table.is_ice})
end

end


modifier_jakiro_dual_breath_custom_tracker = class(mod_hidden)
function modifier_jakiro_dual_breath_custom_tracker:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.dual_ability = self.ability

self.ability.fire_damage = self.ability:GetSpecialValueFor("fire_damage")
self.ability.fire_slow = self.ability:GetSpecialValueFor("fire_slow")
self.ability.frost_damage = self.ability:GetSpecialValueFor("frost_damage")
self.ability.frost_knock = self.ability:GetSpecialValueFor("frost_knock")
self.ability.frost_slow = self.ability:GetSpecialValueFor("frost_slow")
self.ability.frost_slow_attack = self.ability:GetSpecialValueFor("frost_slow_attack")
self.ability.slow_duration = self.ability:GetSpecialValueFor("slow_duration")
self.ability.start_radius = self.ability:GetSpecialValueFor("start_radius")
self.ability.end_radius = self.ability:GetSpecialValueFor("end_radius")
self.ability.speed = self.ability:GetSpecialValueFor("speed")
self.ability.fire_delay = self.ability:GetSpecialValueFor("fire_delay")
self.ability.AbilityCastRange = self.ability:GetSpecialValueFor("AbilityCastRange")
self.ability.burn_interval = self.ability:GetSpecialValueFor("burn_interval")
self.ability.frost_knock_duration = self.ability:GetSpecialValueFor("frost_knock_duration")
end

function modifier_jakiro_dual_breath_custom_tracker:OnRefresh(table)
self.ability.fire_damage= self.ability:GetSpecialValueFor("fire_damage")
self.ability.fire_slow  = self.ability:GetSpecialValueFor("fire_slow")
self.ability.frost_damage = self.ability:GetSpecialValueFor("frost_damage")
self.ability.frost_knock = self.ability:GetSpecialValueFor("frost_knock")
self.ability.frost_slow = self.ability:GetSpecialValueFor("frost_slow")
self.ability.frost_slow_attack = self.ability:GetSpecialValueFor("frost_slow_attack")
end

function modifier_jakiro_dual_breath_custom_tracker:UpdateUI()
if not IsServer() then return end
if self.ability.talents.has_q7 == 0 then return end
if self.ability.talents.has_w7 == 1 then return end
if self.ability.talents.has_e7 == 1 then return end
 
local active = 0
local stack = 0
local spell_mod = self.parent:FindModifierByName("modifier_jakiro_innate_custom_active_last_spell")
if spell_mod then
  stack = 1
  if spell_mod.is_ice == 1 then
    active = 1
  end
end

self.parent:UpdateUIlong({stack = stack, max = 1, override_stack = 0, active = active, style = "JakiroDual"})
end

function modifier_jakiro_dual_breath_custom_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_jakiro_dual_breath_custom_tracker:GetModifierSpellAmplify_Percentage()
return self.ability.talents.q1_spell
end



modifier_jakiro_dual_breath_custom_fire_debuff = class(mod_visible)
function modifier_jakiro_dual_breath_custom_fire_debuff:GetTexture() return "jakiro_dual_breath_fire" end
function modifier_jakiro_dual_breath_custom_fire_debuff:IsPurgable() return self.ability.talents.has_q4 == 0 end
function modifier_jakiro_dual_breath_custom_fire_debuff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_jakiro_dual_breath_custom_fire_debuff:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.slow = self.ability.fire_slow + self.ability.talents.q2_slow

if not IsServer() then return end
self.parent:GenericParticle("particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf", self)

self.interval = self.ability.burn_interval
self.damage = self.ability:GetDamage()
self.max = self.ability:GetDuration()/self.interval
self.count = 0

if IsValid(self.caster.jakiro_innate) then
  self.caster.jakiro_innate.tracker:UpdateMod(self)
end

Timers:CreateTimer(0.1, function()
  if IsValid(self) and IsValid(self.parent) then
    self.parent:EmitSound("Hero_Jakiro.DualBreath.Burn")
  end
end)

self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL, custom_flag = "jakiro_fire"}
self:StartIntervalThink(self.interval)
end

function modifier_jakiro_dual_breath_custom_fire_debuff:OnIntervalThink()
if not IsServer() then return end

self.damageTable.damage = self.damage*self.interval
DoDamage(self.damageTable)

self.count = self.count + 1
if self.count >= self.max then
  self:Destroy()
  return
end

end

function modifier_jakiro_dual_breath_custom_fire_debuff:OnDestroy()
if not IsServer() then return end
self.parent:StopSound("Hero_Jakiro.DualBreath.Burn")

if IsValid(self.caster.jakiro_innate) then
  self.caster.jakiro_innate.tracker:UpdateMod(self, true)
end

end

function modifier_jakiro_dual_breath_custom_fire_debuff:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_jakiro_dual_breath_custom_fire_debuff:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end


modifier_jakiro_dual_breath_custom_ice_debuff = class(mod_visible)
function modifier_jakiro_dual_breath_custom_ice_debuff:GetTexture() return "jakiro_dual_breath_ice" end
function modifier_jakiro_dual_breath_custom_ice_debuff:IsPurgable() return self.ability.talents.has_q4 == 0 end
function modifier_jakiro_dual_breath_custom_ice_debuff:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.slow = self.ability.frost_slow + self.ability.talents.q2_slow
self.attack_slow = self.ability.frost_slow_attack

if not IsServer() then return end

if IsValid(self.caster.jakiro_innate) then
  self.caster.jakiro_innate.tracker:UpdateMod(self)
end

end

function modifier_jakiro_dual_breath_custom_ice_debuff:OnDestroy()
if not IsServer() then return end

if IsValid(self.caster.jakiro_innate) then
  self.caster.jakiro_innate.tracker:UpdateMod(self, true)
end

end

function modifier_jakiro_dual_breath_custom_ice_debuff:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_jakiro_dual_breath_custom_ice_debuff:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_jakiro_dual_breath_custom_ice_debuff:GetModifierAttackSpeedBonus_Constant()
return self.attack_slow
end

function modifier_jakiro_dual_breath_custom_ice_debuff:GetStatusEffectName()
return "particles/status_fx/status_effect_frost.vpcf"
end

function modifier_jakiro_dual_breath_custom_ice_debuff:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL 
end


modifier_jakiro_dual_breath_custom_heal_reduce = class(mod_hidden)
function modifier_jakiro_dual_breath_custom_heal_reduce:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.heal_reduce = self.ability.talents.q3_heal_reduce
end

function modifier_jakiro_dual_breath_custom_heal_reduce:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE
}
end

function modifier_jakiro_dual_breath_custom_heal_reduce:GetModifierHealChange()
return self.heal_reduce
end

function modifier_jakiro_dual_breath_custom_heal_reduce:GetModifierHPRegenAmplify_Percentage()
return self.heal_reduce
end


modifier_jakiro_dual_breath_custom_magic_reduce = class(mod_visible)
function modifier_jakiro_dual_breath_custom_magic_reduce:GetTexture() return "buffs/jakiro/dual_3" end
function modifier_jakiro_dual_breath_custom_magic_reduce:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max = self.ability.talents.q3_duration
self.magic_reduce = self.ability.talents.q3_magic/self.max

if not IsServer() then return end
self:OnRefresh()
end

function modifier_jakiro_dual_breath_custom_magic_reduce:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self:GetStackCount() >= self.max then
  self.parent:EmitSound("Jakiro.Dual_resist")
  self.parent:GenericParticle("particles/ember_spirit/guard_resist_max.vpcf", self)
end

end

function modifier_jakiro_dual_breath_custom_magic_reduce:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_jakiro_dual_breath_custom_magic_reduce:GetModifierMagicalResistanceBonus()
return self:GetStackCount()*self.magic_reduce
end


modifier_jakiro_dual_breath_custom_disarm = class(mod_hidden)
function modifier_jakiro_dual_breath_custom_disarm:IsPurgable() return true end
function modifier_jakiro_dual_breath_custom_disarm:CheckState()
return
{
  [MODIFIER_STATE_DISARMED] = true
}
end

function modifier_jakiro_dual_breath_custom_disarm:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()

self.parent:EmitSound("Jakiro.Dual_disarm")
self.parent:GenericParticle("particles/jakiro/ice_path_frost_debuff.vpcf", self, true)
end



modifier_jakiro_dual_breath_custom_legendary_mark = class(mod_hidden)
function modifier_jakiro_dual_breath_custom_legendary_mark:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.is_ice = table.is_ice
local effect = "particles/invoker/meteor_mark.vpcf"
if self.is_ice == 1 then
  effect = "particles/tormentor/tormentor_marka.vpcf"
end

self.parent:GenericParticle(effect, self, true)
end



modifier_jakiro_dual_breath_custom_legendary_damage = class(mod_visible)
function modifier_jakiro_dual_breath_custom_legendary_damage:RemoveOnDeath() return false end
function modifier_jakiro_dual_breath_custom_legendary_damage:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability.talents.q7_max
self.damage = self.ability.talents.q7_damage*100
self.range = self.ability.talents.q7_range
if not IsServer() then return end
self:AddStack(table)
end

function modifier_jakiro_dual_breath_custom_legendary_damage:OnRefresh(table)
if not IsServer() then return end
self:AddStack(table)
end

function modifier_jakiro_dual_breath_custom_legendary_damage:AddStack(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end

if table.stack then
  self:SetStackCount(math.min(self.max, table.stack))
else
  self:IncrementStackCount()
end

self.parent:GenericParticle("particles/jakiro/dual_legendary_number.vpcf")
self.parent:GenericParticle("particles/jakiro/dual_legendary_proc.vpcf")
self.parent:EmitSound("Jakiro.Dual_legendary_stack")
end

function modifier_jakiro_dual_breath_custom_legendary_damage:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_TOOLTIP,
  MODIFIER_PROPERTY_TOOLTIP2
}
end

function modifier_jakiro_dual_breath_custom_legendary_damage:OnTooltip()
return self.damage*self:GetStackCount()
end

function modifier_jakiro_dual_breath_custom_legendary_damage:OnTooltip2()
return self.range*self:GetStackCount()
end