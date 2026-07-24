--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_bristleback_bristleback_custom_tracker", "abilities/bristleback/bristleback_bristleback_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_bristleback_custom_active", "abilities/bristleback/bristleback_bristleback_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_bristleback_custom_make_spray", "abilities/bristleback/bristleback_bristleback_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_bristleback_custom_buff_count", "abilities/bristleback/bristleback_bristleback_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_bristleback_custom_buff_active", "abilities/bristleback/bristleback_bristleback_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_bristleback_custom_taunt_cd", "abilities/bristleback/bristleback_bristleback_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_bristleback_custom_legendary", "abilities/bristleback/bristleback_bristleback_custom", LUA_MODIFIER_MOTION_NONE)

bristleback_bristleback_custom  = class({})
bristleback_bristleback_custom.talents = {}

function bristleback_bristleback_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_back_dmg.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_quill_spray_impact.vpcf", context )
PrecacheResource( "particle", "particles/pangolier/linken_proc.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_back_dmg.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_back_lrg_dmg.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_back_dmg.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_pangolier/pangolier_tailthump_buff.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_egg.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_streaks.vpcf", context )
PrecacheResource( "particle", "particles/pangolier/linken_active.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf", context )
PrecacheResource( "particle", "particles/bloodseeker/thirst_legendary.vpcf", context )
PrecacheResource( "particle", "particles/general/generic_armor_reduction.vpcf", context )
PrecacheResource( "particle", "particles/bristleback/armor_buff.vpcf", context )
PrecacheResource( "particle", "particles/bristleback/back_buff_count.vpcf", context )
PrecacheResource( "particle", "particles/bloodseeker/rite_stun.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_warpath_active_screenfx.vpcf", context )
PrecacheResource( "particle", "particles/bristleback/back_mana.vpcf", context )
PrecacheResource( "particle", "particles/bristleback/back_taunt.vpcf", context )
end

function bristleback_bristleback_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents = 
  {
    has_e1 = 0,
    e1_base = 0,
    e1_damage = 0,
    e1_chance = caster:GetTalentValue("modifier_bristle_back_1", "chance", true),
    e1_damage_reduce = caster:GetTalentValue("modifier_bristle_back_1", "damage_reduce", true)/100,
    e1_damage_type_quill = caster:GetTalentValue("modifier_bristle_back_1", "damage_type_quill", true),
    e1_damage_type = caster:GetTalentValue("modifier_bristle_back_1", "damage_type", true),

    has_e3 = 0,
    e3_health = 0,
    e3_spell = 0,
    e3_bonus = caster:GetTalentValue("modifier_bristle_back_3", "bonus", true),
    e3_stack_duration = caster:GetTalentValue("modifier_bristle_back_3", "stack_duration", true),
    e3_stack = caster:GetTalentValue("modifier_bristle_back_3", "stack", true),
    e3_duration = caster:GetTalentValue("modifier_bristle_back_3", "duration", true),
    
    has_e4 = 0,
    e4_stack_duration = caster:GetTalentValue("modifier_bristle_back_4", "stack_duration", true),
    e4_taunt = caster:GetTalentValue("modifier_bristle_back_4", "taunt", true),
    e4_talent_cd = caster:GetTalentValue("modifier_bristle_back_4", "talent_cd", true),
    e4_damage = caster:GetTalentValue("modifier_bristle_back_4", "damage", true),
    e4_stack = caster:GetTalentValue("modifier_bristle_back_4", "stack", true),
    e4_radius = caster:GetTalentValue("modifier_bristle_back_4", "radius", true),
    
    has_h5 = 0,
    h5_talent_cd = caster:GetTalentValue("modifier_bristle_hero_5", "talent_cd", true),
    h5_duration = caster:GetTalentValue("modifier_bristle_hero_5", "duration", true),
    h5_damage_reduce = caster:GetTalentValue("modifier_bristle_hero_5", "damage_reduce", true),

    has_w7 = 0,
    w7_creeps = caster:GetTalentValue("modifier_bristle_spray_7", "creeps", true),
    w7_mana_inc = caster:GetTalentValue("modifier_bristle_spray_7", "mana_inc", true)/100,

    has_r7 = 0,
  }
end

if caster:HasTalent("modifier_bristle_back_1") then
  self.talents.has_e1 = 1
  self.talents.e1_base = caster:GetTalentValue("modifier_bristle_back_1", "base")
  self.talents.e1_damage = caster:GetTalentValue("modifier_bristle_back_1", "damage")/100
end

if caster:HasTalent("modifier_bristle_back_3") then
  self.talents.has_e3 = 1
  self.talents.e3_health = caster:GetTalentValue("modifier_bristle_back_3", "health")
  self.talents.e3_spell = caster:GetTalentValue("modifier_bristle_back_3", "spell")
  if IsServer() then
    self.tracker:UpdateUI()
    caster:CalculateStatBonus(true)
  end
end

if caster:HasTalent("modifier_bristle_back_4") then
  self.talents.has_e4 = 1
end

if caster:HasTalent("modifier_bristle_back_7") then
  self.talents.has_e7 = 1
end

if caster:HasTalent("modifier_bristle_hero_5") then
  self.talents.has_h5 = 1
end

if caster:HasTalent("modifier_bristle_spray_7") then
  self.talents.has_w7 = 1
end

if caster:HasTalent("modifier_bristle_warpath_7") then
  self.talents.has_r7 = 1
end

end

function bristleback_bristleback_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "bristleback_bristleback", self)
end

function bristleback_bristleback_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_bristleback_bristleback_custom_tracker"
end

function bristleback_bristleback_custom:GetBehavior()
if self.talents.has_h5 == 1 then
  return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end
return DOTA_ABILITY_BEHAVIOR_PASSIVE 
end

function bristleback_bristleback_custom:GetCooldown(iLevel)
if self.talents.has_h5 == 1 then
  return self.talents.h5_talent_cd
end

end

function bristleback_bristleback_custom:OnSpellStart()
self.caster:StartGesture(ACT_DOTA_TELEPORT_END)
self.caster:AddNewModifier(self.caster, self, "modifier_bristleback_bristleback_custom_active", {duration = self.talents.h5_duration + 0.1})
end

function bristleback_bristleback_custom:ProcSlow(target)
if not IsServer() then return end
if not self:IsTrained() then return end
if self.talents.has_e1 == 0 then return end
if not self.caster.spray_ability then return end
if not RollPseudoRandomPercentage(self.talents.e1_chance, 7954, self.caster) then return end

local damage_table = {victim = target, attacker = self.caster, ability = self.caster.spray_ability}
local damage = self.talents.e1_base + self.talents.e1_damage*(self.caster:GetMaxHealth() - self.caster:GetHealth())
local damage_type = self.talents.e1_damage_type

if self.talents.has_w7 == 1 then
  damage = damage * (1 + self.talents.e1_damage_reduce)
  damage_type = self.talents.e1_damage_type_quill
end

damage_table.damage = damage
damage_table.damage_type = damage_type
DoDamage(damage_table, "modifier_bristle_back_1")

target:EmitSound("BB.Quill_proc")
target:GenericParticle("particles/brist_proc.vpcf") 
end

function bristleback_bristleback_custom:GetFacing(attacker)
if not IsServer() then return end
local forwardVector = self.caster:GetForwardVector()
local forwardAngle = math.deg(math.atan2(forwardVector.x, forwardVector.y))
    
local reverseEnemyVector = (self.caster:GetAbsOrigin() - attacker:GetAbsOrigin()):Normalized()
local reverseEnemyAngle = math.deg(math.atan2(reverseEnemyVector.x, reverseEnemyVector.y))

local difference = math.abs(forwardAngle - reverseEnemyAngle)

if self.caster:HasModifier("modifier_bristleback_bristleback_custom_active") then
  return 1
end

if (difference <= (self.back_angle / 1)) or (difference >= (360 - (self.back_angle / 1))) then
  return 1
elseif difference <= self.side_angle or difference >= (360 - (self.side_angle)) then 
  return 2
else
  return 3
end

end


modifier_bristleback_bristleback_custom_tracker = class(mod_hidden)
function modifier_bristleback_bristleback_custom_tracker:OnCreated()
self.ability  = self:GetAbility()
self.parent   = self:GetParent()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.bristleback_ability = self.ability

self.ability.side_damage_reduction = self.ability:GetSpecialValueFor("side_damage_reduction")
self.ability.back_damage_reduction = self.ability:GetSpecialValueFor("back_damage_reduction")
self.ability.quill_release_threshold = self.ability:GetSpecialValueFor("quill_release_threshold")
self.ability.side_angle = self.ability:GetSpecialValueFor("side_angle")
self.ability.back_angle = self.ability:GetSpecialValueFor("back_angle")     
self.ability.quill_interval = self.ability:GetSpecialValueFor("quill_interval") 

self.quill_count = 0

self.parent:AddDamageEvent_inc(self, true)
end

function modifier_bristleback_bristleback_custom_tracker:OnRefresh()
self.ability.side_damage_reduction = self.ability:GetSpecialValueFor("side_damage_reduction")
self.ability.back_damage_reduction = self.ability:GetSpecialValueFor("back_damage_reduction")
self.ability.quill_release_threshold = self.ability:GetSpecialValueFor("quill_release_threshold")
end

function modifier_bristleback_bristleback_custom_tracker:UpdateUI()
if not IsServer() then return end
if self.ability.talents.has_r7 == 1 then return end
if self.ability.talents.has_e3 == 0 then return end

local max = self.ability.talents.e3_stack
local stack = 0
local zero = 0
local active = 0

local mod = self.parent:FindModifierByName("modifier_bristleback_bristleback_custom_buff_count")
if mod then
  stack = mod.stack
else
  mod = self.parent:FindModifierByName("modifier_bristleback_bristleback_custom_buff_active")
  if mod then
    max = self.ability.talents.e3_duration
    stack = mod:GetRemainingTime()
    zero = 1
    active = 1
  end
end

self.parent:UpdateUIlong({max = max, stack = stack, use_zero = zero, priority = 2, active = active, style = "BristBack"})
end

function modifier_bristleback_bristleback_custom_tracker:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
  MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
}
end

function modifier_bristleback_bristleback_custom_tracker:GetModifierSpellAmplify_Percentage()
return self.ability.talents.e3_spell*(self.parent:HasModifier("modifier_bristleback_bristleback_custom_buff_active") and self.ability.talents.e3_bonus or 1)
end

function modifier_bristleback_bristleback_custom_tracker:GetModifierExtraHealthPercentage()
return self.ability.talents.e3_health*(self.parent:HasModifier("modifier_bristleback_bristleback_custom_buff_active") and self.ability.talents.e3_bonus or 1)
end

function modifier_bristleback_bristleback_custom_tracker:GetModifierIncomingDamage_Percentage(params)
if not IsServer() then return end 
if self.parent:PassivesDisabled() and not self.parent:HasModifier("modifier_bristleback_bristleback_custom_active") then return end 
if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then return end 
if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) == DOTA_DAMAGE_FLAG_HPLOSS then return  end

local attacker = params.attacker
if not attacker:IsUnit() then return end

local facing = self.ability:GetFacing(attacker)
local pfx_names = {"particles/units/heroes/hero_bristleback/bristleback_back_dmg.vpcf", "particles/units/heroes/hero_bristleback/bristleback_back_lrg_dmg.vpcf"}

if facing == 1 then
  local particle = ParticleManager:CreateParticle(wearables_system:GetParticleReplacementAbility(self.parent, pfx_names[1], self), PATTACH_ABSORIGIN_FOLLOW, self.parent)
  ParticleManager:SetParticleControl(particle, 1, self.parent:GetAbsOrigin())
  ParticleManager:SetParticleControlEnt(particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
  ParticleManager:ReleaseParticleIndex(particle)

  local particle2 = ParticleManager:CreateParticle(wearables_system:GetParticleReplacementAbility(self.parent, pfx_names[2], self), PATTACH_ABSORIGIN_FOLLOW, self.parent)
  ParticleManager:SetParticleControlEnt(particle2, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
  ParticleManager:ReleaseParticleIndex(particle2)
  
  local sound_name = wearables_system:GetSoundReplacement(self.parent, "Hero_Bristleback.Bristleback", self)
  self.parent:EmitSound(sound_name)

  if self.parent:GetQuest() == "Brist.Quest_7" and attacker:IsRealHero() then 
    self.parent:UpdateQuest(math.floor(params.original_damage))
  end
elseif facing == 2 then 
  local particle = ParticleManager:CreateParticle(pfx_names[1], PATTACH_ABSORIGIN_FOLLOW, self.parent)
  ParticleManager:SetParticleControl(particle, 1, self.parent:GetAbsOrigin())
  ParticleManager:SetParticleControlEnt(particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
  ParticleManager:ReleaseParticleIndex(particle)
end

if self.parent:HasModifier("modifier_bristleback_innate_custom_shield") then return end
return self:GetReduction(facing)
end


function modifier_bristleback_bristleback_custom_tracker:GetReduction(facing)
if not IsServer() then return end
local side_damage_reduction = self.ability.side_damage_reduction + (self.ability.talents.has_h5 == 1 and self.ability.talents.h5_damage_reduce or 0)
local back_damage_reduction = self.ability.back_damage_reduction + (self.ability.talents.has_h5 == 1 and self.ability.talents.h5_damage_reduce or 0)

if facing == 1 then
  return back_damage_reduction
elseif facing == 2 then
  return side_damage_reduction
end
return 0
end

function modifier_bristleback_bristleback_custom_tracker:DamageEvent_inc( params )
if not IsServer() then return end
if not params.attacker:IsUnit() then return end
if params.unit ~= self.parent then return end
if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then return end 
if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) == DOTA_DAMAGE_FLAG_HPLOSS  then return end 
if self.parent:HasModifier("modifier_bristleback_innate_custom_shield") then return end

local attacker = params.attacker

if self.ability:GetFacing(attacker) ~= 1 then return end
self:IncStacks(params.damage, attacker)
end

function modifier_bristleback_bristleback_custom_tracker:IncStacks(stack, attacker)
if not IsServer() then return end
if self.parent:PassivesDisabled() and not self.parent:HasModifier("modifier_bristleback_bristleback_custom_active") then return end

local quill_release_threshold = self.ability.quill_release_threshold + (self.ability.talents.has_e4 == 1 and self.ability.talents.e4_damage or 0)
local add_stack = stack
if self.ability.talents.has_w7 == 1 and (attacker:IsCreep() and not towers[attacker:GetTeamNumber()]) then
  add_stack = add_stack*self.ability.talents.w7_creeps
end

local final = self.quill_count + add_stack
if final >= quill_release_threshold then 
  local delta = math.floor(final/quill_release_threshold)

  if self.parent.spray_ability then
    self.parent.spray_ability:ProcHeal(true)
  end

  if (self.ability.talents.has_e3 == 1 or self.ability.talents.has_e4 == 1) and (not self.parent:HasModifier("modifier_bristleback_bristleback_custom_buff_active") and not self.parent:HasModifier("modifier_bristleback_bristleback_custom_taunt_cd")) then
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_bristleback_bristleback_custom_buff_count", {duration = self.ability.talents.e3_stack_duration})
  end

  if self.ability.talents.has_w7 == 0 then
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_bristleback_bristleback_custom_make_spray", {stack = delta})
  else
    self.parent:GiveMana(self.parent:GetMaxMana()*self.ability.talents.w7_mana_inc)
    self.parent:GenericParticle("particles/bristleback/back_mana.vpcf")
  end
  self.quill_count = final - delta*quill_release_threshold
else 
  self.quill_count = final
end

end


modifier_bristleback_bristleback_custom_make_spray = class(mod_hidden)
function modifier_bristleback_bristleback_custom_make_spray:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.stack = table.stack
self:StartIntervalThink(self.ability.quill_interval)
end

function modifier_bristleback_bristleback_custom_make_spray:OnRefresh(table)
if not IsServer() then return end
self.stack = self.stack + table.stack
end

function modifier_bristleback_bristleback_custom_make_spray:OnIntervalThink()
if not IsServer() then return end

if self.parent.spray_ability then
  self.parent.spray_ability:MakeSpray(nil, true)
end

self.stack = self.stack - 1
if self.stack <= 0 then 
  self:Destroy()
  return
end

end



modifier_bristleback_bristleback_custom_buff_count = class(mod_hidden)
function modifier_bristleback_bristleback_custom_buff_count:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.stack = 0
self.max = self.ability.talents.e3_stack
self.visual_max = self.max
self.particle = self.parent:GenericParticle("particles/bristleback/back_buff_count.vpcf", self, true)
self:OnRefresh()
end

function modifier_bristleback_bristleback_custom_buff_count:OnDestroy()
if not IsServer() then return end

if self.ability.tracker then
  self.ability.tracker:UpdateUI()
end

end

function modifier_bristleback_bristleback_custom_buff_count:OnRefresh()
if not IsServer() then return end
self.stack = self.stack + 1

if self.stack >= self.max then

  if self.ability.talents.has_e3 == 1 then
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_bristleback_bristleback_custom_buff_active", {duration = self.ability.talents.e3_duration})
  end

  if self.ability.talents.has_e4 == 1 then
    local radius = self.ability.talents.e4_radius
    self.parent:EmitSound("BB.Back_taunt")
    self.parent:EmitSound("BB.Back_legendary_active_vo")

    local effect_cast = ParticleManager:CreateParticle("particles/bristleback/back_taunt.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
    ParticleManager:SetParticleControlEnt( effect_cast, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_attack3", Vector(0,0,0), true )
    ParticleManager:SetParticleControl(effect_cast, 2, Vector(radius, radius, radius))
    ParticleManager:ReleaseParticleIndex( effect_cast )

    for _,target in pairs(self.parent:FindTargets(radius)) do
      if target:IsHero() then
        target:AddNewModifier(self.parent, self.parent:BkbAbility(self.ability, true), "modifier_generic_taunt", {duration = (1 - target:GetStatusResistance())*self.ability.talents.e4_taunt})
      end
    end

    self.parent:AddNewModifier(self.parent, self.ability, "modifier_bristleback_bristleback_custom_taunt_cd", {duration = self.ability.talents.e4_talent_cd})
  end
  self:Destroy()
  return
end

if self.ability.tracker then
  self.ability.tracker:UpdateUI()
end

if not self.particle then return end
for i = 1,self.visual_max do 
  if i <= math.floor(self.stack/(self.max/self.visual_max)) then 
    ParticleManager:SetParticleControl(self.particle, i, Vector(1, 0, 0)) 
  else 
    ParticleManager:SetParticleControl(self.particle, i, Vector(0, 0, 0)) 
  end
end

end


modifier_bristleback_bristleback_custom_buff_active = class(mod_visible)
function modifier_bristleback_bristleback_custom_buff_active:GetTexture() return "buffs/bristleback/back_3" end
function modifier_bristleback_bristleback_custom_buff_active:GetStatusEffectName() return "particles/status_fx/status_effect_legion_commander_duel.vpcf" end
function modifier_bristleback_bristleback_custom_buff_active:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH  end
function modifier_bristleback_bristleback_custom_buff_active:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:EmitSound("Lc.Moment_Lowhp")
self.parent:GenericParticle("particles/lc_lowhp.vpcf", self)

self.parent:CalculateStatBonus(true)
self:OnIntervalThink()
self:StartIntervalThink(0.1)
end

function modifier_bristleback_bristleback_custom_buff_active:OnIntervalThink()
if not IsServer() then return end
  
if self.ability.tracker then
  self.ability.tracker:UpdateUI()
end

end

function modifier_bristleback_bristleback_custom_buff_active:OnDestroy()
if not IsServer() then return end
self.parent:CalculateStatBonus(true)

if self.ability.tracker then
  self.ability.tracker:UpdateUI()
end

end

function modifier_bristleback_bristleback_custom_buff_active:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MODEL_SCALE
}
end

function modifier_bristleback_bristleback_custom_buff_active:GetModifierModelScale()
return 15
end



modifier_bristleback_bristleback_custom_active = class(mod_hidden)
function modifier_bristleback_bristleback_custom_active:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:EmitSound("BB.Back_legendary_shield")

local particle_1 = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_tailthump_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(particle_1, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,0), false) 
self:AddParticle(particle_1, false, false, -1, true, false)
ParticleManager:SetParticleControl(particle_1, 3, Vector( 255, 255, 255 ) )

local particle_2 = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_egg.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(particle_2, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,0), false) 
self:AddParticle(particle_2, false, false, -1, true, false)

local particle_3 = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_streaks.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(particle_3, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,0), false) 
self:AddParticle(particle_3, false, false, -1, true, false)

self.RemoveForDuel = true
end


modifier_bristleback_bristleback_custom_taunt_cd = class(mod_cd)
function modifier_bristleback_bristleback_custom_taunt_cd:GetTexture() return "buffs/bristleback/back_4" end



bristleback_quill_spray_custom_legendary = class({})
bristleback_quill_spray_custom_legendary.talents = {}

function bristleback_quill_spray_custom_legendary:CreateTalent()
self:SetHidden(false)
self:SetLevel(1)
end

function bristleback_quill_spray_custom_legendary:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_e7 = 0,
    e7_health = caster:GetTalentValue("modifier_bristle_back_7", "health", true),
    e7_talent_cd = caster:GetTalentValue("modifier_bristle_back_7", "talent_cd", true),
  }
end

end


function bristleback_quill_spray_custom_legendary:Init()
if not self:GetCaster() then return end
self.caster = self:GetCaster()
self:UpdateTalents()
end

function bristleback_quill_spray_custom_legendary:GetCooldown(iLevel)
return self.talents.e7_talent_cd
end 

function bristleback_quill_spray_custom_legendary:OnSpellStart()
self.caster:StartGesture(ACT_DOTA_CAST_ABILITY_3)
self.caster:EmitSound("Hero_Bristleback.Bristleback.Active")

local point = self:GetCursorPosition()
self.caster:AddNewModifier(self.caster, self, "modifier_bristleback_active_conical_quill_spray", {x = point.x, y = point.y, z = point.z})
self.caster:AddNewModifier(self.caster, self, "modifier_bristleback_bristleback_custom_legendary", {})

local bristleback_head = self.caster:GetItemWearableHandle("head")
if bristleback_head then
    bristleback_head:StartGesture(ACT_DOTA_CAST_ABILITY_2)
end

end


modifier_bristleback_bristleback_custom_legendary = class(mod_hidden)
function modifier_bristleback_bristleback_custom_legendary:OnCreated()
if not IsServer() then return end 
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.count = 0
self.max = math.max(1, math.floor((self.parent:GetMaxHealth() - self.parent:GetHealth())/self.ability.talents.e7_health))
self.interval = self.ability:GetSpecialValueFor("activation_spray_interval")
self.quill_spray_ability = self.parent.spray_ability

local number_1 = self.max >= 10 and math.floor(self.max/10) or self.max
local number_2 = self.max >= 10 and (self.max - number_1*10) or 0
local number_3 = self.max >= 10 and 1 or 0

local effect_cast = ParticleManager:CreateParticle("particles/bristleback/spray_double.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent )
ParticleManager:SetParticleControl( effect_cast, 1, Vector(number_1, number_2, number_3 ) )
ParticleManager:ReleaseParticleIndex( effect_cast )

self.ability:EndCd()
self:StartIntervalThink(self.ability:GetSpecialValueFor("activation_delay"))
end 

function modifier_bristleback_bristleback_custom_legendary:OnIntervalThink()
if not IsServer() then return end 

if self.quill_spray_ability and self.quill_spray_ability:IsTrained() then 
  self.parent:FadeGesture(ACT_DOTA_CAST_ABILITY_2)
  self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_2)
  self.quill_spray_ability:MakeSpray(nil, false, true)
end

self.count = self.count + 1

if self.count >= self.max then 
  self:Destroy()
  return
end 

self:StartIntervalThink(self.interval)
end 

function modifier_bristleback_bristleback_custom_legendary:OnDestroy()
if not IsServer() then return end 
self.ability:StartCd()
self.parent:RemoveModifierByName("modifier_bristleback_active_conical_quill_spray")
end 