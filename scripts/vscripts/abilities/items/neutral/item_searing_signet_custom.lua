--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_searing_signet_custom", "abilities/items/neutral/item_searing_signet_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_searing_signet_custom_burn", "abilities/items/neutral/item_searing_signet_custom", LUA_MODIFIER_MOTION_NONE)

item_searing_signet_custom = class({})

function item_searing_signet_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_item_searing_signet_custom"
end


modifier_item_searing_signet_custom = class(mod_hidden)
function modifier_item_searing_signet_custom:RemoveOnDeath() return false end
function modifier_item_searing_signet_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.damage_threshold = self.ability:GetSpecialValueFor("damage_threshold")
self.burn_duration = self.ability:GetSpecialValueFor("burn_duration")
self.parent:AddDamageEvent_out(self, true)
end

function modifier_item_searing_signet_custom:DamageEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.unit:IsUnit() then return end
if self.parent:GetTeamNumber() == params.unit:GetTeamNumber() then return end
if params.original_damage <= self.damage_threshold then return end
if not params.inflictor or params.inflictor == self.ability then return end

params.unit:AddNewModifier(self.parent, self.ability, "modifier_item_searing_signet_custom_burn", {duration = self.burn_duration})
end


modifier_item_searing_signet_custom_burn = class(mod_hidden)
function modifier_item_searing_signet_custom_burn:IsPurgable() return true end
function modifier_item_searing_signet_custom_burn:OnCreated()
self.ability = self:GetAbility()
self.caster = self:GetCaster()
self.parent = self:GetParent()

self.duration = self.ability:GetSpecialValueFor("burn_duration")
self.interval = self.ability:GetSpecialValueFor("burn_tickrate")
self.damage = (self.ability:GetSpecialValueFor("burn_damage")/self.duration)*self.interval

self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL}

if not IsServer() then return end
self.parent:EmitSound("item_searing_signet.activate")
self.parent:GenericParticle("particles/items4_fx/searing_signet_fire_debuff.vpcf", self)
self:StartIntervalThink(self.interval - FrameTime())
end

function modifier_item_searing_signet_custom_burn:OnIntervalThink()
if not IsServer() then return end
DoDamage(self.damageTable)
end