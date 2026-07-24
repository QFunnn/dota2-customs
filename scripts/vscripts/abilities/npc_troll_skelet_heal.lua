--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_troll_heal", "abilities/npc_troll_skelet_heal.lua", LUA_MODIFIER_MOTION_NONE)


npc_troll_skelet_heal = class({})


function npc_troll_skelet_heal:GetIntrinsicModifierName() return "modifier_troll_heal" end


modifier_troll_heal = class({})

function modifier_troll_heal:IsHidden() return true end

function modifier_troll_heal:IsPurgable() return false end


function modifier_troll_heal:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:AddAttackEvent_out(self, true)

self.vampiric = self:GetAbility():GetSpecialValueFor("vampiric")
end

function modifier_troll_heal:AttackEvent_out(params)
if not IsServer() then return end
if params.attacker ~= self.parent then return end

local owner = self.parent:GetOwner()
if not owner or owner:IsNull() or not owner:IsAlive() then return end

owner:GenericHeal(owner:GetMaxHealth()*self.vampiric/100, self.ability)
end


