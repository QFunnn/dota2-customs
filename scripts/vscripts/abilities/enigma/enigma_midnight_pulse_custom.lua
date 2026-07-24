--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_enigma_midnight_pulse_custom", "abilities/enigma/enigma_midnight_pulse_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_enigma_midnight_pulse_custom_silence", "abilities/enigma/enigma_midnight_pulse_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_enigma_midnight_pulse_custom_move", "abilities/enigma/enigma_midnight_pulse_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_enigma_midnight_pulse_custom_tracker", "abilities/enigma/enigma_midnight_pulse_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_enigma_midnight_pulse_custom_debuff", "abilities/enigma/enigma_midnight_pulse_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_enigma_midnight_pulse_custom_channel", "abilities/enigma/enigma_midnight_pulse_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_enigma_midnight_pulse_custom_can_channel", "abilities/enigma/enigma_midnight_pulse_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_enigma_midnight_pulse_custom_channel_pull", "abilities/enigma/enigma_midnight_pulse_custom", LUA_MODIFIER_MOTION_HORIZONTAL )

enigma_midnight_pulse_custom = class({})
enigma_midnight_pulse_custom.talents = {}

function enigma_midnight_pulse_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/enigma/midnight_pulse.vpcf", context )
PrecacheResource( "particle", "particles/enigma/midnight_charge.vpcf", context )
PrecacheResource( "particle", "particles/enigma/malefice_pull_field.vpcf", context )
PrecacheResource( "particle", "particles/enigma/malefice_pull_caster.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_lone_druid/lone_druid_savage_roar_debuff.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_dmg.vpcf", context )
PrecacheResource( "particle", "particles/enigma/midnight_status.vpcf", context )
PrecacheResource( "particle", "particles/enigma/midnight_speed_aura.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_dark_seer/dark_seer_surge.vpcf", context )
PrecacheResource( "particle", "particles/enigma/midnight_speed.vpcf", context )
PrecacheResource( "particle", "particles/enigma/midnight_pull_target.vpcf", context )

end

function enigma_midnight_pulse_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_e1 = 0,
    e1_creeps = 0,
    e1_damage = 0,
    e1_magic = 0,

    e2_radius = 0,
    e2_cd = 0,

    has_e3 = 0,
    e3_damage = 0,
    e3_base = 0,
    e3_heal = caster:GetTalentValue("modifier_enigma_midnight_3", "heal", true)/100,
    e3_chance = caster:GetTalentValue("modifier_enigma_midnight_3", "chance", true),
    e3_bonus = caster:GetTalentValue("modifier_enigma_midnight_3", "bonus", true),
    e3_health = caster:GetTalentValue("modifier_enigma_midnight_3", "health", true),
    e3_damage_type = caster:GetTalentValue("modifier_enigma_midnight_3", "damage_type", true),

    has_e4 = 0,
    e4_health = 0,
    e4_heal = caster:GetTalentValue("modifier_enigma_midnight_4", "heal", true)/100,

    has_h5 = 0,
    h5_duration = caster:GetTalentValue("modifier_enigma_hero_5", "duration", true),
    h5_slow = caster:GetTalentValue("modifier_enigma_hero_5", "slow", true),
    h5_speed = caster:GetTalentValue("modifier_enigma_hero_5", "speed", true),

    has_e7 = 0,
    e7_duration = caster:GetTalentValue("modifier_enigma_midnight_7", "duration", true),
    e7_invun = caster:GetTalentValue("modifier_enigma_midnight_7", "invun", true),
    e7_damage = caster:GetTalentValue("modifier_enigma_midnight_7", "damage", true)/100,

    has_r3 = 0,
    r3_radius = caster:GetTalentValue("modifier_enigma_blackhole_3", "radius", true)
  }
end

if caster:HasTalent("modifier_enigma_midnight_1") then
  self.talents.e1_creeps = caster:GetTalentValue("modifier_enigma_midnight_1", "creeps")
  self.talents.e1_magic = caster:GetTalentValue("modifier_enigma_midnight_1", "magic")
  self.talents.e1_damage = caster:GetTalentValue("modifier_enigma_midnight_1", "damage")/100
end

if caster:HasTalent("modifier_enigma_midnight_2") then
  self.talents.e2_radius = caster:GetTalentValue("modifier_enigma_midnight_2", "radius")
  self.talents.e2_cd = caster:GetTalentValue("modifier_enigma_midnight_2", "cd")
end

if caster:HasTalent("modifier_enigma_midnight_3") then
  self.talents.has_e3 = 1
  self.talents.e3_damage = caster:GetTalentValue("modifier_enigma_midnight_3", "damage")/100
  self.talents.e3_base = caster:GetTalentValue("modifier_enigma_midnight_3", "base")
end

if caster:HasTalent("modifier_enigma_midnight_4") then
  self.talents.has_e4 = 1
  self.talents.e4_health = caster:GetTalentValue("modifier_enigma_midnight_4", "health")
  if IsServer() then
    caster:CalculateStatBonus(true)
  end
end

if caster:HasTalent("modifier_enigma_hero_5") then
  self.talents.has_h5 = 1
end

if caster:HasTalent("modifier_enigma_midnight_7") then
  self.talents.has_e7 = 1
end

if caster:HasTalent("modifier_enigma_blackhole_3") then
  self.talents.has_r3 = 1
end

end

function enigma_midnight_pulse_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_enigma_midnight_pulse_custom_tracker"
end

function enigma_midnight_pulse_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "enigma_midnight_pulse", self)
end

function enigma_midnight_pulse_custom:GetCastAnimation()
local caster = self:GetCaster()
if caster:HasModifier("modifier_enigma_midnight_pulse_custom_can_channel") then
  return 0
end
return ACT_DOTA_MIDNIGHT_PULSE
end

function enigma_midnight_pulse_custom:GetBehavior()
local caster = self:GetCaster()
if caster:HasModifier("modifier_enigma_midnight_pulse_custom_can_channel") then
  return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end
if self.talents.has_e7 == 1 then
  return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end
return DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_POINT
end

function enigma_midnight_pulse_custom:GetManaCost(level)
local caster = self:GetCaster()
if caster:HasModifier("modifier_enigma_midnight_pulse_custom_can_channel") then
  return 0
end
return self.BaseClass.GetManaCost(self,level) 
end

function enigma_midnight_pulse_custom:GetAOERadius()
return self:GetRadius()
end

function enigma_midnight_pulse_custom:GetCooldown(level)
return self.BaseClass.GetCooldown( self, level ) + (self.talents.e2_cd and self.talents.e2_cd or 0)
end

function enigma_midnight_pulse_custom:GetCastRange(vLocation, hTarget)
return self.BaseClass.GetCastRange(self , vLocation , hTarget)
end

function enigma_midnight_pulse_custom:GetCastPoint(iLevel)
return self.BaseClass.GetCastPoint(self)
end

function enigma_midnight_pulse_custom:GetRadius()
return (self.radius and self.radius or 0) + (self.talents.e2_radius or self.talents.e2_radius or 0)
end

function enigma_midnight_pulse_custom:OnSpellStart()
local caster = self:GetCaster()
local point = self:GetCursorPosition()

local mod = caster:FindModifierByName("modifier_enigma_midnight_pulse_custom_can_channel")
if mod then
  caster:EmitSound("Enigma.Midnight_pull_voice")
  caster:AddNewModifier(caster, self, "modifier_enigma_midnight_pulse_custom_channel", {duration = self.talents.e7_duration})
  mod:Destroy()
  self:EndCd()
  return
end

if self.talents.has_e7 == 1 then
  point = caster:GetAbsOrigin()
  caster:AddNewModifier(caster, self, "modifier_enigma_midnight_pulse_custom", {duration = self.duration})
  caster:AddNewModifier(caster, self, "modifier_enigma_midnight_pulse_custom_can_channel", {duration = self.duration})
  self:EndCd(0.5)
else
  CreateModifierThinker(caster, self, "modifier_enigma_midnight_pulse_custom", {duration = self.duration}, point, caster:GetTeamNumber(), false)
  self:EndCd()
end

if self.talents.has_h5 == 1 then
  self.caster:AddNewModifier(self.caster, self, "modifier_enigma_midnight_pulse_custom_move", {duration = self.talents.h5_duration})
  for _,target in pairs(self.caster:FindTargets(self:GetRadius(), point)) do
    target:AddNewModifier(caster, self, "modifier_enigma_midnight_pulse_custom_silence", {duration = self.talents.h5_duration*(1 - target:GetStatusResistance())})
  end
end

end



modifier_enigma_midnight_pulse_custom = class(mod_visible)
function modifier_enigma_midnight_pulse_custom:OnCreated(table)
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.radius = self.ability:GetRadius()

if not IsServer() then return end

self.max_time = self:GetRemainingTime()
self.RemoveForDuel = true

self.ability.active_mod = self

self.parent:EmitSound("Hero_Enigma.Midnight_Pulse")

if self.parent == self.caster then
  self.particle = ParticleManager:CreateParticle("particles/enigma/midnight_pulse.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
else
  self.particle = ParticleManager:CreateParticle("particles/enigma/midnight_pulse.vpcf", PATTACH_WORLDORIGIN, nil)
end

ParticleManager:SetParticleControl(self.particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 1, Vector(self.radius, 0, 0))
self:AddParticle( self.particle, false, false, -1, false, false )
end

function modifier_enigma_midnight_pulse_custom:OnDestroy()
if not IsServer() then return end
self.ability.active_mod = nil
self.ability:StartCd()
end

function modifier_enigma_midnight_pulse_custom:IsAura() return true end
function modifier_enigma_midnight_pulse_custom:GetAuraDuration() return 0.5 end
function modifier_enigma_midnight_pulse_custom:GetAuraRadius() return self.radius end
function modifier_enigma_midnight_pulse_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_BOTH end
function modifier_enigma_midnight_pulse_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_enigma_midnight_pulse_custom:GetModifierAura() return "modifier_enigma_midnight_pulse_custom_debuff" end
function modifier_enigma_midnight_pulse_custom:GetAuraEntityReject(hEntity)
if hEntity:IsFieldInvun(self.caster) then return true end
if hEntity:GetTeamNumber() ~= self.parent:GetTeamNumber() then return false end
return self.ability.talents.has_e4 == 0 or hEntity ~= self.caster
end


modifier_enigma_midnight_pulse_custom_debuff = class(mod_visible)
function modifier_enigma_midnight_pulse_custom_debuff:IsHidden() return self.is_friend and self.ability.talents.has_e7 == 1 end
function modifier_enigma_midnight_pulse_custom_debuff:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.base_damage = self.ability.base_damage
self.health_damage = self.ability.damage_percent + self.ability.talents.e1_damage
self.damage_creeps = self.ability.damage_creeps + self.ability.talents.e1_creeps
self.interval = self.ability.tick_rate

self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability}

self.is_friend = self.parent == self.caster

if not IsServer() then return end
if self.is_friend then 
  return
end
self:StartIntervalThink(self.interval - FrameTime())
end

function modifier_enigma_midnight_pulse_custom_debuff:OnIntervalThink()
if not IsServer() then return end

local damage = 0
local damage_ability = nil
local damage_k = 1
if self.parent:IsHero() then
  local health = self.parent:GetHealth() 
  if self.caster:HasModifier("modifier_enigma_midnight_pulse_custom_channel") then
    health = self.parent:GetMaxHealth() - self.parent:GetHealth()
    damage_ability = "modifier_enigma_midnight_7"
    damage_k = 1 + self.ability.talents.e7_damage
  end
  damage = (health*self.health_damage + self.base_damage)
else
  damage = self.damage_creeps
end

damage = (damage*self.interval)*damage_k
self.damageTable.damage_type = DAMAGE_TYPE_MAGICAL

self.damageTable.damage = damage
DoDamage(self.damageTable, damage_ability)

if self.ability.talents.has_e3 == 1 then
  local chance = self.ability.talents.e3_chance
  local index = 1533
  if self.parent:GetHealthPercent() <= self.ability.talents.e3_health then
    chance = chance * self.ability.talents.e3_bonus
    index = 1534
  end

  if RollPseudoRandomPercentage(chance, index, self.parent) then
    self.parent:GenericParticle("particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_dmg.vpcf")
    self.parent:EmitSound("Enigma.Midnight_fear_damage")

    self.damageTable.damage_type = self.ability.talents.e3_damage_type
    self.damageTable.damage = self.ability.talents.e3_base + self.ability.talents.e3_damage*self.caster:GetMaxHealth()

    local real_damage = DoDamage(self.damageTable, "modifier_enigma_midnight_3")
    self.parent:SendNumber(6, real_damage)

    local result = self.caster:CanLifesteal(self.parent)
    if result then
      self.caster:GenericHeal(self.ability.talents.e3_heal*result*real_damage, self.ability, true, "particles/enigma/summon_heal.vpcf", "modifier_enigma_midnight_3")
    end
  end
end

end

function modifier_enigma_midnight_pulse_custom_debuff:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
  MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
}
end

function modifier_enigma_midnight_pulse_custom_debuff:GetModifierMagicalResistanceBonus()
if self.is_friend then return end
return self.ability.talents.e1_magic
end

function modifier_enigma_midnight_pulse_custom_debuff:GetModifierConstantHealthRegen()
if not self.is_friend then return end
return self.parent:GetMaxHealth()*self.ability.talents.e4_heal*(1 - self.parent:GetHealthPercent()/100)
end

function modifier_enigma_midnight_pulse_custom_debuff:IsAura() return self.parent:IsRealHero() and self.ability.talents.has_r3 == 1 end
function modifier_enigma_midnight_pulse_custom_debuff:GetAuraDuration() return 0 end
function modifier_enigma_midnight_pulse_custom_debuff:GetAuraRadius() return self.ability.talents.r3_radius end
function modifier_enigma_midnight_pulse_custom_debuff:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_enigma_midnight_pulse_custom_debuff:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO end
function modifier_enigma_midnight_pulse_custom_debuff:GetModifierAura() return "modifier_enigma_black_hole_custom_spell_active" end
function modifier_enigma_midnight_pulse_custom_debuff:GetAuraEntityReject(hEntity)
return self.caster ~= hEntity
end


modifier_enigma_midnight_pulse_custom_tracker = class(mod_hidden)
function modifier_enigma_midnight_pulse_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.ability.radius = self.ability:GetSpecialValueFor("radius")
self.ability.damage_percent = self.ability:GetSpecialValueFor("damage_percent")/100
self.ability.duration = self.ability:GetSpecialValueFor("duration")      
self.ability.base_damage = self.ability:GetSpecialValueFor("base_damage")   
self.ability.damage_creeps = self.ability:GetSpecialValueFor("damage_creeps") 
self.ability.tick_rate = self.ability:GetSpecialValueFor("tick_rate")     

if not IsServer() then return end
self:StartIntervalThink(2)
end

function modifier_enigma_midnight_pulse_custom_tracker:OnRefresh(table)
self.ability.damage_percent = self.ability:GetSpecialValueFor("damage_percent")/100  
self.ability.base_damage = self.ability:GetSpecialValueFor("base_damage")   
self.ability.damage_creeps = self.ability:GetSpecialValueFor("damage_creeps") 
end

function modifier_enigma_midnight_pulse_custom_tracker:OnIntervalThink()
if not IsServer() then return end

if (not self.ability.active_mod or self.ability.active_mod:IsNull()) and not self.ability:IsActivated() then
  self.ability:StartCd()
end

end

function modifier_enigma_midnight_pulse_custom_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE
}
end

function modifier_enigma_midnight_pulse_custom_tracker:GetModifierExtraHealthPercentage()
return self.ability.talents.e4_health
end



modifier_enigma_midnight_pulse_custom_can_channel = class(mod_hidden)

modifier_enigma_midnight_pulse_custom_channel = class(mod_hidden)
function modifier_enigma_midnight_pulse_custom_channel:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.radius = self.ability:GetRadius()

if not IsServer() then return end

self.parent:EmitSound("Enigma.Midnight_pull_caster")
self.parent:EmitSound("Enigma.Midnight_pull_start")

self.parent:GenericParticle("particles/enigma/malefice_pull_caster.vpcf", self)

self.effect = ParticleManager:CreateParticle("particles/enigma/malefice_pull_field.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl( self.effect, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl( self.effect, 1, Vector(self.radius, 0, 0) )
self:AddParticle( self.effect, false, false, -1, false, false )

self.mod = self.parent:FindModifierByName("modifier_enigma_midnight_pulse_custom")
if self.mod then
  self.mod_duration = self.mod:GetRemainingTime()
  self.mod:SetDuration(-1, true)
end

self.parent:AddOrderEvent(self)

self.targets = {}
self:OnIntervalThink()
self:StartIntervalThink(0.1)
end

function modifier_enigma_midnight_pulse_custom_channel:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MODEL_SCALE,
  MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end

function modifier_enigma_midnight_pulse_custom_channel:GetOverrideAnimation()
return ACT_DOTA_CAST_ABILITY_4
end

function modifier_enigma_midnight_pulse_custom_channel:GetModifierModelScale()
return 40
end

function modifier_enigma_midnight_pulse_custom_channel:OnIntervalThink()
if not IsServer() then return end

local targets = self.parent:FindTargets(self.radius)

for _,target in pairs(targets) do
  if not target:HasModifier("modifier_enigma_midnight_pulse_custom_channel_pull") and not target:IsDebuffImmune() then
    self.targets[target:entindex()] = true
    target:AddNewModifier(self.parent, self.ability, "modifier_enigma_midnight_pulse_custom_channel_pull", {duration = self:GetRemainingTime() + 0.1})
  end
end

end

function modifier_enigma_midnight_pulse_custom_channel:OnDestroy()
if not IsServer() then return end

self.parent:StopSound("Enigma.Midnight_pull_caster")

self.mod = self.parent:FindModifierByName("modifier_enigma_midnight_pulse_custom")
if self.mod and self.mod_duration then
  self.mod:SetDuration(self.mod_duration, true)
end

for index,_ in pairs(self.targets) do
  local unit = EntIndexToHScript(index)
  if unit and not unit:IsNull() then
    unit:RemoveModifierByName("modifier_enigma_midnight_pulse_custom_channel_pull")
  end
end

end

function modifier_enigma_midnight_pulse_custom_channel:OrderEvent( params )

if params.order_type==DOTA_UNIT_ORDER_STOP or params.order_type==DOTA_UNIT_ORDER_HOLD_POSITION then
  self:Destroy()
end

end

function modifier_enigma_midnight_pulse_custom_channel:CheckState()
local result = 
{
  [MODIFIER_STATE_ROOTED] = true,
  [MODIFIER_STATE_DISARMED] = true,
  [MODIFIER_STATE_SILENCED] = true,
}
if self:GetElapsedTime() <= self.ability.talents.e7_invun then
  result[MODIFIER_STATE_INVULNERABLE] = true
  result[MODIFIER_STATE_NO_HEALTH_BAR] = true
end
return result
end


modifier_enigma_midnight_pulse_custom_channel_pull = class(mod_hidden)
function modifier_enigma_midnight_pulse_custom_channel_pull:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.vec = self.caster:GetAbsOrigin() - self.parent:GetAbsOrigin()

self.max_duration = self.ability.talents.e7_duration
self.max_range = self.ability:GetRadius()
self.min_range = 120

self.speed = (self.max_range - self.min_range)/self.max_duration

self.min_point = self.caster:GetAbsOrigin() - self.vec:Normalized()*120

if not IsServer() then return end

self.particle = ParticleManager:CreateParticle("particles/enigma/midnight_pull_target.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
ParticleManager:SetParticleControlEnt( self.particle, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_attack"..RandomInt(1, 2), self.caster:GetOrigin(), true )
ParticleManager:SetParticleControlEnt( self.particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
self:AddParticle( self.particle, false, false, -1, false, false )

self.effect = ParticleManager:CreateParticle("particles/units/heroes/hero_enigma/enigma_black_hole_scepter_pull_debuff.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt( self.effect, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
ParticleManager:SetParticleControlEnt( self.effect, 1, self.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", self.caster:GetOrigin(), true )
self:AddParticle( self.effect, false, false, -1, false, false )

if not self:ApplyHorizontalMotionController() then
  self:Destroy()
  return
end

end

function modifier_enigma_midnight_pulse_custom_channel_pull:OnDestroy()
if not IsServer() then return end
self.parent:RemoveHorizontalMotionController(self)
FindClearSpaceForUnit( self.parent, self.parent:GetOrigin(), false )
end

function modifier_enigma_midnight_pulse_custom_channel_pull:UpdateHorizontalMotion( me, dt )

if self.parent:IsDebuffImmune() then
  self:Destroy()
  return
end

local origin = me:GetOrigin()

if (origin - self.caster:GetAbsOrigin()):Length2D() <= self.min_range then
  return
end

local nextpos = origin + self.vec:Normalized() * self.speed * dt
me:SetOrigin(nextpos)
end

function modifier_enigma_midnight_pulse_custom_channel_pull:OnHorizontalMotionInterrupted()
self:Destroy()
end

function modifier_enigma_midnight_pulse_custom_channel_pull:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
}
end

function modifier_enigma_midnight_pulse_custom_channel_pull:GetOverrideAnimation()
return ACT_DOTA_FLAIL
end

function modifier_enigma_midnight_pulse_custom_channel_pull:CheckState()
return
{
  [MODIFIER_STATE_ROOTED] = true
}
end

function modifier_enigma_midnight_pulse_custom_channel_pull:GetStatusEffectName()
return "particles/status_fx/status_effect_enigma_blackhole_tgt.vpcf"
end

function modifier_enigma_midnight_pulse_custom_channel_pull:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end



modifier_enigma_midnight_pulse_custom_move = class(mod_hidden)
function modifier_enigma_midnight_pulse_custom_move:IsPurgable() return true end
function modifier_enigma_midnight_pulse_custom_move:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

if not IsServer() then return end
self.parent:EmitSound("Enigma.Midnight_speed")
self.parent:GenericParticle("particles/units/heroes/hero_dark_seer/dark_seer_surge.vpcf", self)
self.parent:GenericParticle("particles/enigma/midnight_speed.vpcf", self)
end

function modifier_enigma_midnight_pulse_custom_move:CheckState()
return
{
  [MODIFIER_STATE_NO_UNIT_COLLISION] = true
}
end

function modifier_enigma_midnight_pulse_custom_move:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
  MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
}
end

function modifier_enigma_midnight_pulse_custom_move:GetActivityTranslationModifiers()
return "haste"
end

function modifier_enigma_midnight_pulse_custom_move:GetModifierMoveSpeed_Absolute()
return self.ability.talents.h5_speed
end



modifier_enigma_midnight_pulse_custom_silence = class(mod_hidden)
function modifier_enigma_midnight_pulse_custom_silence:IsPurgable() return true end
function modifier_enigma_midnight_pulse_custom_silence:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

if not IsServer() then return end
self.parent:EmitSound("Sf.Raze_Silence")
self.parent:GenericParticle("particles/generic_gameplay/generic_silenced.vpcf", self, true)
self.parent:GenericParticle("particles/void_astral_slow.vpcf", self)
end

function modifier_enigma_midnight_pulse_custom_silence:CheckState()
return 
{
  [MODIFIER_STATE_SILENCED] = true
}
end

function modifier_enigma_midnight_pulse_custom_silence:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_enigma_midnight_pulse_custom_silence:GetModifierMoveSpeedBonus_Percentage()
return self.ability.talents.h5_slow
end


