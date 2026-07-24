--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_prawler_aura", "abilities/neutral_prawler_aura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_prawler_aura_buff", "abilities/neutral_prawler_aura", LUA_MODIFIER_MOTION_NONE)



neutral_prawler_aura = class({})

function neutral_prawler_aura:GetIntrinsicModifierName() return "modifier_prawler_aura" end 


modifier_prawler_aura = class({})


function modifier_prawler_aura:OnCreated()
if not IsServer() then return end
self.ability = self:GetAbility()
self.radius = self.ability:GetSpecialValueFor("radius")
end


function modifier_prawler_aura:IsPurgable() return false end
function modifier_prawler_aura:IsHidden() return true end
function modifier_prawler_aura:IsAura() return true end
function modifier_prawler_aura:GetAuraDuration() return 0.1 end
function modifier_prawler_aura:GetAuraRadius() return self.radius end
function modifier_prawler_aura:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_prawler_aura:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_prawler_aura:GetModifierAura() return "modifier_prawler_aura_buff" end




modifier_prawler_aura_buff = class({})
function modifier_prawler_aura_buff:IsPurgable() return false end
function modifier_prawler_aura_buff:IsHidden() return false end
function modifier_prawler_aura_buff:OnCreated(table)

self.ability = self:GetAbility()
self.parent = self:GetParent()

self.heal = self.ability:GetSpecialValueFor("heal")
self.parent:AddDamageEvent_out(self, true)
end


function modifier_prawler_aura_buff:DamageEvent_out(params)
if not IsServer() then return end
if not params.unit:IsUnit() then return end
if self.parent ~= params.attacker then return end
local attacker = params.attacker
if not attacker:CheckLifesteal(params) then return end

attacker:GenericHeal(self.heal*params.damage/100, self.ability, true)
end