--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_monkey_king_innate_custom", "abilities/monkey_king/monkey_king_innate_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_innate_custom_clone", "abilities/monkey_king/monkey_king_innate_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_innate_custom_tracker", "abilities/monkey_king/monkey_king_innate_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_mischief_invun", "abilities/monkey_king/monkey_king_innate_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_monkey_king_mischief_regen", "abilities/monkey_king/monkey_king_innate_custom.lua", LUA_MODIFIER_MOTION_NONE)

monkey_king_innate_custom = class({})
monkey_king_innate_custom.talents = {}

function monkey_king_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
  
PrecacheResource( "soundfile", "soundevents/npc_dota_hero_monkey_king.vsndevts", context )
PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_disguise.vpcf", context )
PrecacheResource( "particle", "particles/monkey_king/innate_marker.vpcf", context )
PrecacheResource( "soundfile", "soundevents/vo_custom/monkey_king_vo_custom.vsndevts", context ) 
dota1x6:PrecacheShopItems("npc_dota_hero_monkey_king", context)
end

function monkey_king_innate_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_h4 = 0,
    h4_invun = caster:GetTalentValue("modifier_monkey_king_hero_4", "invun", true),
    h4_cd = caster:GetTalentValue("modifier_monkey_king_hero_4", "cd", true),

    has_h6 = 0,
    h6_duration = caster:GetTalentValue("modifier_monkey_king_hero_6", "duration", true),
    h6_heal = caster:GetTalentValue("modifier_monkey_king_hero_6", "heal", true),
  }
end

if caster:HasTalent("modifier_monkey_king_hero_4") then
  self.talents.has_h4 = 1
end

if caster:HasTalent("modifier_monkey_king_hero_6") then
  self.talents.has_h6 = 1
end

end


function monkey_king_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_monkey_king_innate_custom_tracker"
end

function monkey_king_innate_custom:GetAbilityTextureName()
if self.caster:HasModifier("modifier_monkey_king_innate_custom") then
  return "monkey_king_untransform"
end
return "monkey_king_transfiguration"
end

function monkey_king_innate_custom:GetBehavior()
if self.caster:HasModifier("modifier_monkey_king_innate_custom") then
  return DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE
end
return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE
end

function monkey_king_innate_custom:GetCastRange()
return (self.AbilityCastRange and self.AbilityCastRange or 0) - self.caster:GetCastRangeBonus()
end

function monkey_king_innate_custom:GetCooldown(iLevel)
return self.BaseClass.GetCooldown(self, iLevel) + (self.talents.has_h4 == 1 and self.talents.h4_cd or 0)
end

function monkey_king_innate_custom:OnSpellStart()

local mod = self.caster:FindModifierByName("modifier_monkey_king_innate_custom")

if mod then 
  mod:Destroy()
  return
end 

if not IsValid(self.caster.command_ability) then return end

local point = self.caster:CastPosition(self:GetCursorPosition())
local clone = self.caster.command_ability:SpawnSoldier(point, self.duration, 1)

local point_2 = point + RandomVector(self.radius)
self.caster.command_ability:SpawnSoldier(point_2, self.duration_clone, 1)

clone:AddNewModifier(self.caster, self, "modifier_monkey_king_innate_custom_clone", {duration = self.duration})
clone:AddNewModifier(self.caster, self, "modifier_monkey_king_mischief_invun", {duration = self.delay})

self.caster:RemoveModifierByName("modifier_monkey_king_tree_dance_custom")
self.caster:AddNewModifier(self.caster, self, "modifier_monkey_king_innate_custom", {duration = self.duration, monkey = clone:entindex()})

for _,soldier in pairs(self.caster.command_ability.soldiers) do
  if soldier:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier_active") then
    local part = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_disguise.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(part, 0, soldier:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(part)
  end
end

EmitSoundOnLocationWithCaster(self.caster:GetAbsOrigin(), "Hero_MonkeyKing.Transform.On", self.caster)
EmitSoundOnLocationWithCaster(self.caster:GetAbsOrigin(), "MK.Innate_cast", self.caster)
end


modifier_monkey_king_innate_custom = class(mod_visible)
function modifier_monkey_king_innate_custom:OnCreated(params)
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self.parent:NoDraw(self, true)
self.parent:AddNoDraw()
self.RemoveForDuel = true 

self.monkey = EntIndexToHScript(params.monkey)
self.pos = self.parent:GetAbsOrigin()

self.monkey:AddAttackEvent_inc(self, true)
self.monkey:AddAttackFailEvent_inc(self, true)
self.parent:AddSpellEvent(self, true)

self.ability:EndCd(0.2)

if self.ability.talents.has_h6 == 1 then
  self.mod = self.parent:AddNewModifier(self.parent, self.ability, "modifier_monkey_king_mischief_regen", {})
end

self:StartIntervalThink(0.2)
end

function modifier_monkey_king_innate_custom:OnIntervalThink()
if not IsServer() then return end
if not IsValid(self.monkey) or not self.monkey:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier_active") then 
  self:Destroy()
  return
end 

self.parent:SetAbsOrigin(self.monkey:GetAbsOrigin())
end

function modifier_monkey_king_innate_custom:CheckState()
return 
{
  [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
  [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
  [MODIFIER_STATE_NO_HEALTH_BAR] = true,
  [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
  [MODIFIER_STATE_DEBUFF_IMMUNE] = true,
  [MODIFIER_STATE_DISARMED] = true,
  [MODIFIER_STATE_INVULNERABLE] = true,
  [MODIFIER_STATE_OUT_OF_GAME] = true,
  [MODIFIER_STATE_MUTED] = true,
}
end

function modifier_monkey_king_innate_custom:SpellEvent(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end
if params.ability:GetName() == "monkey_king_primal_spring_custom" or self.ability == params.ability then return end

self:Destroy()
end

function modifier_monkey_king_innate_custom:AttackEvent_inc(params)
if not IsServer() then return end
if not params.attacker:IsHero() then return end
if not IsValid(self.monkey) then return end 
if self.monkey ~= params.target then return end
if params.no_attack_cooldown then return end

self:Destroy()
end

function modifier_monkey_king_innate_custom:AttackFailEvent_inc(params)
if not IsServer() then return end
if not params.attacker:IsHero() then return end
if not IsValid(self.monkey) then return end 
if self.monkey ~= params.target then return end
if params.inflictor then return end
if params.damage_category == 0 then return end
if params.no_attack_cooldown then return end

self:Destroy()
end

function modifier_monkey_king_innate_custom:OnDestroy()
if not IsServer() then return end
self.parent:EndNoDraw(self)
self.parent:RemoveNoDraw()
self.ability:StartCd()

if IsValid(self.mod) then
  self.mod:SetDuration(self.ability.talents.h6_duration, true)
end

if not self.caster:IsCurrentlyHorizontalMotionControlled() and not self.caster:IsCurrentlyVerticalMotionControlled() then
  self.caster:FacePoint()
end

if IsValid(self.monkey) then 
  local abs = self.monkey:GetAbsOrigin()
  self.monkey:RemoveModifierByName("modifier_monkey_king_wukongs_command_custom_soldier_active")
  self.monkey:RemoveModifierByName("modifier_monkey_king_innate_custom_clone")

  if self.caster:HasScepter() then
    self.caster.command_ability:SpawnSoldier(abs, self.ability.duration_clone, 1)
  end
end

local part = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_disguise.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(part, 0, self.parent:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(part)

if self.ability.talents.has_h4 == 1 then
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_invulnerable", {duration = self.ability.talents.h4_invun})
end

EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), "Hero_MonkeyKing.Transform.On", self.parent)
end



modifier_monkey_king_innate_custom_tracker = class(mod_hidden)
function modifier_monkey_king_innate_custom_tracker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.ability.duration = self.ability:GetSpecialValueFor("duration")
self.ability.delay = self.ability:GetSpecialValueFor("delay")
self.ability.duration_clone = self.ability:GetSpecialValueFor("duration_clone")
self.ability.AbilityCastRange = self.ability:GetSpecialValueFor("AbilityCastRange")
self.ability.radius = self.ability:GetSpecialValueFor("radius")
end




modifier_monkey_king_mischief_invun = class(mod_hidden)
modifier_monkey_king_innate_custom_clone = class(mod_hidden)
function modifier_monkey_king_innate_custom_clone:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

local effect = ParticleManager:CreateParticleForTeam("particles/monkey_king/innate_marker.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent, self.parent:GetTeamNumber())
self:AddParticle(effect,false,false,-1,false,false)
end


modifier_monkey_king_mischief_regen = class(mod_hidden)
function modifier_monkey_king_mischief_regen:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.regen = self.ability.talents.h6_heal
end

function modifier_monkey_king_mischief_regen:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
}
end

function modifier_monkey_king_mischief_regen:GetModifierHealthRegenPercentage()
return self.regen
end