--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_lina_scepter_custom", "abilities/lina/lina_scepter_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lina_scepter_custom_caster", "abilities/lina/lina_scepter_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lina_scepter_custom_blink", "abilities/lina/lina_scepter_custom", LUA_MODIFIER_MOTION_NONE )

lina_scepter_custom = class({})

function lina_scepter_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/econ/events/fall_2022/radiance/radiance_owner_fall2022.vpcf", context )
PrecacheResource( "particle", "particles/lina/stun_clone.vpcf", context )

end

function lina_scepter_custom:Spawn()
if not self:GetCaster() then return end
self.caster = self:GetCaster()

self.stun = self:GetLevelSpecialValueFor("stun", 1)
self.damage = self:GetLevelSpecialValueFor("damage", 1)
self.duration = self:GetLevelSpecialValueFor("duration", 1)
self.radius = self:GetLevelSpecialValueFor("radius", 1)
self.speed = self:GetLevelSpecialValueFor("speed", 1)
self.range = self:GetLevelSpecialValueFor("range", 1)
self.caster.lina_scepter = self
end

function lina_scepter_custom:GetAbilityTextureName()
if self.caster:HasModifier("modifier_lina_scepter_custom_caster") then 
  return "phoenix_launch_fire_spirit"
end 
return "lina_scepter_ability"
end

function lina_scepter_custom:GetManaCost(iLevel)
if self.caster:HasModifier("modifier_lina_scepter_custom_caster") then 
  return 0
end
return self.BaseClass.GetManaCost(self, iLevel)
end

function lina_scepter_custom:GetBehavior()
if self.caster:HasModifier("modifier_lina_scepter_custom_caster") then 
  return DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
end 
return DOTA_ABILITY_BEHAVIOR_POINT
end

function lina_scepter_custom:GetCastAnimation()
if self.caster:HasModifier("modifier_lina_scepter_custom_caster") then 
  return 0
end 
return ACT_DOTA_CAST_ABILITY_1
end

function lina_scepter_custom:GetCastRange(vLocation, hTarget)
return IsClient() and ((self.range and self.range or 0) - self.caster:GetCastRangeBonus()) or 999999
end

function lina_scepter_custom:OnSpellStart()

local mod = self.caster:FindModifierByName("modifier_lina_scepter_custom_caster")
if mod then
  if IsValid(self.lina_clone) then
    local pos = self.lina_clone:GetAbsOrigin()
    self.caster:FaceTowards(pos + self.lina_clone:GetForwardVector()*10)
    self.caster:SetForwardVector(self.lina_clone:GetForwardVector())

    self.caster:AddNewModifier(self.caster, self, "modifier_lina_scepter_custom_blink", {duration = 0.1, x = pos.x, y = pos.y})
    self.lina_clone:RemoveModifierByName("modifier_lina_scepter_custom")
  end
  return
end

local point = self:GetCursorPosition()
if self.caster:GetAbsOrigin() == point then
  point = self.caster:GetAbsOrigin() + self.caster:GetForwardVector()*10
end

local dir = (point - self.caster:GetAbsOrigin())
dir.z = 0
local vec = self.caster:GetAbsOrigin() + dir:Normalized()*self.range
local duration = dir:Length2D()/self.speed + self.duration + 0.5

local illusion_self = CreateIllusions(self.caster, self.caster, {
  outgoing_damage = -100,
  incoming_damage = 0,
  duration = duration 
}, 1, 0, false, false)

for _,illusion in pairs(illusion_self) do

  illusion:SetHealth(illusion:GetMaxHealth())
  illusion.owner = self.caster

  illusion:AddNewModifier(self.caster, self.ability, "modifier_lina_scepter_custom",  {duration = duration, x = vec.x, y = vec.y})
  illusion:SetOrigin(self.caster:GetAbsOrigin() + dir:Normalized()*50)

  illusion:SetForwardVector(dir:Normalized())
  illusion:FaceTowards(vec)
  illusion:MoveToPosition(vec)
end

end

modifier_lina_scepter_custom = class(mod_hidden)
function modifier_lina_scepter_custom:GetStatusEffectName() return "particles/status_fx/status_effect_qop_tgt_arcana.vpcf" end
function modifier_lina_scepter_custom:StatusEffectPriority() return MODIFIER_PRIORITY_ILLUSION end
function modifier_lina_scepter_custom:GetEffectName() return "particles/lina/stun_clone.vpcf" end
function modifier_lina_scepter_custom:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.speed = self.ability.speed
self.count = -1
self.state = 0

if not IsServer() then return end

self.parent:EmitSound("Lina.Scepter_start")
self.parent:EmitSound("Lina.Scepter_start2")
self.parent:EmitSound("Lina.Scepter_loop")

self.point = GetGroundPosition(Vector(table.x, table.y, 0), nil)
self.caster:AddNewModifier(self.caster, self.ability, "modifier_lina_scepter_custom_caster", {})
self.ability:EndCd(0)

self.ability.lina_clone = self.parent
self.parent:GenericParticle("particles/econ/events/fall_2022/radiance/radiance_owner_fall2022.vpcf", self)
self.parent:GenericParticle("particles/econ/events/fall_2022/phase_boots/phase_boots_fall_2022.vpcf", self)

self.interval = FrameTime()*3
self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_lina_scepter_custom:OnIntervalThink()
if not IsServer() then return end

if self.state == 0 then
  self.parent:MoveToPosition(self.point)
  local dist = (self.point - self.parent:GetAbsOrigin()):Length2D()

  if dist > 10 then return end
  self.state = 1
  self:SetDuration(self.ability.duration, true)
  self.time = self.ability.duration*2
end

self.count = self.count + 1

local number = (self.time-self.count)/2 
local int = number
if number % 1 ~= 0 then 
  int = number - 0.5 
end
local digits = math.floor(math.log10(number)) + 2
local decimal = number % 1

if decimal == 0.5 then
  decimal = 8
else 
  decimal = 1
end

local particle = ParticleManager:CreateParticle("particles/lina_timer.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(particle, 1, Vector(0, int, decimal))
ParticleManager:SetParticleControl(particle, 2, Vector(digits, 0, 0))
ParticleManager:ReleaseParticleIndex(particle)

self:StartIntervalThink(0.5)
end

function modifier_lina_scepter_custom:OnDestroy()
if not IsServer() then return end

self.ability:StartCd()
self.caster:RemoveModifierByName("modifier_lina_scepter_custom_caster")
self.ability.lina_clone = nil

self.parent:StopSound("Lina.Scepter_loop")

local particle_end = ParticleManager:CreateParticle( "particles/units/heroes/hero_lina/lina_spell_light_strike_array.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( particle_end, 0, self.parent:GetAbsOrigin() )
ParticleManager:SetParticleControl( particle_end, 1, Vector(self.ability.radius, 1, 1 ) )
ParticleManager:ReleaseParticleIndex( particle_end )

EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), "Ability.LightStrikeArray", self.caster )

local damageTable = {attacker = self.caster, ability = self.ability, damage = self.ability.damage, damage_type = DAMAGE_TYPE_MAGICAL}
for _,target in pairs(self.caster:FindTargets(self.ability.radius, self.parent:GetAbsOrigin())) do
  damageTable.victim = target
  if IsValid(self.caster.lina_innate) then
    self.caster.lina_innate:ApplyBurn(target, self.ability.damage)
  end
  DoDamage(damageTable)
  target:AddNewModifier(self.caster, self.ability, "modifier_stunned", {duration = (1 - target:GetStatusResistance())*self.ability.stun})
end


self.parent:Kill(nil, nil) 
end

function modifier_lina_scepter_custom:CheckState()
local result =
{
  [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
  [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
  [MODIFIER_STATE_FORCED_FLYING_VISION] = true,
  [MODIFIER_STATE_INVULNERABLE] = true,
  [MODIFIER_STATE_OUT_OF_GAME] = true,
  [MODIFIER_STATE_DISARMED] = true,
  [MODIFIER_STATE_UNSELECTABLE] = true,
  [MODIFIER_STATE_UNTARGETABLE] = true,
  [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
  [MODIFIER_STATE_NO_HEALTH_BAR] = true,
}
if self.state == 1 then
  result[MODIFIER_STATE_STUNNED] = true
end
return result
end

function modifier_lina_scepter_custom:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
  MODIFIER_PROPERTY_MODEL_SCALE,
  MODIFIER_PROPERTY_FIXED_DAY_VISION,
  MODIFIER_PROPERTY_FIXED_NIGHT_VISION
}
end

function modifier_lina_scepter_custom:GetModifierModelScale()
return 25
end

function modifier_lina_scepter_custom:GetFixedNightVision()
return 500
end

function modifier_lina_scepter_custom:GetFixedDayVision()
return 500
end

function modifier_lina_scepter_custom:GetModifierMoveSpeed_Absolute()
return self.speed
end

modifier_lina_scepter_custom_caster = class(mod_hidden)


modifier_lina_scepter_custom_blink = class(mod_hidden)
function modifier_lina_scepter_custom_blink:OnCreated(table)
if not IsServer() then return end 
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.point = GetGroundPosition(Vector(table.x, table.y, 0), nil)
self.parent:NoDraw(self)
self.parent:AddNoDraw()

EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), "Lina.Array_blink", self.parent)

local effect_end = ParticleManager:CreateParticle("particles/items3_fx/blink_overwhelming_start.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(effect_end, 0, self.parent:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(effect_end)

ProjectileManager:ProjectileDodge(self.parent)

self.parent:SetAbsOrigin(self.point)
FindClearSpaceForUnit(self.parent, self.point, false)
end 

function modifier_lina_scepter_custom_blink:CheckState()
return
{
  [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
  [MODIFIER_STATE_STUNNED] = true
}
end

function modifier_lina_scepter_custom_blink:OnDestroy()
if not IsServer() then return end 
self.parent:GenericParticle("particles/items3_fx/blink_overwhelming_end.vpcf")

self.parent:Stop()
self.parent:RemoveNoDraw()
end 
