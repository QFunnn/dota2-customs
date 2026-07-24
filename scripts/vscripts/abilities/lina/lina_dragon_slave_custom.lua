--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_lina_dragon_slave_custom_legendary", "abilities/lina/lina_dragon_slave_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lina_dragon_slave_custom_legendary_stack", "abilities/lina/lina_dragon_slave_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lina_dragon_slave_custom_tracker", "abilities/lina/lina_dragon_slave_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lina_dragon_slave_custom_slow", "abilities/lina/lina_dragon_slave_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lina_dragon_slave_custom_proc", "abilities/lina/lina_dragon_slave_custom", LUA_MODIFIER_MOTION_NONE )

lina_dragon_slave_custom = class({})
lina_dragon_slave_custom.talents = {}

function lina_dragon_slave_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/units/heroes/hero_lina/lina_spell_dragon_slave.vpcf", context )
PrecacheResource( "particle", "particles/huskar_spears_legen.vpcf", context ) 
PrecacheResource( "particle", "particles/status_fx/status_effect_omnislash.vpcf", context ) 
PrecacheResource( "particle", "particles/lina/dragon_status.vpcf", context )
PrecacheResource( "particle", "particles/mars_revenge_proc.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_phoenix/phoenix_fire_spirit_burn.vpcf", context )
PrecacheResource( "particle", "particles/lina_attack_slow.vpcf", context )
PrecacheResource( "particle", "particles/status_fx/status_effect_enchantress_shard_debuff.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_essence_effect.vpcf", context )
PrecacheResource( "particle", "particles/ember_spirit/chains_bkb.vpcf", context )

end

function lina_dragon_slave_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_q1 = 0,
    q1_damage = 0,
    q1_spell = 0,
    
    has_q2 = 0,
    q2_cd = 0,
    q2_slow = 0,
    q2_duration = caster:GetTalentValue("modifier_lina_dragon_2", "duration", true),
    
    has_q3 = 0,
    q3_damage = 0,
    
    has_q4 = 0,
    q4_duration = caster:GetTalentValue("modifier_lina_dragon_4", "duration", true),
    q4_damage = caster:GetTalentValue("modifier_lina_dragon_4", "damage", true)/100,
    q4_cd_items = caster:GetTalentValue("modifier_lina_dragon_4", "cd_items", true),
    q4_count = caster:GetTalentValue("modifier_lina_dragon_4", "count", true),
    q4_range = caster:GetTalentValue("modifier_lina_dragon_4", "range", true),
    
    has_q7 = 0,
    q7_duration = caster:GetTalentValue("modifier_lina_dragon_7", "duration", true),
    q7_radius = caster:GetTalentValue("modifier_lina_dragon_7", "radius", true),
    q7_status = caster:GetTalentValue("modifier_lina_dragon_7", "status", true),
    q7_cd = caster:GetTalentValue("modifier_lina_dragon_7", "cd", true)/100,
    q7_cast = caster:GetTalentValue("modifier_lina_dragon_7", "cast", true)/100,
    q7_linger = caster:GetTalentValue("modifier_lina_dragon_7", "linger", true),
    q7_count = caster:GetTalentValue("modifier_lina_dragon_7", "count", true),
    q7_mana = caster:GetTalentValue("modifier_lina_dragon_7", "mana", true)/100,
    q7_visual_max = 5,
    
    has_h3 = 0,
    h3_mana = 0,
    h3_health = 0,
    h3_duration = caster:GetTalentValue("modifier_lina_hero_3", "duration", true),
    h3_count = caster:GetTalentValue("modifier_lina_hero_3", "count", true), 

    has_w7 = 0,
  }
end

if caster:HasTalent("modifier_lina_dragon_1") then
  self.talents.has_q1 = 1
  self.talents.q1_damage = caster:GetTalentValue("modifier_lina_dragon_1", "damage")
  self.talents.q1_spell = caster:GetTalentValue("modifier_lina_dragon_1", "spell")
end

if caster:HasTalent("modifier_lina_dragon_2") then
  self.talents.has_q2 = 1
  self.talents.q2_cd = caster:GetTalentValue("modifier_lina_dragon_2", "cd")
  self.talents.q2_slow = caster:GetTalentValue("modifier_lina_dragon_2", "slow")
end

if caster:HasTalent("modifier_lina_dragon_3") then
  self.talents.has_q3 = 1
  self.talents.q3_damage = caster:GetTalentValue("modifier_lina_dragon_3", "damage")/100
end

if caster:HasTalent("modifier_lina_dragon_4") then
  self.talents.has_q4 = 1
  self.caster:AddSpellEvent(self.tracker, true)
end

if caster:HasTalent("modifier_lina_dragon_7") then
  self.talents.has_q7 = 1
  if IsServer() and name == "modifier_lina_dragon_7" then
    self.caster:AddSpellEvent(self.tracker, true)
    self.tracker:UpdateUI()
  end
end

if caster:HasTalent("modifier_lina_hero_3") then
  self.talents.has_h3 = 1
  self.talents.h3_mana = caster:GetTalentValue("modifier_lina_hero_3", "mana")/100
  self.talents.h3_health = caster:GetTalentValue("modifier_lina_hero_3", "health")
  if IsServer() then
    self.caster:AddSpellEvent(self.tracker, true)
    self.caster:CalculateStatBonus(true)
  end
end

if caster:HasTalent("modifier_lina_array_7") then
  self.talents.has_w7 = 1
end

end

function lina_dragon_slave_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_lina_dragon_slave_custom_tracker"
end

function lina_dragon_slave_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "lina_dragon_slave", self)
end

function lina_dragon_slave_custom:GetCastPoint()
local k = 1
if self.caster:HasModifier("modifier_lina_dragon_slave_custom_legendary") then
  k = 1 + self.talents.q7_cast
end
return self.BaseClass.GetCastPoint(self)*k
end

function lina_dragon_slave_custom:GetManaCost(level)
return self.BaseClass.GetManaCost(self,level) * (1 + (self.caster:HasModifier("modifier_lina_dragon_slave_custom_legendary") and self.talents.q7_mana or 0))
end

function lina_dragon_slave_custom:GetCooldown(iLevel)
local k = 1
if self.caster:HasModifier("modifier_lina_dragon_slave_custom_legendary") then
  k = 1 + self.talents.q7_cd
end
return (self.BaseClass.GetCooldown(self, iLevel) + (self.talents.q2_cd and self.talents.q2_cd or 0))*k
end

function lina_dragon_slave_custom:OnSpellStart(new_target, damage_ability)
local target = self:GetCursorTarget()
local point = self:GetCursorPosition()
local ability = nil
if new_target then 
  target = new_target
end
if damage_ability then
  ability = damage_ability
end 
if target then 
  point = target:GetAbsOrigin()  
end
if point == self.caster:GetAbsOrigin() then 
  point = point + self.caster:GetForwardVector()*10
end

local direction = point-self.caster:GetAbsOrigin()
direction.z = 0
local projectile_normalized = direction:Normalized()

local sound = wearables_system:GetSoundReplacement(self.caster, "Hero_Lina.DragonSlave.Cast", self)
local particle = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_lina/lina_spell_dragon_slave.vpcf", self)

local info = {
    Source = self.caster,
    Ability = self,
    vSpawnOrigin = self.caster:GetAbsOrigin(),
    bDeleteOnHit = false,
    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    EffectName = particle,
    fDistance = self.dragon_slave_distance + self.caster:GetCastRangeBonus(),
    fStartRadius = self.dragon_slave_width_initial,
    fEndRadius = self.dragon_slave_width_end,
    vVelocity = projectile_normalized * self.dragon_slave_speed,
    bProvidesVision = false,
    ExtraData =
    {
      x = self.caster:GetAbsOrigin().x,
      y = self.caster:GetAbsOrigin().y,
      damage_ability = ability,
    }
}

ProjectileManager:CreateLinearProjectile(info)
self.caster:EmitSound(sound)
self.caster:EmitSound("Hero_Lina.DragonSlave")
end

function lina_dragon_slave_custom:OnProjectileHit_ExtraData(target, vLocation, table)
if not IsServer() then return end
if not target then return end

local damage = self.dragon_slave_damage + self.talents.q1_damage

if self.talents.has_q2 == 1 then 
  target:AddNewModifier(self.caster, self, "modifier_lina_dragon_slave_custom_slow", {duration = self.talents.q2_duration})
end

if target:IsRealHero() and self.caster:GetQuest() == "Lina.Quest_5" and (self.caster:GetAbsOrigin() - target:GetAbsOrigin()):Length2D() >= self.caster.quest.number then 
  self.caster:UpdateQuest(1)
end

if self.caster:GetQuest() == "Lina.Quest_7" and target:IsRealHero() and not self.caster:QuestCompleted() then 
  target:AddNewModifier(self.caster, self, "modifier_lina_fiery_soul_custom_quest", {duration = self.caster.quest.number})
end

local damage_ability = table.damage_ability
local damage_k = 1
if damage_ability == "modifier_lina_dragon_4" then 
  damage_k = self.talents.q4_damage
end 
damage = damage*damage_k

if IsValid(self.caster.lina_innate) then
  local burn_damage = self.talents.has_q3 == 1 and target:GetMaxHealth()*self.talents.q3_damage or 0
  self.caster.lina_innate:ApplyBurn(target, damage, burn_damage*damage_k)
end

DoDamage({ victim = target, attacker = self.caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self}, damage_ability)

local particle_impact = wearables_system:GetParticleReplacementAbility(self.caster, "particles/units/heroes/hero_lina/lina_spell_dragon_slave_impact.vpcf", self)
if particle_impact == "particles/units/heroes/hero_lina/lina_spell_dragon_slave_impact.vpcf" then return end
if not table.x or not table.y then return end 

local cast_point = GetGroundPosition(Vector(table.x, table.y, 0), nil)

local direction = vLocation - cast_point
direction.z = 0
direction = direction:Normalized()

local particle = ParticleManager:CreateParticle(particle_impact, PATTACH_ABSORIGIN_FOLLOW, target )
ParticleManager:SetParticleControlForward( particle, 1, direction )
ParticleManager:ReleaseParticleIndex( particle )
end


modifier_lina_dragon_slave_custom_tracker = class(mod_hidden)
function modifier_lina_dragon_slave_custom_tracker:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.dragon_ability = self.ability

self.ability.dragon_slave_damage = self.ability:GetSpecialValueFor("dragon_slave_damage")
self.ability.dragon_slave_speed = self.ability:GetSpecialValueFor("dragon_slave_speed")
self.ability.dragon_slave_width_initial = self.ability:GetSpecialValueFor("dragon_slave_width_initial")
self.ability.dragon_slave_width_end = self.ability:GetSpecialValueFor("dragon_slave_width_end")
self.ability.dragon_slave_distance = self.ability:GetSpecialValueFor("dragon_slave_distance")
end

function modifier_lina_dragon_slave_custom_tracker:OnRefresh()
self.ability.dragon_slave_damage = self.ability:GetSpecialValueFor("dragon_slave_damage")
end

function modifier_lina_dragon_slave_custom_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
  MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
}
end

function modifier_lina_dragon_slave_custom_tracker:GetModifierSpellAmplify_Percentage()
return self.ability.talents.q1_spell
end

function modifier_lina_dragon_slave_custom_tracker:GetModifierExtraHealthPercentage()
return self.ability.talents.h3_health
end

function modifier_lina_dragon_slave_custom_tracker:SpellEvent( params )
if not IsServer() then return end
if params.unit ~= self.parent then return end

if self.ability.talents.has_h3 == 1 or self.ability.talents.has_q4 == 1 then 
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_lina_dragon_slave_custom_proc", {duration = self.ability.talents.h3_duration, dragon = params.ability == self.ability})
end 

if self.ability.talents.has_q7 == 0 then return end
if self.parent:HasModifier("modifier_lina_dragon_slave_custom_legendary") then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_lina_dragon_slave_custom_legendary_stack", {duration = self.ability.talents.q7_linger})
end

function modifier_lina_dragon_slave_custom_tracker:UpdateUI()
if not IsServer() then return end
if self.ability.talents.has_q7 == 0 then return end
if self.ability.talents.has_w7 == 1 then return end

local stack = 0
local active = 0
local zero = false
local max = self.ability.talents.q7_count
local mod = self.parent:FindModifierByName("modifier_lina_dragon_slave_custom_legendary_stack")
local active_mod = self.parent:FindModifierByName("modifier_lina_dragon_slave_custom_legendary")

if mod then
  stack = mod:GetStackCount()
end

if active_mod then
  max = self.ability.talents.q7_duration
  stack = active_mod:GetRemainingTime()
  active = 1
  zero = 1
end

if mod or active_mod then
  if self.particle then
    ParticleManager:DestroyParticle(self.particle, true)
    ParticleManager:ReleaseParticleIndex(self.particle)
    self.particle = nil
  end
elseif not self.particle then
  self.particle = self.parent:GenericParticle("particles/lina/soul_stack.vpcf", self, true)
  for i = 1,self.ability.talents.q7_visual_max do 
    ParticleManager:SetParticleControl(self.particle, i, Vector(0, 0, 0)) 
  end
end

self.parent:UpdateUIlong({stack = stack, max = max, use_zero = zero, active = active, style = "LinaDragon"})
end


modifier_lina_dragon_slave_custom_legendary_stack = class(mod_hidden)
function modifier_lina_dragon_slave_custom_legendary_stack:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.max = self.ability.talents.q7_count
self.radius = self.ability.talents.q7_radius
self.duration = self.ability.talents.q7_linger
if not IsServer() then return end

self.visual_max = self.ability.talents.q7_visual_max
self.particle = self.parent:GenericParticle("particles/lina/soul_stack.vpcf", self, true)

self:OnRefresh()
self:StartIntervalThink(0.5)
end

function modifier_lina_dragon_slave_custom_legendary_stack:OnIntervalThink()
if not IsServer() then return end
local targets = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false )

if #targets > 0 then
  self:SetDuration(self.duration, true)
end

end

function modifier_lina_dragon_slave_custom_legendary_stack:OnRefresh()
if not IsServer() then return end
self:IncrementStackCount()
if self:GetStackCount() < self.max then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_lina_dragon_slave_custom_legendary", {duration = self.ability.talents.q7_duration})
self:Destroy()
end

function modifier_lina_dragon_slave_custom_legendary_stack:OnStackCountChanged()
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

function modifier_lina_dragon_slave_custom_legendary_stack:OnDestroy()
if not IsServer() then return end

if self.ability.tracker then
  self.ability.tracker:UpdateUI()
end

end

modifier_lina_dragon_slave_custom_legendary = class(mod_hidden)
function modifier_lina_dragon_slave_custom_legendary:GetEffectName() return "particles/huskar_spears_legen.vpcf" end
function modifier_lina_dragon_slave_custom_legendary:GetStatusEffectName() return "particles/status_fx/status_effect_omnislash.vpcf" end
function modifier_lina_dragon_slave_custom_legendary:StatusEffectPriority() return MODIFIER_PRIORITY_ULTRA end
function modifier_lina_dragon_slave_custom_legendary:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.status = self.ability.talents.q7_status

if not IsServer() then return end
self.RemoveForDuel = true

local cd = self.ability:GetCooldownTimeRemaining()
if cd > 0 then
  self.parent:CdAbility(self.ability, cd*self.ability.talents.q7_cd)
end

self.parent:EmitSound("Lina.Dragon_status")
self.parent:EmitSound("Lina.Dragon_legendary")

self.parent:GenericParticle("particles/ember_spirit/chains_bkb.vpcf", self)

self.particle = self.parent:GenericParticle("particles/lina/soul_stack.vpcf", self, true)
for i = 1,self.ability.talents.q7_visual_max do 
  ParticleManager:SetParticleControl(self.particle, i, Vector(1, 0, 0)) 
end

local particle_peffect = ParticleManager:CreateParticle("particles/mars_revenge_proc.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(particle_peffect, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_peffect, 2, self.parent:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(particle_peffect)

self:OnIntervalThink()
self:StartIntervalThink(0.1)
end

function modifier_lina_dragon_slave_custom_legendary:OnIntervalThink()
if not IsServer() then return end
if not self.ability.tracker then return end
self.ability.tracker:UpdateUI()
end

function modifier_lina_dragon_slave_custom_legendary:OnDestroy()
if not IsServer() then return end
if not self.ability.tracker then return end
self.ability.tracker:UpdateUI()
end

function modifier_lina_dragon_slave_custom_legendary:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
  MODIFIER_PROPERTY_MODEL_SCALE,
}
end

function modifier_lina_dragon_slave_custom_legendary:GetModifierModelScale()
return 20
end

function modifier_lina_dragon_slave_custom_legendary:GetModifierStatusResistanceStacking()
return self.status
end

function modifier_lina_dragon_slave_custom_legendary:CheckState()
return
{
  [MODIFIER_STATE_FORCED_FLYING_VISION] = true, 
}
end

modifier_lina_dragon_slave_custom_slow = class(mod_hidden)
function modifier_lina_dragon_slave_custom_slow:IsPurgable() return true end
function modifier_lina_dragon_slave_custom_slow:GetEffectName() return "particles/lina_attack_slow.vpcf" end
function modifier_lina_dragon_slave_custom_slow:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_lina_dragon_slave_custom_slow:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.slow = self.ability.talents.q2_slow
end 

function modifier_lina_dragon_slave_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end


modifier_lina_dragon_slave_custom_proc = class(mod_visible)
function modifier_lina_dragon_slave_custom_proc:GetTexture() return "buffs/lina/hero_3" end
function modifier_lina_dragon_slave_custom_proc:OnCreated(table)
if not IsServer() then return end 
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.RemoveForDuel = true
self.max = self.ability.talents.h3_count 
self:OnRefresh()
end 

function modifier_lina_dragon_slave_custom_proc:OnRefresh(table)
if not IsServer() then return end 

self:IncrementStackCount()

if self:GetStackCount() < self.max then return end

if self.ability.talents.has_h3 == 1 then 
  local mana = self.parent:GetMaxMana()*self.ability.talents.h3_mana
  self.parent:GenericParticle("particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_essence_effect.vpcf")
  self.parent:EmitSound("Lina.Dragon_heal")

  self.parent:GenericHeal(mana, self.ability, false, "", "modifier_lina_hero_3")
  self.parent:GiveMana(mana)
end

if self.ability.talents.has_q4 == 1 then
  self.parent:CdItems(self.ability.talents.q4_cd_items)
  local target = self.parent:RandomTarget(self.ability.talents.q4_range)
  if target then
    local delay = 0
    if table.dragon == 1 then
      delay = 0.25
    end
    Timers:CreateTimer(delay, function()
      self.ability:OnSpellStart(target, "modifier_lina_dragon_4")
    end)
  end 
end

self:Destroy()
end

