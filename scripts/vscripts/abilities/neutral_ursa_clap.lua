--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_ursa_clap", "abilities/neutral_ursa_clap", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ursa_clap_slow", "abilities/neutral_ursa_clap", LUA_MODIFIER_MOTION_NONE)




neutral_ursa_clap = class({})

function neutral_ursa_clap:GetIntrinsicModifierName() 
if not self:GetCaster():IsCreep() then return end
return "modifier_ursa_clap" 
end 


modifier_ursa_clap = class({})

function modifier_ursa_clap:IsPurgable() return false end

function modifier_ursa_clap:IsHidden() return true end

function modifier_ursa_clap:OnCreated(table)
if not IsServer() then return end
self:GetAbility():SetLevel(1)

self.slow = self:GetAbility():GetSpecialValueFor("slow")
self.aoe = self:GetAbility():GetSpecialValueFor("aoe")
self.damage = self:GetAbility():GetSpecialValueFor("damage")
self.duration = self:GetAbility():GetSpecialValueFor("duration")
self.illusion = self:GetAbility():GetSpecialValueFor("illusion")
end




function modifier_ursa_clap:StartCast(target)
if not IsServer() then return end
local array_target = nil

if target then 
  array_target = target:entindex()
end

self:GetParent():EmitSound("n_creep_Ursa.Clap")
self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_neutral_cast", {target = array_target, duration = 0.4, anim = ACT_DOTA_CAST_ABILITY_1, effect = 1, parent_mod = self:GetName()})
end



function modifier_ursa_clap:EndCast()
if not IsServer() then return end

local trail_pfx = ParticleManager:CreateParticle("particles/neutral_fx/ursa_thunderclap.vpcf", PATTACH_ABSORIGIN, self:GetParent())
ParticleManager:SetParticleControl(trail_pfx, 1, Vector(self.aoe , 0 , 0 ) )
ParticleManager:ReleaseParticleIndex(trail_pfx)    

for _,target in pairs(self:GetParent():FindTargets(self.aoe)) do

  local damage = self.damage
  if target:IsIllusion() then 
    damage = target:GetMaxHealth()*self.illusion/100
  end

  SendOverheadEventMessage(target, 4, target, damage, nil)
  DoDamage({victim = target, attacker = self:GetParent(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})

  target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_ursa_clap_slow", {duration = self.duration*(1 - target:GetStatusResistance())})
end
      
end





modifier_ursa_clap_slow = class({})
function modifier_ursa_clap_slow:IsPurgable() return true end
function modifier_ursa_clap_slow:IsHidden() return false end
function modifier_ursa_clap_slow:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end


function modifier_ursa_clap_slow:OnCreated()
self.slow = self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_ursa_clap_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end