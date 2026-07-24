--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_centaur_return_custom", "abilities/centaur/centaur_return_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_centaur_return_custom_legendary_banner", "abilities/centaur/centaur_return_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_centaur_return_custom_target_taunt", "abilities/centaur/centaur_return_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_centaur_return_custom_legendary_speed", "abilities/centaur/centaur_return_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_centaur_return_custom_shard_stun_cd", "abilities/centaur/centaur_return_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_centaur_return_custom_shard_spell_cd", "abilities/centaur/centaur_return_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_centaur_return_custom_regen", "abilities/centaur/centaur_return_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_centaur_return_custom_armor", "abilities/centaur/centaur_return_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_centaur_return_custom_slow", "abilities/centaur/centaur_return_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_centaur_return_custom_status_bonus", "abilities/centaur/centaur_return_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_centaur_return_custom_status_cd", "abilities/centaur/centaur_return_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_centaur_return_custom_str", "abilities/centaur/centaur_return_custom", LUA_MODIFIER_MOTION_NONE )

centaur_return_custom = class({})
centaur_return_custom.talents = {}

function centaur_return_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_centaur/centaur_return.vpcf", context )
PrecacheResource( "particle", "particles/centaur/return_legendary_timer.vpcf", context )
PrecacheResource( "particle", "particles/centaur/reuturn_legendary_caster.vpcf", context )
PrecacheResource( "particle", "particles/econ/items/axe/axe_ti9_immortal/axe_ti9_call.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_axe/axe_beserkers_call_owner.vpcf", context )
PrecacheResource( "particle", "particles/centaur/return_legendary_pulses.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap_debuff.vpcf", context )
PrecacheResource( "particle", "particles/centaur/return_hit.vpcf", context )
PrecacheResource( "particle", "particles/mars/arena_linkena.vpcf", context )
PrecacheResource( "particle", "particles/centaur/return_leash.vpcf", context )
PrecacheResource( "particle", "particles/centaur/return_purge.vpcf", context )
PrecacheResource( "particle", "particles/lc_lowhp.vpcf", context )
PrecacheResource( "particle", "particles/centaur/retaliate_attack.vpcf", context )
PrecacheUnitByNameSync("npc_dota_centaur_banner", context, -1)

end

function centaur_return_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.talents =
  {
    has_e1 = 0,
    e1_armor = 0,
    e1_damage = 0,
    e1_duration = caster:GetTalentValue("modifier_centaur_retaliate_1", "duration", true),

    has_e2 = 0,
    e2_heal = 0,
    e2_bonus = caster:GetTalentValue("modifier_centaur_retaliate_2", "bonus", true),

    has_regen = 0,
    regen_bonus = 0,
    armor_bonus = 0,
    regen_max = caster:GetTalentValue("modifier_centaur_hero_3", "max", true),
    regen_duration = caster:GetTalentValue("modifier_centaur_hero_3", "duration", true),

    has_e3 = 0,
    e3_str = 0,
    e3_damage = 0,
    e3_duration = caster:GetTalentValue("modifier_centaur_retaliate_3", "duration", true),
    e3_chance = caster:GetTalentValue("modifier_centaur_retaliate_3", "chance", true),
    e3_max = caster:GetTalentValue("modifier_centaur_retaliate_3", "max", true),
    e3_radius = caster:GetTalentValue("modifier_centaur_retaliate_3", "radius", true),

    has_e4 = 0,
    taunt_timer = caster:GetTalentValue("modifier_centaur_retaliate_4", "timer", true),
    taunt_duration = caster:GetTalentValue("modifier_centaur_retaliate_4", "taunt", true),
    
    has_e4 = 0,
    e4_slow = caster:GetTalentValue("modifier_centaur_retaliate_4", "slow", true),
    e4_duration = caster:GetTalentValue("modifier_centaur_retaliate_4", "duration", true),
    e4_talent_cd = caster:GetTalentValue("modifier_centaur_retaliate_4", "talent_cd", true),
    e4_timer = caster:GetTalentValue("modifier_centaur_retaliate_4", "timer", true),
    e4_slow_duration = caster:GetTalentValue("modifier_centaur_retaliate_4", "slow_duration", true),
    e4_taunt = caster:GetTalentValue("modifier_centaur_retaliate_4", "taunt", true),

    has_e7 = 0,
    e7_talent_cd = caster:GetTalentValue("modifier_centaur_retaliate_7", "talent_cd", true),
    e7_knock_radius = caster:GetTalentValue("modifier_centaur_retaliate_7", "knock_radius", true),
    e7_duration = caster:GetTalentValue("modifier_centaur_retaliate_7", "duration", true),
    e7_heal = caster:GetTalentValue("modifier_centaur_retaliate_7", "heal", true)/100,
    e7_knock_duration = caster:GetTalentValue("modifier_centaur_retaliate_7", "knock_duration", true),
    e7_range = caster:GetTalentValue("modifier_centaur_retaliate_7", "range", true),
    e7_attack_radius = caster:GetTalentValue("modifier_centaur_retaliate_7", "attack_radius", true),
    e7_health = caster:GetTalentValue("modifier_centaur_retaliate_7", "health", true)/100,
    e7_speed = caster:GetTalentValue("modifier_centaur_retaliate_7", "speed", true),
    e7_radius = caster:GetTalentValue("modifier_centaur_retaliate_7", "radius", true),
    e7_effect_duration = caster:GetTalentValue("modifier_centaur_retaliate_7", "effect_duration", true),
    e7_max = caster:GetTalentValue("modifier_centaur_retaliate_7", "max", true),

    has_h5 = 0,
    h5_damage_reduce = caster:GetTalentValue("modifier_centaur_hero_5", "damage_reduce", true),
    h5_talent_cd = caster:GetTalentValue("modifier_centaur_hero_5", "talent_cd", true),
    h5_status_bonus = caster:GetTalentValue("modifier_centaur_hero_5", "status_bonus", true),
    h5_status = caster:GetTalentValue("modifier_centaur_hero_5", "status", true),
    h5_duration = caster:GetTalentValue("modifier_centaur_hero_5", "duration", true),
  }
end

if caster:HasTalent("modifier_centaur_retaliate_1") then
  self.talents.has_e1 = 1
  self.talents.e1_armor = caster:GetTalentValue("modifier_centaur_retaliate_1", "armor")
  self.talents.e1_damage = caster:GetTalentValue("modifier_centaur_retaliate_1", "damage")
  caster:AddAttackEvent_out(self.tracker, true)
end

if caster:HasTalent("modifier_centaur_retaliate_2") then
  self.talents.has_e2 = 1
  self.talents.e2_heal = caster:GetTalentValue("modifier_centaur_retaliate_2", "heal")/100
end

if caster:HasTalent("modifier_centaur_hero_3") then
  self.talents.has_regen = 1
  self.talents.regen_bonus = caster:GetTalentValue("modifier_centaur_hero_3", "regen")/self.talents.regen_max
  self.talents.armor_bonus = caster:GetTalentValue("modifier_centaur_hero_3", "armor")/self.talents.regen_max
end

if caster:HasTalent("modifier_centaur_retaliate_3") then
  self.talents.has_e3 = 1
  self.talents.e3_str = caster:GetTalentValue("modifier_centaur_retaliate_3", "str")
  self.talents.e3_damage = caster:GetTalentValue("modifier_centaur_retaliate_3", "damage")/100
  caster:AddAttackEvent_out(self.tracker, true)
end

if caster:HasTalent("modifier_centaur_retaliate_4") then
  self.talents.has_e4 = 1
  caster:AddAttackEvent_out(self.tracker, true)
end

if caster:HasTalent("modifier_centaur_retaliate_7") then
  self.talents.has_e7 = 1
  caster:AddAttackEvent_out(self.tracker, true)
end

if caster:HasTalent("modifier_centaur_hero_5") then
  self.talents.has_h5 = 1
end

end

function centaur_return_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_centaur_return_custom"
end

function centaur_return_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "centaur_return", self)
end

function centaur_return_custom:OnInventoryContentsChanged()
if not IsServer() then return end
local mod = self:GetCaster():FindModifierByName("modifier_centaur_return_custom")
if not mod then return end
mod:InitShard()
end

function centaur_return_custom:HasActive()
local caster = self:GetCaster()
return self.talents.has_e7 == 1 or self.talents.has_e4 == 1
end

function centaur_return_custom:GetBehavior()
if self:HasActive() then
  return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
end
return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function centaur_return_custom:GetAOERadius()
if not self:HasActive() then return end
return self.talents.e7_radius
end

function centaur_return_custom:GetCastRange(vLocation, hTarget)
if not self:HasActive() then return end
return self.talents.e7_range
end

function centaur_return_custom:GetCooldown(level)
if not self:HasActive() then return end
return self.talents.e7_talent_cd
end

function centaur_return_custom:ProcHeal(damage)
if not IsServer() then return end
local heal = damage*self.talents.e2_heal
if self.caster:HasModifier("modifier_centaur_stampede_custom") then
  heal = heal*self.talents.e2_bonus
end
self.caster:GenericHeal(heal, self, true, "particles/items3_fx/octarine_core_lifesteal.vpcf", "modifier_centaur_retaliate_2")
end

function centaur_return_custom:DealDamage(target, is_attack)
local caster = self:GetCaster()

if caster:PassivesDisabled() then return end
if not IsValid(target) or not target:IsAlive() then return end
if target:IsInvulnerable() then return end
if (target:GetAbsOrigin() - caster:GetAbsOrigin()):Length2D() >= 1200 then return end

local damage_base = self.return_damage
local damage_str = self.return_damage_str + self.talents.e1_damage
local damage = damage_base + damage_str*caster:GetStrength()/100
local shard_chance = self.shard_chance

if self.talents.has_regen == 1 then
  caster:AddNewModifier(caster, self, "modifier_centaur_return_custom_regen", {duration = self.talents.regen_duration})
end

local pfx_name = wearables_system:GetParticleReplacementAbility(caster, "particles/units/heroes/hero_centaur/centaur_return.vpcf", self)

local targets = {}
if is_attack then
  damage = damage * self.talents.e3_damage
  targets = caster:FindTargets(self.talents.e3_radius, target:GetAbsOrigin())
  if target:IsHero() then
    self.caster:AddNewModifier(self.caster, self, "modifier_centaur_return_custom_str", {duration = self.talents.e3_duration})
  end
  target:EmitSound("Centaur.Return_attack")
else
  table.insert(targets, target)
end

local damageTable = { attacker = caster, damage = damage, ability = self, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK + DOTA_DAMAGE_FLAG_REFLECTION}
for _,aoe_target in pairs(targets) do
  if caster:HasShard() and not aoe_target:HasModifier("modifier_centaur_return_custom_target_taunt") and not is_attack
    and not aoe_target:HasModifier("modifier_centaur_return_custom_shard_stun_cd") and RollPseudoRandomPercentage(shard_chance, 1896, aoe_target) then

    aoe_target:AddNewModifier(caster, self, "modifier_bashed", {duration = (1 - aoe_target:GetStatusResistance())*self.shard_stun})
    aoe_target:AddNewModifier(caster, self, "modifier_centaur_return_custom_shard_stun_cd", {duration = self.shard_cd})
    aoe_target:EmitSound("Centaur.Return_shard_bash")
  end

  if aoe_target:IsRealHero() and caster:GetQuest() == "Centaur.Quest_7" and not caster:QuestCompleted() then
    caster:UpdateQuest(1)
  end

  damageTable.victim = aoe_target
  local real_damage = DoDamage(damageTable, is_attack)
  if self.talents.has_e2 == 1 then
    local result = caster:CanLifesteal(aoe_target)
    if result then
      self:ProcHeal(real_damage*result)
    end
  end

  if aoe_target:IsHero() then
    aoe_target:EmitSound("Hero_Centaur.Retaliate.Target")
  end

  local caster_pfx  = ParticleManager:CreateParticle(pfx_name, PATTACH_CUSTOMORIGIN_FOLLOW, caster)
  ParticleManager:SetParticleControlEnt(caster_pfx, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
  ParticleManager:SetParticleControlEnt(caster_pfx, 1, aoe_target, PATTACH_POINT_FOLLOW, "attach_hitloc", aoe_target:GetAbsOrigin(), true)
  ParticleManager:ReleaseParticleIndex(caster_pfx)
end

end


function centaur_return_custom:OnSpellStart()
local caster = self:GetCaster()

caster:RemoveModifierByName("modifier_centaur_return_custom_legendary_speed")

local duration = self.talents.e7_duration + 0.2
local point = self:GetCursorPosition()

caster:StartGesture(ACT_DOTA_CAST_ABILITY_3)

local banner = CreateUnitByName("npc_dota_centaur_banner", point, true, caster, caster, caster:GetTeamNumber())
banner.owner = caster
banner:AddNewModifier(caster, self, "modifier_kill", {duration = duration})
banner:AddNewModifier(caster, self, "modifier_centaur_return_custom_legendary_banner", {duration = duration})
end



modifier_centaur_return_custom_legendary_banner = class(mod_hidden)
function modifier_centaur_return_custom_legendary_banner:OnCreated()
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.radius = self.ability.talents.e7_radius
self.knock_radius = self.ability.talents.e7_knock_radius
self.taunt = self.ability.talents.e4_taunt
self.taunt_timer = self.ability.talents.e4_timer
self.taunt_count = 0

if not IsServer() then return end
self.ability:EndCd()
self.parent:SetMaxHealth(self.ability.talents.e7_health*self.caster:GetMaxHealth())
self.parent:SetHealth(self.parent:GetMaxHealth())

self.parent:EmitSound("Centaur.Return_legendary_banner1")
self.parent:EmitSound("Centaur.Return_legendary_banner2")
self.parent:EmitSound("Centaur.Return_legendary_banner3")

self.targets = {}
if self.ability.talents.has_e7 == 1 then
  for _,target in pairs(self.caster:FindTargets(self.radius, self.parent:GetAbsOrigin(), nil, DOTA_UNIT_TARGET_FLAG_INVULNERABLE)) do
    if not target:IsFieldInvun(self.caster) then
      self.targets[target] = true
      local effect_cast = ParticleManager:CreateParticle( "particles/centaur/return_leash.vpcf", PATTACH_ABSORIGIN, target )
      ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetAbsOrigin() )
      ParticleManager:SetParticleControlEnt(effect_cast, 1, target, PATTACH_POINT_FOLLOW,"attach_hitloc", target:GetOrigin(),true)
      self:AddParticle(effect_cast,false,false,-1,false,false)

      self.targets[target] = effect_cast
    end
  end
end

local pos = self.parent:GetAbsOrigin() + self.parent:GetForwardVector()*10
local qangle = QAngle(0, -90, 0)
pos = RotatePosition(self.parent:GetAbsOrigin(), qangle, pos)

local dir = pos - self.parent:GetAbsOrigin()
self.parent:FaceTowards(pos)
self.parent:SetForwardVector(dir:Normalized())

self.interval = 0.1
self.count = 0
self.particle_count = 0.5
self.particle_number = -1
self.pulse_count = 1
self.stage = 0
self.ability.active_banner = self.parent

self.timer = self.taunt_timer*2 
self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_centaur_return_custom_legendary_banner:CheckState()
return
{
  [MODIFIER_STATE_NO_UNIT_COLLISION] = true
}
end

function modifier_centaur_return_custom_legendary_banner:OnIntervalThink()
if not IsServer() then return end

if not self.parent:IsAlive() then
  self:Destroy()
  return
end

self.pulse_count = self.pulse_count + self.interval

local point = self.parent:GetAbsOrigin()

for _,target in pairs(self.caster:FindTargets(self.radius, point)) do 
  if target:IsRealHero() then
    AddFOWViewer(target:GetTeamNumber(), point, 50, self.interval*2, false)
  end
end

if self.ability.talents.has_e7 == 1 then
  for target,effect in pairs(self.targets) do
    if IsValid(target) and target:IsAlive() and not target:IsFieldInvun(self.caster) then 
      if (point - target:GetAbsOrigin()):Length2D() > self.knock_radius and not target:IsInvulnerable() and not target:IsOutOfGame() and not target:HasModifier("modifier_generic_arc") then 
        target:EmitSound("Centaur.Return_banner_knock")
        self.parent:PullTarget(target, self.ability, self.ability.talents.e7_knock_duration)
      end
    else
      if effect then
        ParticleManager:DestroyParticle(effect, false)
        ParticleManager:ReleaseParticleIndex(effect)
        effect = nil
      end
      self.targets[target] = nil
    end
  end
end

if self.pulse_count >= 0.95 then
  self.pulse_count = 0
  self.parent:EmitSound("Centaur.Return_legendary_pulse")

  local effect_cast = ParticleManager:CreateParticle( "particles/centaur/return_legendary_pulses.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent )
  ParticleManager:SetParticleControlEnt( effect_cast, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, point, true )
  ParticleManager:SetParticleControl( effect_cast, 1, Vector(self.radius,self.radius,self.radius))
  ParticleManager:SetParticleControlEnt( effect_cast, 2, self.parent, PATTACH_POINT_FOLLOW, "torch", point, true )
  ParticleManager:ReleaseParticleIndex( effect_cast )
end

if self.ability.talents.has_e4 == 0 or self.taunt_count >= 2 then return end

local max = self.taunt_timer
if self.stage == 1 then
  max = self.taunt
end

self.count = self.count + self.interval

if self.stage == 0 then
  self.particle_count = self.particle_count + self.interval

  if self.particle_count >= 0.5 then
    self.particle_count = 0
    self.particle_number = self.particle_number + 1

    local number = (self.timer-self.particle_number)/2 
    local int = number
    if number % 1 ~= 0 then 
      int = number - 0.5
    end

    local digits = math.floor(math.log10(number)) + 2
    local decimal = number % 1
    if decimal == 0.5 then
      decimal = 8
    else 
      decimal = 1
    end

    local particle = ParticleManager:CreateParticle("particles/centaur/return_legendary_timer.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
    ParticleManager:SetParticleControl(particle, 0, point)
    ParticleManager:SetParticleControl(particle, 1, Vector(0, int, decimal))
    ParticleManager:SetParticleControl(particle, 2, Vector(digits, 0, 0))
    ParticleManager:ReleaseParticleIndex(particle)
  end
end

if self.count < max then return end

self.count = 0

if self.stage == 0 then
  self.stage = 1
  self.particle_count = 0.5
  self.particle_number = -1
  self.taunt_count = self.taunt_count + 1

  self.parent:EmitSound("Centaur.Return_legendary_taunt")

  local effect_cast = ParticleManager:CreateParticle( "particles/econ/items/axe/axe_ti9_immortal/axe_ti9_call.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
  ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetAbsOrigin() )
  ParticleManager:SetParticleControl( effect_cast, 2, Vector(self.radius,self.radius,self.radius))
  ParticleManager:ReleaseParticleIndex( effect_cast )

  local effect_cast2 = ParticleManager:CreateParticle( "particles/units/heroes/hero_axe/axe_beserkers_call_owner.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
  ParticleManager:SetParticleControlEnt( effect_cast2, 1, self.parent, PATTACH_POINT_FOLLOW, "torch", self.parent:GetAbsOrigin(), true )
  ParticleManager:ReleaseParticleIndex( effect_cast2 )

  if IsValid(self.caster) and self.caster:IsAlive() then
    local targets = self.caster:FindTargets(self.radius, self.parent:GetAbsOrigin())
    for _,target in pairs(targets) do 
      if target:IsHero()then
        target:AddNewModifier(self.caster, self.ability, "modifier_centaur_return_custom_target_taunt", {duration = self.taunt*(1 - target:GetStatusResistance())})
      end
    end
  end
else
  self.stage = 0
end

end

function modifier_centaur_return_custom_legendary_banner:OnDestroy()
if not IsServer() then return end
self.ability:StartCd()
self.parent:Kill(nil, nil)

self.parent:EmitSound("Centaur.Return_legendary_banner_death")
end



modifier_centaur_return_custom = class(mod_hidden)
function modifier_centaur_return_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.retaliate_ability = self.ability

self.ability.return_damage = self.ability:GetSpecialValueFor("return_damage")    
self.ability.return_damage_str = self.ability:GetSpecialValueFor("return_damage_str")
self.ability.shard_spell_cd = self.ability:GetSpecialValueFor("shard_spell_cd")
self.ability.shard_chance = self.ability:GetSpecialValueFor("shard_chance")
self.ability.shard_stun = self.ability:GetSpecialValueFor("shard_stun")
self.ability.shard_cd = self.ability:GetSpecialValueFor("shard_cd")

self.parent:AddAttackEvent_inc(self, true)

self:InitShard()
end

function modifier_centaur_return_custom:OnRefresh()
self.ability.return_damage = self.ability:GetSpecialValueFor("return_damage")    
self.ability.return_damage_str = self.ability:GetSpecialValueFor("return_damage_str")
end

function modifier_centaur_return_custom:InitShard()
if not IsServer() then return end
if self.init_shard then return end
if not self.parent:HasShard() then return end
self.init_shard = true
self.parent:AddDamageEvent_inc(self, true)
end

function modifier_centaur_return_custom:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
  MODIFIER_PROPERTY_ABSORB_SPELL,
}
end

function modifier_centaur_return_custom:GetAbsorbSpell(params) 
if not IsServer() then return end
if self.ability.talents.has_h5 == 0 then return end
if self.parent:PassivesDisabled() then return end
if self.parent:HasModifier("modifier_centaur_return_custom_status_cd") then return end
local attacker = params.ability:GetCaster()

if not attacker then return end
if attacker:GetTeamNumber() == self.parent:GetTeamNumber() then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_centaur_return_custom_status_bonus", {duration = self.ability.talents.h5_duration})
self.parent:AddNewModifier(self.parent, self.ability, "modifier_centaur_return_custom_status_cd", {duration = self.ability.talents.h5_talent_cd})
return false 
end


function modifier_centaur_return_custom:GetModifierStatusResistanceStacking() 
if self.ability.talents.has_h5 == 0 then return end
return self.ability.talents.h5_status*(self.parent:HasModifier("modifier_centaur_return_custom_status_bonus") and self.ability.talents.h5_status_bonus or 1)
end

function modifier_centaur_return_custom:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end
local target = params.target

if self.ability.talents.has_e1 == 1 then
  target:AddNewModifier(self.parent, self.ability, "modifier_centaur_return_custom_armor", {duration = self.ability.talents.e1_duration})
end

if self.ability.talents.has_e3 == 1 and RollPseudoRandomPercentage(self.ability.talents.e3_chance, 334, self.parent) then

  local vec = (target:GetAbsOrigin() - self.parent:GetAbsOrigin()):Normalized()
  vec.z = 0
  local particle_edge_fx = ParticleManager:CreateParticle("particles/centaur/retaliate_attack.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, target)
  ParticleManager:SetParticleControlEnt(particle_edge_fx, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true )
  ParticleManager:SetParticleControlEnt(particle_edge_fx, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true )
  ParticleManager:SetParticleControlForward(particle_edge_fx, 2, vec)
  ParticleManager:SetParticleControl(particle_edge_fx, 5, self.parent:GetAttachmentOrigin(self.parent:ScriptLookupAttachment("attach_hitloc")))
  ParticleManager:SetParticleControlForward(particle_edge_fx, 5, vec)
  ParticleManager:ReleaseParticleIndex(particle_edge_fx)

  self.ability:DealDamage(target, "modifier_centaur_retaliate_3")
end

if self.ability.talents.has_e4 == 1 then
  target:AddNewModifier(self.parent, self.ability, "modifier_centaur_return_custom_slow", {duration = self.ability.talents.e4_slow_duration})
end

if self.ability.talents.has_e7 == 1 and IsValid(self.ability.active_banner) and self.ability.active_banner:IsAlive() then
  local banner = self.ability.active_banner
  banner:GenericHeal(banner:GetMaxHealth()*self.ability.talents.e7_heal, self.ability, true, "")
  if (self.parent:GetAbsOrigin() - banner:GetAbsOrigin()):Length2D() <= self.ability.talents.e7_radius then
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_centaur_return_custom_legendary_speed", {duration = self.ability.talents.e7_effect_duration})
  end
end

end

function modifier_centaur_return_custom:AttackEvent_inc(params)
if not IsServer() then return end
if self.parent:HasShard() then return end
if self.parent ~= params.target then return end
if not params.attacker:IsUnit() then return end

self.ability:DealDamage(params.attacker)
end

function modifier_centaur_return_custom:DamageEvent_inc(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end
if not params.attacker:IsUnit() then return end
if params.attacker:GetTeamNumber() == self.parent:GetTeamNumber() then return end
if params.original_damage <= 1 then return end
if not self.parent:HasShard() then return end

if params.damage_category == DOTA_DAMAGE_CATEGORY_SPELL then 
  if self.parent:HasModifier("modifier_centaur_return_custom_shard_spell_cd") then return end
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_centaur_return_custom_shard_spell_cd", {duration = self.ability.shard_spell_cd})
end

self.ability:DealDamage(params.attacker)
end


modifier_centaur_return_custom_target_taunt = class(mod_hidden)
function modifier_centaur_return_custom_target_taunt:OnCreated( kv )
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()

self.parent:Stop()
self.parent:Interrupt()

self.parent:SetForceAttackTarget( self:GetCaster() )
self.parent:MoveToTargetToAttack( self:GetCaster() )
self:StartIntervalThink(FrameTime())
end

function modifier_centaur_return_custom_target_taunt:OnIntervalThink()
if not IsServer() then return end

if not self.caster or self.caster:IsNull() or not self.caster:IsAlive() 
  or (self.caster:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() >= 1200 then
  self.parent:Stop()
  self.parent:Interrupt()
  self:Destroy()
end

end

function modifier_centaur_return_custom_target_taunt:OnDestroy()
if not IsServer() then return end
self.parent:SetForceAttackTarget( nil )
end

function modifier_centaur_return_custom_target_taunt:CheckState()
return 
{
  [MODIFIER_STATE_TAUNTED] = true,
}
end

function modifier_centaur_return_custom_target_taunt:GetStatusEffectName()
return "particles/status_fx/status_effect_beserkers_call.vpcf"
end

function modifier_centaur_return_custom_target_taunt:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA 
end



modifier_centaur_return_custom_legendary_speed = class(mod_visible)
function modifier_centaur_return_custom_legendary_speed:OnCreated( kv )
self.ability = self:GetAbility()
self.parent = self:GetParent()
self.speed = self.ability.talents.e7_speed
self.max = self.ability.talents.e7_max
self.model = 25/self.max

if not IsServer() then return end
self:OnRefresh()
end

function modifier_centaur_return_custom_legendary_speed:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end

self:IncrementStackCount()
if self:GetStackCount() >= self.max/2 and not self.legendary_particle then
  self.legendary_particle = self.parent:GenericParticle("particles/lc_lowhp.vpcf", self)
end

end

function modifier_centaur_return_custom_legendary_speed:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
  MODIFIER_PROPERTY_MODEL_SCALE
}
end

function modifier_centaur_return_custom_legendary_speed:GetModifierAttackSpeedBonus_Constant()
return self.speed*self:GetStackCount()
end

function modifier_centaur_return_custom_legendary_speed:GetModifierModelScale()
return self.model*self:GetStackCount()
end


modifier_centaur_return_custom_regen = class(mod_visible)
function modifier_centaur_return_custom_regen:GetTexture() return "buffs/centaur/hero_3" end
function modifier_centaur_return_custom_regen:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.max = self.ability.talents.regen_max
self.regen = self.ability.talents.regen_bonus
self.armor = self.ability.talents.armor_bonus

if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_centaur_return_custom_regen:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_centaur_return_custom_regen:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
  MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end

function modifier_centaur_return_custom_regen:GetModifierConstantHealthRegen()
return self:GetStackCount()*self.regen
end

function modifier_centaur_return_custom_regen:GetModifierPhysicalArmorBonus()
return self:GetStackCount()*self.armor
end


modifier_centaur_return_custom_status_bonus = class(mod_hidden)
function modifier_centaur_return_custom_status_bonus:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

if not IsServer() then return end

local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_double_edge_body.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
ParticleManager:ReleaseParticleIndex(particle)

self.parent:EmitSound("Centaur.Return_legendary_caster")
self.parent:GenericParticle("particles/centaur/reuturn_legendary_caster.vpcf", self)
end

function modifier_centaur_return_custom_status_bonus:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_centaur_return_custom_status_bonus:GetModifierIncomingDamage_Percentage()
return self.ability.talents.h5_damage_reduce
end

function modifier_centaur_return_custom_status_bonus:GetStatusEffectName()
return "particles/status_fx/status_effect_overpower.vpcf"
end

function modifier_centaur_return_custom_status_bonus:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA 
end




modifier_centaur_return_custom_armor = class(mod_hidden)
function modifier_centaur_return_custom_armor:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
end

function modifier_centaur_return_custom_armor:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end

function modifier_centaur_return_custom_armor:GetModifierPhysicalArmorBonus()
return self.ability.talents.e1_armor
end



modifier_centaur_return_custom_slow = class(mod_hidden)
function modifier_centaur_return_custom_slow:IsPurgable() return true end
function modifier_centaur_return_custom_slow:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self.parent:GenericParticle("particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap_debuff.vpcf", self)
end

function modifier_centaur_return_custom_slow:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_centaur_return_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.ability.talents.e4_slow
end


modifier_centaur_return_custom_shard_spell_cd = class(mod_hidden)
modifier_centaur_return_custom_shard_stun_cd = class(mod_hidden)

modifier_centaur_return_custom_status_cd = class(mod_cd)
function modifier_centaur_return_custom_status_cd:GetTexture() return "buffs/centaur/hero_5" end


modifier_centaur_return_custom_str = class(mod_visible)
function modifier_centaur_return_custom_str:GetTexture() return "buffs/centaur/retaliate_3" end
function modifier_centaur_return_custom_str:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.max = self.ability.talents.e3_max
self.str = self.ability.talents.e3_str

if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_centaur_return_custom_str:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_centaur_return_custom_str:OnStackCountChanged(iStackCount)
if not IsServer() then return end
self.parent:AddPercentStat({str = self:GetStackCount()*self.str/100}, self)
end

function modifier_centaur_return_custom_str:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_TOOLTIP,
}
end

function modifier_centaur_return_custom_str:OnTooltip()
return self.str*self:GetStackCount()
end