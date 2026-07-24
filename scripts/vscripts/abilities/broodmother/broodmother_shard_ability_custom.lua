--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_broodmother_shard_ability_custom_spider", "abilities/broodmother/broodmother_shard_ability_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_broodmother_shard_ability_custom_target", "abilities/broodmother/broodmother_shard_ability_custom", LUA_MODIFIER_MOTION_NONE )

broodmother_shard_ability_custom = class({})
broodmother_shard_ability_custom.talents = {}

function broodmother_shard_ability_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/broodmother/shard_end.vpcf", context )
PrecacheResource( "particle", "particles/broodmother/broodmother_web.vpcf", context )
end



function broodmother_shard_ability_custom:OnVectorCastStart(vStartLocation, vDirection)
local caster = self:GetCaster()
local target = self:GetCursorTarget()
local point = caster:GetAbsOrigin() + caster:GetForwardVector()*self:GetSpecialValueFor("range_delta")

local duration = self:GetSpecialValueFor("duration")
local unit = CreateUnitByName("npc_dota_broodmother_spiderling_custom_shard", point, false, nil, nil, caster:GetTeamNumber())

local vec = vDirection
if self.vectorTargetPosition2 then
	vec = self.vectorTargetPosition2 - target:GetAbsOrigin()
	vec.z = 0
	vec = vec:Normalized()
end

caster:EmitSound("Brood.Shard_start")
caster:EmitSound("Brood.Shard_start2")
unit:AddNewModifier(caster, self, "modifier_broodmother_shard_ability_custom_spider", {x = vec.x, y = vec.y, target = target:entindex(), duration = duration})
unit.owner = caster

local face_vec = target:GetAbsOrigin() - unit:GetAbsOrigin()
unit:SetForwardVector(face_vec:Normalized())
unit:FaceTowards(target:GetAbsOrigin())
end


modifier_broodmother_shard_ability_custom_spider = class(mod_hidden)
function modifier_broodmother_shard_ability_custom_spider:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.speed = self.ability:GetSpecialValueFor("start_speed")
self.range = self.ability:GetSpecialValueFor("range")
self.drag_speed = self.ability:GetSpecialValueFor("drag_speed")
self.range_delta = self.ability:GetSpecialValueFor("range_delta")
self.drag_duration = self.ability:GetSpecialValueFor("drag_duration")

if not IsServer() then return end
self.vec = Vector(table.x, table.y, 0)

self.parent:SetBaseMaxHealth(300)

self.target = EntIndexToHScript(table.target)
self.interval = 0.1

self.stage = 1

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_broodmother_shard_ability_custom_spider:OnIntervalThink()
if not IsServer() then return end
if not IsValid(self.target) or not self.target:IsAlive() then 
	self:Destroy()
	return 
end

if self.stage == 2 and (not self.target:HasModifier("modifier_broodmother_shard_ability_custom_target") or self.target:IsControlled() or self.target:IsInvulnerable()) then
	self:Destroy()
	return
end

local point = self.target:GetAbsOrigin()
if self.stage == 2 and self.point then
	point = self.point
else
	AddFOWViewer(self.caster:GetTeamNumber(), point, 10, self.interval*2, false)
end

local dist = (point - self.parent:GetAbsOrigin()):Length2D()
if dist <= 50 then
	if self.stage == 2 then
		self:Destroy()
		self.target:RemoveModifierByName("modifier_broodmother_shard_ability_custom_target")
		return
	end
	self.stage = 2
	self.point = point + self.vec*(self.range + self.range_delta)

	self.speed = self.drag_speed
	self:SetDuration(self.drag_duration, true)
	self.target:AddNewModifier(self.caster, self.ability, "modifier_broodmother_shard_ability_custom_target", {target = self.parent:entindex()})
	return
end

self.parent:MoveToPosition(point)
end

function modifier_broodmother_shard_ability_custom_spider:OnDestroy()
if not IsServer() then return end
if not IsValid(self.parent) then return end

local effect = ParticleManager:CreateParticle("particles/broodmother/shard_end.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl( effect, 0, self.parent:GetOrigin())
ParticleManager:ReleaseParticleIndex(effect)

self.parent:AddNoDraw()
self.parent:Kill(nil, nil)
end

function modifier_broodmother_shard_ability_custom_spider:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE
}
end

function modifier_broodmother_shard_ability_custom_spider:GetModifierMoveSpeed_Absolute()
return self.speed
end

function modifier_broodmother_shard_ability_custom_spider:CheckState()
return
{
	[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	[MODIFIER_STATE_INVULNERABLE] = true,
	[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	[MODIFIER_STATE_UNTARGETABLE] = true,
	[MODIFIER_STATE_UNSELECTABLE] = true,
	[MODIFIER_STATE_DISARMED] = true
}
end


modifier_broodmother_shard_ability_custom_target = class(mod_hidden)
function modifier_broodmother_shard_ability_custom_target:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.target = EntIndexToHScript(table.target)

self.parent:EmitSound("Brood.Shard_target")
self.parent:EmitSound("Brood.Shard_target2")

self.range_delta = self.ability:GetSpecialValueFor("range_delta")
self.damage_reduce = self.ability:GetSpecialValueFor("damage_reduce")

local particle = ParticleManager:CreateParticle("particles/broodmother/web_silence_tether.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
ParticleManager:SetParticleControlEnt(particle, 1, self.target, PATTACH_POINT_FOLLOW, "attach_hitloc", self.target:GetOrigin(), true )
self:AddParticle(particle, false, false, -1, false, false)

for i = 1,4 do
	self.parent:GenericParticle("particles/units/heroes/hero_broodmother/broodmother_incapacitatingbite_debuff.vpcf", self)
end

self:OnIntervalThink()
self:StartIntervalThink(FrameTime())
end

function modifier_broodmother_shard_ability_custom_target:OnIntervalThink()
if not IsServer() then return end
if not IsValid(self.target) or not self.target:IsAlive() then
	self:Destroy()
end

local point = self.target:GetAbsOrigin() - self.target:GetForwardVector()*self.range_delta
self.parent:SetAbsOrigin(point)
end

function modifier_broodmother_shard_ability_custom_target:OnDestroy()
if not IsServer() then return end
FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), false)
end

function modifier_broodmother_shard_ability_custom_target:CheckState()
return
{
	[MODIFIER_STATE_STUNNED] = true,
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true
}
end

function modifier_broodmother_shard_ability_custom_target:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_broodmother_shard_ability_custom_target:GetModifierIncomingDamage_Percentage()
return self.damage_reduce
end

function modifier_broodmother_shard_ability_custom_target:GetOverrideAnimation()
return ACT_DOTA_FLAIL
end