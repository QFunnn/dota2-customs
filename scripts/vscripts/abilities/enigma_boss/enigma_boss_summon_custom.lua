--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_enigma_boss_summon_custom_summon", "abilities/enigma_boss/enigma_boss_summon_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_enigma_boss_summon_custom_tracker", "abilities/enigma_boss/enigma_boss_summon_custom.lua", LUA_MODIFIER_MOTION_NONE)

enigma_boss_summon_custom = class({})

function enigma_boss_summon_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/units/heroes/hero_enigma/enigma_eidolon_ambient.vpcf", context )
PrecacheUnitByNameSync("npc_enigma_eidolon_custom", context, -1)

end

function enigma_boss_summon_custom:GetIntrinsicModifierName()
return "modifier_enigma_boss_summon_custom_tracker"
end



function enigma_boss_summon_custom:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()

caster:EmitSound("Enigma_boss.Summon_start")

local max = self:GetSpecialValueFor("max")
local point = target:GetAbsOrigin() + target:GetForwardVector()*300

for i = 1,max do 
	point = RotatePosition( target:GetAbsOrigin(), QAngle( 0, 360/max, 0 ), point )
	self:SpawnUnit(point, 0)
end

end

function enigma_boss_summon_custom:SpawnUnit(point, is_double)

local caster = self:GetCaster()
local health = self:GetSpecialValueFor("eidolon_health_1")
local damage = self:GetSpecialValueFor("eidolon_damage_1")
local magic = self:GetSpecialValueFor("eidolon_magic_1")
local armor = self:GetSpecialValueFor("eidolon_armor_1")
local duration = self:GetSpecialValueFor("duration")
local host_team = caster.host_team


if caster:GetUpgradeStack("modifier_waveupgrade_boss") == 2 then
	health = self:GetSpecialValueFor("eidolon_health_2")
	damage = self:GetSpecialValueFor("eidolon_damage_2")
	magic = self:GetSpecialValueFor("eidolon_magic_2")
	armor = self:GetSpecialValueFor("eidolon_armor_2")
end

if host_team then
  local ids = dota1x6:FindPlayers(host_team)
  if ids then
    if #ids == 2 then
      health = health*creeps_team_health
      damage = damage*creeps_team_damage
    end
  end
end

local eidolon = CreateUnitByName("npc_enigma_eidolon_custom", point, true, nil, nil, DOTA_TEAM_CUSTOM_5)

eidolon:SetBaseDamageMin(damage)
eidolon:SetBaseDamageMax(damage)

eidolon:SetBaseMaxHealth(health)
--eidolon:SetHealth(health)

eidolon:SetPhysicalArmorBaseValue(armor)
eidolon:SetBaseMagicalResistanceValue(magic)

eidolon:SetOwner(caster)
eidolon.mkb = caster.mkb
eidolon.summoned = true
eidolon.host_team = caster.host_team
eidolon.summoner = caster
eidolon.is_eidolon = true
FindClearSpaceForUnit(eidolon, point, false)
eidolon:AddNewModifier(eidolon, nil, "modifier_waveupgrade", {})
eidolon:AddNewModifier(eidolon, nil, "modifier_kill", {duration = duration})
eidolon:AddNewModifier(caster, self, "modifier_enigma_boss_summon_custom_summon", {is_double = is_double})
end




modifier_enigma_boss_summon_custom_summon = class({})
function modifier_enigma_boss_summon_custom_summon:IsHidden() return false end
function modifier_enigma_boss_summon_custom_summon:IsPurgable() return false end
function modifier_enigma_boss_summon_custom_summon:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.caster = self:GetCaster()

self.count = self.ability:GetSpecialValueFor("count")
self.double = self.ability:GetSpecialValueFor("double")
if not IsServer() then return end

self.is_double = table.is_double
self.parent:GenericParticle("particles/units/heroes/hero_enigma/enigma_eidolon_ambient.vpcf", self)
end

function modifier_enigma_boss_summon_custom_summon:CheckState()
return
{
	[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true
}
end







modifier_enigma_boss_summon_custom_tracker = class({})
function modifier_enigma_boss_summon_custom_tracker:IsHidden() return true end
function modifier_enigma_boss_summon_custom_tracker:IsPurgable() return false end
function modifier_enigma_boss_summon_custom_tracker:OnCreated()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.heal = self.ability:GetSpecialValueFor("heal")
self.heal_2 = self.ability:GetSpecialValueFor("heal_2")
self.summon_thresh = self.ability:GetSpecialValueFor("summon_thresh")/100
self.summon_thresh_2 = self.ability:GetSpecialValueFor("summon_thresh_2")/100

if not IsServer() then return end
self.caster:AddAttackEvent_out(self)
self.caster:AddDamageEvent_inc(self)
end

function modifier_enigma_boss_summon_custom_tracker:AttackEvent_out(params)
if not IsServer() then return end
if not self.caster:HasModifier("modifier_waveupgrade_boss") then return end

local attacker = params.attacker
if not attacker.summoner or attacker.summoner ~= self.caster then return end

local heal = self.heal
if self.caster:GetUpgradeStack("modifier_waveupgrade_boss") == 2 then
	heal = self.heal_2
end

if not self.team_bonus then
	self.team_bonus = 1

	if self.caster.host_team then
	  local ids = dota1x6:FindPlayers(self.caster.host_team)
	  if ids then
	    if #ids == 2 then
	      self.team_bonus = creeps_team_health
	    end
	  end
	end
end

heal = heal*self.team_bonus
self.caster:GenericHeal(heal, self.ability)
end


function modifier_enigma_boss_summon_custom_tracker:DamageEvent_inc(params)
if not IsServer() then return end
if not self.caster:HasModifier("modifier_waveupgrade_boss") then return end
if self.caster ~= params.unit then return end

local stack = params.damage
local thresh = self.summon_thresh*self.caster:GetMaxHealth()
if self.caster:GetUpgradeStack("modifier_waveupgrade_boss") == 2 then
	thresh = self.summon_thresh_2*self.caster:GetMaxHealth()
end

local final = self:GetStackCount() + stack

if final >= thresh then 

  local delta = math.floor(final/thresh)

  self.caster:EmitSound("Enigma_boss.eidolon_spawn")
  for i = 1, delta do 
  	local point = self.caster:GetAbsOrigin() + RandomVector(400)
    self.ability:SpawnUnit(point, 0)
  end 

  self:SetStackCount(final - delta*thresh)
else 
  self:SetStackCount(final)
end 



end