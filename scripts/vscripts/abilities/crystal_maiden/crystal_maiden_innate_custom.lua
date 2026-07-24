--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_crystal_maiden_blueheart_custom", "abilities/crystal_maiden/crystal_maiden_innate_custom", LUA_MODIFIER_MOTION_NONE )

crystal_maiden_innate_custom = class({})
crystal_maiden_innate_custom.talents = {}

function crystal_maiden_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_crystal_maiden_blueheart_custom"
end

function crystal_maiden_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "soundfile", "soundevents/npc_dota_hero_crystal_maiden.vsndevts", context )
PrecacheResource( "soundfile", "soundevents/vo_custom/crystal_maiden_vo_custom.vsndevts", context ) 
end

function crystal_maiden_innate_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_q3 = 0,
    q3_heal = 0,

    has_w2 = 0,
    w2_heal = 0,
    w2_bonus = caster:GetTalentValue("modifier_maiden_frostbite_2", "bonus", true),
  }
end

if caster:HasTalent("modifier_maiden_crystal_3") then
  self.talents.has_q3 = 1
  self.talents.q3_heal = caster:GetTalentValue("modifier_maiden_crystal_3", "heal")/100
  caster:AddDamageEvent_out(self.tracker, true)
end

if caster:HasTalent("modifier_maiden_frostbite_2") then
  self.talents.has_w2 = 1
  self.talents.w2_heal = caster:GetTalentValue("modifier_maiden_frostbite_2", "heal")/100
  caster:AddDamageEvent_out(self.tracker, true)
end

end


modifier_crystal_maiden_blueheart_custom = class(mod_hidden)
function modifier_crystal_maiden_blueheart_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.mana = self.ability:GetSpecialValueFor("mana")

if not IsServer() then return end
self:StartIntervalThink(1)
end

function modifier_crystal_maiden_blueheart_custom:OnIntervalThink()
if not IsServer() then return end
if not self.parent:HasModifier("modifier_player_main_custom") then return end

self.parent:AddPercentStat({int = self.ability:GetSpecialValueFor("int")/100}, self)
self:StartIntervalThink(-1)
end

function modifier_crystal_maiden_blueheart_custom:DamageEvent_out(params)
if not IsServer() then return end

local result = self.parent:CheckLifesteal(params)
if not result then return end

if self.ability.talents.has_q3 == 1 and (not params.inflictor or params.inflictor:GetName() == "crystal_maiden_crystal_nova_custom") then
    self.parent:GenericHeal(params.damage*result*self.ability.talents.q3_heal, self.ability, true, nil, "modifier_maiden_crystal_3")
end

if self.ability.talents.has_w2 == 1 and params.inflictor then
    local heal = self.ability.talents.w2_heal*result*params.damage
    if params.inflictor:GetName() == "crystal_maiden_freezing_field_custom" then
        heal = heal*self.ability.talents.w2_bonus
    end
    self.parent:GenericHeal(heal, self.ability, true, "particles/items3_fx/octarine_core_lifesteal.vpcf", "modifier_maiden_frostbite_2")
end

end


function modifier_crystal_maiden_blueheart_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE
}
end

function modifier_crystal_maiden_blueheart_custom:GetModifierTotalPercentageManaRegen()
return self.mana
end

function modifier_crystal_maiden_blueheart_custom:GetModifierSpellAmplify_Percentage()
return self.damage*(self.parent:GetIntellect(false)/self.int)
end