--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_zuus_innate_custom", "abilities/zuus/zuus_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_zuus_innate_custom_purge_cd", "abilities/zuus/zuus_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_zuus_innate_custom_damage_reduce", "abilities/zuus/zuus_innate_custom", LUA_MODIFIER_MOTION_NONE )

zuus_innate_custom = class({})
zuus_innate_custom.talents = {}

function zuus_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/units/heroes/hero_zuus/zuus_static_field.vpcf", context )
PrecacheResource( "particle","particles/zeus/lowhp_damage_reduce.vpcf", context )
PrecacheResource( "soundfile", "soundevents/vo_custom/zuus_vo_custom.vsndevts", context ) 

PrecacheResource( "soundfile", "soundevents/npc_dota_hero_zuus.vsndevts", context )
dota1x6:PrecacheShopItems("npc_dota_hero_zuus", context)
end

function zuus_innate_custom:UpdateTalents(name)
local caster = self:GetCaster()
if not self.init then
  self.init = true
  self.talents =
  {
    has_h3 = 0,
    h3_range = 0,
    h3_mana = 0,
    
    has_h5 = 0,
    h5_damage_reduce = caster:GetTalentValue("modifier_zuus_hero_5", "damage_reduce", true),
    h5_talent_cd = caster:GetTalentValue("modifier_zuus_hero_5", "talent_cd", true),
    h5_status = caster:GetTalentValue("modifier_zuus_hero_5", "status", true),
    h5_radius = caster:GetTalentValue("modifier_zuus_hero_5", "radius", true),
    h5_knock_duration = caster:GetTalentValue("modifier_zuus_hero_5", "knock_duration", true),
    h5_health = caster:GetTalentValue("modifier_zuus_hero_5", "health", true),
    h5_duration = caster:GetTalentValue("modifier_zuus_hero_5", "duration", true),
  }
end

if caster:HasTalent("modifier_zuus_hero_3") then
  self.talents.has_h3 = 1
  self.talents.h3_range = caster:GetTalentValue("modifier_zuus_hero_3", "range")
  self.talents.h3_mana = caster:GetTalentValue("modifier_zuus_hero_3", "mana")
end

if caster:HasTalent("modifier_zuus_hero_5") then
  self.talents.has_h5 = 1
  caster:AddDamageEvent_inc(self.tracker, true)
end

end

function zuus_innate_custom:Init()
self.caster = self:GetCaster()
end

function zuus_innate_custom:GetAbilityTargetFlags()
if self:GetCaster():HasShard() then 
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
else 
	return DOTA_UNIT_TARGET_FLAG_NONE
end

end


function zuus_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_zuus_innate_custom"
end

function zuus_innate_custom:DealDamage(target)
if not IsServer() then return end
if self.caster:PassivesDisabled() then return end

local damage = self.damage + (self.caster:HasShard() and self.shard_damage or 0)
damage = damage*target:GetHealth()

if target:IsCreep() then
	damage = math.min(damage, self.damage_creeps)
end

local real_damage = DoDamage({victim = target, attacker = self.caster, ability = self, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
local result = self.caster:CanLifesteal(target)
if result and self.caster:HasShard() then
	self.caster:GenericHeal(result*real_damage*self.shard_heal, self, true, "", "shard")
end

local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_zuus/zuus_static_field.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
ParticleManager:SetParticleControlEnt(effect_cast, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(effect_cast, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex( effect_cast )
end


modifier_zuus_innate_custom = class(mod_hidden)
function modifier_zuus_innate_custom:RemoveOnDeath() return false end
function modifier_zuus_innate_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.tracker = self
self.ability:UpdateTalents()

self.parent.static_ability = self.ability

self.ability.damage = self.ability:GetSpecialValueFor("damage")/100
self.ability.damage_creeps = self.ability:GetSpecialValueFor("damage_creeps") 
self.ability.shard_heal = self.ability:GetSpecialValueFor("shard_heal")/100
self.ability.shard_damage = self.ability:GetSpecialValueFor("shard_damage")/100 
end

function modifier_zuus_innate_custom:DeclareFunctions()
return
{
  	MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
    MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
    MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
}
end

function modifier_zuus_innate_custom:GetModifierPercentageManacostStacking()
return self.ability.talents.h3_mana
end

function modifier_zuus_innate_custom:GetModifierCastRangeBonusStacking()
return self.ability.talents.h3_range
end

function modifier_zuus_innate_custom:GetModifierStatusResistanceStacking() 
if self.ability.talents.has_h5 == 0 then return end
return self.ability.talents.h5_status
end

function modifier_zuus_innate_custom:DamageEvent_inc(params)
if not IsServer() then return end
if self.parent:HasModifier("modifier_zuus_innate_custom_purge_cd") then return end
if self.ability.talents.has_h5 == 0 then return end
if self.parent ~= params.unit then return end
if self.parent:PassivesDisabled() then return end
if not self.parent:IsAlive() then return end
if self.parent:GetHealthPercent() > self.ability.talents.h5_health then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_zuus_innate_custom_damage_reduce", {duration = self.ability.talents.h5_duration})
self.parent:AddNewModifier(self.parent, self.ability, "modifier_zuus_innate_custom_purge_cd", {duration = self.ability.talents.h5_talent_cd})
self.parent:EmitSound("Zuus.Wrath_knockback")
self.parent:EmitSound("Zuus.Purge_dispel")

local max = 6
local line_position = self.parent:GetAbsOrigin() + self.parent:GetForwardVector() * 400
for i = 1, max do
	local qangle = QAngle(0, 360/max, 0)
	line_position = RotatePosition(self.parent:GetAbsOrigin() , qangle, line_position)

	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	local n = RandomInt(1, 2)
	ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_attack"..n, self.parent:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(particle, 1, line_position)
	ParticleManager:DestroyParticle(particle, false)	
	ParticleManager:ReleaseParticleIndex(particle)
end

for _,unit in pairs(self.parent:FindTargets(self.ability.talents.h5_radius)) do
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControlEnt(particle, 1, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", unit:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_attack"..RandomInt(1, 2), self.parent:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(particle)
	unit:GenericParticle("particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_static_field.vpcf")
	
	local vec = unit:GetAbsOrigin() - self.parent:GetAbsOrigin()
	local point = self.parent:GetAbsOrigin() + vec:Normalized()*self.ability.talents.h5_radius

	local knockbackProperties =
	{
	  center_x = self.parent:GetOrigin().x,
	  center_y = self.parent:GetOrigin().y,
	  center_z = self.parent:GetOrigin().z,
	  duration = self.ability.talents.h5_knock_duration,
	  knockback_duration = self.ability.talents.h5_knock_duration,
	  knockback_distance = (point - unit:GetAbsOrigin()):Length2D(),
	  knockback_height = 0
	}
	unit:AddNewModifier( self.parent, self, "modifier_knockback", knockbackProperties )
end

end



modifier_zuus_innate_custom_purge_cd = class(mod_cd)
function modifier_zuus_innate_custom_purge_cd:GetTexture() return "buffs/zeus/hero_5" end



modifier_zuus_innate_custom_damage_reduce = class(mod_hidden)
function modifier_zuus_innate_custom_damage_reduce:GetStatusEffectName() return "particles/status_fx/status_effect_mjollnir_shield.vpcf" end
function modifier_zuus_innate_custom_damage_reduce:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH end
function modifier_zuus_innate_custom_damage_reduce:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.damage_reduce = self.ability.talents.h5_damage_reduce
if not IsServer() then return end
self.parent:GenericParticle("particles/zeus/lowhp_damage_reduce.vpcf", self)
end

function modifier_zuus_innate_custom_damage_reduce:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_zuus_innate_custom_damage_reduce:GetModifierIncomingDamage_Percentage()
return self.damage_reduce
end