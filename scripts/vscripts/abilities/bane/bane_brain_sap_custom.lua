--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_bane_brain_sap_custom", "abilities/bane/bane_brain_sap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bane_brain_sap_custom_tracker", "abilities/bane/bane_brain_sap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bane_brain_sap_custom_legendary", "abilities/bane/bane_brain_sap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bane_brain_sap_custom_auto_cd", "abilities/bane/bane_brain_sap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bane_brain_sap_custom_shield_auto_cd", "abilities/bane/bane_brain_sap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bane_brain_sap_custom_fear_cd", "abilities/bane/bane_brain_sap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bane_brain_sap_custom_spells", "abilities/bane/bane_brain_sap_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bane_brain_sap_custom_heal_reduce", "abilities/bane/bane_brain_sap_custom", LUA_MODIFIER_MOTION_NONE )

bane_brain_sap_custom = class({})
bane_brain_sap_custom.talents = {}

function bane_brain_sap_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_bane/bane_sap.vpcf", context )
PrecacheResource( "particle", "particles/bane/sap_legendary.vpcf", context )
PrecacheResource( "particle", "particles/bane/sap_mana.vpcf", context )
PrecacheResource( "particle", "particles/bane/sap_legendary_start.vpcf", context )
PrecacheResource( "particle", "particles/bane/brain_shield.vpcf", context )
end

function bane_brain_sap_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
   {
    has_w1 = 0,
    w1_cd = 0,
    w1_mana = 0,
    
    has_w2 = 0,
    w2_damage = 0,
    w2_base = 0,
    
    has_w3 = 0,
    w3_damage = 0,
    w3_mana = 0,
    w3_cd = caster:GetTalentValue("modifier_bane_brain_3", "cd", true),
    w3_radius = caster:GetTalentValue("modifier_bane_brain_3", "radius", true),
    
    has_w4 = 0,
    w4_fear = caster:GetTalentValue("modifier_bane_brain_4", "fear", true),
    w4_cast = caster:GetTalentValue("modifier_bane_brain_4", "cast", true),
    w4_talent_cd = caster:GetTalentValue("modifier_bane_brain_4", "talent_cd", true),
    
    has_w7 = 0,
    w7_damage = caster:GetTalentValue("modifier_bane_brain_7", "damage", true)/100,
    w7_mana = caster:GetTalentValue("modifier_bane_brain_7", "mana", true)/100,
    w7_duration = caster:GetTalentValue("modifier_bane_brain_7", "duration", true),
    w7_damage_reduce = caster:GetTalentValue("modifier_bane_brain_7", "damage_reduce", true),
    w7_cd = caster:GetTalentValue("modifier_bane_brain_7", "cd", true)/100,
    w7_talent_cd = caster:GetTalentValue("modifier_bane_brain_7", "talent_cd", true),
    
    has_h1 = 0,
    h1_move = 0,
    h1_range = 0,
    
    has_h3 = 0,
    h3_heal_reduce = 0,
    h3_regen = 0,
    h3_duration = caster:GetTalentValue("modifier_bane_hero_3", "duration", true),
    
    has_h4 = 0,
    h4_health = caster:GetTalentValue("modifier_bane_hero_4", "health", true),
    h4_duration = caster:GetTalentValue("modifier_bane_hero_4", "duration", true),
    h4_talent_cd = caster:GetTalentValue("modifier_bane_hero_4", "talent_cd", true),
    h4_shield = caster:GetTalentValue("modifier_bane_hero_4", "shield", true)/100,
    h4_heal_inc = caster:GetTalentValue("modifier_bane_hero_4", "heal_inc", true),

    h6_damage_reduce = caster:GetTalentValue("modifier_bane_hero_6", "damage_reduce", true),
  }
end

if caster:HasTalent("modifier_bane_brain_1") then
  self.talents.has_w1 = 1
  self.talents.w1_cd = caster:GetTalentValue("modifier_bane_brain_1", "cd")
  self.talents.w1_mana = caster:GetTalentValue("modifier_bane_brain_1", "mana")
end

if caster:HasTalent("modifier_bane_brain_2") then
  self.talents.has_w2 = 1
  self.talents.w2_damage = caster:GetTalentValue("modifier_bane_brain_2", "damage")/100
  self.talents.w2_base = caster:GetTalentValue("modifier_bane_brain_2", "base")
end

if caster:HasTalent("modifier_bane_brain_3") then
  self.talents.has_w3 = 1
  self.talents.w3_damage = caster:GetTalentValue("modifier_bane_brain_3", "damage")/100
  self.talents.w3_mana = caster:GetTalentValue("modifier_bane_brain_3", "mana")
  self.tracker:StartIntervalThink(0.2)
end

if caster:HasTalent("modifier_bane_brain_4") then
  self.talents.has_w4 = 1
end

if caster:HasTalent("modifier_bane_brain_7") then
  self.talents.has_w7 = 1
end

if caster:HasTalent("modifier_bane_hero_1") then
  self.talents.has_h1 = 1
  self.talents.h1_move = caster:GetTalentValue("modifier_bane_hero_1", "move")
  self.talents.h1_range = caster:GetTalentValue("modifier_bane_hero_1", "range")
end

if caster:HasTalent("modifier_bane_hero_3") then
  self.talents.has_h3 = 1
  self.talents.h3_heal_reduce = caster:GetTalentValue("modifier_bane_hero_3", "heal_reduce")
  self.talents.h3_regen = caster:GetTalentValue("modifier_bane_hero_3", "regen")
  caster:AddSpellEvent(self.tracker, true)
end

if caster:HasTalent("modifier_bane_hero_4") then
  self.talents.has_h4 = 1
  caster:AddDamageEvent_inc(self.tracker, true)
  caster:AddHealEvent_inc(self.tracker, true)
end

end

function bane_brain_sap_custom:Init()
self.caster = self:GetCaster()
end

function bane_brain_sap_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_bane_brain_sap_custom_tracker"
end

function bane_brain_sap_custom:GetCooldown(level)
return (self.BaseClass.GetCooldown( self, level ) + (self.talents.w1_cd and self.talents.w1_cd or 0))*(1 + (self.talents.has_w7 == 1 and self.talents.w7_cd or 0))
end

function bane_brain_sap_custom:GetAOERadius()
return self:GetSpecialValueFor("radius")
end

function bane_brain_sap_custom:GetCastRange(vLocation, hTarget)
return self.BaseClass.GetCastRange(self , vLocation , hTarget)
end

function bane_brain_sap_custom:GetBehavior()
return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_AOE
end

function bane_brain_sap_custom:GetManaCost(level)
return self.talents.has_w7 == 1 and self.caster:GetMaxMana()*self.talents.w7_mana or self.BaseClass.GetManaCost(self,level) 
end

function bane_brain_sap_custom:GetCastPoint(iLevel)
return self.BaseClass.GetCastPoint(self) + (self.talents.has_w4 == 1 and self.talents.w4_cast or 0)
end

function bane_brain_sap_custom:OnSpellStart()
local target = self:GetCursorTarget()
if target:TriggerSpellAbsorb(self) then return end
self:DealDamage(target)
end

function bane_brain_sap_custom:DealDamage(target, is_auto)
local damage = self:GetSpecialValueFor("brain_sap_damage") + self.talents.w2_base + self.talents.w2_damage*self.caster:GetMaxMana()
local radius = self:GetSpecialValueFor("radius")
local heal = self:GetSpecialValueFor("heal")/100
local damage_ability = nil
local visual_caster = self:GetCaster()

if self.talents.has_w7 == 1 then
  damage = damage*(1 + (1 - self.caster:GetMana()/self.caster:GetMaxMana())*self.talents.w7_damage)
end

self.caster:EmitSound("Hero_Bane.BrainSap")
target:EmitSound("Hero_Bane.BrainSap.Target")

if is_auto then
  damage_ability = "modifier_bane_brain_3"
  damage = damage*self.talents.w3_damage
end

if self.talents.has_w4 == 1 and self.caster:GetHealthPercent() < target:GetHealthPercent() and not is_auto then
  if not target:IsDebuffImmune() and not target:HasModifier("modifier_bane_brain_sap_custom_fear_cd") and not target:HasModifier("modifier_bane_nightmare_custom") then
    target:EmitSound("Generic.Fear")
    target:AddNewModifier(self.caster, self, "modifier_bane_brain_sap_custom_fear_cd", {duration = self.talents.w4_talent_cd})
    target:AddNewModifier(self.caster, self, "modifier_nevermore_requiem_fear", {duration = self.talents.w4_fear * (1 - target:GetStatusResistance())})
  end
end

local damage_table = {attacker = self.caster, ability = self, damage = damage, damage_type = DAMAGE_TYPE_PURE}

local targets = self.caster:FindTargets(radius, target:GetAbsOrigin())
for _,unit in pairs(targets) do
  local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_bane/bane_sap.vpcf", PATTACH_CUSTOMORIGIN, visual_caster )
  ParticleManager:SetParticleControlEnt( effect_cast, 0, visual_caster, PATTACH_POINT_FOLLOW, "attach_hitloc", visual_caster:GetOrigin(), true )
  ParticleManager:SetParticleControlEnt( effect_cast, 1, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", unit:GetOrigin(), true )
  ParticleManager:ReleaseParticleIndex( effect_cast )

  damage_table.victim = unit
  local real_damage = DoDamage(damage_table, damage_ability)
  if target == unit and not target:IsIllusion() then
    self.caster:GenericHeal(real_damage*heal, self, nil, nil, damage_ability)
  end
end

end


modifier_bane_brain_sap_custom_tracker = class(mod_hidden)
function modifier_bane_brain_sap_custom_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
  MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
  MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
  --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
  MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
  --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end

function modifier_bane_brain_sap_custom_tracker:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.legendary_ability = self.parent:FindAbilityByName("bane_brain_sap_custom_legendary")
if self.legendary_ability then
  self.legendary_ability:UpdateTalents()
end

end

function modifier_bane_brain_sap_custom_tracker:GetModifierLifestealRegenAmplify_Percentage()
if self.ability.talents.has_h4 == 0 then return end 
return self.ability.talents.h4_heal_inc
end

function modifier_bane_brain_sap_custom_tracker:GetModifierHealChange()
if self.ability.talents.has_h4 == 0 then return end 
return self.ability.talents.h4_heal_inc
end

function modifier_bane_brain_sap_custom_tracker:GetModifierHPRegenAmplify_Percentage() 
if self.ability.talents.has_h4 == 0 then return end 
return self.ability.talents.h4_heal_inc
end

function modifier_bane_brain_sap_custom_tracker:GetModifierCastRangeBonusStacking()
return self.ability.talents.h1_range
end

function modifier_bane_brain_sap_custom_tracker:GetModifierMoveSpeedBonus_Constant()
return self.ability.talents.h1_move
end

function modifier_bane_brain_sap_custom_tracker:GetModifierSpellAmplify_Percentage()
if self.ability.talents.w3_mana <= 0 then return end
return self.parent:GetMaxMana()/self.ability.talents.w3_mana
end

function modifier_bane_brain_sap_custom_tracker:GetModifierPercentageManacostStacking(params)
if self.ability.talents.has_w7 == 1 then
  if params.ability and params.ability == self.ability then
    return self.ability.talents.w1_mana
  else
    return 100
  end
end
return self.ability.talents.w1_mana
end

function modifier_bane_brain_sap_custom_tracker:OnIntervalThink()
if not IsServer() then return end
if self.ability.talents.has_w3 == 0 then return end
if self.parent:HasModifier("modifier_bane_brain_sap_custom_auto_cd") then return end
if not self.parent:IsAlive() or self.parent:IsInvisible() then return end

local target = self.parent:RandomTarget(self.ability.talents.w3_radius)
if not target or target:HasModifier("modifier_bane_nightmare_custom") then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_bane_brain_sap_custom_auto_cd", {duration = self.ability.talents.w3_cd})
self.ability:DealDamage(target, true)
end

function modifier_bane_brain_sap_custom_tracker:DamageEvent_inc(params)
if not IsServer() then return end
if self.ability.talents.has_h4 == 0 then return end
if self.parent:HasModifier("modifier_bane_brain_sap_custom_shield_auto_cd") then return end
if self.parent ~= params.unit then return end
if self.parent:PassivesDisabled() then return end
if not self.parent:IsAlive() then return end
if self.parent:GetHealthPercent() > self.ability.talents.h4_health then return end

if IsValid(self.shield_mod) then
  self.shield:Destroy()
end

self.shield_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_shield",
{
  duration = self.ability.talents.h4_duration,
  max_shield = self.ability.talents.h4_shield*self.parent:GetMaxHealth(), 
  start_full = 1,
  shield_talent = "modifier_bane_hero_4"
})

if self.shield_mod then
  self.parent:EmitSound("Bane.Sap_shield")
  self.cast_effect = ParticleManager:CreateParticle("particles/bane/brain_shield.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
  ParticleManager:SetParticleControlEnt( self.cast_effect, 0,  self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc",  self.parent:GetAbsOrigin(), true )
  ParticleManager:SetParticleControl( self.cast_effect, 1, self.parent:GetAbsOrigin() )
  ParticleManager:SetParticleControlEnt( self.cast_effect, 2,  self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc",  self.parent:GetAbsOrigin(), true )
  self.shield_mod:AddParticle( self.cast_effect, false, false, -1, false, false  )

  self.shield_mod:SetReduceDamage(function(params)
    if params.caster:HasModifier("modifier_bane_fiends_grip_custom_absorb") then
      return (1 - (self.ability.talents.h6_damage_reduce*-1)/100)
    end
  end)
end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_bane_brain_sap_custom_shield_auto_cd", {duration = self.ability.talents.h4_talent_cd})
end

function modifier_bane_brain_sap_custom_tracker:HealEvent_inc(params)
if not IsServer() then return end
if self.ability.talents.has_h4 == 0 then return end
if params.unit ~= self.parent then return end
if not params.inflictor then return end

local final = params.prev_health + params.gain

if final <= self.parent:GetMaxHealth() then return end
local above = final - self.parent:GetMaxHealth()
local max = self.ability.talents.h4_shield*self.parent:GetMaxHealth()

if not IsValid(self.shield_mod) then
  self.shield_mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_shield",
  {
    duration = self.ability.talents.h4_duration,
    max_shield = max, 
    shield_talent = "modifier_bane_hero_4"
  })
  if self.shield_mod then
    self.cast_effect = ParticleManager:CreateParticle("particles/bane/brain_shield.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControlEnt( self.cast_effect, 0,  self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc",  self.parent:GetAbsOrigin(), true )
    ParticleManager:SetParticleControl( self.cast_effect, 1, self.parent:GetAbsOrigin() )
    ParticleManager:SetParticleControlEnt( self.cast_effect, 2,  self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc",  self.parent:GetAbsOrigin(), true )
    self.shield_mod:AddParticle( self.cast_effect, false, false, -1, false, false  )

    self.shield_mod:SetReduceDamage(function(params)
      if params.caster:HasModifier("modifier_bane_fiends_grip_custom_absorb") then
        return (1 - (self.ability.talents.h6_damage_reduce*-1)/100)
      end
    end)
  end
end

if self.shield_mod then
  self.shield_mod:AddShield(above, max)
end


end

function modifier_bane_brain_sap_custom_tracker:SpellEvent(params)
if not IsServer() then return end
if self.ability.talents.has_h3 == 0 then return end
if params.unit ~= self.parent then return end
if params.ability:IsItem() then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_bane_brain_sap_custom_spells", {duration = self.ability.talents.h3_duration})

if params.target then
  params.target:AddNewModifier(self.parent, self.ability, "modifier_bane_brain_sap_custom_heal_reduce", {duration = self.ability.talents.h3_duration})
end

end





bane_brain_sap_custom_legendary = class({})
bane_brain_sap_custom_legendary.talents = {}

function bane_brain_sap_custom_legendary:CreateTalent()
self:SetHidden(false)
self:SetLevel(1)
end

function bane_brain_sap_custom_legendary:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_w7 = 0,
    w7_duration = caster:GetTalentValue("modifier_bane_brain_7", "duration", true),
    w7_damage_reduce = caster:GetTalentValue("modifier_bane_brain_7", "damage_reduce", true),
    w7_talent_cd = caster:GetTalentValue("modifier_bane_brain_7", "talent_cd", true),
  }
end

end

function bane_brain_sap_custom_legendary:Init()
self.caster = self:GetCaster()
end

function bane_brain_sap_custom_legendary:GetCooldown()
return self.talents.w7_talent_cd and self.talents.w7_talent_cd or 0
end

function bane_brain_sap_custom_legendary:OnAbilityPhaseStart()
if self.caster:GetManaPercent() >= 99 then
  CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self.caster:GetPlayerOwnerID()), "CreateIngameErrorMessage", {message = "#bane_full_mana"})
  return false
end
return true
end

function bane_brain_sap_custom_legendary:OnSpellStart()
self.caster:EmitSound("Bane.Sap_legendary_voice")
self.caster:EmitSound("Bane.Sap_legendary_cast")
self.caster:EmitSound("Bane.Sap_legendary_cast2")

self.caster:GenericParticle("particles/bane/sap_legendary_start.vpcf")
self.caster:AddNewModifier(self.caster, self, "modifier_bane_brain_sap_custom_legendary", {duration = self.talents.w7_duration})
end


modifier_bane_brain_sap_custom_legendary = class(mod_visible)
function modifier_bane_brain_sap_custom_legendary:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.damage_reduce = self.ability.talents.w7_damage_reduce
self.mana = 100/self:GetRemainingTime()

if not IsServer() then return end
self.parent:GenericParticle("particles/generic_gameplay/generic_sleep.vpcf", self, true)
self.parent:GenericParticle("particles/bane/sap_legendary.vpcf", self)
self.parent:StartGestureWithPlaybackRate(ACT_DOTA_DISABLED, 0.5)

self.interval = 0.1

self.effect_interval = 0.5
self.effect_count = 0

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_bane_brain_sap_custom_legendary:OnIntervalThink()
if not IsServer() then return end

self.effect_count = self.effect_count + self.interval
if self.effect_count >= self.effect_interval then
  self.effect_count = 0
  self.parent:GenericParticle("particles/bane/sap_mana.vpcf")
end

local mana = self.mana*self.interval*self.parent:GetMaxMana()/100
self.parent:GiveMana(mana)

if self.parent:GetManaPercent() >= 99 then
  self:Destroy()
  return
end

end

function modifier_bane_brain_sap_custom_legendary:GetStatusEffectName()
return "particles/status_fx/status_effect_nightmare.vpcf"
end

function modifier_bane_brain_sap_custom_legendary:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA 
end

function modifier_bane_brain_sap_custom_legendary:CheckState()
return
{
  [MODIFIER_STATE_STUNNED] = true,
}
end

function modifier_bane_brain_sap_custom_legendary:OnDestroy()
if not IsServer() then return end
self.parent:StopSound("Bane.Sap_legendary_cast")
self.parent:EmitSound("Bane.Sap_legendary_end")
self.parent:FadeGesture(ACT_DOTA_DISABLED)
end

function modifier_bane_brain_sap_custom_legendary:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end


function modifier_bane_brain_sap_custom_legendary:GetModifierIncomingDamage_Percentage()
return self.damage_reduce
end


modifier_bane_brain_sap_custom_auto_cd = class(mod_cd)
function modifier_bane_brain_sap_custom_auto_cd:GetTexture() return "buffs/bane/brain_3" end

modifier_bane_brain_sap_custom_shield_auto_cd = class(mod_cd)
function modifier_bane_brain_sap_custom_shield_auto_cd:GetTexture() return "buffs/bane/hero_6" end


modifier_bane_brain_sap_custom_fear_cd = class(mod_hidden)
function modifier_bane_brain_sap_custom_fear_cd:RemoveOnDeath() return false end
function modifier_bane_brain_sap_custom_fear_cd:OnCreated()
self.RemoveForDuel = true
end


modifier_bane_brain_sap_custom_spells = class(mod_visible)
function modifier_bane_brain_sap_custom_spells:GetTexture() return "buffs/bane/hero_4" end
function modifier_bane_brain_sap_custom_spells:OnCreated()
self.ability = self:GetAbility()
self.regen = self.ability.talents.h3_regen
end

function modifier_bane_brain_sap_custom_spells:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
}
end

function modifier_bane_brain_sap_custom_spells:GetModifierHealthRegenPercentage() 
return self.regen
end

modifier_bane_brain_sap_custom_heal_reduce = class(mod_hidden)
function modifier_bane_brain_sap_custom_heal_reduce:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.heal_reduce = self.ability.talents.h3_heal_reduce
end

function modifier_bane_brain_sap_custom_heal_reduce:DeclareFunctions()
return
{

  --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
  MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
  --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end

function modifier_bane_brain_sap_custom_heal_reduce:GetModifierLifestealRegenAmplify_Percentage()
return self.heal_reduce
end

function modifier_bane_brain_sap_custom_heal_reduce:GetModifierHealChange()
return self.heal_reduce
end

function modifier_bane_brain_sap_custom_heal_reduce:GetModifierHPRegenAmplify_Percentage() 
return self.heal_reduce
end