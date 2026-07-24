--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lizard_mkb", "abilities/neutral_lizard_mkb", LUA_MODIFIER_MOTION_NONE)


neutral_lizard_mkb = class({})

function neutral_lizard_mkb:GetIntrinsicModifierName() return "modifier_lizard_mkb" end 


modifier_lizard_mkb = class({})

function modifier_lizard_mkb:IsPurgable() return false end
function modifier_lizard_mkb:IsHidden() return true end
 
function modifier_lizard_mkb:OnCreated(table)

self.parent = self:GetParent()
self.parent:AddAttackEvent_out(self, true)

self.duration = self:GetAbility():GetSpecialValueFor("break_duration")
self.chance = self:GetAbility():GetSpecialValueFor("chance")
end 

function modifier_lizard_mkb:AttackEvent_out(params)
if not IsServer() then return end
if params.attacker ~= self:GetParent() then return end 
if not RollPseudoRandomPercentage(self.chance,179,self:GetParent()) then return end

params.target:EmitSound("Lizard.Break")
params.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_generic_break", {duration = self.duration*(1 - params.target:GetStatusResistance())})
end

