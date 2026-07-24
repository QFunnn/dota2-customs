--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_leshrac_defilement_custom", "abilities/leshrac/leshrac_innate_custom", LUA_MODIFIER_MOTION_NONE )

leshrac_innate_custom = class({})
leshrac_innate_custom.talents = {}

function leshrac_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "soundfile", "soundevents/npc_dota_hero_leshrac.vsndevts", context )
dota1x6:PrecacheShopItems("npc_dota_hero_leshrac", context)
end

function leshrac_innate_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_h3 = 0,
    h3_health = 0,
    h3_range = 0,

    has_q3 = 0,
    q3_heal = 0,
    q3_bonus = caster:GetTalentValue("modifier_leshrac_earth_3", "bonus", true),

    has_r2 = 0,
    r2_heal = 0,
  }
end

if caster:HasTalent("modifier_leshrac_hero_3") then
  self.talents.has_h3 = 1
  self.talents.h3_health = caster:GetTalentValue("modifier_leshrac_hero_3", "health")/100
  self.talents.h3_range = caster:GetTalentValue("modifier_leshrac_hero_3", "range")/100
  if IsServer() then
    caster:CalculateStatBonus(true)
  end
end

if caster:HasTalent("modifier_leshrac_earth_3") then
  self.talents.has_q3 = 1
  self.talents.q3_heal = caster:GetTalentValue("modifier_leshrac_earth_3", "heal")/100
  caster:AddDamageEvent_out(self.tracker, true)
end

if caster:HasTalent("modifier_leshrac_nova_2") then
  self.talents.has_r2 = 1
  self.talents.r2_heal = caster:GetTalentValue("modifier_leshrac_nova_2", "heal")/100
  caster:AddDamageEvent_out(self.tracker, true)
end

end

function leshrac_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_leshrac_defilement_custom"
end

function leshrac_innate_custom:GetRange()
return self.parent:GetIntellect(false)*self.radius*(1 + self.talents.h3_range)
end

modifier_leshrac_defilement_custom = class(mod_hidden)
function modifier_leshrac_defilement_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.leshrac_innate = self.ability

self.ability.radius = self.ability:GetSpecialValueFor("radius")
end

function modifier_leshrac_defilement_custom:DamageEvent_out(params)
if not IsServer() then return end
local result = self.parent:CheckLifesteal(params)
if not result then return end
local target = params.unit

if self.ability.talents.has_q3 == 1 and not params.inflictor then
    local heal = self.ability.talents.q3_heal*result*params.damage
    local hide = true

    if target:HasModifier("modifier_leshrac_split_earth_custom_damage_inc") then
        heal = heal*self.ability.talents.q3_bonus
        hide = false
        target:EmitSound("Leshrac.Earth_attack_hit")
        local hit_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", PATTACH_CUSTOMORIGIN, target)
        ParticleManager:SetParticleControlEnt(hit_effect, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false) 
        ParticleManager:SetParticleControlEnt(hit_effect, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), false) 
        ParticleManager:ReleaseParticleIndex(hit_effect)
    end
    self.parent:GenericHeal(heal, self.ability, hide, false, "modifier_leshrac_earth_3")
end

if self.ability.talents.has_r2 == 1 and params.inflictor then
    self.parent:GenericHeal(self.ability.talents.r2_heal*params.damage*result, self.ability, true, "particles/items3_fx/octarine_core_lifesteal.vpcf", "modifier_leshrac_nova_2")
end

end

function modifier_leshrac_defilement_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
    MODIFIER_PROPERTY_HEALTH_BONUS,
    MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
}
end

function modifier_leshrac_defilement_custom:GetModifierHealthBonus()
return self.ability.talents.h3_health*self.parent:GetMaxMana()
end

function modifier_leshrac_defilement_custom:GetModifierAttackRangeBonus()
return self.ability:GetRange()
end

function modifier_leshrac_defilement_custom:GetModifierCastRangeBonusStacking()
return self.ability:GetRange()
end

