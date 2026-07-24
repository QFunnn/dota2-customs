--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_phantom_assassin_innate_custom", "abilities/phantom_assassin/phantom_assassin_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_innate_custom_cd", "abilities/phantom_assassin/phantom_assassin_innate_custom", LUA_MODIFIER_MOTION_NONE )


phantom_assassin_innate_custom = class({})


function phantom_assassin_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_phantom_assassin_innate_custom"
end

function phantom_assassin_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "soundfile", "soundevents/vo_custom/phantom_assassin_vo_custom.vsndevts", context ) 
PrecacheResource( "soundfile", "soundevents/npc_dota_hero_phantom_assassin.vsndevts", context )
end




modifier_phantom_assassin_innate_custom = class({})
function modifier_phantom_assassin_innate_custom:IsHidden() return true end
function modifier_phantom_assassin_innate_custom:IsPurgable() return false end
function modifier_phantom_assassin_innate_custom:RemoveOnDeath() return false end
function modifier_phantom_assassin_innate_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.chance = self.ability:GetSpecialValueFor("chance")
self.chance_inc = self.ability:GetSpecialValueFor("chance_inc")
self.chance_max = self.ability:GetSpecialValueFor("chance_max")
end


function modifier_phantom_assassin_innate_custom:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_EVASION_CONSTANT
}
end

function modifier_phantom_assassin_innate_custom:GetModifierEvasion_Constant()
if self.parent:PassivesDisabled() then return 0 end

local bonus = 0
if self.parent:HasTalent("modifier_phantom_assassin_blur_1") then 
  bonus = self.parent:GetTalentValue("modifier_phantom_assassin_blur_1", "evasion")
end

return math.min(self.chance_max, self.chance + self.chance_inc*self.parent:GetLevel()) + bonus
end