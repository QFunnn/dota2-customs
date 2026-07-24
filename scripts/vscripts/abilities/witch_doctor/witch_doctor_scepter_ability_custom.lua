--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_witch_doctor_scepter_ability_custom", "abilities/witch_doctor/witch_doctor_scepter_ability_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_witch_doctor_scepter_ability_custom_aura", "abilities/witch_doctor/witch_doctor_scepter_ability_custom", LUA_MODIFIER_MOTION_NONE )

witch_doctor_scepter_ability_custom = class({})

function witch_doctor_scepter_ability_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_alchemist/alchemist_berserk_potion_projectile.vpcf", context )
PrecacheResource( "particle", "amir4an/particles/heroes/witch_doctor/amir4an_1x6/amir4an_1x6_witch_doctor_scepter_ambient.vpcf", context )
PrecacheResource( "particle", "amir4an/particles/heroes/witch_doctor/amir4an_1x6/amir4an_1x6_witch_doctor_scepter_over_head_ambient.vpcf", context )
PrecacheResource( "particle", "particles/witch_doctor/scepter_heal.vpcf", context )
end

function witch_doctor_scepter_ability_custom:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()
local speed = self:GetSpecialValueFor("speed")

caster:EmitSound("WD.Scepter_cast")
caster:EmitSound("WD.Scepter_cast2")
caster:EmitSound("WD.Scepter_cast_vo")

local info = 
{
	Target = target,
	Source = caster,
	Ability = self,	
  	iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1, 
	EffectName = "particles/units/heroes/hero_alchemist/alchemist_berserk_potion_projectile.vpcf",
	iMoveSpeed = speed,
	bDodgeable = false,                         
	bVisibleToEnemies = true,                   
	bProvidesVision = false,        
}
ProjectileManager:CreateTrackingProjectile(info)
end


function witch_doctor_scepter_ability_custom:OnProjectileHit(target, vLocation)
if not target then return end
if target:TriggerSpellAbsorb(self) then return end

local caster = self:GetCaster()
local duration = self:GetSpecialValueFor("duration")

target:AddNewModifier(caster, self, "modifier_witch_doctor_scepter_ability_custom", {duration = duration})
end


modifier_witch_doctor_scepter_ability_custom = class(mod_visible)
function modifier_witch_doctor_scepter_ability_custom:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

if not IsServer() then return end

self.parent:EmitSound("WD.Scepter_target")
self.parent:EmitSound("WD.Scepter_target2")
self.parent:EmitSound("WD.Scepter_target3")

self.heal_pct = self.ability:GetSpecialValueFor("heal_pct")/100
self.damage_pct = self.ability:GetSpecialValueFor("damage_pct")/100

self.damageTable = {attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_PURE, victim = self.parent, damage_flags = DOTA_DAMAGE_FLAG_REFLECTION}

self.parent:GenericParticle("amir4an/particles/heroes/witch_doctor/amir4an_1x6/amir4an_1x6_witch_doctor_scepter_ambient.vpcf", self)
self.parent:GenericParticle("amir4an/particles/heroes/witch_doctor/amir4an_1x6/amir4an_1x6_witch_doctor_scepter_over_head_ambient.vpcf", self, true)
self.parent:AddHealEvent_inc(self, true)
end

function modifier_witch_doctor_scepter_ability_custom:HealEvent_inc(params)
if not IsServer() then return end
if params.unit ~= self.parent then return end

self.damageTable.damage = params.gain*self.heal_pct
DoDamage(self.damageTable)
end

function modifier_witch_doctor_scepter_ability_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_DISABLE_HEALING 
}
end

function modifier_witch_doctor_scepter_ability_custom:GetDisableHealing()
return 1
end

function modifier_witch_doctor_scepter_ability_custom:GetStatusEffectName() return "particles/status_fx/status_effect_nullifier.vpcf" end
function modifier_witch_doctor_scepter_ability_custom:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH end
function modifier_witch_doctor_scepter_ability_custom:IsAura() return true end
function modifier_witch_doctor_scepter_ability_custom:GetAuraDuration() return 0 end
function modifier_witch_doctor_scepter_ability_custom:GetAuraRadius() return 1200 end
function modifier_witch_doctor_scepter_ability_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_witch_doctor_scepter_ability_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_witch_doctor_scepter_ability_custom:GetModifierAura() return "modifier_witch_doctor_scepter_ability_custom_aura" end



modifier_witch_doctor_scepter_ability_custom_aura = class(mod_hidden)
function modifier_witch_doctor_scepter_ability_custom_aura:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_witch_doctor_scepter_ability_custom_aura:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetAuraOwner()
self.ability = self:GetAbility()

if not IsServer() then return end
self.damage_pct = self.ability:GetSpecialValueFor("damage_pct")/100
end

function modifier_witch_doctor_scepter_ability_custom_aura:NoDamage(params)
if not IsServer() then return end
if not params.attacker then return end
if not params.damage or params.damage <= 0 then return end

if params.attacker ~= self.caster then return 0 end
if not self.caster:HasModifier("modifier_witch_doctor_scepter_ability_custom") then return 0 end
if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then return 1 end

local target = params.target
local particle = ParticleManager:CreateParticle("particles/witch_doctor/scepter_heal.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, target)
ParticleManager:SetParticleControlEnt( particle, 0, target, PATTACH_ABSORIGIN_FOLLOW, nil, target:GetAbsOrigin(), true )
ParticleManager:SetParticleControlEnt( particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true )
ParticleManager:ReleaseParticleIndex(particle)

target:GenericHeal(params.damage*self.damage_pct, self.ability, true, "")

return 1
end

function modifier_witch_doctor_scepter_ability_custom_aura:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
}
end

function modifier_witch_doctor_scepter_ability_custom_aura:GetAbsoluteNoDamagePhysical(params)
return self:NoDamage(params)
end

function modifier_witch_doctor_scepter_ability_custom_aura:GetAbsoluteNoDamageMagical(params)
return self:NoDamage(params)
end

function modifier_witch_doctor_scepter_ability_custom_aura:GetAbsoluteNoDamagePure(params)
return self:NoDamage(params)
end
