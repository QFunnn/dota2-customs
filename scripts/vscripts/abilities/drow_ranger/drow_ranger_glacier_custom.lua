--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_drow_ranger_glacier_custom_field", "abilities/drow_ranger/drow_ranger_glacier_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_glacier_custom_blink", "abilities/drow_ranger/drow_ranger_glacier_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_glacier_custom_effect", "abilities/drow_ranger/drow_ranger_glacier_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_glacier_custom_knock_cd", "abilities/drow_ranger/drow_ranger_glacier_custom", LUA_MODIFIER_MOTION_NONE )


drow_ranger_glacier_custom = class({})

function drow_ranger_glacier_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/drow_ranger/marksman_field.vpcf", context )
PrecacheResource( "particle", "particles/drow_ranger/marksman_blink_start.vpcf", context )
PrecacheResource( "particle", "particles/drow_ranger/marksman_blink_end.vpcf", context )
end

function drow_ranger_glacier_custom:Spawn()
if self.init then return end
self.init = true

self.caster = self:GetCaster()
self.range = self:GetLevelSpecialValueFor("range", 1)        
self.radius = self:GetLevelSpecialValueFor("radius", 1)       
self.duration = self:GetLevelSpecialValueFor("duration", 1)     
self.attack_range = self:GetLevelSpecialValueFor("attack_range", 1) 
end

function drow_ranger_glacier_custom:GetCastRange(vLocation, hTarget)
if IsServer() then return 999999 end
return (self.range and self.range or 0)
end

function drow_ranger_glacier_custom:GetAOERadius()
return (self.radius and self.radius or 0)
end

function drow_ranger_glacier_custom:OnSpellStart()
if not self.caster then return end

local point = self:GetCursorPosition()
local origin = self.caster:GetAbsOrigin()
local dir = point - origin
local vec = dir:Normalized()
vec.z = 0

local range = self.range + self.caster:GetCastRangeBonus()
if dir:Length2D() >= range then 
	point = origin + vec*range
end 

self.caster:AddNewModifier(self.caster, self, "modifier_drow_ranger_glacier_custom_blink", {duration = 0.2, x = point.x, y = point.y})
end


modifier_drow_ranger_glacier_custom_blink = class(mod_hidden)
function modifier_drow_ranger_glacier_custom_blink:OnCreated(table)
if not IsServer() then return end 
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.point = GetGroundPosition(Vector(table.x, table.y, 0), nil)
self.parent:NoDraw(self)
self.parent:AddNoDraw()

EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), "Lina.Array_blink", self.parent)

local effect_end = ParticleManager:CreateParticle("particles/drow_ranger/marksman_blink_start.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(effect_end, 0, self.parent:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(effect_end)

ProjectileManager:ProjectileDodge(self.parent)

self.parent:SetAbsOrigin(self.point)
FindClearSpaceForUnit(self.parent, self.point, false)

CreateModifierThinker(self.parent, self.ability, "modifier_drow_ranger_glacier_custom_field", {duration = self.ability.duration}, self.point, self.parent:GetTeamNumber(), false)
end 


function modifier_drow_ranger_glacier_custom_blink:CheckState()
return
{
  [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
  [MODIFIER_STATE_INVULNERABLE] = true,
  [MODIFIER_STATE_OUT_OF_GAME] = true,
  [MODIFIER_STATE_STUNNED] = true
}
end

function modifier_drow_ranger_glacier_custom_blink:OnDestroy()
if not IsServer() then return end 

self.parent:StartGesture(ACT_DOTA_TELEPORT_END)
self.parent:GenericParticle("particles/drow_ranger/marksman_blink_end.vpcf")
self.parent:Stop()
self.parent:RemoveNoDraw()
end 


modifier_drow_ranger_glacier_custom_field = class(mod_hidden)
function modifier_drow_ranger_glacier_custom_field:OnCreated()
self.caster = self:GetCaster()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.center = self.parent:GetAbsOrigin()

self.radius = self.ability.radius

if not IsServer() then return end

self.parent:EmitSound("Drow.Mark_legendary_lp")
EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), "Drow.Mark_legendary", self.caster)

local effect_cast = ParticleManager:CreateParticle( "particles/drow_ranger/marksman_field.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetAbsOrigin() )
ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, self:GetRemainingTime(), 1 ) )
self:AddParticle( effect_cast, false, false, -1, false, false )

self:OnIntervalThink()
self:StartIntervalThink(0.05)
end

function modifier_drow_ranger_glacier_custom_field:OnIntervalThink()
if not IsServer() then return end

for _,target in pairs(self.caster:FindTargets(self.radius, self.center)) do 
  if not target:HasModifier("modifier_drow_ranger_glacier_custom_knock_cd") and not target:IsDebuffImmune() then 

    local dir = target:GetAbsOrigin() - self.center
    local point = self.center + dir:Normalized()*self.radius*1.2

    target:InterruptMotionControllers(false)
    self:ChangePos(target, point)
    target:AddNewModifier(target, nil, "modifier_drow_ranger_glacier_custom_knock_cd", {duration = 0.2})
  end
end

end 

function modifier_drow_ranger_glacier_custom_field:CheckPos(target)
if not IsServer() then return end

local radius = self.radius*0.9
local dir = (target:GetAbsOrigin() - self.center)

if dir:Length2D() > radius then 

  target:InterruptMotionControllers(false)
  local point = self.center + dir:Normalized()*(radius*0.8)

  if dir:Length2D() > radius*1.4 then 
    FindClearSpaceForUnit(target, point, true)
  else 
    self:ChangePos(target, point)
  end
end 

end

function modifier_drow_ranger_glacier_custom_field:ChangePos(target, point)
if not IsServer() then return end

target:EmitSound("Drow.Scepter_return")
local duration = 0.2
local distance = (target:GetAbsOrigin() - point):Length2D()
local knockbackProperties =
{
  target_x = point.x,
  target_y = point.y,
  distance = distance,
  speed = distance/duration,
  height = 0,
  fix_end = true,
  isStun = true,
  activity = ACT_DOTA_FLAIL,
}
target:AddNewModifier( self.caster, self.ability, "modifier_generic_arc", knockbackProperties )
end 





function modifier_drow_ranger_glacier_custom_field:OnDestroy()
if not IsServer() then return end
self.parent:StopSound("Drow.Mark_legendary_lp")
EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), "Drow.Mark_legendary_end", self.caster)
end

function modifier_drow_ranger_glacier_custom_field:IsAura() return true end
function modifier_drow_ranger_glacier_custom_field:GetAuraDuration() return 0.1 end
function modifier_drow_ranger_glacier_custom_field:GetAuraRadius() return self.radius end
function modifier_drow_ranger_glacier_custom_field:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_drow_ranger_glacier_custom_field:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO end
function modifier_drow_ranger_glacier_custom_field:GetModifierAura() return "modifier_drow_ranger_glacier_custom_effect" end

modifier_drow_ranger_glacier_custom_effect = class(mod_visible)
function modifier_drow_ranger_glacier_custom_effect:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.range = self.ability.attack_range
end

function modifier_drow_ranger_glacier_custom_effect:CheckState()
return
{
	[MODIFIER_STATE_ATTACKS_DONT_REVEAL] = true
}
end

function modifier_drow_ranger_glacier_custom_effect:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
}
end

function modifier_drow_ranger_glacier_custom_effect:GetModifierAttackRangeBonus()
return self.range
end



modifier_drow_ranger_glacier_custom_knock_cd = class(mod_hidden)