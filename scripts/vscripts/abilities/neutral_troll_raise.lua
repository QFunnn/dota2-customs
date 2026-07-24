--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_troll_raise", "abilities/neutral_troll_raise", LUA_MODIFIER_MOTION_NONE)




neutral_troll_raise = class({})

function neutral_troll_raise:GetIntrinsicModifierName()
if not self:GetCaster():IsCreep() then return end 
return "modifier_troll_raise" 
end 


modifier_troll_raise = class({})

function modifier_troll_raise:IsPurgable() return false end
function modifier_troll_raise:IsHidden() return true end

function modifier_troll_raise:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
self.ability  = self:GetAbility()
self.target = nil

self.number = self:GetAbility():GetSpecialValueFor("number")
self.duration = self:GetAbility():GetSpecialValueFor("duration")

end


function modifier_troll_raise:StartCast(target)
if not IsServer() then return end
local array_target = nil

if target then 
  array_target = target:entindex()
  self.target = target
end

self:GetParent():AddNewModifier(self.parent, self:GetAbility(), "modifier_neutral_cast", {target = array_target, duration = 0.4, anim = ACT_DOTA_CAST_ABILITY_2, parent_mod = self:GetName()})
end



function modifier_troll_raise:EndCast()
if not IsServer() then return end

self:GetParent():EmitSound("n_creep_TrollWarlord.RaiseDead")

for i = 1,self.number do

  local new_skelet = CreateUnitByName("npc_dota_dark_troll_warlord_skeleton_warrior", self:GetParent():GetAbsOrigin(), true, nil, nil, DOTA_TEAM_NEUTRALS)
  new_skelet:SetOwner(self:GetParent())
  new_skelet:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_kill", {duration = self.duration})

  if self.target and not self.target:IsNull() then 
    new_skelet:SetForceAttackTarget(self.target)
  end
end

end



