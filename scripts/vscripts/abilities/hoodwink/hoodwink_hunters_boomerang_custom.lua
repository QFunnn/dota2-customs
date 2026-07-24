--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_hoodwink_hunters_boomerang_custom_target", "abilities/hoodwink/hoodwink_hunters_boomerang_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_hoodwink_hunters_boomerang_custom_thinker", "abilities/hoodwink/hoodwink_hunters_boomerang_custom", LUA_MODIFIER_MOTION_NONE )

hoodwink_hunters_boomerang_custom = class({})

function hoodwink_hunters_boomerang_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/hoodwink/hoodwink_boomerang_custom.vpcf", context )
PrecacheResource( "particle", "particles/hoodwink/hoodwink_boomerang_custom_2.vpcf", context )
PrecacheResource( "particle", "particles/hoodwink/hoodwink_boomerang_custom_hit.vpcf", context )
end

function hoodwink_hunters_boomerang_custom:InitSpell()
if not IsServer() then return end
if self.speed then return end

self.speed = self:GetSpecialValueFor("speed")
self.radius = self:GetSpecialValueFor("radius")
self.damage = self:GetSpecialValueFor("damage")
self.duration = self:GetSpecialValueFor("duration")
self.range = self:GetSpecialValueFor("AbilityCastRange")

self.damageTable = {attacker = self:GetCaster(), ability = self, damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL}
end

function hoodwink_hunters_boomerang_custom:GetCastRange( location, target )
return self.BaseClass.GetCastRange(self, location, target) - self:GetCaster():GetCastRangeBonus()
end

function hoodwink_hunters_boomerang_custom:OnSpellStart()
local caster = self:GetCaster()
self:InitSpell()

local origin = caster:GetAbsOrigin()
local point = self:GetCursorPosition()
if origin == point then
	point = origin + caster:GetForwardVector()*10
end

local vec = point - origin
local max_range = self.range
local cast_point = GetGroundPosition((origin + vec:Normalized()*max_range), nil) + Vector(0, 0, 100)

local target = CreateModifierThinker(caster, self, "modifier_hoodwink_hunters_boomerang_custom_target", {duration = 10}, cast_point, caster:GetTeamNumber(), false)
local thinker = CreateModifierThinker(caster, self, "modifier_hoodwink_hunters_boomerang_custom_thinker", {}, origin, caster:GetTeamNumber(), false)

self.info = {
	Ability = self,	
	Target = target,
	Source = caster,
	EffectName = "particles/hoodwink/hoodwink_boomerang_custom.vpcf",
	iMoveSpeed = self.speed,
	bDodgeable = true,
	bVisibleToEnemies = true,
	bProvidesVision = true,
	iVisionRadius = 200,
	iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
	iVisionTeamNumber = caster:GetTeamNumber(),
	ExtraData = 
	{ 
		target = target:entindex(),
		thinker = thinker:entindex(),
		x = origin.x,
		y = origin.y
	}
}
caster:EmitSound("Hero_Hoodwink.Boomerang.Cast")
ProjectileManager:CreateTrackingProjectile(self.info)
end

function hoodwink_hunters_boomerang_custom:OnProjectileThink_ExtraData(location, table)
if not IsServer() then return end
local thinker = EntIndexToHScript(table.thinker)
if not IsValid(thinker) then return end

local mod = thinker:FindModifierByName("modifier_hoodwink_hunters_boomerang_custom_thinker")
if not mod then return end

local caster = self:GetCaster()

local targets = caster:FindTargets(self.radius, location)
for _,target in pairs(targets) do
	if not mod.targets[target] then
		mod.targets[target] = true
		self.damageTable.victim = target
		DoDamage(self.damageTable)

		local particle = ParticleManager:CreateParticle("particles/hoodwink/hoodwink_boomerang_custom_hit.vpcf", PATTACH_CUSTOMORIGIN, target)
		ParticleManager:SetParticleControlEnt( particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
		ParticleManager:ReleaseParticleIndex(particle)

		target:EmitSound(target:IsCreep() and "Hero_Hoodwink.Boomerang.Slow.Creep" or "Hero_Hoodwink.Boomerang.Slow")

		if IsValid(caster.sharp_ability) then 
			target:RemoveModifierByName("modifier_hoodwink_sharpshooter_custom_debuff")
			local origin = Vector(table.x, table.y, 0)
			local dir = (target:GetAbsOrigin() - origin):Normalized()
			target:AddNewModifier(caster, caster.sharp_ability, "modifier_hoodwink_sharpshooter_custom_debuff", { duration = self.duration*(1 - target:GetStatusResistance()), x = dir.x, y = dir.y } )
		end 
	end
end

thinker:SetAbsOrigin(location)
end


function hoodwink_hunters_boomerang_custom:OnProjectileHit_ExtraData(target, location, table)
if not target then return end
local thinker = EntIndexToHScript(table.thinker)
if not IsValid(thinker) then return end

local mod = thinker:FindModifierByName("modifier_hoodwink_hunters_boomerang_custom_thinker")
if not mod then return end

if not table.target then 
	mod:Destroy()
	return 
end

local target = EntIndexToHScript(table.target)
if not IsValid(target) then return end

local caster = self:GetCaster()
self.info.Source = target
self.info.Target = caster
self.info.iSourceAttachment = nil
self.info.EffectName = "particles/hoodwink/hoodwink_boomerang_custom_2.vpcf"
self.info.ExtraData = 
{
	thinker = table.thinker,
	x = location.x,
	y = location.y,
}
ProjectileManager:CreateTrackingProjectile(self.info)

mod.targets = {}

EmitSoundOnLocationWithCaster(location, "Hero_Hoodwink.Boomerang.Return", caster)
target:Destroy()
end





modifier_hoodwink_hunters_boomerang_custom_target = class(mod_hidden)
function modifier_hoodwink_hunters_boomerang_custom_target:OnCreated(table)
self.parent = self:GetParent()
end

function modifier_hoodwink_hunters_boomerang_custom_target:OnDestroy()
if not IsServer() then return end
UTIL_Remove(self.parent)
end


modifier_hoodwink_hunters_boomerang_custom_thinker = class(mod_hidden)
function modifier_hoodwink_hunters_boomerang_custom_thinker:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.targets = {}
if not IsServer() then return end
EmitSoundOn("Hoodwink.Shard_projectile", self.parent)
end

function modifier_hoodwink_hunters_boomerang_custom_thinker:OnDestroy()
if not IsServer() then return end
StopSoundOn("Hoodwink.Shard_projectile", self.parent)
UTIL_Remove(self.parent)
end