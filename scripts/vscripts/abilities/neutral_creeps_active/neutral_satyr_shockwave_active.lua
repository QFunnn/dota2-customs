--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


neutral_satyr_shockwave_active = class({})


function neutral_satyr_shockwave_active:OnSpellStart()
local caster = self:GetCaster()

local stun = self:GetSpecialValueFor("stun")
local radius = self:GetSpecialValueFor("radius")
local speed = self:GetSpecialValueFor("speed")
local distance = self:GetSpecialValueFor("distance")

local direction = caster:GetForwardVector()
direction.z = 0.0

caster:EmitSound("n_creep_SatyrHellcaller.Shockwave")

local info = 
{
  EffectName = "particles/neutral_fx/satyr_hellcaller.vpcf",
  Ability = self,
  vSpawnOrigin = caster:GetOrigin(), 
  fStartRadius = 70,
  fEndRadius = radius,
  vVelocity = direction * speed,
  fDistance = distance,
  Source = caster,
  bDeleteOnHit = false,
  fExpireTime = GameRules:GetGameTime() + 4,
  iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
  iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
}

ProjectileManager:CreateLinearProjectile(info)  
end



function neutral_satyr_shockwave_active:OnProjectileHit(hTarget, vLocation)
if not IsServer() then return end
if hTarget==nil then return end

local caster = self:GetCaster()
local silence = self:GetSpecialValueFor("silence")
local damage = self:GetSpecialValueFor("damage")

SendOverheadEventMessage(hTarget, 4, hTarget, damage, nil)

hTarget:AddNewModifier(caster, self, "modifier_generic_silence", {duration = silence*(1 - hTarget:GetStatusResistance())})  

DoDamage({victim = hTarget, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
hTarget:EmitSound("n_creep_SatyrHellcaller.Shockwave.Damage")
end
