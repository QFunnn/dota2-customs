--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_neutral_frostgolem_slow_passive", "abilities/neutral_frostgolem_slow", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_frostgolem_slow_buff", "abilities/neutral_frostgolem_slow", LUA_MODIFIER_MOTION_NONE)





neutral_frostgolem_slow = class({})

function neutral_frostgolem_slow:GetIntrinsicModifierName() return "modifier_neutral_frostgolem_slow_passive" end 


modifier_neutral_frostgolem_slow_passive = class({})

function modifier_neutral_frostgolem_slow_passive:IsPurgable() return false end
function modifier_neutral_frostgolem_slow_passive:IsHidden() return true end

function modifier_neutral_frostgolem_slow_passive:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.parent:AddAttackEvent_out(self, true)

self.duration = self:GetAbility():GetSpecialValueFor("duration")
end


function modifier_neutral_frostgolem_slow_passive:AttackEvent_out(params)
if not IsServer() then return end
if self:GetParent() ~= params.attacker then return end
if not params.target:IsUnit() then return end

params.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_neutral_frostgolem_slow_buff", {duration = self.duration})
end



modifier_neutral_frostgolem_slow_buff = class({})
function modifier_neutral_frostgolem_slow_buff:IsHidden() return false end
function modifier_neutral_frostgolem_slow_buff:IsPurgable() return true end
function modifier_neutral_frostgolem_slow_buff:OnCreated(table)
if not self:GetAbility() then return end
self.slow = self:GetAbility():GetSpecialValueFor("slow")
self.heal = self:GetAbility():GetSpecialValueFor("heal")
end

function modifier_neutral_frostgolem_slow_buff:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
  --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
  MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
  --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE
}
end

function modifier_neutral_frostgolem_slow_buff:GetModifierLifestealRegenAmplify_Percentage() return self.heal end
function modifier_neutral_frostgolem_slow_buff:GetModifierHealChange() return self.heal end
function modifier_neutral_frostgolem_slow_buff:GetModifierHPRegenAmplify_Percentage() return self.heal end
function modifier_neutral_frostgolem_slow_buff:GetModifierMoveSpeedBonus_Percentage() return self.slow end

function modifier_neutral_frostgolem_slow_buff:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost_lich.vpcf"
end

function modifier_neutral_frostgolem_slow_buff:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL 
end