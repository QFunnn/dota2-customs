--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_nyx_assassin_burrow_custom", "abilities/nyx_assassin/nyx_assassin_burrow_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_nyx_assassin_burrow_custom_dash", "abilities/nyx_assassin/nyx_assassin_burrow_custom", LUA_MODIFIER_MOTION_HORIZONTAL )

nyx_assassin_burrow_custom = class({})
nyx_assassin_burrow_custom.talents = {}

function nyx_assassin_burrow_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/sand_king/burrow_legendary_start.vpcf", context )
PrecacheResource( "particle", "particles/sand_king/burrow_legendary.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow_exit.vpcf", context )
PrecacheResource( "particle", "particles/sand_king/burrow_legendary_active.vpcf", context )
PrecacheResource( "particle", "particles/sand_king/sand_king_wave.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_sandking/sandking_sandstorm_burrowstrike_field_explosion.vpcf", context )
PrecacheResource( "particle", "particles/nyx_assassin/scepter_dash.vpcf", context )

end

function nyx_assassin_burrow_custom:Spawn()
if self.init then return end
self.init = true

self.caster = self:GetCaster()   
self.duration = self:GetLevelSpecialValueFor("duration", 1) 
self.damage_reduce = self:GetLevelSpecialValueFor("incoming", 1) 
self.regen = self:GetLevelSpecialValueFor("regen", 1)     
self.dash_range = self:GetLevelSpecialValueFor("dash_range", 1)  
self.dash_speed = self:GetLevelSpecialValueFor("dash_speed", 1) 
self.stun = self:GetLevelSpecialValueFor("stun", 1)  
self.damage = self:GetLevelSpecialValueFor("damage", 1)   
self.radius = self:GetLevelSpecialValueFor("radius", 1)        
end

function nyx_assassin_burrow_custom:GetCastAnimation()
return 0
end

function nyx_assassin_burrow_custom:GetAbilityTextureName()
if self.caster:HasModifier("modifier_nyx_assassin_burrow_custom") then
 return "nyx_assassin_unburrow"
end
return "nyx_assassin_burrow"
end

function nyx_assassin_burrow_custom:GetBehavior()
if self.caster:HasModifier("modifier_nyx_assassin_burrow_custom") then
  return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
end
return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function nyx_assassin_burrow_custom:GetCastRange(location, hTarget)
if self.caster:HasModifier("modifier_nyx_assassin_burrow_custom") then
  if IsServer() then
    return 99999
  end
  return self.dash_range
end
return 0
end

function nyx_assassin_burrow_custom:GetCastPoint(iLevel)
if self.caster:HasModifier("modifier_nyx_assassin_burrow_custom") then return 0 end
return self.BaseClass.GetCastPoint(self)
end

function nyx_assassin_burrow_custom:GetManaCost(level)
if self.caster:HasModifier("modifier_nyx_assassin_burrow_custom") then return 0 end
return self.BaseClass.GetManaCost(self, level)
end

function nyx_assassin_burrow_custom:OnAbilityPhaseStart()
if self.caster:HasModifier("modifier_nyx_assassin_burrow_custom") then return true end

self.particle_sandblast_fx = ParticleManager:CreateParticle("particles/sand_king/burrow_legendary_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
self.caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1.5)
self.caster:EmitSound("Hero_NyxAssassin.Burrow.In")
return true
end 

function nyx_assassin_burrow_custom:OnAbilityPhaseInterrupted()
if self.caster:HasModifier("modifier_nyx_assassin_burrow_custom") then return end

if self.particle_sandblast_fx then 
  ParticleManager:DestroyParticle(self.particle_sandblast_fx, false)
  ParticleManager:ReleaseParticleIndex(self.particle_sandblast_fx)
  self.particle_sandblast_fx = nil
  self.caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
end 

end

function nyx_assassin_burrow_custom:OnSpellStart()
local mod = self.caster:FindModifierByName("modifier_nyx_assassin_burrow_custom")
if mod then
  local point = self:GetCursorPosition()
  if point == self.caster:GetAbsOrigin() then
    point = self.caster:GetAbsOrigin() + self.caster:GetForwardVector()*50
  end
  local vec = point - self.caster:GetAbsOrigin()
  local max_dist = self.dash_range + self.caster:GetCastRangeBonus()
  if vec:Length2D() > max_dist then
    point = self.caster:GetAbsOrigin() + vec:Normalized()*max_dist
  end

  mod:SetTarget(point)
  return
end

if self.particle_sandblast_fx then 
  ParticleManager:DestroyParticle(self.particle_sandblast_fx, false)
  ParticleManager:ReleaseParticleIndex(self.particle_sandblast_fx)
  self.particle_sandblast_fx = nil
end 

self.caster:RemoveGesture(ACT_DOTA_CAST_ABILITY_4)
self.caster:AddNewModifier(self.caster, self, "modifier_nyx_assassin_burrow_custom", {duration = self.duration})
end 




modifier_nyx_assassin_burrow_custom = class(mod_visible)
function modifier_nyx_assassin_burrow_custom:OnCreated()
self.ability = self:GetAbility()
self.parent = self:GetParent() 

self.regen = self.ability.regen
self.damage_reduce = self.ability.damage_reduce

if not IsServer() then return end

self.parent:NoDraw(self, true)
self.ability:EndCd(0)
self.RemoveForDuel = true
self.parent:GenericParticle("particles/sand_king/burrow_legendary_active.vpcf", self)

self.effect_cast = ParticleManager:CreateParticle( "particles/sand_king/burrow_legendary.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetOrigin() )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 160, 160, 160 ) )
self:AddParticle(self.effect_cast,false, false, -1, false, false)
end

function modifier_nyx_assassin_burrow_custom:SetTarget(cast_point)
if not IsServer() then return end
local point = GetGroundPosition(cast_point, nil)
local vec = point - self.parent:GetAbsOrigin()

local dist = vec:Length2D()
local duration = dist/self.ability.dash_speed

vec = vec:Normalized()
vec.z = 0
self.parent:SetForwardVector(vec)
self.parent:FaceTowards(self.parent:GetAbsOrigin() + vec*10)

self:SetDuration(duration + 0.1, true)
self.ability:EndCd()
self.parent:AddNewModifier(self.parent, self.ability, "modifier_nyx_assassin_burrow_custom_dash", {duration = duration, x = point.x, y = point.y})
end

function modifier_nyx_assassin_burrow_custom:OnDestroy()
if not IsServer() then return end
self.ability:StartCd()
self.parent:EndNoDraw(self)
self.parent:GenericParticle("particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow_exit.vpcf")

self.parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_BURROW_END, 1.4)
self.parent:EmitSound("Hero_NyxAssassin.Burrow.Out")
end

function modifier_nyx_assassin_burrow_custom:CheckState()
return
{
  [MODIFIER_STATE_DISARMED] = true, 
}
end

function modifier_nyx_assassin_burrow_custom:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MODEL_CHANGE,
  MODIFIER_PROPERTY_MODEL_SCALE,
  MODIFIER_PROPERTY_DISABLE_TURNING,
  MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MAX,
  MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
  MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
  MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
}
end

function modifier_nyx_assassin_burrow_custom:GetModifierIncomingDamage_Percentage()
return self.damage_reduce
end

function modifier_nyx_assassin_burrow_custom:GetModifierHealthRegenPercentage()
return self.regen
end

function modifier_nyx_assassin_burrow_custom:GetModifierIgnoreCastAngle()
return 1
end

function modifier_nyx_assassin_burrow_custom:GetModifierDisableTurning()
return 1
end

function modifier_nyx_assassin_burrow_custom:GetModifierMoveSpeed_AbsoluteMax()
return 0.1
end

function modifier_nyx_assassin_burrow_custom:GetModifierModelChange()
return "models/heroes/nerubian_assassin/mound.vmdl"
end

function modifier_nyx_assassin_burrow_custom:GetModifierModelScale()
return 15
end


modifier_nyx_assassin_burrow_custom_dash = class(mod_hidden)
function modifier_nyx_assassin_burrow_custom_dash:StatusEffectPriority() return MODIFIER_PRIORITY_ULTRA end
function modifier_nyx_assassin_burrow_custom_dash:GetStatusEffectName() return "particles/status_fx/status_effect_burn.vpcf" end
function modifier_nyx_assassin_burrow_custom_dash:OnCreated(params)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.point = GetGroundPosition(Vector(params.x, params.y, 0), nil)

self.parent:EmitSound("Nyx.Scepter_dash")
self.parent:EmitSound("Nyx.Scepter_dash2")

self.parent:GenericParticle("particles/nyx_assassin/scepter_dash.vpcf", self)

local effect_cast = ParticleManager:CreateParticle( "particles/sand_king/sand_king_wave.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl( effect_cast, 1, Vector(200,1,1))
ParticleManager:ReleaseParticleIndex( effect_cast )

self.dir = (self.point - self.parent:GetAbsOrigin())
self.dir.z = 0
self.distance = self.dir:Length2D() / self:GetDuration()

self.targets = {}
self.DamageTable = {attacker = self.parent, ability = self.ability, damage = self.ability.damage, damage_type = DAMAGE_TYPE_MAGICAL}
self.stun = self.ability.stun
self.radius = self.ability.radius

if self:ApplyHorizontalMotionController() == false then
  self:Destroy()
end

end

function modifier_nyx_assassin_burrow_custom_dash:CheckState()
return
{
  [MODIFIER_STATE_INVULNERABLE] = true, 
  [MODIFIER_STATE_NO_HEALTH_BAR] = true, 
}
end

function modifier_nyx_assassin_burrow_custom_dash:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_VISUAL_Z_DELTA
}
end

function modifier_nyx_assassin_burrow_custom_dash:GetVisualZDelta()
return -50
end

function modifier_nyx_assassin_burrow_custom_dash:OnDestroy()
if not IsServer() then return end

self.parent:StopSound("Nyx.Scepter_dash")

self.parent:InterruptMotionControllers( true )
self.parent:Stop()
FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), true)
end

function modifier_nyx_assassin_burrow_custom_dash:UpdateHorizontalMotion( me, dt )
if not IsServer() then return end
local pos = self.parent:GetAbsOrigin()
GridNav:DestroyTreesAroundPoint(pos, 80, false)
self.parent:SetAbsOrigin(GetGroundPosition(pos + self.dir:Normalized() * self.distance * dt,self.parent))

local point = self.parent:GetAbsOrigin() - self.dir:Normalized()*80

for _,target in pairs(self.parent:FindTargets(self.radius, point)) do
  if not self.targets[target:entindex()] then
    self.targets[target:entindex()] = true
    self.DamageTable.victim = target
    DoDamage(self.DamageTable)

    target:EmitSound("Nyx.Scepter_stun")
    target:AddNewModifier(self.parent, self.ability, "modifier_stunned", {duration = (1 - target:GetStatusResistance())*self.stun})
    
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_sandking/sandking_sandstorm_burrowstrike_field_explosion.vpcf", PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, target:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex( effect_cast )

    local knockbackProperties =
    {
      center_x = target:GetOrigin().x,
      center_y = target:GetOrigin().y,
      center_z = target:GetOrigin().z,
      duration = 0.4,
      knockback_duration = 0.4,
      knockback_distance = 0,
      knockback_height = 220
    }
    target:AddNewModifier( self.parent, self.ability, "modifier_knockback", knockbackProperties )

    if IsValid(self.parent.impale_ability) then
      self.parent.impale_ability:AbilityHit(target)
      if not self.cd_proc then
        self.cd_proc = true
        self.parent.impale_ability:ProcCd()
      end
    end

    if IsValid(self.parent.carapace_ability) and not self.speed_proc then
      self.parent.carapace_ability:SpeedStack()
      self.speed_proc = true
    end
  end
end

local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_sandking/sandking_sandstorm_burrowstrike_field_explosion.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( effect_cast, 0, point)
ParticleManager:ReleaseParticleIndex( effect_cast )


local dist_left = (self.point - self.parent:GetAbsOrigin()):Length2D()
if dist_left <= 150 and self.parent:HasModifier("modifier_nyx_assassin_burrow_custom") then
  self.parent:RemoveModifierByName("modifier_nyx_assassin_burrow_custom")

  local effect_cast = ParticleManager:CreateParticle( "particles/sand_king/sand_king_wave.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
  ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetAbsOrigin())
  ParticleManager:SetParticleControl( effect_cast, 1, Vector(200,1,1))
  ParticleManager:ReleaseParticleIndex( effect_cast )
end

end

function modifier_nyx_assassin_burrow_custom_dash:OnHorizontalMotionInterrupted()
self:Destroy()
end


