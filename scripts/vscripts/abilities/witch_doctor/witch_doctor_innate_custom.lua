--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_witch_doctor_innate_custom", "abilities/witch_doctor/witch_doctor_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_witch_doctor_innate_custom_grisgris", "abilities/witch_doctor/witch_doctor_innate_custom", LUA_MODIFIER_MOTION_NONE )

witch_doctor_innate_custom = class({})

function witch_doctor_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "soundfile", "soundevents/npc_dota_hero_witch_doctor.vsndevts", context )
PrecacheResource( "particle", "particles/units/heroes/hero_witchdoctor/witchdoctor_neutral_consume.vpcf", context )
dota1x6:PrecacheShopItems("npc_dota_hero_witch_doctor", context)
end

function witch_doctor_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_witch_doctor_innate_custom"
end

modifier_witch_doctor_innate_custom = class(mod_hidden)
function modifier_witch_doctor_innate_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
if self.ability:IsStolen() then return end
local item = CreateItem("item_grisgris_custom", self.parent, self.parent)
self.parent:AddItem(item)
end



item_grisgris_custom = class({})

function item_grisgris_custom:GetIntrinsicModifierName()
return "modifier_witch_doctor_innate_custom_grisgris"
end

modifier_witch_doctor_innate_custom_grisgris = class(mod_visible)
function modifier_witch_doctor_innate_custom_grisgris:RemoveOnDeath() return false end
function modifier_witch_doctor_innate_custom_grisgris:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.gold_interval = self.ability:GetSpecialValueFor("gold_tick_interval")*10
self.kill_gold = self.ability:GetSpecialValueFor("kill_gold")
self.radius = self.ability:GetSpecialValueFor("radius")
self.epic_min = self.ability:GetSpecialValueFor("epic_min")
self.gold = 10

if not IsServer() then return end
self.parent:AddDeathEvent(self, true)
self:StartIntervalThink(self.gold_interval)
end

function modifier_witch_doctor_innate_custom_grisgris:OnIntervalThink()
if not IsServer() then return end
self:SetStackCount(self:GetStackCount() + self.gold)
end

function modifier_witch_doctor_innate_custom_grisgris:DeathEvent(params)
if not IsServer() then return end
local unit = params.unit
local is_caster = self.parent == unit

if not unit:IsValidKill(self.parent) and not is_caster then return end

if (unit:GetTeamNumber() ~= self.parent:GetTeamNumber() and ((params.attacker and params.attacker:FindOwner() == self.parent) 
    or (unit:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() <= self.radius)) 
    or is_caster then

    self:SetStackCount(self:GetStackCount() + self.kill_gold)
end

end

function modifier_witch_doctor_innate_custom_grisgris:ConsumeGold()
if not IsServer() then return end
if self.ended then return end

local gold = self:GetStackCount()
if gold <= 0 then return end

self.ended = true
self.parent:EmitSound("Hero_WitchDoctor.Item.GrisGris")

local Particle = ParticleManager:CreateParticle("particles/units/heroes/hero_witchdoctor/witchdoctor_neutral_consume.vpcf", PATTACH_POINT_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(Particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(Particle)

self.parent:GiveGold(gold, true)

if GameRules:GetDOTATime(false, false) >= self.epic_min*60 then
    dota1x6:CreateUpgradeOrb(self.parent, 3)
end

end

function modifier_witch_doctor_innate_custom_grisgris:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_TOOLTIP
}
end

function modifier_witch_doctor_innate_custom_grisgris:OnTooltip()
return self:GetStackCount()
end