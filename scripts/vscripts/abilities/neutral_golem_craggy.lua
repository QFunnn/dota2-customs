--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_golem_craggy", "abilities/neutral_golem_craggy", LUA_MODIFIER_MOTION_NONE)




neutral_golem_craggy = class({})

function neutral_golem_craggy:GetIntrinsicModifierName() return "modifier_golem_craggy" end 


modifier_golem_craggy = class({})

function modifier_golem_craggy:IsPurgable() return false end

function modifier_golem_craggy:IsHidden() return true end

function modifier_golem_craggy:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.parent:AddAttackEvent_inc(self, true)

self.duration = self:GetAbility():GetSpecialValueFor("duration")
self.damage = self:GetAbility():GetSpecialValueFor("damage")
self.chance = self:GetAbility():GetSpecialValueFor("chance")
end



function modifier_golem_craggy:AttackEvent_inc(params)
if not IsServer() then return end
if self:GetParent() ~= params.target then return end
if not RollPseudoRandomPercentage(self.chance,1522,self:GetParent()) then return end

params.attacker:EmitSound("BB.Goo_stun")
params.attacker:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_bashed", {duration = self.duration*(1 - params.attacker:GetStatusResistance())})
DoDamage({victim = params.attacker, damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, attacker = self:GetParent(),  ability = self:GetAbility()})
end