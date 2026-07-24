--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_broodmother_incapacitating_bite_custom_tracker", "abilities/broodmother/broodmother_incapacitating_bite_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_broodmother_incapacitating_bite_custom", "abilities/broodmother/broodmother_incapacitating_bite_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_broodmother_incapacitating_bite_custom_speed", "abilities/broodmother/broodmother_incapacitating_bite_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_broodmother_incapacitating_bite_custom_bash_cd", "abilities/broodmother/broodmother_incapacitating_bite_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_broodmother_incapacitating_bite_custom_armor", "abilities/broodmother/broodmother_incapacitating_bite_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_broodmother_incapacitating_bite_custom_legendary_stack", "abilities/broodmother/broodmother_incapacitating_bite_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_broodmother_incapacitating_bite_custom_legendary_active", "abilities/broodmother/broodmother_incapacitating_bite_custom", LUA_MODIFIER_MOTION_NONE )

broodmother_incapacitating_bite_custom = class({})
broodmother_incapacitating_bite_custom.talents = {}
broodmother_incapacitating_bite_custom.legendary_stack = nil
broodmother_incapacitating_bite_custom.legendary_active = nil

function broodmother_incapacitating_bite_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_broodmother/broodmother_incapacitatingbite_debuff.vpcf", context )
PrecacheResource( "particle", "particles/hoodwink/bush_damage.vpcf", context )
PrecacheResource( "particle", "particles/broodmother/bite_stack.vpcf", context )
PrecacheResource( "particle", "particles/lc_odd_charge_mark.vpcf", context )
PrecacheResource( "particle", "particles/econ/items/troll_warlord/troll_warlord_ti7_axe/troll_ti7_axe_bash_explosion.vpcf", context )
PrecacheResource( "particle", "particles/broodmother/bite_legendary_hit.vpcf", context )
end

function broodmother_incapacitating_bite_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_e1 = 0,
    e1_speed = 0,
    
    has_e2 = 0,
    e2_range = 0,
    e2_damage_reduce = 0,
    
    has_e3 = 0,
    e3_crit = 0,
    e3_armor = 0,
    e3_chance = caster:GetTalentValue("modifier_broodmother_bite_3", "chance", true),
    e3_duration = caster:GetTalentValue("modifier_broodmother_bite_3", "duration", true),
    e3_max = caster:GetTalentValue("modifier_broodmother_bite_3", "max", true),
    
    has_e4 = 0,
    e4_stun = caster:GetTalentValue("modifier_broodmother_bite_4", "stun", true),
    e4_chance = caster:GetTalentValue("modifier_broodmother_bite_4", "chance", true),
    e4_chance_hero = caster:GetTalentValue("modifier_broodmother_bite_4", "chance_hero", true),
    e4_talent_cd = caster:GetTalentValue("modifier_broodmother_bite_4", "talent_cd", true),
    
    has_e7 = 0,
    e7_stun = caster:GetTalentValue("modifier_broodmother_bite_7", "stun", true),
    e7_duration = caster:GetTalentValue("modifier_broodmother_bite_7", "duration", true),
    e7_damage = caster:GetTalentValue("modifier_broodmother_bite_7", "damage", true),
    e7_spider = caster:GetTalentValue("modifier_broodmother_bite_7", "spider", true),
    e7_max = caster:GetTalentValue("modifier_broodmother_bite_7", "max", true),
    e7_linger = caster:GetTalentValue("modifier_broodmother_bite_7", "linger", true),
    e7_talent_cd = caster:GetTalentValue("modifier_broodmother_bite_7", "talent_cd", true),
    
    has_h2 = 0,
    h2_magic = 0,
    h2_armor = 0,
    h2_health = caster:GetTalentValue("modifier_broodmother_hero_2", "health", true),
    h2_bonus = caster:GetTalentValue("modifier_broodmother_hero_2", "bonus", true),
  }
end

if caster:HasTalent("modifier_broodmother_bite_1") then
  self.talents.has_e1 = 1
  self.talents.e1_speed = caster:GetTalentValue("modifier_broodmother_bite_1", "speed")
end

if caster:HasTalent("modifier_broodmother_bite_2") then
  self.talents.has_e2 = 1
  self.talents.e2_range = caster:GetTalentValue("modifier_broodmother_bite_2", "range")
  self.talents.e2_damage_reduce = caster:GetTalentValue("modifier_broodmother_bite_2", "damage_reduce")
end

if caster:HasTalent("modifier_broodmother_bite_3") then
  self.talents.has_e3 = 1
  self.talents.e3_crit = caster:GetTalentValue("modifier_broodmother_bite_3", "crit")
  self.talents.e3_armor = caster:GetTalentValue("modifier_broodmother_bite_3", "armor")
end

if caster:HasTalent("modifier_broodmother_bite_4") then
  self.talents.has_e4 = 1
end

if caster:HasTalent("modifier_broodmother_bite_7") then
  self.talents.has_e7 = 1
  if IsServer() then
    self.tracker:UpdateUI()
  end
end

if caster:HasTalent("modifier_broodmother_hero_2") then
  self.talents.has_h2 = 1
  self.talents.h2_magic = caster:GetTalentValue("modifier_broodmother_hero_2", "magic")
  self.talents.h2_armor = caster:GetTalentValue("modifier_broodmother_hero_2", "armor")
end

end

function broodmother_incapacitating_bite_custom:GetCooldown(level)
return ((self.talents.e7_talent_cd and self.talents.has_e7 == 1) and self.talents.e7_talent_cd or 0)
end

function broodmother_incapacitating_bite_custom:GetBehavior()
if self.talents.has_e7 == 1 then
  return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end
return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function broodmother_incapacitating_bite_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_broodmother_incapacitating_bite_custom_tracker"
end

function broodmother_incapacitating_bite_custom:OnAbilityPhaseStart()
local target = self:GetCursorTarget()
if not target then return false end

local mod = target:FindModifierByName("modifier_broodmother_incapacitating_bite_custom_legendary_stack")
if mod and mod:GetStackCount() >= self.talents.e7_max then
  return true
end

CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID()), "CreateIngameErrorMessage", {message = "#brood_bite_error"})
return false
end

function broodmother_incapacitating_bite_custom:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()
local mod = target:FindModifierByName("modifier_broodmother_incapacitating_bite_custom_legendary_stack")

if not mod then return end
mod:Destroy()

caster:EmitSound("Brood.Bite_legendary_caster_vo")
caster:EmitSound("Brood.Bite_legendary_caster")
target:EmitSound("Brood.Bite_legendary_active")
target:EmitSound("Brood.Bite_legendary_active2")

local particle = ParticleManager:CreateParticle("particles/econ/items/troll_warlord/troll_warlord_ti7_axe/troll_ti7_axe_bash_explosion.vpcf", PATTACH_OVERHEAD_FOLLOW, target)
ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())
ParticleManager:Delete(particle, 1)

for i = 1,2 do
  local particle2 = ParticleManager:CreateParticle("particles/broodmother/bite_legendary_hit.vpcf", PATTACH_CUSTOMORIGIN, caster)
  ParticleManager:SetParticleControlEnt(particle2, 0, caster, PATTACH_POINT_FOLLOW, "attach_thorax", caster:GetAbsOrigin(), true)
  ParticleManager:SetParticleControlEnt(particle2, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
  ParticleManager:ReleaseParticleIndex(particle2)
end

target:AddNewModifier(caster, caster:BkbAbility(self, true), "modifier_stunned", {duration = self.talents.e7_stun*(1 - target:GetStatusResistance())})
target:AddNewModifier(caster, caster:BkbAbility(self, true), "modifier_broodmother_incapacitating_bite_custom_legendary_active", {duration = self.talents.e7_duration})
end


modifier_broodmother_incapacitating_bite_custom_tracker = class(mod_hidden)
function modifier_broodmother_incapacitating_bite_custom_tracker:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.bite_ability = self.ability

self.ability.miss_chance = self.ability:GetSpecialValueFor("miss_chance")
self.ability.bonus_movespeed = self.ability:GetSpecialValueFor("bonus_movespeed")
self.ability.attack_damage = self.ability:GetSpecialValueFor("attack_damage") 
self.ability.creeps = self.ability:GetSpecialValueFor("creeps") 
self.ability.duration = self.ability:GetSpecialValueFor("duration") 
end

function modifier_broodmother_incapacitating_bite_custom_tracker:OnRefresh()
self.ability.miss_chance = self.ability:GetSpecialValueFor("miss_chance")
self.ability.bonus_movespeed = self.ability:GetSpecialValueFor("bonus_movespeed")
self.ability.attack_damage = self.ability:GetSpecialValueFor("attack_damage")
self.ability.creeps = self.ability:GetSpecialValueFor("creeps")  
end

function modifier_broodmother_incapacitating_bite_custom_tracker:UpdateUI()
if not IsServer() then return end
if self.ability.talents.has_e7 == 0 then return end

local max = self.ability.talents.e7_max
local stack = 0
local hide = nil
local hide_active = 1
local time_active = 0
if IsValid(self.ability.legendary_stack) then
  stack = self.ability.legendary_stack:GetStackCount()
end
if IsValid(self.ability.legendary_active) then
  hide = 1
  hide_active = 0
  time_active = self.ability.legendary_active:GetRemainingTime()
end

self.parent:UpdateUIlong({max = max, stack = stack, hide = hide, style = "BroodBite"})
self.parent:UpdateUIshort({max_time = self.ability.talents.e7_duration, time = time_active, stack = "+"..self.ability.talents.e7_damage.."%", hide = hide_active, hide_full = hide_active, style = "BroodBite"})
end

function modifier_broodmother_incapacitating_bite_custom_tracker:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
  MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
  MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end

function modifier_broodmother_incapacitating_bite_custom_tracker:GetModifierAttackRangeBonus()
return self.ability.talents.e2_range
end

function modifier_broodmother_incapacitating_bite_custom_tracker:GetModifierPhysicalArmorBonus()
return self.ability.talents.h2_armor*(self.parent:GetHealthPercent() <= self.ability.talents.h2_health and self.ability.talents.h2_bonus or 1)
end

function modifier_broodmother_incapacitating_bite_custom_tracker:GetModifierMagicalResistanceBonus()
return self.ability.talents.h2_magic*(self.parent:GetHealthPercent() <= self.ability.talents.h2_health and self.ability.talents.h2_bonus or 1)
end



modifier_broodmother_incapacitating_bite_custom = class(mod_visible)
function modifier_broodmother_incapacitating_bite_custom:IsPurgable() return true end
function modifier_broodmother_incapacitating_bite_custom:GetTexture() return "broodmother_incapacitating_bite" end
function modifier_broodmother_incapacitating_bite_custom:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self.caster.bite_ability

if not IsValid(self.ability) then return end

self.miss = self.ability.miss_chance
self.slow = self.ability.bonus_movespeed
self.damage = self.ability.attack_damage
self.creeps = self.ability.creeps
self.damage_reduce = self.ability.talents.e2_damage_reduce

if not IsServer() then return end
self.parent:GenericParticle("particles/units/heroes/hero_broodmother/broodmother_incapacitatingbite_debuff.vpcf", self)

self.quest = self.parent:IsRealHero() and self.caster:GetQuest() == "Brood.Quest_7"

if self.ability.talents.has_e3 == 0 and self.ability.talents.has_e7 == 0 and not self.quest then return end

self.interval = 0.25
self:OnIntervalThink(true)
self:StartIntervalThink(self.interval - 0.01)
end

function modifier_broodmother_incapacitating_bite_custom:OnIntervalThink(first)
if not IsServer() then return end

if self.quest and not first then
  self.caster:UpdateQuest(self.interval)
end

if self.ability.talents.has_e3 == 1 then
  self.parent:AddNewModifier(self.caster, self.ability, "modifier_broodmother_incapacitating_bite_custom_armor", {duration = self.ability.talents.e3_duration, interval = self.interval})
end

if self.ability.talents.has_e7 == 1 and self.ability:GetCooldownTimeRemaining() <= 0 and not self.parent:HasModifier("modifier_broodmother_incapacitating_bite_custom_legendary_active") then
  self.parent:AddNewModifier(self.caster, self.ability, "modifier_broodmother_incapacitating_bite_custom_legendary_stack", {duration = self.ability.talents.e7_linger, interval = self.interval})
end

end

function modifier_broodmother_incapacitating_bite_custom:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
  MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_TARGET,
  MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
  MODIFIER_PROPERTY_MISS_PERCENTAGE
}
end

function modifier_broodmother_incapacitating_bite_custom:GetModifierSpellAmplify_Percentage()
return self.damage_reduce
end

function modifier_broodmother_incapacitating_bite_custom:GetModifierDamageOutgoing_Percentage()
return self.damage_reduce
end

function modifier_broodmother_incapacitating_bite_custom:GetModifierPreAttack_BonusDamage_Target(params)
return (params.attacker and params.attacker == self.caster and self.parent:IsCreep()) and self.creeps or self.damage
end

function modifier_broodmother_incapacitating_bite_custom:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_broodmother_incapacitating_bite_custom:GetModifierMiss_Percentage(params)
if params.target and params.target:IsBuilding() then return end
return self.miss
end


modifier_broodmother_incapacitating_bite_custom_speed = class(mod_visible)
function modifier_broodmother_incapacitating_bite_custom_speed:GetTexture() return "buffs/broodmother/bite_1" end
function modifier_broodmother_incapacitating_bite_custom_speed:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.speed = self.ability.talents.e1_speed
end

function modifier_broodmother_incapacitating_bite_custom_speed:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_broodmother_incapacitating_bite_custom_speed:GetModifierAttackSpeedBonus_Constant()
return self.speed
end


modifier_broodmother_incapacitating_bite_custom_bash_cd = class(mod_hidden)


modifier_broodmother_incapacitating_bite_custom_armor = class(mod_visible)
function modifier_broodmother_incapacitating_bite_custom_armor:GetTexture() return "buffs/broodmother/bite_3" end
function modifier_broodmother_incapacitating_bite_custom_armor:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max = self.ability.talents.e3_max
self.armor = self.ability.talents.e3_armor/self.max
self.crit = self.ability.talents.e3_crit

if not IsServer() then return end
self.count = -1
self.max_timer = 1/table.interval
self:AddStack()
end

function modifier_broodmother_incapacitating_bite_custom_armor:OnRefresh(table)
if not IsServer() then return end
self:AddStack()
end

function modifier_broodmother_incapacitating_bite_custom_armor:AddStack()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self.count = self.count + 1
if self.count < self.max_timer then return end
self.count = 0
self:IncrementStackCount()

if self:GetStackCount() >= self.max then
  self.parent:EmitSound("Brood.Bite_armor")
  self.parent:GenericParticle("particles/hoodwink/bush_damage.vpcf", self)
end

end

function modifier_broodmother_incapacitating_bite_custom_armor:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
  MODIFIER_PROPERTY_PREATTACK_TARGET_CRITICALSTRIKE
}
end

function modifier_broodmother_incapacitating_bite_custom_armor:GetModifierPhysicalArmorBonus()
return self.armor*self:GetStackCount()
end

function modifier_broodmother_incapacitating_bite_custom_armor:GetModifierPreAttack_Target_CriticalStrike(params)
if not IsServer() then return end
if self:GetStackCount() < self.max then return end
local attacker = params.attacker
if attacker.owner then
  attacker = attacker.owner
end
if attacker ~= self.caster then return end
if not RollPseudoRandomPercentage(self.ability.talents.e3_chance, 5121, params.attacker) then return end

return self.crit
end


modifier_broodmother_incapacitating_bite_custom_legendary_stack = class(mod_hidden)
function modifier_broodmother_incapacitating_bite_custom_legendary_stack:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max = self.ability.talents.e7_max

if not IsServer() then return end

if self.parent:IsRealHero() and not self.ability.legendary_stack then
  self.ability.legendary_stack = self
end

self.effect_cast = self.parent:GenericParticle("particles/broodmother/bite_stack.vpcf", self, true)
self.max_timer = 1/table.interval
self.count = -1
self:AddStack()
end

function modifier_broodmother_incapacitating_bite_custom_legendary_stack:OnRefresh(table)
if not IsServer() then return end
self:AddStack()
end

function modifier_broodmother_incapacitating_bite_custom_legendary_stack:AddStack()
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self.count = self.count + 1
if self.count < self.max_timer then return end
self.count = 0
self:IncrementStackCount()

if self:GetStackCount() >= self.max then
  self.parent:GenericParticle("particles/lc_odd_charge_mark.vpcf", self, true)
  if self.effect_cast then
    ParticleManager:DestroyParticle(self.effect_cast, false)
    ParticleManager:ReleaseParticleIndex(self.effect_cast)
    self.effect_cast = nil
  end
end

end

function modifier_broodmother_incapacitating_bite_custom_legendary_stack:OnStackCountChanged(iStackCount)
if not self.effect_cast then return end
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )

if IsValid(self.ability.tracker) and self.ability.legendary_stack == self then
  self.ability.tracker:UpdateUI()
end

end

function modifier_broodmother_incapacitating_bite_custom_legendary_stack:OnDestroy()
if not IsServer() then return end

if self.ability.legendary_stack == self then
  self.ability.legendary_stack = nil
  if IsValid(self.ability.tracker) then
    self.ability.tracker:UpdateUI()
  end
end

end



modifier_broodmother_incapacitating_bite_custom_legendary_active = class(mod_hidden)
function modifier_broodmother_incapacitating_bite_custom_legendary_active:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self.caster.bite_ability
self.RemoveForDuel = true

if not IsServer() then return end
if not IsValid(self.ability) then return end
self.parent:GenericParticle("particles/general/generic_armor_reduction.vpcf", self, true)
self.ability.legendary_active = self
self.ability:EndCd()

self:StartIntervalThink(0.1)
self:OnIntervalThink()
end

function modifier_broodmother_incapacitating_bite_custom_legendary_active:OnIntervalThink()
if not IsServer() then return end
if not IsValid(self.ability.tracker) then return end
self.ability.tracker:UpdateUI()
end

function modifier_broodmother_incapacitating_bite_custom_legendary_active:OnDestroy()
if not IsServer() then return end
self.ability.legendary_active = nil
self:OnIntervalThink()
self.ability:StartCd()
end

function modifier_broodmother_incapacitating_bite_custom_legendary_active:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_broodmother_incapacitating_bite_custom_legendary_active:GetModifierIncomingDamage_Percentage(params)
if params.inflictor then return end
if IsServer() and (not params.attacker or params.attacker:FindOwner() ~= self.caster) then return end 
return self.caster == params.attacker and self.ability.talents.e7_damage or self.ability.talents.e7_spider
end

function modifier_broodmother_incapacitating_bite_custom_legendary_active:GetStatusEffectName() return "particles/status_fx/status_effect_rupture.vpcf" end
function modifier_broodmother_incapacitating_bite_custom_legendary_active:StatusEffectPriority() return MODIFIER_PRIORITY_ULTRA end 