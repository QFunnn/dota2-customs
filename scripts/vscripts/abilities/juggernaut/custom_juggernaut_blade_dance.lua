--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_juggernaut_blade_dance", "abilities/juggernaut/custom_juggernaut_blade_dance.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_juggernaut_blade_dance_legendary", "abilities/juggernaut/custom_juggernaut_blade_dance.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_juggernaut_blade_dance_anim", "abilities/juggernaut/custom_juggernaut_blade_dance.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_juggernaut_blade_dance_slow", "abilities/juggernaut/custom_juggernaut_blade_dance.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_juggernaut_blade_dance_armor", "abilities/juggernaut/custom_juggernaut_blade_dance.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_juggernaut_blade_dance_illusion", "abilities/juggernaut/custom_juggernaut_blade_dance.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_juggernaut_blade_dance_illusion_damage", "abilities/juggernaut/custom_juggernaut_blade_dance.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_juggernaut_blade_dance_shield_cd", "abilities/juggernaut/custom_juggernaut_blade_dance.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_juggernaut_blade_dance_bonus", "abilities/juggernaut/custom_juggernaut_blade_dance.lua", LUA_MODIFIER_MOTION_NONE)

custom_juggernaut_blade_dance = class({})
custom_juggernaut_blade_dance.talents = {}

function custom_juggernaut_blade_dance:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/units/heroes/hero_mars/mars_shield_bash_crit_strike.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_mars/mars_shield_bash_crit_strike.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_mars/mars_shield_bash.vpcf", context )
PrecacheResource( "particle", "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger.vpcf", context )
PrecacheResource( "particle", "particles/jugger_legendary.vpcf", context )
PrecacheResource( "particle", "particles/lc_lowhp.vpcf", context )

PrecacheResource( "particle", "particles/bloodseeker/thirst_cleave.vpcf", context )
PrecacheResource( "particle", "particles/status_fx/status_effect_huskar_lifebreak.vpcf", context )
PrecacheResource( "particle", "particles/jugg_omni_proc.vpcf", context )
PrecacheResource( "particle", "particles/jugger_stack.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_juggernaut/juggernaut_crit_tgt.vpcf", context )
PrecacheResource( "particle", "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_omni_slash_trail.vpcf", context )
PrecacheResource( "particle", "particles/econ/events/ti10/blink_dagger_start_ti10_lvl2_sparkles.vpcf", context )
PrecacheResource( "particle", "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_omni_dash.vpcf", context )
PrecacheResource( "particle", "particles/items2_fx/sange_maim.vpcf", context )
PrecacheResource( "particle", "particles/juggernaut/dance_shield.vpcf", context )
PrecacheResource( "particle", "particles/juggernaut/dance_shield_purge.vpcf", context )
end

function custom_juggernaut_blade_dance:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_e1 = 0,
    e1_speed = 0,
    e1_chance = 0,
    
    has_e2 = 0,
    e2_cleave = 0,
    e2_range = 0,
    
    has_e3 = 0,
    e3_agi = 0,
    e3_damage = 0,
    e3_attacks = caster:GetTalentValue("modifier_juggernaut_bladedance_3", "attacks", true),
    e3_speed = caster:GetTalentValue("modifier_juggernaut_bladedance_3", "speed", true),
    e3_move = caster:GetTalentValue("modifier_juggernaut_bladedance_3", "move", true),
    e3_duration = caster:GetTalentValue("modifier_juggernaut_bladedance_3", "duration", true),
    
    has_e4 = 0,
    e4_heal = caster:GetTalentValue("modifier_juggernaut_bladedance_4", "heal", true)/100,
    e4_bonus = caster:GetTalentValue("modifier_juggernaut_bladedance_4", "bonus", true),
    e4_duration = caster:GetTalentValue("modifier_juggernaut_bladedance_4", "duration", true),
    e4_armor = caster:GetTalentValue("modifier_juggernaut_bladedance_4", "armor", true),
    
    has_e7 = 0,
    e7_talent_cd = caster:GetTalentValue("modifier_juggernaut_bladedance_7", "talent_cd", true),
    e7_status = caster:GetTalentValue("modifier_juggernaut_bladedance_7", "status", true),
    e7_damage = caster:GetTalentValue("modifier_juggernaut_bladedance_7", "damage", true),
    e7_duration = caster:GetTalentValue("modifier_juggernaut_bladedance_7", "duration", true),
    e7_blade_fury = caster:GetTalentValue("modifier_juggernaut_bladedance_7", "blade_fury", true),
    e7_damage_max = caster:GetTalentValue("modifier_juggernaut_bladedance_7", "damage_max", true),
    
    has_h3 = 0,
    h3_move = 0,
    h3_slow = 0,
    h3_duration = caster:GetTalentValue("modifier_juggernaut_hero_3", "duration", true),
    
    has_h6 = 0,
    h6_talent_cd = caster:GetTalentValue("modifier_juggernaut_hero_6", "talent_cd", true),
    h6_cd_inc = caster:GetTalentValue("modifier_juggernaut_hero_6", "cd_inc", true),
    h6_base = caster:GetTalentValue("modifier_juggernaut_hero_6", "base", true),
    h6_shield = caster:GetTalentValue("modifier_juggernaut_hero_6", "shield", true),

    has_r1 = 0,
    r1_damage = 0,
    r1_duration = caster:GetTalentValue("modifier_juggernaut_omnislash_1", "duration", true),
    r1_max = caster:GetTalentValue("modifier_juggernaut_omnislash_1", "max", true),
  }
end

if caster:HasTalent("modifier_juggernaut_bladedance_1") then
  self.talents.has_e1 = 1
  self.talents.e1_speed = caster:GetTalentValue("modifier_juggernaut_bladedance_1", "speed")
  self.talents.e1_chance = caster:GetTalentValue("modifier_juggernaut_bladedance_1", "chance")
end

if caster:HasTalent("modifier_juggernaut_bladedance_2") then
  self.talents.has_e2 = 1
  self.talents.e2_cleave = caster:GetTalentValue("modifier_juggernaut_bladedance_2", "cleave")/100
  self.talents.e2_range = caster:GetTalentValue("modifier_juggernaut_bladedance_2", "range")
end

if caster:HasTalent("modifier_juggernaut_bladedance_3") then
  self.talents.has_e3 = 1
  self.talents.e3_agi = caster:GetTalentValue("modifier_juggernaut_bladedance_3", "agi")
  self.talents.e3_damage = caster:GetTalentValue("modifier_juggernaut_bladedance_3", "damage")
  if IsServer() then
    caster:AddPercentStat({agi = self.talents.e3_agi/100}, self.tracker)
  end
end

if caster:HasTalent("modifier_juggernaut_bladedance_4") then
  self.talents.has_e4 = 1
  caster:AddDamageEvent_out(self.tracker, true)
end

if caster:HasTalent("modifier_juggernaut_bladedance_7") then
  self.talents.has_e7 = 1
end

if caster:HasTalent("modifier_juggernaut_hero_3") then
  self.talents.has_h3 = 1
  self.talents.h3_move = caster:GetTalentValue("modifier_juggernaut_hero_3", "move")
  self.talents.h3_slow = caster:GetTalentValue("modifier_juggernaut_hero_3", "slow")
end

if caster:HasTalent("modifier_juggernaut_hero_6") then
  self.talents.has_h6 = 1
  if IsServer() and not self.shield_init then
    self.shield_init = true
    self.tracker:StartIntervalThink(1)
  end
end

if caster:HasTalent("modifier_juggernaut_omnislash_1") then
  self.talents.has_r1 = 1
  self.talents.r1_damage = caster:GetTalentValue("modifier_juggernaut_omnislash_1", "damage")
end

end

function custom_juggernaut_blade_dance:GetIntrinsicModifierName() 
return "modifier_custom_juggernaut_blade_dance" 
end

function custom_juggernaut_blade_dance:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "juggernaut_blade_dance", self)
end

function custom_juggernaut_blade_dance:GetBehavior()
if self.talents.has_e7 == 1 then
  return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end
return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function custom_juggernaut_blade_dance:GetCooldown(iLevel)
if self.talents.has_e7 == 1 then 
  return self.talents.e7_talent_cd
end 

end

function custom_juggernaut_blade_dance:OnAbilityPhaseStart()
local caster = self:GetCaster()
caster:AddNewModifier(caster, self, "modifier_custom_juggernaut_blade_dance_anim", {})
caster:StartGesture(ACT_DOTA_ATTACK_EVENT)
return true 
end

function custom_juggernaut_blade_dance:OnAbilityPhaseInterrupted()
local caster = self:GetCaster()
caster:FadeGesture(ACT_DOTA_ATTACK_EVENT)
caster:RemoveModifierByName("modifier_custom_juggernaut_blade_dance_anim")
end

function custom_juggernaut_blade_dance:OnSpellStart()
local caster = self:GetCaster()

caster:RemoveModifierByName("modifier_custom_juggernaut_blade_dance_anim")
caster:EmitSound("Hero_Juggernaut.ArcanaTrigger")
caster:EmitSound("Juggernaut.ShockWave")

local range = 300
local enemies = caster:FindTargets(range) 

local origin = caster:GetOrigin()
local cast_direction = (caster:GetAbsOrigin() + caster:GetForwardVector()*range - origin):Normalized()
local cast_angle = VectorToAngles( cast_direction ).y
local angle = 140 / 2

for _,enemy in pairs(enemies) do
  local enemy_direction = (enemy:GetOrigin() - origin):Normalized()
  local enemy_angle = VectorToAngles( enemy_direction ).y
  local angle_diff = math.abs( AngleDiff( cast_angle, enemy_angle ) )

  if angle_diff <= angle then
    local effect = ParticleManager:CreateParticle( "particles/units/heroes/hero_mars/mars_shield_bash_crit_strike.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy )
    ParticleManager:SetParticleControl( effect, 0, enemy:GetOrigin() )
    ParticleManager:SetParticleControl( effect, 1, enemy:GetOrigin() )
    ParticleManager:SetParticleControlForward( effect, 1, (enemy:GetOrigin() - caster:GetAbsOrigin()):Normalized() )
    ParticleManager:ReleaseParticleIndex( effect )
  end
end

local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_mars/mars_shield_bash.vpcf", PATTACH_WORLDORIGIN, caster )
ParticleManager:SetParticleControl( effect_cast, 0, caster:GetOrigin() )
ParticleManager:SetParticleControl( effect_cast, 1, Vector(range,range,range) )
ParticleManager:SetParticleControlForward( effect_cast, 0, cast_direction )
ParticleManager:ReleaseParticleIndex( effect_cast )

caster:AddNewModifier(caster, self, "modifier_custom_juggernaut_blade_dance_legendary", {duration = self.talents.e7_duration})
end

function custom_juggernaut_blade_dance:GetCrit(ignore_random)
if not IsServer() then return end
local caster = self:GetCaster()

if caster:PassivesDisabled() and self.talents.has_e4 == 0 then return end

local damage = self.damage
local mod  = caster:FindModifierByName("modifier_custom_juggernaut_blade_dance_legendary")
if mod then
  damage = math.min(self.talents.e7_damage_max, damage + mod.stack*self.talents.e7_damage)
end

if ignore_random then
  return damage
end
local chance = self.chance + self.talents.e1_chance
local index = 1392
if IsValid(caster.omnislash_ability) and caster:HasModifier("modifier_custom_juggernaut_omnislash_attack") then
  chance = chance*caster.omnislash_ability.crit_bonus
  index = 1393
end

if caster:HasModifier("modifier_custom_juggernaut_blade_dance_illusion_damage") then return end
if not RollPseudoRandomPercentage(chance, index, caster) then return end

return damage
end

function custom_juggernaut_blade_dance:CasterProc(is_fury)
if not IsServer() then return end
local caster = self:GetCaster()

local legendary_mod = caster:FindModifierByName("modifier_custom_juggernaut_blade_dance_legendary")
if legendary_mod then
  local bonus = is_fury and (1/self.talents.e7_blade_fury) or 1
  legendary_mod.stack = legendary_mod.stack + bonus
end

if not is_fury and self.talents.has_r1 == 1 then
  caster:AddNewModifier(caster, self, "modifier_custom_juggernaut_blade_dance_bonus", {duration = self.talents.r1_duration})
end

if IsValid(caster.swift_ability) then
  caster:CdAbility(caster.swift_ability, caster.swift_ability.cd_inc)
end

local mod = caster:FindModifierByName("modifier_custom_juggernaut_blade_dance_shield_cd")
if not mod then return end

local new_cd = mod:GetRemainingTime() + self.talents.h6_cd_inc
if new_cd <= 0 then
  mod:Destroy()
  return
end
mod:SetDuration(new_cd, true)
end

function custom_juggernaut_blade_dance:ProcCrit(target)
if not IsServer() then return end
local caster = self:GetCaster()

if self.talents.has_h3 == 1 then
  target:AddNewModifier(caster, self, "modifier_custom_juggernaut_blade_dance_slow", {duration = self.talents.h3_duration})
end

end



modifier_custom_juggernaut_blade_dance_anim = class(mod_hidden)
function modifier_custom_juggernaut_blade_dance_anim:DeclareFunctions() 
return 
{ 
  MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS 
} 
end

function modifier_custom_juggernaut_blade_dance_anim:GetActivityTranslationModifiers() 
return "ti8" 
end


modifier_custom_juggernaut_blade_dance_legendary = class(mod_hidden)
function modifier_custom_juggernaut_blade_dance_legendary:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self.RemoveForDuel = true
self.ability:EndCd()
self.parent:GenericParticle("particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger.vpcf", self)
self.parent:GenericParticle("particles/lc_lowhp.vpcf", self)

self.stack = 0
self.max_time = self.ability.talents.e7_duration
self:OnIntervalThink()
self:StartIntervalThink(0.1)
end

function modifier_custom_juggernaut_blade_dance_legendary:OnIntervalThink()
if not IsServer() then return end

self.parent:UpdateUIshort({max_time = self.max_time, time = self:GetRemainingTime(), stack = math.floor(self.ability:GetCrit(true)).."%", priority = 2, style = "JuggernautDance"})
end

function modifier_custom_juggernaut_blade_dance_legendary:OnDestroy()
if not IsServer() then return end
self.parent:UpdateUIshort({hide = 1, hide_full = 1, priority = 2, style = "JuggernautDance"})
self.ability:StartCd()
end

function modifier_custom_juggernaut_blade_dance_legendary:GetStatusEffectName() return "particles/status_fx/status_effect_monkey_king_fur_army.vpcf" end
function modifier_custom_juggernaut_blade_dance_legendary:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH end
function modifier_custom_juggernaut_blade_dance_legendary:DeclareFunctions()
return
{ 
  MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
  MODIFIER_PROPERTY_MODEL_SCALE,
  MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
}
end

function modifier_custom_juggernaut_blade_dance_legendary:GetModifierModelScale()
return 20
end

function modifier_custom_juggernaut_blade_dance_legendary:GetModifierStatusResistanceStacking() 
return self.ability.talents.e7_status
end

function modifier_custom_juggernaut_blade_dance_legendary:GetActivityTranslationModifiers() 
return "chase"
end

function modifier_custom_juggernaut_blade_dance_legendary:GetEffectName() 
return "particles/jugger_legendary.vpcf"
end



modifier_custom_juggernaut_blade_dance = class(mod_hidden)
function modifier_custom_juggernaut_blade_dance:GetCritDamage()
return self.ability:GetCrit(true)
end
 
function modifier_custom_juggernaut_blade_dance:DeclareFunctions() 
return 
{
  MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
  MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
  MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
} 
end

function modifier_custom_juggernaut_blade_dance:GetModifierAttackRangeBonus()
return self.ability.talents.e2_range
end 

function modifier_custom_juggernaut_blade_dance:GetModifierAttackSpeedBonus_Constant()
return self.ability.talents.e1_speed
end 

function modifier_custom_juggernaut_blade_dance:GetModifierMoveSpeedBonus_Constant()
return self.ability.talents.h3_move
end 

function modifier_custom_juggernaut_blade_dance:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.bladedance_ability = self.ability

self.ability.chance = self.ability:GetSpecialValueFor("chance")
self.ability.damage = self.ability:GetSpecialValueFor("damage")
self.record = nil

if not IsServer() then return end
if not self.parent:IsRealHero() then return end

self.parent:AddAttackEvent_out(self, true)
self:UpdateEffects()
end

function modifier_custom_juggernaut_blade_dance:OnRefresh()
self.ability.damage = self.ability:GetSpecialValueFor("damage")
self:UpdateEffects()
end

function modifier_custom_juggernaut_blade_dance:UpdateEffects()
if not IsServer() then return end
if not self.parent:IsRealHero() then return end
self.sound = wearables_system:GetSoundReplacement(self.parent, "Hero_Juggernaut.BladeDance", self)
self.effect = wearables_system:GetParticleReplacementAbility(self.parent, "particles/units/heroes/hero_juggernaut/jugg_crit_blur.vpcf", self)
self.effect_2 = wearables_system:GetParticleReplacementAbility(self.parent, "particles/units/heroes/hero_juggernaut/juggernaut_crit_tgt.vpcf", self)
end

function modifier_custom_juggernaut_blade_dance:PlayEffect(target, auto)
if not IsServer() then return end
local mod = self
if self.parent.owner then
  mod = self.parent.owner:FindModifierByName(self:GetName())
end

if not mod then return end
target:EmitSound(mod.sound)

--if mod.effect ~= "particles/units/heroes/hero_juggernaut/jugg_crit_blur.vpcf" and not auto then
--  self.parent:GenericParticle(mod.effect)
--end

local particle_crit = ParticleManager:CreateParticle(mod.effect_2, PATTACH_ABSORIGIN_FOLLOW, target)
ParticleManager:SetParticleControlEnt(particle_crit, 1, target, PATTACH_ABSORIGIN_FOLLOW, nil, target:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(particle_crit)
end

function modifier_custom_juggernaut_blade_dance:GetModifierPreAttack_CriticalStrike( params )
if not IsServer() then return end
if self.parent:HasModifier("modifier_custom_juggernaut_blade_dance_illusion") then return end

local target = params.target
self.record = nil

if target:GetTeamNumber() == self.parent:GetTeamNumber() then return end

local crit = self.ability:GetCrit(self.force_crit)
if not crit then return end

self.record = params.record
return crit
end

function modifier_custom_juggernaut_blade_dance:AttackEvent_out(params)
if not IsServer() then return end
if not params.target:IsUnit() then return end

local target = params.target
local real_attacker = params.attacker
local attacker = params.attacker
if attacker.owner then
  attacker = attacker.owner
end

if attacker == self.parent then
  local force_effect = false
  local illusion_mod = real_attacker:FindModifierByName("modifier_custom_juggernaut_blade_dance_illusion")
  if illusion_mod and illusion_mod.attack_count and illusion_mod.attack_count > 0 then
    illusion_mod.attack_count = illusion_mod.attack_count - 1
    if illusion_mod.attack_count == 0 then
      illusion_mod:SetDuration(0.2, false)
    end
    if illusion_mod.record then
      illusion_mod.record = nil
      self.force_crit = true
      force_effect = true
    end

    self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_juggernaut_blade_dance_illusion_damage", {})
    self.parent:PerformAttack(target, true, true, true, true, false, false, true, {attack = "jugg_illusion"})
    self.parent:RemoveModifierByName("modifier_custom_juggernaut_blade_dance_illusion_damage")
    self.force_crit = nil
  end

  local mod = real_attacker:FindModifierByName(self:GetName())
  if (mod and mod.record == params.record) then
    mod:PlayEffect(target, params.no_attack_cooldown)
  end
end

if real_attacker ~= self.parent then return end

if self.ability.talents.has_e2 == 1 then 
  DoCleaveAttack(self.parent, target, nil, params.damage * self.ability.talents.e2_cleave , 150, 360, 650, "particles/bloodseeker/thirst_cleave.vpcf" )
end

local mod = self.parent:FindModifierByName("modifier_custom_juggernaut_blade_dance_legendary")
if mod and (not params.attack_flag or params.attack_flag ~= "jugg_illusion") then
  mod:SetDuration(self.ability.talents.e7_duration, true)
end

if params.record ~= self.record then return end

if (self.parent:GetQuest() == "Jugg.Quest_6") and target:IsRealHero() then 
  self.parent:UpdateQuest(1)
end

if self.ability.talents.has_e4 == 1 then
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_juggernaut_blade_dance_armor", {duration = self.ability.talents.e4_duration})
end

if self.ability.talents.has_e3 == 1 and not IsValid(self.ability.active_illusion) then

  local duration = self.ability.talents.e3_duration
  local damage = -100
  local illusion = CreateIllusions(self.parent, self.parent, {duration = duration, outgoing_damage = damage, incoming_damage = 0}, 1, 0, false, true)  

  for _,illusion in pairs(illusion) do
    for _,mod in pairs(self.parent:FindAllModifiers()) do
        if mod.StackOnIllusion ~= nil and mod.StackOnIllusion == true then
            illusion:UpgradeIllusion(mod:GetName(), mod:GetStackCount() )
        end
    end
    illusion.owner = self.parent
    FindClearSpaceForUnit(illusion, target:GetAbsOrigin() + RandomVector(200), false)
    illusion:AddNewModifier(self.parent, self.ability, "modifier_custom_juggernaut_blade_dance_illusion", {target = target:entindex()})
  end
end

self.ability:CasterProc()
self.ability:ProcCrit(target)         
end

function modifier_custom_juggernaut_blade_dance:DamageEvent_out(params)
if not IsServer() then return end 
if self.ability.talents.has_e4 == 0 then return end

local result = self.parent:CheckLifesteal(params, 2)
if not result then return end

local bonus = (params.attack_damage_flag and params.attack_damage_flag == "jugg_omnislash") and self.ability.talents.e4_bonus or 1
self.parent:GenericHeal(result*self.ability.talents.e4_heal*params.damage*bonus, self.ability, true, nil, "modifier_juggernaut_bladedance_4")
end 

function modifier_custom_juggernaut_blade_dance:OnIntervalThink()
if not IsServer() then return end
if self.ability.talents.has_h6 == 0 then return end
if not self.parent:IsAlive() then return end
if IsValid(self.ability.shield_mod) then return end
if self.parent:HasModifier("modifier_custom_juggernaut_blade_dance_shield_cd") then return end

self.ability.shield_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_shield",
{
  max_shield = self.ability.talents.h6_base + self.ability.talents.h6_shield*self.parent:GetMaxHealth()/100,
  start_full = 1,
  shield_talent = "modifier_juggernaut_hero_6",
  refresh_timer = 6,
})

if self.ability.shield_mod then
  self.parent:EmitSound("Juggernaut.Shield_start")
  self.parent:GenericParticle("particles/juggernaut/dance_shield.vpcf", self.ability.shield_mod)

  self.ability.shield_mod:SetEndFunction(function()
    self.parent:Purge(false, true, false, true, true)
    self.parent:EmitSound("Juggernaut.Shield_end")
    self.parent:GenericParticle("particles/juggernaut/dance_shield_purge.vpcf")
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_juggernaut_blade_dance_shield_cd", {duration = self.ability.talents.h6_talent_cd})
  end)
end

end


modifier_custom_juggernaut_blade_dance_slow = class(mod_hidden)
function modifier_custom_juggernaut_blade_dance_slow:IsPurgable() return true end
function modifier_custom_juggernaut_blade_dance_slow:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.slow = self.ability.talents.h3_slow
if not IsServer() then return end 
self.parent:EmitSound("DOTA_Item.Maim")
self.parent:GenericParticle("particles/items2_fx/sange_maim.vpcf", self)
end 

function modifier_custom_juggernaut_blade_dance_slow:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_custom_juggernaut_blade_dance_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end


modifier_custom_juggernaut_blade_dance_armor = class(mod_hidden)
function modifier_custom_juggernaut_blade_dance_armor:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.armor = self.ability.talents.e4_armor
self.parent:AddDamageEvent_inc(self, true)
end

function modifier_custom_juggernaut_blade_dance_armor:DamageEvent_inc(params)
if not IsServer() then return end
if self.on_cd then return end
if params.inflictor then return end
if self.parent ~= params.unit then return end

self.parent:EmitSound("Juggernaut.Parry")
local particle = ParticleManager:CreateParticle( "particles/jugg_parry.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
ParticleManager:SetParticleControl( particle, 1, self.parent:GetAbsOrigin() )
ParticleManager:ReleaseParticleIndex(particle)

self.on_cd = true
self:StartIntervalThink(0.3)
end

function modifier_custom_juggernaut_blade_dance_armor:OnIntervalThink()
if not IsServer() then return end
self.on_cd = false
self:StartIntervalThink(-1)
end

function modifier_custom_juggernaut_blade_dance_armor:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end

function modifier_custom_juggernaut_blade_dance_armor:GetModifierPhysicalArmorBonus()
return self.armor
end



modifier_custom_juggernaut_blade_dance_illusion = class(mod_hidden)
function modifier_custom_juggernaut_blade_dance_illusion:OnCreated(params)
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self.parent:EmitSound("Juggernaut.Crit_illusion")

self.ability.active_illusion = self.parent
self.attack_count = self.ability.talents.e3_attacks

self.target = EntIndexToHScript(params.target)
self:OnIntervalThink()
self:StartIntervalThink(0.5)

self.parent:AddAttackRecordEvent_out(self)
end 

function modifier_custom_juggernaut_blade_dance_illusion:AttackRecordEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

self.record = nil
if not self.ability:GetCrit() then return end

self.record = true
self.parent:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK_EVENT, 1.4)
end

function modifier_custom_juggernaut_blade_dance_illusion:OnIntervalThink()
if not IsServer() then return end

if self.target and not self.target:IsNull() and self.target:IsAlive() then
  if self.parent:GetForceAttackTarget() == nil then  
    self.parent:SetForceAttackTarget(self.target)
  end
else 
  if self.parent:GetForceAttackTarget() then
    self.parent:SetForceAttackTarget(nil)
    self.parent:MoveToPositionAggressive(self.parent:GetAbsOrigin())
  end
end 

end 

function modifier_custom_juggernaut_blade_dance_illusion:OnDestroy()
if not IsServer() then return end
self.parent:Kill(nil, nil)
self.ability.active_illusion = nil
end

function modifier_custom_juggernaut_blade_dance_illusion:CheckState()
return
{
  [MODIFIER_STATE_NO_HEALTH_BAR] = true,
  [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
  [MODIFIER_STATE_OUT_OF_GAME] = true,
  [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
  [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
  [MODIFIER_STATE_UNSELECTABLE] = true,
  [MODIFIER_STATE_UNTARGETABLE] = true,
  [MODIFIER_STATE_INVULNERABLE] = true
}
end

function modifier_custom_juggernaut_blade_dance_illusion:GetStatusEffectName() return "particles/status_fx/status_effect_monkey_king_fur_army.vpcf" end
function modifier_custom_juggernaut_blade_dance_illusion:StatusEffectPriority() return MODIFIER_PRIORITY_ILLUSION end
function modifier_custom_juggernaut_blade_dance_illusion:GetEffectName() return "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_body_ambient.vpcf" end
function modifier_custom_juggernaut_blade_dance_illusion:GetEffectAttachType() return PATTACH_ABSORIGIN_FOLLOW end

function modifier_custom_juggernaut_blade_dance_illusion:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
  MODIFIER_PROPERTY_FIXED_ATTACK_RATE,
  MODIFIER_PROPERTY_MODEL_SCALE
}
end

function modifier_custom_juggernaut_blade_dance_illusion:GetModifierFixedAttackRate()
return self.ability.talents.e3_speed
end

function modifier_custom_juggernaut_blade_dance_illusion:GetModifierMoveSpeed_Absolute()
return self.ability.talents.e3_move
end

function modifier_custom_juggernaut_blade_dance_illusion:GetModifierModelScale()
return 20
end


modifier_custom_juggernaut_blade_dance_illusion_damage = class(mod_hidden)
function modifier_custom_juggernaut_blade_dance_illusion_damage:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.damage = self.ability.talents.e3_damage - 100
end

function modifier_custom_juggernaut_blade_dance_illusion_damage:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
}
end

function modifier_custom_juggernaut_blade_dance_illusion_damage:GetModifierTotalDamageOutgoing_Percentage(params)
if params.inflictor then return end
return self.damage
end


modifier_custom_juggernaut_blade_dance_shield_cd = class(mod_cd)
function modifier_custom_juggernaut_blade_dance_shield_cd:GetTexture() return "buffs/juggernaut/hero_7" end
function modifier_custom_juggernaut_blade_dance_shield_cd:OnDestroy()
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not self.ability.tracker then return end
self.ability.tracker:OnIntervalThink()
end



modifier_custom_juggernaut_blade_dance_bonus = class(mod_visible)
function modifier_custom_juggernaut_blade_dance_bonus:GetTexture() return "buffs/juggernaut/omnislash_1" end
function modifier_custom_juggernaut_blade_dance_bonus:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.damage = self.ability.talents.r1_damage
if not IsServer() then return end
self:OnRefresh()
end

function modifier_custom_juggernaut_blade_dance_bonus:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.ability.talents.r1_max then return end
self:IncrementStackCount()
end

function modifier_custom_juggernaut_blade_dance_bonus:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
}
end

function modifier_custom_juggernaut_blade_dance_bonus:GetModifierPreAttack_BonusDamage()
return self.damage*self:GetStackCount()
end