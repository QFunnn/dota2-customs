--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_golem_stun", "abilities/neutral_golem_stun", LUA_MODIFIER_MOTION_NONE)


neutral_golem_stun = class({})

function neutral_golem_stun:GetIntrinsicModifierName() return "modifier_golem_stun" end 



function neutral_golem_stun:OnProjectileHit(hTarget, vLocation)
if not IsServer() then return end
if hTarget==nil then return end
if hTarget:TriggerSpellAbsorb( self ) then return end
  
self.stun = self:GetSpecialValueFor("stun")
self.damage = self:GetSpecialValueFor("damage")

if hTarget:IsIllusion() then 
  self.damage = hTarget:GetMaxHealth()*self:GetSpecialValueFor("illusion")/100
end

SendOverheadEventMessage(hTarget, 4, hTarget, self.damage , nil)

hTarget:EmitSound("n_mud_golem.Boulder.Target")
hTarget:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = self.stun*(1 - hTarget:GetStatusResistance())})     

DoDamage({victim = hTarget, attacker = self:GetCaster(), damage = self.damage , damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
end


modifier_golem_stun = class({})

function modifier_golem_stun:IsPurgable() return false end

function modifier_golem_stun:IsHidden() return true end

function modifier_golem_stun:OnCreated(table)
if not IsServer() then return end
self.target = nil
end

function modifier_golem_stun:StartCast(target)
if not IsServer() then return end
local array_target = nil

if target then 
  array_target = target:entindex()
  self.target = target
end

self:GetParent():EmitSound("n_mud_golem.Boulder.Cast")
self:GetParent():AddNewModifier(self.parent, self:GetAbility(), "modifier_neutral_cast", {target = array_target, duration = 0.1, anim = ACT_DOTA_CAST_ABILITY_1, parent_mod = self:GetName()})
end


function modifier_golem_stun:EndCast()
if not IsServer() then return end
if not self.target or self.target:IsNull() or not self.target:IsAlive() then return end

local projectile_name = "particles/neutral_fx/mud_golem_hurl_boulder.vpcf"
local projectile_speed = self:GetAbility():GetSpecialValueFor("speed")
local projectile_vision = 450

local info = 
{
  Target = self.target,
  Source = self:GetParent(),
  Ability = self:GetAbility(), 
  EffectName = projectile_name,
  iMoveSpeed = projectile_speed,
  bReplaceExisting = false,                         
  bProvidesVision = true,                           
  iVisionRadius = projectile_vision,        
  iVisionTeamNumber = self:GetParent():GetTeamNumber()        
}
ProjectileManager:CreateTrackingProjectile(info)
end

