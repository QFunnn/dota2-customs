--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lich_ulti_cd", "abilities/npc_lich_ulti", LUA_MODIFIER_MOTION_NONE)

npc_lich_ulti = class({})

function npc_lich_ulti:OnAbilityPhaseStart()
    self.sign = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_has_quest.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetCaster())
       return true
end 

function npc_lich_ulti:New_Hit( target , source )
if not IsServer() then return end
    local projectile_name = "particles/econ/items/lich/lich_ti8_immortal_arms/lich_ti8_chain_frost.vpcf"
    local projectile_speed = self:GetSpecialValueFor("projectile")
    local projectile_vision = 450

        local info = {
       Target = target,
       Source = source,
       Ability = self, 
      EffectName = projectile_name,
      iMoveSpeed = projectile_speed,
      bReplaceExisting = false,                         
      bProvidesVision = true,                           
      iVisionRadius = projectile_vision,        
      iVisionTeamNumber = self:GetCaster():GetTeamNumber()        
        }
 ProjectileManager:CreateTrackingProjectile(info)


end



function npc_lich_ulti:OnSpellStart()
if not IsServer() then return end

if self.sign then 
  ParticleManager:DestroyParticle(self.sign, true)
end

self:GetCaster():EmitSound("Lich.Ulti_voice")

self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_lich_ulti_cd", {duration = self:GetCooldownTimeRemaining()})

local point = self:GetCursorTarget()

self:GetCaster():EmitSound("Hero_Lich.ChainFrost")

self:New_Hit(point, self:GetCaster())
    
end



function npc_lich_ulti:OnAbilityPhaseInterrupted()
    ParticleManager:DestroyParticle(self.sign, true)
end

function npc_lich_ulti:OnProjectileHit(hTarget, vLocation)
if not IsServer() then return end
if not hTarget  then return end

local radius = self:GetSpecialValueFor("radius")

local enemy_for_ability = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), hTarget:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY + DOTA_UNIT_TARGET_TEAM_ENEMY , DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE , FIND_CLOSEST, false)

local target = {}
local j = 0

for _,i in pairs(enemy_for_ability) do 
  if ((i:GetTeamNumber() == self:GetCaster():GetTeamNumber() and i:GetUnitName() == "npc_lich_ice_unit") or
    (i:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() and (i:IsCreep() or i:IsHero()))) and  
    (i ~= hTarget) then 

    j = j + 1
    target[j] = i
  end
end

self:GetCaster():EmitSound("Hero_Lich.ChainFrostImpact.Hero")

if hTarget:TriggerSpellAbsorb(self)  then return end


if j > 0 then 
  local t = target[RandomInt(1, #target)]
  self:New_Hit(t , hTarget)
end



local damage = self:GetSpecialValueFor("damage")*hTarget:GetMaxHealth()/100

if hTarget:IsCreep() then 
  damage = math.min(500, damage)
end

DoDamage({ victim = hTarget, attacker = self:GetCaster(), ability = self, damage = damage, damage_type = DAMAGE_TYPE_PURE, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION})


return true
end




modifier_lich_ulti_cd = class({})

function modifier_lich_ulti_cd:IsHidden() return false end
function modifier_lich_ulti_cd:IsPurgable() return false end