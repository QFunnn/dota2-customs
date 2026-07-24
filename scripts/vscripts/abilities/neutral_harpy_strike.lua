--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_harpy_strike", "abilities/neutral_harpy_strike", LUA_MODIFIER_MOTION_NONE)




neutral_harpy_strike = class({})

function neutral_harpy_strike:GetIntrinsicModifierName()
if not self:GetCaster():IsCreep() then return end  
return "modifier_harpy_strike" 
end 





modifier_harpy_strike = class({})

function modifier_harpy_strike:IsPurgable() return false end
function modifier_harpy_strike:IsHidden() return true end

function modifier_harpy_strike:OnCreated(table)
if not IsServer() then return end

self.illusion = self:GetAbility():GetSpecialValueFor("illusion")
self.damage = self:GetAbility():GetSpecialValueFor("damage")
self.target = nil
end



function modifier_harpy_strike:StartCast(target)
if not IsServer() then return end
local array_target = nil

if target then 
  array_target = target:entindex()
  self.target = target

end

self:GetParent():AddNewModifier(self.parent, self:GetAbility(), "modifier_neutral_cast", {target = array_target, duration = 0.3, anim = ACT_DOTA_CAST_ABILITY_1, parent_mod = self:GetName()})
end




function modifier_harpy_strike:EndCast()
if not IsServer() then return end
if not self.target or self.target:IsNull() or not self.target:IsAlive() then return end
if self.target:TriggerSpellAbsorb( self:GetAbility() ) then return end

self:GetParent():EmitSound("n_creep_HarpyStorm.ChainLighting")

self.nFXIndex = ParticleManager:CreateParticle("particles/neutral_fx/harpy_chain_lightning.vpcf", PATTACH_POINT_FOLLOW, self:GetParent())
ParticleManager:SetParticleControlEnt(self.nFXIndex, 0, self.target, PATTACH_POINT_FOLLOW, "attach_hitloc", self.target:GetAbsOrigin(), true) 
ParticleManager:SetParticleControlEnt(self.nFXIndex, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(self.nFXIndex)

local damage = self.damage

if self.target:IsIllusion() then 
  damage = self.illusion*self.target:GetMaxHealth()/100
end

DoDamage({victim = self.target, attacker = self:GetParent(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
SendOverheadEventMessage(self.target, 4, self.target, damage, nil)
end




