--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_life_stealer_innate_custom_tracker", "abilities/life_stealer/life_stealer_innate_custom", LUA_MODIFIER_MOTION_NONE )

life_stealer_innate_custom = class({})
life_stealer_innate_custom.talents = {}

function life_stealer_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/units/heroes/hero_life_stealer/life_stealer_health_steal.vpcf", context )
PrecacheResource( "particle", "particles/lifestealer/rage_legendary_attack.vpcf", context )
PrecacheResource( "particle", "particles/lifestealer/rage_legendary_attack_2.vpcf", context )
PrecacheResource( "particle", "particles/lifestealer/scepter_blood.vpcf", context )
PrecacheResource( "particle", "particles/brist_lowhp_.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath.vpcf", context )
PrecacheResource( "model", "models/events/crownfall/survivors/skeleton_melee/skeleton_melee.vmdl", context )

PrecacheResource( "soundfile", "soundevents/npc_dota_hero_life_stealer.vsndevts", context )
dota1x6:PrecacheShopItems("npc_dota_hero_life_stealer", context)
end

function life_stealer_innate_custom:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_e1 = 0,
    e1_speed = 0,
  }
end

if caster:HasTalent("modifier_lifestealer_ghoul_1") then
  self.talents.has_e1 = 1
  self.talents.e1_speed = caster:GetTalentValue("modifier_lifestealer_ghoul_1", "speed")
end

end

function life_stealer_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_life_stealer_innate_custom_tracker"
end

modifier_life_stealer_innate_custom_tracker = class(mod_hidden)
function modifier_life_stealer_innate_custom_tracker:IsHidden() return false end
function modifier_life_stealer_innate_custom_tracker:OnCreated(table)
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not self.ability.tracker then
	self.ability.tracker = self
end

self.ability:UpdateTalents()

self.ability.attack_speed_init = self.ability:GetSpecialValueFor("attack_speed_init")
self.ability.attack_speed_inc  = self.ability:GetSpecialValueFor("attack_speed_inc")
self.ability.attack_speed_max  = self.ability:GetSpecialValueFor("attack_speed_max")
end

function modifier_life_stealer_innate_custom_tracker:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
}
end

function modifier_life_stealer_innate_custom_tracker:GetModifierAttackSpeedBonus_Constant()
if self.parent:PassivesDisabled() then return end
if self.parent:HasModifier("modifier_life_stealer_infest_custom") then return end
return math.min(self.ability.attack_speed_init + self.ability.attack_speed_inc*self.caster:GetLevel(), self.ability.attack_speed_max) + self.parent:GetUpgradeStack("modifier_life_stealer_feast_custom_speed_bonus")*self.ability.talents.e1_speed
end