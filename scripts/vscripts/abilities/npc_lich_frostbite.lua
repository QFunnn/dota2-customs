--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lich_frostbite", "abilities/npc_lich_frostbite.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lich_blast", "abilities/npc_lich_frostbite", LUA_MODIFIER_MOTION_NONE)

npc_lich_frostbite = class({})


function npc_lich_frostbite:GetIntrinsicModifierName() return "modifier_lich_frostbite" end



modifier_lich_frostbite = class({})
function modifier_lich_frostbite:IsHidden() return true end
function modifier_lich_frostbite:IsPurgable() return true end



function modifier_lich_frostbite:OnCreated()
self.parent = self:GetParent()
self.parent:AddDeathEvent(self)
self.parent:AddDamageEvent_out(self, true)
end


function modifier_lich_frostbite:DamageEvent_out(params)
if not IsServer() then return end
if not params.attacker then return end
if (not params.attacker:IsAlive()) then return end
if not self:GetAbility() then return end
if (params.attacker ~= self:GetParent()) then return end
local blast = self:GetParent():FindAbilityByName("npc_lich_blast") 
local ulti = self:GetParent():FindAbilityByName("npc_lich_ulti") 

if params.inflictor == blast or params.inflictor == ulti and params.unit:GetTeamNumber() ~= params.attacker:GetTeamNumber() then 
  local duration = self:GetAbility():GetSpecialValueFor("duration") + (self:GetCaster():GetUpgradeStack("modifier_waveupgrade_boss") - 1)*self:GetAbility():GetSpecialValueFor("duration_inc")
	params.unit:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_lich_blast", {duration = duration})
end

end

function modifier_lich_frostbite:DeathEvent(params)
if not IsServer() then return end
if self:GetParent() ~= params.unit then return end

self:GetParent():EmitSound("Lich.Death_voice")
end





modifier_lich_blast = class({})
function modifier_lich_blast:IsHidden() return false end
function modifier_lich_blast:IsPurgable() return false end
function modifier_lich_blast:OnCreated(table)

self.parent = self:GetParent()

self.heal = -1*self:GetAbility():GetSpecialValueFor("heal")
self.slow = -1*self:GetAbility():GetSpecialValueFor("slow")
self.max = self:GetAbility():GetSpecialValueFor("max")
self.damage = self:GetAbility():GetSpecialValueFor("damage_stack")
if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_lich_blast:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_lich_blast:DeclareFunctions()
return
{
  --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
  MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
  MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
  --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE
}
end





function modifier_lich_blast:GetModifierMoveSpeedBonus_Percentage() return self:GetStackCount()*self.slow end

function modifier_lich_blast:GetStatusEffectName()
  return "particles/status_fx/status_effect_frost_lich.vpcf"
end

function modifier_lich_blast:GetModifierHealChange() return self.heal*self:GetStackCount()  end
function modifier_lich_blast:GetModifierHPRegenAmplify_Percentage() return self.heal*self:GetStackCount() end
function modifier_lich_blast:GetModifierLifestealRegenAmplify_Percentage() return self.heal*self:GetStackCount() end


function modifier_lich_blast:GetModifierIncomingDamage_Percentage(params)
if IsClient() then 
  return self:GetStackCount()*self.damage
end


if not params.attacker then return end
if params.attacker ~= self:GetCaster() then return end

return self:GetStackCount()*self.damage
end