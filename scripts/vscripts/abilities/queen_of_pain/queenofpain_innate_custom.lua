--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_queenofpain_innate_custom", "abilities/queen_of_pain/queenofpain_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_queenofpain_scepter_custom", "abilities/queen_of_pain/queenofpain_innate_custom", LUA_MODIFIER_MOTION_NONE )


queenofpain_innate_custom = class({})



function queenofpain_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/units/heroes/hero_queenofpain/queenofpain_return.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_centaur/centaur_return.vpcf", context )
PrecacheResource( "particle","particles/queen_of_pain/scepter_active.vpcf", context )  
PrecacheResource( "particle","particles/econ/items/queen_of_pain/qop_ti8_immortal/qop_ti8_base_attack.vpcf", context )  
PrecacheResource( "particle","particles/econ/items/queen_of_pain/qop_ti8_immortal/qop_ti8_golden_base_attack.vpcf", context )  

PrecacheResource( "soundfile", "soundevents/npc_dota_hero_queenofpain.vsndevts", context )
PrecacheResource( "soundfile", "soundevents/vo_custom/queenofpain_vo_custom.vsndevts", context ) 
end


function queenofpain_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_queenofpain_innate_custom"
end



modifier_queenofpain_innate_custom = class({})
function modifier_queenofpain_innate_custom:IsHidden() return true end
function modifier_queenofpain_innate_custom:IsPurgable() return false end
function modifier_queenofpain_innate_custom:RemoveOnDeath() return false end
function modifier_queenofpain_innate_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.heal = self.ability:GetSpecialValueFor("heal")/100
self.radius = self.ability:GetSpecialValueFor("radius")
self.max_dist = self.ability:GetSpecialValueFor("max_range")
self.min_dist = self.ability:GetSpecialValueFor("min_range")
self.creeps = self.ability:GetSpecialValueFor("creeps")

self.low_health = self.parent:GetTalentValue("modifier_queen_scream_6", "health", true)
self.low_heal = self.parent:GetTalentValue("modifier_queen_scream_6", "heal", true)/100

self.parent:AddDamageEvent_out(self)
end

function modifier_queenofpain_innate_custom:DamageEvent_out(params)
if not IsServer() then return end
if self.parent:PassivesDisabled() then return end

local unit = params.unit
local vec = (self.parent:GetAbsOrigin() - unit:GetAbsOrigin())

if vec:Length2D() > self.max_dist then return end
if not self.parent:CheckLifesteal(params) then return end

local base_heal = self.heal

if self.parent:HasTalent("modifier_queen_scream_6") and self.parent:GetHealthPercent() <= self.low_health then
	base_heal = base_heal + self.low_heal
end

local length = math.min(self.max_dist, math.max(self.min_dist, vec:Length2D())) - self.min_dist
local heal = base_heal*(1 - length/(self.max_dist - self.min_dist)) 
local mod = self.parent:FindModifierByName("modifier_queenofpain_scepter_custom")

if mod and mod.bonus then
	heal = heal*mod.bonus
end

heal = heal*params.damage
if unit:IsCreep() then
	heal = heal/self.creeps
end

self.parent:GenericHeal(heal, self.ability, true, "particles/items3_fx/octarine_core_lifesteal.vpcf")
end






custom_queenofpain_scepter = class({})

function custom_queenofpain_scepter:GetHealthCost()
return self:GetSpecialValueFor("cost")*self:GetCaster():GetHealth()/100
end

function custom_queenofpain_scepter:OnSpellStart()
local caster = self:GetCaster()
caster:StartGesture(ACT_DOTA_CAST_ABILITY_3)
caster:EmitSound("QoP.Scepter_active1")
caster:EmitSound("QoP.Scepter_active2")
caster:EmitSound("QoP.Scepter_active3")
caster:AddNewModifier(caster, self, "modifier_queenofpain_scepter_custom", {duration = self:GetSpecialValueFor("duration")})
end

modifier_queenofpain_scepter_custom = class({})
function modifier_queenofpain_scepter_custom:IsHidden() return false end
function modifier_queenofpain_scepter_custom:IsPurgable() return false end
function modifier_queenofpain_scepter_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.damage = self.ability:GetSpecialValueFor("damage")/100
self.bonus = self.ability:GetSpecialValueFor("bonus")
self.radius = 1200

self.parent:AddDamageEvent_inc(self)
if not IsServer() then return end
self.parent:GenericParticle("particles/brist_proc.vpcf")
self.parent:GenericParticle("particles/queen_of_pain/scepter_active.vpcf", self)
self.ability:EndCd()
end

function modifier_queenofpain_scepter_custom:OnDestroy()
if not IsServer() then return end
self.ability:StartCd()
end


function modifier_queenofpain_scepter_custom:DamageEvent_inc(params)
if not IsServer() then return end
if not self.parent:IsAlive() then return end
if self.parent ~= params.unit then return end
if self.parent == params.attacker then return end

local target = params.attacker

if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then return end
if params.inflictor and params.inflictor:GetName() == self.ability:GetName() then return end
if (self.parent:GetAbsOrigin() - target:GetAbsOrigin()):Length2D() > self.radius then return end

local damage_return = params.original_damage*self.damage

self.parent:EmitSound("QoP.Scepter_damage")

if target:IsHero() then
	for i = 1,3 do
		local caster_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_return.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
		ParticleManager:SetParticleControlEnt(caster_pfx, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(caster_pfx, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(caster_pfx)
	end
end	

DoDamage({victim = target, attacker = self.parent, damage = damage_return, damage_type = DAMAGE_TYPE_MAGICAL,  damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK, ability = self.ability})
end








function modifier_queenofpain_scepter_custom:GetStatusEffectName()
return "particles/status_fx/status_effect_statue_compendium_2014_dire.vpcf"
end

function modifier_queenofpain_scepter_custom:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA 
end