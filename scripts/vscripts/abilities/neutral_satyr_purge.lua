--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_satyr_purge", "abilities/neutral_satyr_purge", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_satyr_purge_slow", "abilities/neutral_satyr_purge", LUA_MODIFIER_MOTION_NONE)



neutral_satyr_purge = class({})

function neutral_satyr_purge:GetIntrinsicModifierName()
if not self:GetCaster():IsCreep() then return end  
return "modifier_satyr_purge" 
end 




modifier_satyr_purge = class({})

function modifier_satyr_purge:IsPurgable() return false end
function modifier_satyr_purge:IsHidden() return true end

function modifier_satyr_purge:OnCreated(table)
if not IsServer() then return end

self.duration = self:GetAbility():GetSpecialValueFor("duration")
self.illusion = self:GetAbility():GetSpecialValueFor("illusion")

self.target = nil
end


function modifier_satyr_purge:StartCast(target)
if not IsServer() then return end
local array_target = nil

if target then 
  array_target = target:entindex()
  self.target = target

  if self.target:HasModifier("modifier_satyr_purge_slow") then 
    return
  end
end

self:GetParent():AddNewModifier(self.parent, self:GetAbility(), "modifier_neutral_cast", {target = array_target, duration = 0.1, anim = ACT_DOTA_CAST_ABILITY_1, parent_mod = self:GetName()})
end




function modifier_satyr_purge:EndCast()
if not IsServer() then return end
if not self.target or self.target:IsNull() or not self.target:IsAlive() then return end
if self.target:TriggerSpellAbsorb( self:GetAbility() ) then return end

self.target:EmitSound("n_creep_SatyrTrickster.Cast")
local effect = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_purge.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.target)
ParticleManager:ReleaseParticleIndex(effect)
      
if self.target:IsIllusion() then 
  local damage = self.target:GetMaxHealth()*self.illusion/100

  SendOverheadEventMessage(self.target, 4, self.target, damage, nil)
  DoDamage({victim = self.target, attacker = self:GetParent(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
end


self.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_satyr_purge_slow", {duration = self.duration*(1 - self.target:GetStatusResistance())})
end





modifier_satyr_purge_slow = class({})
function modifier_satyr_purge_slow:IsPurgable() return true end
function modifier_satyr_purge_slow:IsHidden() return false end
function modifier_satyr_purge_slow:GetEffectName() return "particles/items_fx/diffusal_slow.vpcf" end
function modifier_satyr_purge_slow:OnCreated(table)
self.slow = -1*self:GetAbility():GetSpecialValueFor("slow")
self.damage = -1*self:GetAbility():GetSpecialValueFor("damage")
end

function modifier_satyr_purge_slow:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
  MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
  MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

 
function modifier_satyr_purge_slow:GetModifierMoveSpeedBonus_Percentage() 
return self.slow 
end

function modifier_satyr_purge_slow:GetModifierDamageOutgoing_Percentage()
return self.damage 
end

function modifier_satyr_purge_slow:GetModifierSpellAmplify_Percentage() 
  return self.damage 
end