--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_crystal_maiden_arcane_aura_custom", "abilities/crystal_maiden/crystal_maiden_arcane_aura_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_arcane_aura_custom_buff", "abilities/crystal_maiden/crystal_maiden_arcane_aura_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_arcane_aura_custom_shield", "abilities/crystal_maiden/crystal_maiden_arcane_aura_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_arcane_aura_custom_slow", "abilities/crystal_maiden/crystal_maiden_arcane_aura_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_arcane_aura_custom_haste", "abilities/crystal_maiden/crystal_maiden_arcane_aura_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_arcane_aura_custom_damage", "abilities/crystal_maiden/crystal_maiden_arcane_aura_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_arcane_aura_custom_shard", "abilities/crystal_maiden/crystal_maiden_arcane_aura_custom", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_crystal_maiden_arcane_aura_custom_shard_unit", "abilities/crystal_maiden/crystal_maiden_arcane_aura_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_arcane_aura_custom_clone", "abilities/crystal_maiden/crystal_maiden_arcane_aura_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_arcane_aura_custom_clone_attack", "abilities/crystal_maiden/crystal_maiden_arcane_aura_custom", LUA_MODIFIER_MOTION_NONE )

crystal_maiden_arcane_aura_custom = class({})
crystal_maiden_arcane_aura_custom.talents = {}
crystal_maiden_arcane_aura_custom.shard_clones = {}

function crystal_maiden_arcane_aura_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/units/heroes/hero_ancient_apparition/ancient_apparition_chilling_touch_projectile.vpcf", context )
PrecacheResource( "particle", "particles/econ/items/crystal_maiden/ti9_immortal_staff/cm_ti9_staff_lvlup_globe.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf", context )
PrecacheResource( "particle", "particles/items5_fx/maiden_shield_start.vpcf", context )
PrecacheResource( "particle", "particles/maiden_shield.vpcf", context )
PrecacheResource( "particle", "particles/zuus_speed.vpcf", context )
PrecacheResource( "particle", "particles/maiden_arcane.vpcf", context )
PrecacheResource( "particle", "particles/maiden_spells.vpcf", context )
PrecacheResource( "particle", "particles/maiden_shield_active.vpcf", context )
PrecacheResource( "particle", "particles/drow_ranger/frost_cleave.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_lina/lina_supercharge_buff.vpcf", context )
PrecacheResource( "particle", "particles/crystal_maiden/arcane_attack.vpcf", context )
PrecacheResource( "particle", "particles/crystal_maiden/aura_legendary_explosion.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_crystalmaiden/maiden_crystal_clone_end.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_crystalmaiden/maiden_crystal_clone_movement.vpcf", context )
PrecacheResource( "particle", "particles/crystal_maiden/arcane_legendary_max.vpcf", context )
end


function crystal_maiden_arcane_aura_custom:UpdateTalents()
local caster = self:GetCaster()

if not self.init then
  self.init = true
  self.talents =
  {    
    has_e1 = 0,
    e1_damage = 0,
    e1_stats = 0,

    has_slow = 0,
    range_inc = 0,
    slow_inc = 0,
    slow_duration = caster:GetTalentValue("modifier_maiden_arcane_2", "duration", true),

    has_clone = 0,
    clone_stun = 0,
    clone_damage = 0,
    clone_duration = caster:GetTalentValue("modifier_maiden_arcane_3", "duration", true),
    clone_radius = caster:GetTalentValue("modifier_maiden_arcane_3", "radius", true),
    clone_spawn = caster:GetTalentValue("modifier_maiden_arcane_3", "spawn_radius", true),

    has_haste = 0,
    haste_count = 0,
    haste_move = caster:GetTalentValue("modifier_maiden_arcane_4", "move", true),
    haste_duration = caster:GetTalentValue("modifier_maiden_arcane_4", "duration", true),
    duration_legendary = 0,

    has_shield = 0,
    shield_amount = caster:GetTalentValue("modifier_maiden_hero_6", "mana", true)/100,
    shield_status = caster:GetTalentValue("modifier_maiden_hero_6", "status", true),
    shield_radius = caster:GetTalentValue("modifier_maiden_hero_6", "radius", true),
    shield_cd = caster:GetTalentValue("modifier_maiden_hero_6", "cd", true),

    has_legendary = 0,
    legendary_damage = caster:GetTalentValue("modifier_maiden_arcane_7", "damage", true),
    legendary_cdr = caster:GetTalentValue("modifier_maiden_arcane_7", "cdr", true),
    legendary_max = caster:GetTalentValue("modifier_maiden_arcane_7", "max", true),
    legendary_duration = caster:GetTalentValue("modifier_maiden_arcane_7", "duration", true),
    legendary_duration_hero = caster:GetTalentValue("modifier_maiden_arcane_7", "duration_hero", true),
    legendary_duration_creeps = caster:GetTalentValue("modifier_maiden_arcane_7", "duration_creeps", true),
  }
end

if caster:HasTalent("modifier_maiden_arcane_1") then
  self.talents.has_e1 = 1
  self.talents.e1_damage = caster:GetTalentValue("modifier_maiden_arcane_1", "damage")/100
  self.talents.e1_stats = caster:GetTalentValue("modifier_maiden_arcane_1", "stats")/100
  caster:AddPercentStat({agi = self.talents.e1_stats, int = self.talents.e1_stats, str = self.talents.e1_stats}, self.tracker)
end

if caster:HasTalent("modifier_maiden_arcane_2") then
  self.talents.has_slow = 1
  self.talents.range_inc = caster:GetTalentValue("modifier_maiden_arcane_2", "range")
  self.talents.slow_inc = caster:GetTalentValue("modifier_maiden_arcane_2", "slow")
end

if caster:HasTalent("modifier_maiden_arcane_3") then
  self.talents.has_clone = 1
  self.talents.clone_damage = caster:GetTalentValue("modifier_maiden_arcane_3", "damage")
  self.talents.clone_stun = caster:GetTalentValue("modifier_maiden_arcane_3", "stun")
end

if caster:HasTalent("modifier_maiden_arcane_4") then
  self.talents.has_haste = 1
  self.talents.haste_count = caster:GetTalentValue("modifier_maiden_arcane_4", "count")
  self.talents.duration_legendary = caster:GetTalentValue("modifier_maiden_arcane_4", "duration_legendary")
end

if caster:HasTalent("modifier_maiden_hero_6") then
  self.talents.has_shield = 1
  caster:AddDamageEvent_inc(self.tracker, true)
  if IsServer() and not self.shield_init then
    self.shield_init = true
    self.tracker:OnIntervalThink()
  end
end

if caster:HasTalent("modifier_maiden_arcane_7") then
  self.talents.has_legendary = 1
  if IsServer() then
    self.tracker:UpdateUI()
  end
end

end

function crystal_maiden_arcane_aura_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "crystal_maiden_brilliance_aura", self)
end

function crystal_maiden_arcane_aura_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_crystal_maiden_arcane_aura_custom"
end

function crystal_maiden_arcane_aura_custom:OnUpgrade()
if not IsServer() then return end
local caster = self:GetCaster()

if not caster:IsRealHero() then return end

local effect_name = wearables_system:GetParticleReplacementAbility(self:GetCaster(), "particles/ability_modifier_placeholder/brilliance_aura.vpcf", self)

if effect_name ~= "particles/ability_modifier_placeholder/brilliance_aura.vpcf" then
  local particle = ParticleManager:CreateParticle( effect_name, PATTACH_ABSORIGIN_FOLLOW, caster )
  ParticleManager:SetParticleControlEnt( particle, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true )
  ParticleManager:SetParticleControl(particle, 5, Vector(1,1,1))
  ParticleManager:ReleaseParticleIndex( particle )
end

end

function crystal_maiden_arcane_aura_custom:GetBehavior()
if self:GetCaster():HasShard() then
  return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_MOVEMENT + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING + DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL
end
return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function crystal_maiden_arcane_aura_custom:GetCooldown(iLevel)
local caster = self:GetCaster()
if not caster:HasShard() then return end 
return self.shard_cd and self.shard_cd or 0
end

function crystal_maiden_arcane_aura_custom:GetManaCost(iLevel)
local caster = self:GetCaster()
if not caster:HasShard() then return end 
return self.shard_mana and self.shard_mana or 0
end 

function crystal_maiden_arcane_aura_custom:GetCastRange(vLocation, hTarget)
local caster = self:GetCaster()
if not caster:HasShard() then return end 
if IsServer() then return 99999 end
return (self.shard_range and self.shard_range or 0) - caster:GetCastRangeBonus()
end

function crystal_maiden_arcane_aura_custom:GetCastAnimation()
return ACT_DOTA_CAST_ABILITY_5
end

function crystal_maiden_arcane_aura_custom:OnSpellStart()
local caster = self:GetCaster()
caster:StartGesture(ACT_DOTA_CAST_ABILITY_5)

local point = self:GetCursorPosition()
local dir = (point - caster:GetAbsOrigin()):Normalized()
if point == caster:GetAbsOrigin() then
  dir = caster:GetForwardVector()
end
dir.z = 0

local illusion_self = CreateIllusions(caster, caster, 
{
  outgoing_damage = 0,
  duration = self.clone_duration
}, 1, 0, false, false)

for _,illusion in pairs(illusion_self) do
  illusion.owner = caster
  illusion:SetForwardVector(dir)
  illusion:FaceTowards(caster:GetAbsOrigin() + dir*10)
  illusion:AddNewModifier(caster, self, "modifier_crystal_maiden_arcane_aura_custom_shard_unit", {duration = self.clone_duration})
  illusion:SetAbsOrigin(caster:GetAbsOrigin())
end

point = caster:GetAbsOrigin() + dir*self.shard_range

local mod = caster:FindModifierByName("modifier_crystal_maiden_frostbite_custom_tracker")
if mod then
  mod:CreateArea(point)
end
caster:FaceTowards(point)
caster:SetForwardVector(dir)
caster:AddNewModifier(caster, self, "modifier_crystal_maiden_arcane_aura_custom_shard", {duration = self.shard_duration, x = point.x, y = point.y})
end


function crystal_maiden_arcane_aura_custom:SearchClones(radius, point)
if not IsServer() then return end
if not self.shard_clones then return end

for clone,_ in pairs(self.shard_clones) do
  if IsValid(clone) and clone:IsAlive() and (clone:GetAbsOrigin() - point):Length2D() <= radius then
    local mod = clone:FindModifierByName("modifier_crystal_maiden_arcane_aura_custom_shard_unit")
    if mod then
      mod:Destroy()
    end
  end
end

end

function crystal_maiden_arcane_aura_custom:ProcEffects(hit_type)
if not IsServer() then return end
local caster = self:GetCaster()

if self.talents.has_legendary == 1 and hit_type then
  local duration = hit_type == 2 and self.talents.legendary_duration_hero or self.talents.legendary_duration_creeps
  local mod = caster:FindModifierByName("modifier_crystal_maiden_arcane_aura_custom_damage")
  if mod then
    duration = math.max(mod:GetRemainingTime(), duration)
  end
  caster:AddNewModifier(caster, self, "modifier_crystal_maiden_arcane_aura_custom_damage", {duration = duration})
end

end

function crystal_maiden_arcane_aura_custom:DealDamage(target)
if not IsServer() then return end
local caster = self:GetCaster()
if target:GetTeamNumber() == caster:GetTeamNumber() then return end

local damage = self.damage + caster:GetAverageTrueAttackDamage(nil)*self.talents.e1_damage
local damageTable = {attacker = caster, ability = self, damage = damage, victim = target, damage_type = DAMAGE_TYPE_MAGICAL,}

target:EmitSound("Maiden.Arcane_attack")

DoDamage(damageTable)
target:SendNumber(4, damage)

local particle = ParticleManager:CreateParticle( "particles/crystal_maiden/arcane_attack.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, target )
ParticleManager:SetParticleControlEnt( particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true )
ParticleManager:ReleaseParticleIndex( particle )

if self.talents.has_slow == 1 then
  target:AddNewModifier(caster, self, "modifier_crystal_maiden_arcane_aura_custom_slow", {duration = self.talents.slow_duration})
end

end



modifier_crystal_maiden_arcane_aura_custom = class(mod_hidden)
function modifier_crystal_maiden_arcane_aura_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.arcane_aura_ability = self.ability

self.attack = false
self.proc = nil
self.records = {}

self.ability.count = self.ability:GetSpecialValueFor("count") 
self.ability.duration = self.ability:GetSpecialValueFor("duration") 
self.ability.attack_range = self.ability:GetSpecialValueFor("attack_range")  
self.ability.speed = self.ability:GetSpecialValueFor("speed") 
self.ability.damage = self.ability:GetSpecialValueFor("damage") 
self.ability.proj_speed = self.ability:GetSpecialValueFor("proj_speed")

self.ability.clone_health = self.ability:GetSpecialValueFor("clone_health")     
self.ability.clone_duration = self.ability:GetSpecialValueFor("clone_duration")   
self.ability.shard_duration = self.ability:GetSpecialValueFor("shard_duration")         
self.ability.shard_cd = self.ability:GetSpecialValueFor("cd")               
self.ability.frostbite_duration = self.ability:GetSpecialValueFor("frostbite_duration")
self.ability.frostbite_radius = self.ability:GetSpecialValueFor("frostbite_radius")
self.ability.shard_mana = self.ability:GetSpecialValueFor("mana")             
self.ability.shard_range = self.ability:GetSpecialValueFor("range")            

self.parent:AddAttackStartEvent_out(self)
self.parent:AddSpellEvent(self, true)
self.parent:AddAttackEvent_out(self, true)
self.parent:AddRecordDestroyEvent(self, true)
end

function modifier_crystal_maiden_arcane_aura_custom:OnRefresh()
self.ability.attack_range = self.ability:GetSpecialValueFor("attack_range")  
self.ability.speed = self.ability:GetSpecialValueFor("speed") 
self.ability.damage = self.ability:GetSpecialValueFor("damage") 
end

function modifier_crystal_maiden_arcane_aura_custom:OnIntervalThink()
if not IsServer() then return end
if self.ability.talents.has_shield == 0 then return end
if not self.parent:IsAlive() then
  self:StartIntervalThink(0.5)
  return
end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_crystal_maiden_arcane_aura_custom_shield", {})
self:StartIntervalThink(-1)
end

function modifier_crystal_maiden_arcane_aura_custom:UpdateUI()
if not IsServer() then return end
if self.ability.talents.has_legendary == 0 then return end

local mod = self.parent:FindModifierByName("modifier_crystal_maiden_arcane_aura_custom_damage")
local max = 1
local stack = 0
local active = 0
local override = 0

if mod then
  stack = mod:GetRemainingTime()
  override = mod:GetStackCount()
  max = mod.max_time
  active = stack >= self.ability.talents.legendary_max and 1 or 0
end

self.parent:UpdateUIlong({max = max, stack = stack, override_stack = override, active = 1, style = "MaidenAura"})
end

function modifier_crystal_maiden_arcane_aura_custom:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
}
end

function modifier_crystal_maiden_arcane_aura_custom:GetModifierAttackRangeBonus()
return self.ability.talents.range_inc
end

function modifier_crystal_maiden_arcane_aura_custom:DamageEvent_inc(params)
if not IsServer() then return end
if self.ability.talents.has_shield == 0 then return end
if self.parent ~= params.unit then return end
if self.parent:GetTeamNumber() == params.attacker:GetTeamNumber() then return end
if (self.parent:GetAbsOrigin() - params.attacker:GetAbsOrigin()):Length2D() > self.ability.talents.shield_radius and not self.parent:HasModifier("modifier_crystal_maiden_arcane_aura_custom_shield") then return end

self:StartIntervalThink(self.ability.talents.shield_cd)
end

function modifier_crystal_maiden_arcane_aura_custom:AttackStartEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end

local target = params.target
local has_crystal = self.parent:HasModifier("modifier_crystal_maiden_crystal_nova_legendary_aura")

if self.parent:HasModifier("modifier_crystal_maiden_arcane_aura_custom_clone_attack") then return end
if params.no_attack_cooldown and not has_crystal then return end

local mod = self.parent:FindModifierByName("modifier_crystal_maiden_arcane_aura_custom_buff")
if not mod then return end 

local type = 1

if self.ability.talents.has_clone == 1 and not mod.clone_proc then
  mod.clone_proc = true
  local projectile =
  {
    Target = params.target,
    Source = self.parent,
    Ability = self.ability,
    EffectName = "particles/units/heroes/hero_ancient_apparition/ancient_apparition_chilling_touch_projectile.vpcf",
    iMoveSpeed = self.parent:GetProjectileSpeed(),
    vSourceLoc = self.parent:GetAbsOrigin(),
    bDodgeable = true,
    bProvidesVision = false,
  }
  self.parent:EmitSound("Maiden.Arcane_legendary_attack")
  local hProjectile = ProjectileManager:CreateTrackingProjectile( projectile )
  type = 2
end

if not params.no_attack_cooldown then
  self.ability:ProcEffects(target:IsHero() and 2 or 1)
  mod:ReduceStack()
end

self.records[params.record] = type
end

function modifier_crystal_maiden_arcane_aura_custom:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
local target = params.target
local type = self.records[params.record]

if not target:IsUnit() then return end
if not type then return end

self.ability:DealDamage(target)

if type == 2 then
  local point = target:GetAbsOrigin() + RandomVector(self.ability.talents.clone_spawn)
  local vec = target:GetAbsOrigin() - point
  local duration = self.ability.talents.clone_duration
  local illusion = CreateUnitByName("npc_crystal_maiden_clone_custom", point, true, nil, nil, self.parent:GetTeamNumber())

  illusion.owner = self.parent
  illusion.crystal_clone = true
  illusion:SetHealth(illusion:GetMaxHealth())
  illusion:AddNewModifier(self.parent, self.ability, "modifier_crystal_maiden_arcane_aura_custom_clone",  {duration = duration})
  illusion:AddNewModifier(self.parent, self.ability, "modifier_kill", {duration = duration})
  illusion:SetOrigin(GetGroundPosition(point, nil))
  illusion:SetForwardVector(vec:Normalized())
  illusion:FaceTowards(point)
  AddFOWViewer(self.parent:GetTeamNumber(), point, self.ability.talents.clone_radius, duration, false)
end

end

function modifier_crystal_maiden_arcane_aura_custom:RecordDestroyEvent(params)
if not IsServer() then return end
if not self.records[params.record] then return end
self.records[params.record] = nil
end

function modifier_crystal_maiden_arcane_aura_custom:SpellEvent(params)
if not IsServer() then return end
if params.unit ~= self.parent then return end
if self.parent:PassivesDisabled() then return end
if params.ability:IsItem() then return end

local duration = self.ability.talents.has_legendary == 1 and (self.ability.talents.legendary_duration + self.ability.talents.duration_legendary) or self.ability.duration
self.parent:AddNewModifier(self.parent, self.ability, "modifier_crystal_maiden_arcane_aura_custom_buff", {duration = duration})

if self.ability.talents.has_haste == 0 then return end
self.parent:RemoveModifierByName("modifier_crystal_maiden_arcane_aura_custom_haste")
self.parent:AddNewModifier(self.parent, self.ability, "modifier_crystal_maiden_arcane_aura_custom_haste", {duration = self.ability.talents.haste_duration})
end



modifier_crystal_maiden_arcane_aura_custom_buff = class(mod_visible)
function modifier_crystal_maiden_arcane_aura_custom_buff:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.range = self.ability.attack_range
self.speed = self.ability.speed
self.proj_speed = self.ability.proj_speed
self.max = self.ability.count + self.ability.talents.haste_count

if not IsServer() then return end

if self.ability.talents.has_legendary == 0 then
  self:SetStackCount(self.max)
end

self.parent:GenericParticle("particles/units/heroes/hero_lina/lina_supercharge_buff.vpcf", self)
end

function modifier_crystal_maiden_arcane_aura_custom_buff:OnRefresh()
if not IsServer() then return end
self.clone_proc = nil

if self.ability.talents.has_legendary == 1 then return end
self:SetStackCount(self.max)
end

function modifier_crystal_maiden_arcane_aura_custom_buff:ReduceStack()
if not IsServer() then return end
if self.ability.talents.has_legendary == 1 then return end
self:DecrementStackCount()
if self:GetStackCount() <= 0 then
  self:Destroy()
  return
end

end

function modifier_crystal_maiden_arcane_aura_custom_buff:CheckState()
return
{
  [MODIFIER_STATE_CANNOT_MISS] = true
}
end

function modifier_crystal_maiden_arcane_aura_custom_buff:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS,
  MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
}
end

function modifier_crystal_maiden_arcane_aura_custom_buff:GetModifierProjectileSpeedBonus()
return self.proj_speed
end

function modifier_crystal_maiden_arcane_aura_custom_buff:GetModifierAttackRangeBonus()
return self.range
end

function modifier_crystal_maiden_arcane_aura_custom_buff:GetModifierAttackSpeedBonus_Constant()
return self.speed
end


modifier_crystal_maiden_arcane_aura_custom_shield = class(mod_visible)
function modifier_crystal_maiden_arcane_aura_custom_shield:GetTexture() return "buffs/crystal_maiden/hero_7" end
function modifier_crystal_maiden_arcane_aura_custom_shield:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.shield_resist = self.ability.talents.shield_status
self.shield_talent = "modifier_maiden_hero_6"
self.max_shield = self.ability.talents.shield_amount*self.parent:GetMaxMana()
self.shield = self.max_shield

if not IsServer() then return end

self.parent:EmitSound("Maiden.Arcane_shield_loop")
self.parent:GenericParticle("particles/items5_fx/maiden_shield_start.vpcf", self)
self.parent:GenericParticle("particles/maiden_arcane.vpcf")
self.parent:EmitSound("Maiden.Arcane_shield")
self.parent:EmitSound("Maiden.Arcane_shield_2")
self.parent:SendNumber(11, self.max_shield)

self.pfx = ParticleManager:CreateParticle("particles/maiden_shield.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.pfx, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, "", self.parent:GetAbsOrigin(), false)
ParticleManager:SetParticleControl(self.pfx, 2, Vector(90, 90, 90))
self:AddParticle(self.pfx,false, false, -1, false, false)

self:SetHasCustomTransmitterData(true)
end

function modifier_crystal_maiden_arcane_aura_custom_shield:OnRefresh(table)
if not IsServer() then return end
self.max_shield = self.ability.talents.shield_amount*self.parent:GetMaxMana()
self.shield = self.max_shield

self.parent:EmitSound("Maiden.Arcane_shield")
self.parent:GenericParticle("particles/maiden_arcane.vpcf")
self:SendBuffRefreshToClients()
end

function modifier_crystal_maiden_arcane_aura_custom_shield:OnDestroy()
if not IsServer() then return end
self.parent:EmitSound("Maiden.Arcane_shield_end")
self.parent:StopSound("Maiden.Arcane_shield_loop")
end

function modifier_crystal_maiden_arcane_aura_custom_shield:AddCustomTransmitterData() 
return 
{ 
  shield = self.shield,
  max_shield = self.max_shield,
}
end

function modifier_crystal_maiden_arcane_aura_custom_shield:HandleCustomTransmitterData(data)
self.shield = data.shield
self.max_shield = data.max_shield
end

function modifier_crystal_maiden_arcane_aura_custom_shield:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
  MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
}
end
function modifier_crystal_maiden_arcane_aura_custom_shield:GetStatusEffectName()
return "particles/status_fx/status_effect_frost.vpcf"
end

function modifier_crystal_maiden_arcane_aura_custom_shield:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH
end

function modifier_crystal_maiden_arcane_aura_custom_shield:GetModifierStatusResistanceStacking()
return self.shield_resist
end

function modifier_crystal_maiden_arcane_aura_custom_shield:GetModifierIncomingDamageConstant( params )

if IsClient() then 
  if params.report_max then 
    return self.max_shield
  else 
    return self.shield
  end 
end

if not IsServer() then return end
self.parent:EmitSound("Hero_Lich.ProjectileImpact")

local damage = math.min(params.damage, self.shield)
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self.shield = self.shield - damage
self:SendBuffRefreshToClients()
if self.shield <= 0 then
  self:Destroy()
end

return -damage
end


modifier_crystal_maiden_arcane_aura_custom_clone = class(mod_hidden)
function modifier_crystal_maiden_arcane_aura_custom_clone:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

if not IsServer() then return end
self.frozen = false
self.parent:EmitSound("Maiden.Aura_clone_start")

self.parent:GenericParticle("particles/units/heroes/hero_lina/lina_supercharge_buff.vpcf", self)

local states = {ACT_DOTA_GENERIC_CHANNEL_1, ACT_DOTA_CAST_ABILITY_1, ACT_DOTA_CAST_ABILITY_2}
self.parent:StartGesture(states[RandomInt(1, #states)])
self.parent:GenericParticle("particles/maiden_shield_active.vpcf")
self:StartIntervalThink(0.15)
end

function modifier_crystal_maiden_arcane_aura_custom_clone:OnIntervalThink()
if not IsServer() then return end
self.frozen = true
self:StartIntervalThink(-1)
end

function modifier_crystal_maiden_arcane_aura_custom_clone:GetStatusEffectName()
return "particles/status_fx/crystal_maiden_crystal_clone.vpcf"
end

function modifier_crystal_maiden_arcane_aura_custom_clone:StatusEffectPriority()
return MODIFIER_PRIORITY_ILLUSION
end

function modifier_crystal_maiden_arcane_aura_custom_clone:CheckState()
return
{
  [MODIFIER_STATE_FROZEN] = self.frozen,
  [MODIFIER_STATE_STUNNED] = true,
  [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
  [MODIFIER_STATE_UNSELECTABLE] = true, 
  [MODIFIER_STATE_INVULNERABLE] = true, 
  [MODIFIER_STATE_OUT_OF_GAME] = true, 
  [MODIFIER_STATE_NO_HEALTH_BAR] = true, 
  [MODIFIER_STATE_UNTARGETABLE] = true, 
  [MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true, 
}
end

function modifier_crystal_maiden_arcane_aura_custom_clone:OnDestroy()
if not IsServer() then return end
if self.ended then return end

self.ended = true
self.parent:EmitSound("Maiden.Aura_clone_end")

local radius = self.ability.talents.clone_radius
local effect_cast = ParticleManager:CreateParticle( "particles/crystal_maiden/aura_legendary_explosion.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetAbsOrigin() )
ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, duration, radius ) )
ParticleManager:ReleaseParticleIndex( effect_cast )

local first = 1
self.caster:AddNewModifier(self.caster, self.ability, "modifier_crystal_maiden_arcane_aura_custom_clone_attack", {duration = 1})

for _,target in pairs(self.caster:FindTargets(radius, self.parent:GetAbsOrigin())) do
  target:AddNewModifier(self.caster, self.ability, "modifier_stunned", {duration = (1 - target:GetStatusResistance())*self.ability.talents.clone_stun})
  first = 0
  self.caster:PerformAttack(target, true, true, true, true, false, false, true)
  self.ability:DealDamage(target)
end

self.caster:RemoveModifierByName("modifier_crystal_maiden_arcane_aura_custom_clone_attack")
self.parent:Kill(nil, nil)
self.parent:AddNoDraw()
end


modifier_crystal_maiden_arcane_aura_custom_clone_attack = class(mod_hidden)
function modifier_crystal_maiden_arcane_aura_custom_clone_attack:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.heal_count = 0
self.damage = self.ability.talents.clone_damage - 100
end

function modifier_crystal_maiden_arcane_aura_custom_clone_attack:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
}
end

function modifier_crystal_maiden_arcane_aura_custom_clone_attack:OnDestroy()
if not IsServer() then return end
if self.heal_count <= 0 then return end
self.parent:GenericHeal(self.heal_count, self.ability, false, "", "modifier_maiden_arcane_3")
end

function modifier_crystal_maiden_arcane_aura_custom_clone_attack:GetModifierTotalDamageOutgoing_Percentage(params)
if not IsServer() then return end
if params.inflictor then return end
return self.damage
end


modifier_crystal_maiden_arcane_aura_custom_slow = class({})
function modifier_crystal_maiden_arcane_aura_custom_slow:IsHidden() return true end
function modifier_crystal_maiden_arcane_aura_custom_slow:IsPurgable() return true end
function modifier_crystal_maiden_arcane_aura_custom_slow:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_crystal_maiden_arcane_aura_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_crystal_maiden_arcane_aura_custom_slow:GetStatusEffectName()
return "particles/status_fx/status_effect_frost.vpcf"
end

function modifier_crystal_maiden_arcane_aura_custom_slow:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL 
end

function modifier_crystal_maiden_arcane_aura_custom_slow:OnCreated()
self.slow = self:GetAbility().talents.slow_inc
end 



modifier_crystal_maiden_arcane_aura_custom_haste = class(mod_visible)
function modifier_crystal_maiden_arcane_aura_custom_haste:GetTexture() return "buffs/crystal_maiden/arcane_4" end
function modifier_crystal_maiden_arcane_aura_custom_haste:GetEffectName() return "particles/zuus_speed.vpcf" end
function modifier_crystal_maiden_arcane_aura_custom_haste:OnCreated()
self.speed = self:GetAbility().talents.haste_move
end

function modifier_crystal_maiden_arcane_aura_custom_haste:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_crystal_maiden_arcane_aura_custom_haste:GetModifierMoveSpeedBonus_Percentage()
return self.speed
end

function modifier_crystal_maiden_arcane_aura_custom_haste:CheckState()
return
{
  [MODIFIER_STATE_UNSLOWABLE] = true
}
end


modifier_crystal_maiden_arcane_aura_custom_damage = class(mod_hidden)
function modifier_crystal_maiden_arcane_aura_custom_damage:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability.talents.legendary_max
self.damage = self.ability.talents.legendary_damage
self.cdr = self.ability.talents.legendary_cdr
if not IsServer() then return end
self.max_time = self:GetRemainingTime()

self.mod = self.parent:FindModifierByName("modifier_crystal_maiden_arcane_aura_custom")
self:IncrementStackCount()
self:OnIntervalThink()
self:StartIntervalThink(0.1)
end

function modifier_crystal_maiden_arcane_aura_custom_damage:OnRefresh()
if not IsServer() then return end
self.max_time = self:GetRemainingTime()

if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()

if self:GetStackCount() >= self.max then
  self.parent:GenericParticle("particles/maiden_spells.vpcf", self)
  self.parent:GenericParticle("particles/crystal_maiden/arcane_legendary_max.vpcf", self)

  local particle = ParticleManager:CreateParticle( "particles/econ/items/crystal_maiden/ti9_immortal_staff/cm_ti9_staff_lvlup_globe.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
  ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
  ParticleManager:SetParticleControl(particle, 5, Vector(1,1,1))
  ParticleManager:ReleaseParticleIndex( particle )

  self.parent:EmitSound("Maiden.Arcane_legendary_max")
end

self:OnIntervalThink()
end

function modifier_crystal_maiden_arcane_aura_custom_damage:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
  MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE
}
end

function modifier_crystal_maiden_arcane_aura_custom_damage:GetModifierDamageOutgoing_Percentage()
return self.damage*self:GetStackCount()
end

function modifier_crystal_maiden_arcane_aura_custom_damage:GetModifierPercentageCooldown()
return self.cdr*self:GetStackCount()
end

function modifier_crystal_maiden_arcane_aura_custom_damage:OnIntervalThink()
if not IsServer() then return end
if not self.mod then return end
self.mod:UpdateUI()
end

function modifier_crystal_maiden_arcane_aura_custom_damage:OnDestroy()
if not IsServer() then return end
if not self.mod then return end
self.mod:UpdateUI()
end





modifier_crystal_maiden_arcane_aura_custom_shard = class(mod_hidden)

function modifier_crystal_maiden_arcane_aura_custom_shard:OnCreated(params)
if not IsServer() then return end

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:EmitSound("Hero_Crystal.CrystalClone.Cast")
self.parent:GenericParticle("particles/units/heroes/hero_crystalmaiden/maiden_crystal_clone_movement.vpcf", self)
self.point = GetGroundPosition(Vector(params.x, params.y, 0), nil)

self.dir = (self.point - self.parent:GetAbsOrigin())
self.dir.z = 0
self.distance = self.dir:Length2D() / self:GetDuration()

if self:ApplyHorizontalMotionController() == false then
  self:Destroy()
end

end

function modifier_crystal_maiden_arcane_aura_custom_shard:OnDestroy()
if not IsServer() then return end
self.parent:InterruptMotionControllers( true )
local dir = self.parent:GetForwardVector()
dir.z = 0
self.parent:SetForwardVector(dir)
self.parent:FaceTowards(self.parent:GetAbsOrigin() + dir*10)

ResolveNPCPositions(self.parent:GetAbsOrigin(), 128)
end

function modifier_crystal_maiden_arcane_aura_custom_shard:UpdateHorizontalMotion( me, dt )
if not IsServer() then return end
local pos = self.parent:GetAbsOrigin()
GridNav:DestroyTreesAroundPoint(pos, 80, false)
self.parent:SetAbsOrigin(GetGroundPosition(pos + self.dir:Normalized() * self.distance * dt,self.parent))
end

function modifier_crystal_maiden_arcane_aura_custom_shard:OnHorizontalMotionInterrupted()
self:Destroy()
end



modifier_crystal_maiden_arcane_aura_custom_shard_unit = class(mod_hidden)
function modifier_crystal_maiden_arcane_aura_custom_shard_unit:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.health = self.ability.clone_health - self.parent:GetMaxHealth()

if not IsServer() then return end
self.ability.shard_clones[self.parent] = true
self.frostbite = self.caster:FindAbilityByName("crystal_maiden_frostbite_custom")

self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_5)
self.frozen = false

self.parent:CalculateStatBonus(true)
self:StartIntervalThink(0.1)
end

function modifier_crystal_maiden_arcane_aura_custom_shard_unit:OnIntervalThink()
if not IsServer() then return end
self.frozen = true
self:StartIntervalThink(-1)
end

function modifier_crystal_maiden_arcane_aura_custom_shard_unit:GetStatusEffectName()
return "particles/status_fx/crystal_maiden_crystal_clone.vpcf"
end

function modifier_crystal_maiden_arcane_aura_custom_shard_unit:StatusEffectPriority()
return MODIFIER_PRIORITY_ILLUSION
end

function modifier_crystal_maiden_arcane_aura_custom_shard_unit:CheckState()
return
{
  [MODIFIER_STATE_FROZEN] = self.frozen,
  [MODIFIER_STATE_STUNNED] = true,
  [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
  [MODIFIER_STATE_NO_HEALTH_BAR] = true,
  [MODIFIER_STATE_UNTARGETABLE] = true, 
  [MODIFIER_STATE_UNSELECTABLE] = true, 
}
end

function modifier_crystal_maiden_arcane_aura_custom_shard_unit:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_HEALTH_BONUS
}
end

function modifier_crystal_maiden_arcane_aura_custom_shard_unit:GetModifierHealthBonus()
return self.health
end

function modifier_crystal_maiden_arcane_aura_custom_shard_unit:OnDestroy()
if not IsServer() then return end
self.ability.shard_clones[self.parent] = nil
if self.ended then return end

self.ended = true
local radius = self.ability.frostbite_radius

if self.frostbite and self.frostbite:IsTrained() then
  for _,target in pairs(self.caster:FindTargets(radius, self.parent:GetAbsOrigin())) do
    self.frostbite:ApplyEffect(target, self.ability.frostbite_duration)
  end
end

local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_crystalmaiden/maiden_crystal_clone_end.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetAbsOrigin() )
ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
ParticleManager:ReleaseParticleIndex( effect_cast )
self.parent:EmitSound("Hero_Crystal.CrystalClone.Destroy")
self.parent:Kill(nil, nil)
end