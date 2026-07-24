--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_mars_innate_custom", "abilities/mars/mars_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_mars_innate_custom_effect", "abilities/mars/mars_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_mars_innate_custom_str", "abilities/mars/mars_innate_custom", LUA_MODIFIER_MOTION_NONE )

mars_innate_custom = class({})
mars_innate_custom.talents = {}

function mars_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/mars/innate_effect.vpcf", context )
PrecacheResource( "soundfile", "soundevents/npc_dota_hero_mars.vsndevts", context )
dota1x6:PrecacheShopItems("npc_dota_hero_mars", context)
end

function mars_innate_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_e2 = 0,
    e2_heal = 0,
    e2_bonus = caster:GetTalentValue("modifier_mars_bulwark_2", "bonus", true),

    has_e3 = 0,
    e3_heal = 0,

    has_h1 = 0,
    h1_status = 0,
    h1_move = 0,

    has_h2 = 0,
    h2_str = 0,
    h2_armor = 0,
    h2_bonus = caster:GetTalentValue("modifier_mars_hero_2", "bonus", true),
    h2_cd = caster:GetTalentValue("modifier_mars_hero_2", "cd", true),
    h2_duration = caster:GetTalentValue("modifier_mars_hero_2", "duration", true),
    h2_max = caster:GetTalentValue("modifier_mars_hero_2", "max", true),
    
    has_h3 = 0,
    h3_mana = 0,
    h3_cdr = 0,

    has_r4 = 0,
    r4_heal = caster:GetTalentValue("modifier_mars_arena_4", "heal", true)/100,
    r4_duration = caster:GetTalentValue("modifier_mars_arena_4", "duration", true),
    r4_shield = caster:GetTalentValue("modifier_mars_arena_4", "shield", true)/100,
  }
end

if caster:HasTalent("modifier_mars_bulwark_2") then
  self.talents.has_e2 = 1
  self.talents.e2_heal = caster:GetTalentValue("modifier_mars_bulwark_2", "heal")/100
  self.caster:AddDamageEvent_out(self.tracker, true)
end

if caster:HasTalent("modifier_mars_bulwark_3") then
  self.talents.has_e3 = 1
  self.talents.e3_heal = caster:GetTalentValue("modifier_mars_bulwark_3", "heal")/100
  self.caster:AddDamageEvent_out(self.tracker, true)
end

if caster:HasTalent("modifier_mars_hero_1") then
  self.talents.has_h1 = 1
  self.talents.h1_status = caster:GetTalentValue("modifier_mars_hero_1", "status")
  self.talents.h1_move = caster:GetTalentValue("modifier_mars_hero_1", "move")
end

if caster:HasTalent("modifier_mars_hero_2") then
  self.talents.has_h2 = 1
  self.talents.h2_str = caster:GetTalentValue("modifier_mars_hero_2", "str")
  self.talents.h2_armor = caster:GetTalentValue("modifier_mars_hero_2", "armor")
  if IsServer() then
    caster:CalculateStatBonus(true)
  end
end

if caster:HasTalent("modifier_mars_hero_3") then
  self.talents.has_h3 = 1
  self.talents.h3_mana = caster:GetTalentValue("modifier_mars_hero_3", "mana")/100
  self.talents.h3_cdr = caster:GetTalentValue("modifier_mars_hero_3", "cdr")
end

if caster:HasTalent("modifier_mars_arena_4") then
  self.talents.has_r4 = 1
  self.caster:AddDamageEvent_out(self.tracker, true)
end

end

function mars_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_mars_innate_custom"
end

function mars_innate_custom:CheckAngle(target)
local result = 0
local facing_direction = self.caster:GetAnglesAsVector().y
local attacker_vector = (target:GetOrigin() - self.caster:GetOrigin())
local attacker_direction = VectorToAngles( attacker_vector ).y
local angle_diff = math.abs( AngleDiff( facing_direction, attacker_direction ) )
local angle_front = self.forward_angle / 2
local angle_side = self.side_angle / 2

if angle_diff < angle_front then
    result = 1
elseif angle_diff < angle_side then
    result = 2
end
return result
end


modifier_mars_innate_custom = class(mod_hidden )
function modifier_mars_innate_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.mars_innate = self.ability

self.ability.damage = self.ability:GetSpecialValueFor("damage")
self.ability.movespeed = self.ability:GetSpecialValueFor("movespeed")
self.ability.timer = self.ability:GetSpecialValueFor("timer")
self.ability.forward_angle = self.ability:GetSpecialValueFor("forward_angle")
self.ability.side_angle = self.ability:GetSpecialValueFor("side_angle") 

if not IsServer() then return end
self.parent:AddDamageEvent_inc(self, true)
self:StartIntervalThink(1)
end

function modifier_mars_innate_custom:OnDestroy()
if not IsServer() then return end
self.parent:RemoveModifierByName("modifier_mars_innate_custom_effect")
end

function modifier_mars_innate_custom:OnIntervalThink()
if not IsServer() then return end
if not self.parent:IsAlive() then
    self:StartIntervalThink(0.5)
    return
end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_mars_innate_custom_effect", {})
self:StartIntervalThink(-1)
end

function modifier_mars_innate_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
    MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
}
end

function modifier_mars_innate_custom:GetModifierPercentageCooldown() 
return self.ability.talents.h3_cdr
end

function modifier_mars_innate_custom:GetModifierPhysicalArmorBonus()
return self.ability.talents.h2_armor * (1 + self.parent:GetUpgradeStack("modifier_mars_innate_custom_str")*(self.ability.talents.h2_bonus - 1)/self.ability.talents.h2_max)
end

function modifier_mars_innate_custom:GetModifierBonusStats_Strength()
return self.ability.talents.h2_str * (1 + self.parent:GetUpgradeStack("modifier_mars_innate_custom_str")*(self.ability.talents.h2_bonus - 1)/self.ability.talents.h2_max)
end

function modifier_mars_innate_custom:GetModifierProcAttack_Feedback(params)
if not IsServer() then return end
params.target:EmitSound("Hero_Mars.Attack_custom")
end

function modifier_mars_innate_custom:DamageEvent_inc(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end

local attacker = params.attacker
local result = self.ability:CheckAngle(attacker)

if result == 1 then
    if self.ability.talents.has_h2 == 1 and self.parent:CheckCd("mars_h3", self.ability.talents.h2_cd) then
        self.parent:AddNewModifier(self.parent, nil, "modifier_mars_innate_custom_str", {duration = self.ability.talents.h2_duration})
    end
end

if result ~= 0 then return end

self.parent:RemoveModifierByName("modifier_mars_innate_custom_effect")
self:StartIntervalThink(self.ability.timer)
end

function modifier_mars_innate_custom:DamageEvent_out(params)
if not IsServer() then return end
local result = self.parent:CheckLifesteal(params)
if not result then return end

if self.ability.talents.has_e2 == 1 and not params.inflictor then
    local heal = params.damage*result*self.ability.talents.e2_heal
    if self.parent:HasModifier("modifier_mars_innate_custom_effect") then
        heal = heal*self.ability.talents.e2_bonus
    end
    self.parent:GenericHeal(heal, self.ability, true, false, "modifier_mars_bulwark_2")
end

if self.ability.talents.has_e3 == 1 and not params.inflictor and params.attack_damage_flag == "mars_e3" then
    self.parent:GenericHeal(params.damage*result*self.ability.talents.e3_heal, self.ability, true, "", "modifier_mars_bulwark_3")
end

if self.ability.talents.has_r4 == 1 and params.inflictor then
    local heal = params.damage*result*self.ability.talents.r4_heal
    self.parent:GenericHeal(heal, self.ability, true, "particles/items3_fx/octarine_core_lifesteal.vpcf", "modifier_mars_arena_4")

    if self.parent:HasModifier("modifier_mars_arena_of_blood_custom_projectile_aura") then
      local max_shield = self.parent:GetMaxHealth()*self.ability.talents.r4_shield

      if not IsValid(self.shield_mod) then
          self.shield_mod = self.parent:AddNewModifier(self.parent, self, "modifier_generic_shield_multiple", 
          {
            duration = self.ability.talents.r4_duration,
            shield_talent = "modifier_mars_arena_4",
            max_shield = max_shield,
          })
          if self.shield_mod then
            self.particle = ParticleManager:CreateParticle("particles/wraith_king/reinc_shield.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent )
            ParticleManager:SetParticleControlEnt(self.particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
            self.shield_mod:AddParticle(self.particle,false, false, -1, false, false)

            self.shield_mod:SetReduceDamage(function(params)
              local caster = params.caster
              local result = 1
              if IsValid(caster.bulwark_ability) then
                result = caster.bulwark_ability:GetReduction(params)
              end
              return 1 + result/100
            end)
          end
      end
      if IsValid(self.shield_mod) then
        self.shield_mod:AddShield(heal, max_shield)
        self.shield_mod:SetDuration(self.ability.talents.r4_duration, true)
      end
    end
end

end

modifier_mars_innate_custom_effect = class(mod_visible)
function modifier_mars_innate_custom_effect:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.move = self.ability.movespeed
self.damage = self.ability.damage

if not IsServer() then return end

self.parent:EmitSound("Mars.Innate_active")

local hit_effect = ParticleManager:CreateParticle("particles/mars/innate_effect.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(hit_effect, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetAbsOrigin(), false) 
self:AddParticle( hit_effect, false, false, -1, false, false  )
end

function modifier_mars_innate_custom_effect:OnDestroy()
if not IsServer() then return end
if not IsValid(self.ability.tracker) then return end
self.ability.tracker:StartIntervalThink(self.ability.timer)
end

function modifier_mars_innate_custom_effect:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
    MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
    MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
}
end

function modifier_mars_innate_custom_effect:GetModifierDamageOutgoing_Percentage()
return self.damage
end

function modifier_mars_innate_custom_effect:GetModifierSpellAmplify_Percentage()
return self.damage
end

function modifier_mars_innate_custom_effect:GetModifierMoveSpeedBonus_Constant()
return self.move + self.ability.talents.h1_move
end

function modifier_mars_innate_custom_effect:GetModifierStatusResistanceStacking()
return self.ability.talents.h1_status
end

function modifier_mars_innate_custom_effect:GetModifierConstantManaRegen()
return self.ability.talents.h3_mana*self.parent:GetMaxMana()
end

modifier_mars_innate_custom_str = class(mod_visible)
function modifier_mars_innate_custom_str:GetTexture() return "buffs/mars/hero_2" end
function modifier_mars_innate_custom_str:OnCreated()
self.parent = self:GetParent()
self.ability = self.parent.mars_innate
if not self.ability then
    self:Destroy()
    return
end

self.max = self.ability.talents.h2_max
if not IsServer() then return end
self:OnRefresh()
end

function modifier_mars_innate_custom_str:OnRefresh()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
self.parent:CalculateStatBonus(true)
end

function modifier_mars_innate_custom_str:OnDestroy()
if not IsServer() then return end
self.parent:CalculateStatBonus(true)
end