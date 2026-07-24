--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_satyr_manaburn", "abilities/neutral_satyr_manaburn", LUA_MODIFIER_MOTION_NONE)




neutral_satyr_manaburn = class({})

function neutral_satyr_manaburn:GetIntrinsicModifierName() return "modifier_satyr_manaburn" end 





modifier_satyr_manaburn = class({})

function modifier_satyr_manaburn:IsPurgable() return false end

function modifier_satyr_manaburn:IsHidden() return true end

function modifier_satyr_manaburn:OnCreated(table)
if not IsServer() then return end
self.mana = self:GetAbility():GetSpecialValueFor("mana")
self.damage = self:GetAbility():GetSpecialValueFor("damage")
end

function modifier_satyr_manaburn:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL
}
end

function modifier_satyr_manaburn:GetModifierProcAttack_BonusDamage_Magical(params)
if not IsServer() then return end

params.target:EmitSound("n_creep_SatyrSoulstealer.ManaBurn")

local effect = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_manaburn.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.target)

params.target:Script_ReduceMana(self.mana, self:GetAbility())
return self.damage
end

