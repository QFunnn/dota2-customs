--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_huskar_innate", "abilities/huskar/custom_huskar_innate", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_huskar_innate_cd", "abilities/huskar/custom_huskar_innate", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_huskar_innate_scepter", "abilities/huskar/custom_huskar_innate", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_huskar_stun_cd", "abilities/huskar/custom_huskar_innate", LUA_MODIFIER_MOTION_NONE)

custom_huskar_innate = class({})
custom_huskar_innate.talents = {}

function custom_huskar_innate:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/huskar/innate_heal.vpcf", context )
PrecacheResource( "particle", "particles/huskar/shard_shield.vpcf", context )
PrecacheResource( "particle", "particles/econ/items/effigies/status_fx_effigies/se_effigy_ti6_lvl2.vpcf", context )
PrecacheResource( "particle", "amir4an/particles/heroes/huskar/amir4an_1x6/amir4an_1x6_huskar_ability_mana_heal_ambient.vpcf", context )

PrecacheResource( "soundfile", "soundevents/npc_dota_hero_huskar.vsndevts", context )
dota1x6:PrecacheShopItems("npc_dota_hero_huskar", context)
end

function custom_huskar_innate:UpdateTalents()
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_h5 = 0,
  }
end

if caster:HasTalent("modifier_huskar_hero_5") then
  self.talents.has_h5 = 1
end

end


function custom_huskar_innate:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_custom_huskar_innate"
end


modifier_custom_huskar_innate = class(mod_hidden)
function modifier_custom_huskar_innate:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.ability.heal = self.ability:GetSpecialValueFor("heal")/100
self.ability.cooldown = self.ability:GetSpecialValueFor("cooldown")
self.ability.scepter_duration = self.ability:GetSpecialValueFor("scepter_duration")
self.parent:AddDamageEvent_inc(self)
end

function modifier_custom_huskar_innate:DamageEvent_inc(params)
if not IsServer() then return end
if params.damage <= 0 then return end
if self.parent ~= params.unit then return end
if self.parent == params.attacker then return end

if self.parent:HasModifier("modifier_custom_huskar_innate_cd") or self.parent:HasModifier("modifier_custom_huskar_innate_scepter") then return end
if self.parent:PassivesDisabled() and self.ability.talents.has_h5 == 0 then return end
if self.parent:GetHealth() > 1 then return end

if self.parent:HasScepter() then
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_debuff_immune", {duration = self.ability.scepter_duration + 0.1})
  self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_huskar_innate_scepter", {duration = self.ability.scepter_duration})
  return
end

self:ProcHeal()
end

function modifier_custom_huskar_innate:ProcHeal()
if not IsServer() then return end
local mana = self.parent:GetMana()
self.parent:SetMana(1)

self.parent:EmitSound("Huskar.Innate_heal")
self.parent:EmitSound("Huskar.Innate_heal2")

local hit_effect = ParticleManager:CreateParticle("amir4an/particles/heroes/huskar/amir4an_1x6/amir4an_1x6_huskar_ability_mana_heal_ambient.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(hit_effect, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), false) 
ParticleManager:ReleaseParticleIndex(hit_effect)
self.parent:GenericHeal(mana*self.ability.heal, self.ability, false, nil)

self.parent:AddNewModifier(self.parent, self.ability, "modifier_custom_huskar_innate_cd", {duration = self.ability.cooldown})
end

function modifier_custom_huskar_innate:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_CONVERT_MANA_COST_TO_HEALTH_COST,
  MODIFIER_PROPERTY_MIN_HEALTH,
}
end

function modifier_custom_huskar_innate:GetModifierConvertManaCostToHealthCost()
return 1
end

function modifier_custom_huskar_innate:GetMinHealth()
if not self.parent:IsAlive() then return end
if self.parent:LethalDisabled() then return end
if self.parent:HasModifier("modifier_custom_huskar_innate_scepter") then
  return 1
end
if self.parent:HasModifier("modifier_custom_huskar_innate_cd") then return end
if self.parent:PassivesDisabled() and self.ability.talents.has_h5 == 0 then return end
return 1
end



modifier_custom_huskar_innate_cd = class(mod_cd)


modifier_custom_huskar_innate_scepter = class(mod_visible)
function modifier_custom_huskar_innate_scepter:GetEffectName() return "particles/huskar_grave.vpcf" end
function modifier_custom_huskar_innate_scepter:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
if not IsServer() then return end
self.parent:EmitSound("Huskar.Passive_Legendary")
end

function modifier_custom_huskar_innate_scepter:OnDestroy()
self.ended = true

if not IsServer() then return end
if not self.parent:IsAlive() then return end
self.ability.tracker:ProcHeal()
end

function modifier_custom_huskar_innate_scepter:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_DISABLE_HEALING
}
end

function modifier_custom_huskar_innate_scepter:GetDisableHealing()
if self.ended then return end
return 1
end

modifier_custom_huskar_stun_cd = class(mod_cd)
function modifier_custom_huskar_stun_cd:GetTexture() return "buffs/huskar/hero_7" end