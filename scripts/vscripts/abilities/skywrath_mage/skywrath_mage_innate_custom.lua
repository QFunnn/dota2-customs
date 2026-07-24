--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_skywrath_mage_innate_custom", "abilities/skywrath_mage/skywrath_mage_innate_custom", LUA_MODIFIER_MOTION_NONE )


skywrath_mage_innate_custom = class({})

function skywrath_mage_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "soundfile", "soundevents/vo_custom/skywrath_mage_vo_custom.vsndevts", context ) 
PrecacheResource( "soundfile", "soundevents/npc_dota_hero_skywrath_mage.vsndevts", context )
dota1x6:PrecacheShopItems("npc_dota_hero_skywrath_mage", context)
end


function skywrath_mage_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_skywrath_mage_innate_custom"
end



modifier_skywrath_mage_innate_custom = class({})
function modifier_skywrath_mage_innate_custom:IsHidden() return true end
function modifier_skywrath_mage_innate_custom:IsPurgable() return false end
function modifier_skywrath_mage_innate_custom:RemoveOnDeath() return false end
function modifier_skywrath_mage_innate_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:AddDamageEvent_out(self)
self.parent:AddHealEvent_inc(self)

self.seal_health = self.parent:GetTalentValue("modifier_sky_seal_4", "health", true)
self.seal_duration = self.parent:GetTalentValue("modifier_sky_seal_4", "duration", true)
self.heal_count = 0

self.heal_bonus = self.parent:GetTalentValue("modifier_sky_flare_2", "bonus", true)

self.seal = self.parent:FindAbilityByName("skywrath_mage_ancient_seal_custom")

self.creeps = self.ability:GetSpecialValueFor("creeps")
self.lifesteal = self.ability:GetSpecialValueFor("lifesteal")/100
end

function modifier_skywrath_mage_innate_custom:OnRefresh(table)
self.lifesteal = self.ability:GetSpecialValueFor("lifesteal")/100
end


function modifier_skywrath_mage_innate_custom:DamageEvent_out(params)
if self.parent:PassivesDisabled() then return end
if not self.parent:CheckLifesteal(params, 1 ) then return end

local heal = self.lifesteal

if self.parent:HasTalent("modifier_sky_seal_4") and params.unit:HasModifier("modifier_skywrath_mage_ancient_seal_custom_silence") then 
  heal = heal + self.parent:GetTalentValue("modifier_sky_seal_4", "heal")/100
end

if self.parent:HasTalent("modifier_sky_flare_2") then 
  local bonus = self.parent:GetTalentValue("modifier_sky_flare_2", "heal")/100
  if params.inflictor and params.inflictor:GetName() == "skywrath_mage_mystic_flare_custom" then 
    bonus = bonus*self.heal_bonus
  end
  heal = heal + bonus
end

if params.unit:IsCreep() then 
  heal = heal / self.creeps
end

self.parent:GenericHeal(params.damage*heal, self.ability, true, "particles/items3_fx/octarine_core_lifesteal.vpcf")
end


function modifier_skywrath_mage_innate_custom:HealEvent_inc(params)
if not IsServer() then return end 
if not self.parent:HasTalent("modifier_sky_seal_4") then return end
if self.parent ~= params.unit then return end
if self.parent:GetHealth() >= self.parent:GetMaxHealth() then return end
if not self.seal or not self.seal:IsTrained() then return end

local gain = math.min(params.gain, self.parent:GetMaxHealth() - self.parent:GetHealth())
local final = self.heal_count + gain

if final >= self.seal_health then 

  local delta = math.floor(final/self.seal_health)

  for i = 1, delta do 
    self.parent:AddNewModifier(self.parent, self.seal, "modifier_skywrath_mage_ancient_seal_custom_damage", {duration = self.seal_duration})
  end 

  self.heal_count = final - delta*self.seal_health
else 
  self.heal_count = final
end

end