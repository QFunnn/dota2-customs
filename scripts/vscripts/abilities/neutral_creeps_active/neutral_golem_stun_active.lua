--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


neutral_golem_stun_active = class({})


function neutral_golem_stun_active:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()

local speed = self:GetSpecialValueFor("speed")
caster:EmitSound("n_mud_golem.Boulder.Cast")

local info = 
{
  Target = target,
  Source = caster,
  Ability = self, 
  EffectName = "particles/neutral_fx/mud_golem_hurl_boulder.vpcf",
  iMoveSpeed = speed,
  bReplaceExisting = false,                         
  bProvidesVision = true,                           
  iVisionRadius = 450,        
  iVisionTeamNumber = caster:GetTeamNumber()        
}
ProjectileManager:CreateTrackingProjectile(info)
end



function neutral_golem_stun_active:OnProjectileHit(hTarget, vLocation)
if not IsServer() then return end
if hTarget==nil then return end
if hTarget:TriggerSpellAbsorb( self ) then return end
  
local caster = self:GetCaster()
local stun = self:GetSpecialValueFor("stun")
local damage = self:GetSpecialValueFor("damage")

SendOverheadEventMessage(hTarget, 4, hTarget, damage , nil)

hTarget:EmitSound("n_mud_golem.Boulder.Target")
hTarget:AddNewModifier(caster, self, "modifier_stunned", {duration = stun})     

DoDamage({victim = hTarget, attacker = caster, damage = damage , damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
end