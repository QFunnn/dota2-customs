--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_bloodseeker_sanguivore_custom", "abilities/bloodseeker/bloodseeker_innate_custom", LUA_MODIFIER_MOTION_NONE )

bloodseeker_innate_custom = class({})

function bloodseeker_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_bloodseeker_sanguivore_custom"
end

function bloodseeker_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "soundfile", "soundevents/npc_dota_hero_bloodseeker.vsndevts", context )
PrecacheResource( "particle", "particles/bloodseeker/shard_shield.vpcf", context )
dota1x6:PrecacheShopItems("npc_dota_hero_bloodseeker", context)
end

function bloodseeker_innate_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_h2 = 0,
    h2_shield_max = 0,
    h2_shield = 0,

    has_h3 = 0,
    h3_heal = 0,
    h3_health = caster:GetTalentValue("modifier_bloodseeker_hero_3", "health", true),
    h3_bonus = caster:GetTalentValue("modifier_bloodseeker_hero_3", "bonus", true),
  }
end

if caster:HasTalent("modifier_bloodseeker_hero_2") then
  self.talents.has_h2 = 1
  self.talents.h2_shield_max = caster:GetTalentValue("modifier_bloodseeker_hero_2", "shield_max")/100
  self.talents.h2_shield = caster:GetTalentValue("modifier_bloodseeker_hero_2", "shield")/100
end

if caster:HasTalent("modifier_bloodseeker_hero_3") then
  self.talents.has_h3 = 1
  self.talents.h3_heal = caster:GetTalentValue("modifier_bloodseeker_hero_3", "heal")/100
  caster:AddDamageEvent_out(self.tracker, true)
end

end


function bloodseeker_innate_custom:OnInventoryContentsChanged()
if not IsServer() then return end

if self.tracker then
	self.tracker:InitScepter()
end

end



modifier_bloodseeker_sanguivore_custom = class(mod_hidden)
function modifier_bloodseeker_sanguivore_custom:RemoveOnDeath() return false end
function modifier_bloodseeker_sanguivore_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.sanguivore_ability = self.ability

self.parent:AddDeathEvent(self, true)

self.scepter_shield = self.ability:GetSpecialValueFor("scepter_shield")/100
self.shield_max = self.ability:GetSpecialValueFor("shield_max")/100
self.heal_pct = self.ability:GetSpecialValueFor("heal_pct")/100
self:InitScepter()
end

function modifier_bloodseeker_sanguivore_custom:InitScepter()
if not IsServer() then return end
if self.init_scepter then return end
if not self.parent:HasScepter() then return end

self.init_scepter = true
self.parent:AddDamageEvent_out(self, true)
end

function modifier_bloodseeker_sanguivore_custom:DamageEvent_out(params)
if not IsServer() then return end
local target = params.unit

if self.parent ~= params.attacker then return end
if not target:IsUnit() then return end

local result = self.parent:CheckLifesteal(params)
if not result then return end

if self.ability.talents.has_h3 == 1 then
  local heal = self.ability.talents.h3_heal*params.damage
  local effect = ""
  if target:GetHealthPercent() <= self.ability.talents.h3_health then
    effect = "particles/items3_fx/octarine_core_lifesteal.vpcf"
    heal = heal*self.ability.talents.h3_bonus
  end
  self.parent:GenericHeal(heal*result, self.ability, true, effect, "modifier_bloodseeker_hero_3")
end

if self.parent:HasScepter() and target:HasModifier("modifier_bloodseeker_rupture_custom") then
  local shield = params.damage*self.scepter_shield*result
  self:AddShield(shield)
end

end


function modifier_bloodseeker_sanguivore_custom:DeathEvent(params)
if not IsServer() then return end 
if self.parent:PassivesDisabled() then return end
if not params.attacker then return end
if params.attacker ~= self.parent then return end
if not params.unit:IsUnit() then return end
if params.unit:IsIllusion() then return end


local effect = wearables_system:GetParticleReplacementAbility(self.parent, "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath.vpcf", self, "bloodseeker_bloodrage_custom")
local pfx = "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath.vpcf"
if effect == "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_eztzhok.vpcf" then
    pfx = ""
  local particle = ParticleManager:CreateParticle(effect, PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
  ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetAbsOrigin(), true )
  ParticleManager:SetParticleControlEnt( particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
  ParticleManager:ReleaseParticleIndex(particle)
end

self:AddShield(params.unit:GetMaxHealth()*self.heal_pct)
end

function modifier_bloodseeker_sanguivore_custom:AddShield(add_shield, is_bath)
if not IsServer() then return end
local max_shield = (self.parent:GetMaxHealth()*self.shield_max)*(1 + self.ability.talents.h2_shield_max)
local shield = add_shield
if is_bath then
  shield = max_shield*self.ability.talents.h2_shield
end

if not IsValid(self.active_shield) then
  self.active_shield = self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_shield",
  {
    max_shield = max_shield,
  })
  if self.active_shield then
    self.active_shield.RemoveForDuel = nil
    self.parent:GenericParticle("particles/bloodseeker/shard_shield.vpcf", self.active_shield)
  end
end

if self.active_shield then
  self.active_shield:AddShield(shield, max_shield)
end

end


function modifier_bloodseeker_sanguivore_custom:OnDestroy()
if not IsServer() then return end
if not IsValid(self.active_shield) then return end
self.active_shield:Destroy()
end
