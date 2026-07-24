--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_gungir_custom", "abilities/items/item_gungir_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_gungir_custom_root", "abilities/items/item_gungir_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_gungir_custom_speed", "abilities/items/item_gungir_custom", LUA_MODIFIER_MOTION_NONE)

item_gungir_custom = class({})

function item_gungir_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items3_fx/gleipnir_root.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/gleipnir_projectile.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_techies/techies_tazer.vpcf", context )
end

function item_gungir_custom:GetIntrinsicModifierName()
return "modifier_item_gungir_custom"
end


function item_gungir_custom:GetAOERadius()
return self:GetSpecialValueFor("radius")
end


function item_gungir_custom:OnSpellStart()
local caster = self:GetCaster()
caster:EmitSound("Item.Gleipnir.Cast")
local aoe = self:GetSpecialValueFor("radius")
local point = self:GetCursorPosition()

local info = 
{
  Source = caster,
  Ability = self, 
  EffectName = "particles/items3_fx/gleipnir_projectile.vpcf",
  iMoveSpeed = 1900,
  bReplaceExisting = false,                         
  bProvidesVision = true,                           
  iVisionRadius = 30,        
  iVisionTeamNumber = caster:GetTeamNumber()      
}

for _,target in pairs(caster:FindTargets(aoe, point)) do
  info.Target = target
  ProjectileManager:CreateTrackingProjectile(info)
end

local duration = self:GetSpecialValueFor("duration")
AddFOWViewer(caster:GetTeamNumber(), point, aoe, duration*2, false)

--caster:AddNewModifier(caster, self, "modifier_item_gungir_custom_speed", {duration = self:GetSpecialValueFor("speed_duration")})
end


function item_gungir_custom:OnProjectileHit(target, vLocation)
if target==nil then return end

if target:TriggerSpellAbsorb(self) then return end

local caster = self:GetCaster()
target:EmitSound("Item.Gleipnir.Target")
target:AddNewModifier(caster, self, "modifier_item_gungir_custom_root", {duration = self:GetSpecialValueFor("duration")})
end






modifier_item_gungir_custom_root = class({})
function modifier_item_gungir_custom_root:IsHidden() return true end
function modifier_item_gungir_custom_root:IsPurgable() return true end
function modifier_item_gungir_custom_root:CheckState()
return
{
  [MODIFIER_STATE_ROOTED] = true
}
end
function modifier_item_gungir_custom_root:GetEffectName() return "particles/items3_fx/gleipnir_root.vpcf" end

function modifier_item_gungir_custom_root:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.ticks = self.ability:GetSpecialValueFor("ticks")

if not IsServer() then return end

local damage = self.ability:GetSpecialValueFor("damage")

self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage = damage/self.ticks, damage_type = DAMAGE_TYPE_MAGICAL}

self.count = 0
self.interval = self:GetRemainingTime()/self.ticks

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end


function modifier_item_gungir_custom_root:OnRefresh(table)
if not IsServer() then return end
self.count = 0
end


function modifier_item_gungir_custom_root:OnIntervalThink()
if not IsServer() then return end
if self.count >= self.ticks then return end

DoDamage(self.damageTable)
self.count = self.count + 1
end


modifier_item_gungir_custom = class(mod_hidden)
function modifier_item_gungir_custom:RemoveOnDeath() return false end
function modifier_item_gungir_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_gungir_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.health = self.ability:GetSpecialValueFor("bonus_hp")
self.int = self.ability:GetSpecialValueFor("bonus_intellect")
self.mana = self.ability:GetSpecialValueFor("bonus_mana")
self.cast = self.ability:GetSpecialValueFor("cast_speed")
self.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")
end

function modifier_item_gungir_custom:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_HEALTH_BONUS,
  MODIFIER_PROPERTY_MANA_BONUS,
  MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
}
end

function modifier_item_gungir_custom:GetModifierSpellAmplify_Percentage()
return self.bonus_damage
end

function modifier_item_gungir_custom:GetModifierHealthBonus()
return self.health
end

function modifier_item_gungir_custom:GetModifierManaBonus()
return self.mana
end

function modifier_item_gungir_custom:GetModifierBonusStats_Intellect()
return self.int
end




modifier_item_gungir_custom_speed = class({})
function modifier_item_gungir_custom_speed:IsHidden() return false end
function modifier_item_gungir_custom_speed:IsPurgable() return true end
function modifier_item_gungir_custom_speed:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.movespeed = self.ability:GetSpecialValueFor("movespeed")
if not IsServer() then return end
self.parent:GenericParticle("particles/units/heroes/hero_techies/techies_tazer.vpcf", self)
end

function modifier_item_gungir_custom_speed:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_item_gungir_custom_speed:GetModifierMoveSpeedBonus_Percentage()
return self.movespeed
end


function modifier_item_gungir_custom_speed:GetStatusEffectName()
return "particles/status_fx/status_effect_mjollnir_shield.vpcf"
end

function modifier_item_gungir_custom_speed:StatusEffectPriority()
return MODIFIER_PRIORITY_HIGH 
end