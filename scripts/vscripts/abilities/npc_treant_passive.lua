--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



LinkLuaModifier("modifier_treant_cd", "abilities/npc_treant_passive.lua", LUA_MODIFIER_MOTION_NONE)
npc_treant_passive = class({})


function npc_treant_passive:OnSpellStart()
if not IsServer() then return end
	

local target = self:GetCursorTarget()

self:GetCaster():EmitSound("Hero_Treant.LivingArmor.Cast")

target:EmitSound("Hero_Treant.LivingArmor.Target")


local heal = (target:GetMaxHealth() - target:GetHealth())*self:GetSpecialValueFor("heal")/100
target:Heal(heal, self)

SendOverheadEventMessage(target, 10, target, heal, nil)

local particle = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
ParticleManager:ReleaseParticleIndex( particle )
local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
ParticleManager:ReleaseParticleIndex( particle )



self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_treant_cd", {duration = self:GetCooldownTimeRemaining()})
end
 


modifier_treant_cd = class({})

function modifier_treant_cd:IsHidden() return false end
function modifier_treant_cd:IsPurgable() return false end