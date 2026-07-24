--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_satyr_purge_active_slow", "abilities/neutral_creeps_active/neutral_satyr_purge_active", LUA_MODIFIER_MOTION_NONE )

neutral_satyr_purge_active = class({})



function neutral_satyr_purge_active:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()

if target:TriggerSpellAbsorb(self) then return end

local duration = self:GetSpecialValueFor("duration")

target:EmitSound("n_creep_SatyrTrickster.Cast")
local effect = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_purge.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
ParticleManager:ReleaseParticleIndex(effect)

target:AddNewModifier(caster, self, "modifier_satyr_purge_active_slow", {duration = duration}) 
end




modifier_satyr_purge_active_slow = class({})
function modifier_satyr_purge_active_slow:IsPurgable() return true end
function modifier_satyr_purge_active_slow:IsHidden() return false end
function modifier_satyr_purge_active_slow:GetEffectName() return "particles/items_fx/diffusal_slow.vpcf" end
function modifier_satyr_purge_active_slow:OnCreated(table)
self.ability = self:GetAbility()
self.slow = self.ability:GetSpecialValueFor("slow")
self.damage = self.ability:GetSpecialValueFor("damage")
end

function modifier_satyr_purge_active_slow:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
  MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

 
function modifier_satyr_purge_active_slow:GetModifierMoveSpeedBonus_Percentage() 
return self.slow 
end

function modifier_satyr_purge_active_slow:GetModifierDamageOutgoing_Percentage()
return self.damage 
end

function modifier_satyr_purge_active_slow:GetModifierSpellAmplify_Percentage() 
return self.damage 
end