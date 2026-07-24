--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_razor_innate_custom", "abilities/razor/razor_innate_custom", LUA_MODIFIER_MOTION_NONE )


razor_innate_custom = class({})


function razor_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_razor_innate_custom"
end

function razor_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle","particles/razor_custom/razor_whip.vpcf", context )
PrecacheResource( "particle","particles/razor_custom/razor_ambient.vpcf", context )
PrecacheResource( "particle","particles/razor_custom/razor_ambient_main.vpcf", context )

PrecacheResource( "model","models/items/razor/razor_arcana/razor_arcana.vmdl", context )

PrecacheResource( "soundfile", "soundevents/npc_dota_hero_razor.vsndevts", context )
PrecacheResource( "soundfile", "soundevents/vo_custom/razor_vo_custom.vsndevts", context ) 
end


modifier_razor_innate_custom = class({})
function modifier_razor_innate_custom:IsHidden() return true end
function modifier_razor_innate_custom:IsPurgable() return false end
function modifier_razor_innate_custom:RemoveOnDeath() return false end
function modifier_razor_innate_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.move = self.ability:GetSpecialValueFor("move")
self.move_bonus = self.parent:GetTalentValue("modifier_razor_current_5", "speed_bonus", true)
self.max_move = self.parent:GetTalentValue("modifier_razor_current_5", "speed_max", true)

if not IsServer() then return end
self:StartIntervalThink(1)
end

function modifier_razor_innate_custom:OnIntervalThink()
if not IsServer() then return end
if not self.parent:HasTalent("modifier_razor_current_1") then return end

self:SetStackCount(self.parent:GetAverageTrueAttackDamage(nil))
self:StartIntervalThink(0.5)
end

function modifier_razor_innate_custom:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
  MODIFIER_PROPERTY_MOVESPEED_LIMIT,
  MODIFIER_PROPERTY_MOVESPEED_MAX,
  MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
}
end

function modifier_razor_innate_custom:GetModifierSpellAmplify_Percentage()
if not self.parent:HasTalent("modifier_razor_current_1") then return end
return self:GetStackCount()/self.parent:GetTalentValue("modifier_razor_current_1", "spell_attack")
end

function modifier_razor_innate_custom:GetModifierMoveSpeedBonus_Percentage()
if self.parent:PassivesDisabled() then return end
local bonus = 0 

if self.parent:HasTalent("modifier_razor_current_5") then 
	bonus = self.move_bonus
end 
return (self.move + bonus)*self.parent:GetLevel()
end 

function modifier_razor_innate_custom:GetModifierIgnoreMovespeedLimit( params )
if self.parent:PassivesDisabled() then return 0 end
if self.parent:HasTalent("modifier_razor_current_5") then 
  return 1
end
return 0
end

function modifier_razor_innate_custom:GetModifierMoveSpeed_Max( params )
if self.parent:PassivesDisabled() then return end
if self.parent:HasTalent("modifier_razor_current_5") then 
  return self.max_move
end
return 
end

function modifier_razor_innate_custom:GetModifierMoveSpeed_Limit()
if self.parent:PassivesDisabled() then return end
if self.parent:HasTalent("modifier_razor_current_5") then 
  return self.max_move
end
return 
end
