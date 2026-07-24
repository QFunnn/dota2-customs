--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_satyr_shockwave", "abilities/neutral_satyr_shockwave", LUA_MODIFIER_MOTION_NONE)



neutral_satyr_shockwave = class({})

function neutral_satyr_shockwave:GetIntrinsicModifierName()
if not self:GetCaster():IsCreep() then return end
return "modifier_satyr_shockwave" 
end 



function neutral_satyr_shockwave:OnProjectileHit(hTarget, vLocation)
if not IsServer() then return end
if hTarget==nil then return end

self.silence = self:GetSpecialValueFor("silence")
self.damage = self:GetSpecialValueFor("damage")

if hTarget:IsIllusion() then 
  self.damage = hTarget:GetMaxHealth()*self:GetSpecialValueFor("illusion")/100
end

SendOverheadEventMessage(hTarget, 4, hTarget, self.damage, nil)

hTarget:AddNewModifier(self:GetCaster(), self, "modifier_generic_silence", {duration = self.silence*(1 - hTarget:GetStatusResistance())})  

DoDamage({victim = hTarget, attacker = self:GetCaster(), damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
hTarget:EmitSound("n_creep_SatyrHellcaller.Shockwave.Damage")
end


modifier_satyr_shockwave = class({})

function modifier_satyr_shockwave:IsPurgable() return false end
function modifier_satyr_shockwave:IsHidden() return true end

function modifier_satyr_shockwave:OnCreated(table)
if not IsServer() then return end

self.ability  = self:GetAbility()
self.speed = self:GetAbility():GetSpecialValueFor("speed")
self.distance = self:GetAbility():GetSpecialValueFor("distance")
self.radius = self:GetAbility():GetSpecialValueFor("radius")

self.parent = self:GetParent()
end


function modifier_satyr_shockwave:StartCast(target)
if not IsServer() then return end
local array_target = nil

if target then 
  array_target = target:entindex()
end

self:GetParent():AddNewModifier(self.parent, self:GetAbility(), "modifier_neutral_cast", {target = array_target, duration = 0.8, anim_speed = 0.8, anim = ACT_DOTA_CAST_ABILITY_1, effect = 1, parent_mod = self:GetName()})
end

 
function modifier_satyr_shockwave:EndCast()
if not IsServer() then return end

local direction = self.parent:GetForwardVector()
direction.z = 0.0

self.parent:EmitSound("n_creep_SatyrHellcaller.Shockwave")

local info = 
{
  EffectName = "particles/neutral_fx/satyr_hellcaller.vpcf",
  Ability = self:GetAbility(),
  vSpawnOrigin = self:GetParent():GetOrigin(), 
  fStartRadius = 70,
  fEndRadius = self.radius,
  vVelocity = direction * self.speed,
  fDistance = self.distance,
  Source = self.parent,
  bDeleteOnHit = false,
  fExpireTime = GameRules:GetGameTime() + 4,
  iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
  iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
}


ProjectileManager:CreateLinearProjectile(info)
end



