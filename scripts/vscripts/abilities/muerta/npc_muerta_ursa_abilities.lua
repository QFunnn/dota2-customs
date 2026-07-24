--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_npc_muerta_ursa_speed", "abilities/muerta/npc_muerta_ursa_abilities", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_npc_muerta_ursa_passive", "abilities/muerta/npc_muerta_ursa_abilities", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_npc_muerta_ursa_debuff", "abilities/muerta/npc_muerta_ursa_abilities", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_npc_muerta_ursa_slow", "abilities/muerta/npc_muerta_ursa_abilities", LUA_MODIFIER_MOTION_NONE)


npc_muerta_ursa_speed = class({})

function npc_muerta_ursa_speed:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_ursa/ursa_overpower_buff.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_ursa/ursa_fury_swipes.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_ursa/ursa_fury_swipes_debuff.vpcf", context )
PrecacheResource( "particle", "particles/generic_gameplay/generic_has_quest.vpcf", context )
PrecacheResource( "particle", "particles/red_zone.vpcf", context )
PrecacheResource( "particle", "particles/neutral_fx/ursa_thunderclap.vpcf", context )
PrecacheResource( "particle", "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_debuff.vpcf", context )
PrecacheResource( "particle", "particles/status_fx/status_effect_snapfire_slow.vpcf", context )
end

function npc_muerta_ursa_speed:Spawn()
if not self:GetCaster() then return end
self.caster = self:GetCaster()

self.move = self:GetLevelSpecialValueFor("move", 1)
self.speed = self:GetLevelSpecialValueFor("speed", 1)
self.attacks = self:GetLevelSpecialValueFor("attacks", 1)
self.duration = self:GetLevelSpecialValueFor("duration", 1)
end

function npc_muerta_ursa_speed:OnSpellStart()

self.caster:EmitSound("Hero_Ursa.Overpower")
self.caster:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_3)
self.caster:AddNewModifier(self.caster, self, "modifier_npc_muerta_ursa_speed", {duration = self.duration})
end

modifier_npc_muerta_ursa_speed = class(mod_hidden)
function modifier_npc_muerta_ursa_speed:IsPurgable() return true end
function modifier_npc_muerta_ursa_speed:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.move = self.ability.move
self.speed = self.ability.speed

if not IsServer() then return end

self.parent:AddAttackStartEvent_out(self, true)

local ursa_overpower_buff_particle_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_ursa/ursa_overpower_buff.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
ParticleManager:SetParticleControlEnt(ursa_overpower_buff_particle_fx, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(ursa_overpower_buff_particle_fx, 2, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(ursa_overpower_buff_particle_fx, 3, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
self:AddParticle(ursa_overpower_buff_particle_fx, false, false, -1, false, false)

self:SetStackCount(self.ability.attacks)
end

function modifier_npc_muerta_ursa_speed:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
}
end

function modifier_npc_muerta_ursa_speed:GetModifierMoveSpeedBonus_Percentage()
return self.move
end

function modifier_npc_muerta_ursa_speed:GetModifierAttackSpeedBonus_Constant()
if self:GetStackCount() == 0 then return end
return self.speed
end

function modifier_npc_muerta_ursa_speed:AttackStartEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end

local target = params.target
if not target:IsUnit() then return end
if self:GetStackCount() == 0 then return end

self:DecrementStackCount()
end


npc_muerta_ursa_passive = class({})

function npc_muerta_ursa_passive:GetIntrinsicModifierName()
return "modifier_npc_muerta_ursa_passive"
end

function npc_muerta_ursa_passive:Spawn()
if not self:GetCaster() then return end
self.caster = self:GetCaster()

self.damage = self:GetLevelSpecialValueFor("damage", 1)
self.duration = self:GetLevelSpecialValueFor("duration", 1)
end

modifier_npc_muerta_ursa_passive = class(mod_hidden)
function modifier_npc_muerta_ursa_passive:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL
}
end

function modifier_npc_muerta_ursa_passive:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent.ursa_creep_passive = self.ability
end

function modifier_npc_muerta_ursa_passive:GetModifierProcAttack_BonusDamage_Physical(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end

local target = params.target
local mod = target:AddNewModifier(self.parent, self.ability, "modifier_npc_muerta_ursa_debuff", {duration = self.ability.duration})
local damage = 0

if mod then 
	damage = mod:GetStackCount()*self.parent:GetAverageTrueAttackDamage(nil)*self.ability.damage/100
end

return damage
end


modifier_npc_muerta_ursa_debuff = class(mod_visible)
function modifier_npc_muerta_ursa_debuff:GetTexture() return "ursa_overpower" end
function modifier_npc_muerta_ursa_debuff:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.damage = self.ability.damage

if not IsServer() then return end
self.parent:GenericParticle("particles/units/heroes/hero_ursa/ursa_fury_swipes_debuff.vpcf", self, true)
self:SetStackCount(1)
end

function modifier_npc_muerta_ursa_debuff:OnRefresh(table)
if not IsServer() then return end
self:IncrementStackCount()
end

function modifier_npc_muerta_ursa_debuff:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_TOOLTIP
}
end

function modifier_npc_muerta_ursa_debuff:OnTooltip()
return self:GetStackCount()*self.damage
end



npc_muerta_ursa_clap = class({})

function npc_muerta_ursa_clap:Spawn()
if not self:GetCaster() then return end
self.caster = self:GetCaster()

self.stacks = self:GetLevelSpecialValueFor("stacks", 1)
self.slow = self:GetLevelSpecialValueFor("slow", 1)
self.duration = self:GetLevelSpecialValueFor("duration", 1)
self.radius = self:GetLevelSpecialValueFor("radius", 1)
end

function npc_muerta_ursa_clap:OnAbilityPhaseStart()
self.sign = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_has_quest.vpcf", PATTACH_OVERHEAD_FOLLOW, self.caster)
self.caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 0.7)
self.caster:EmitSound("n_creep_Ursa.Clap")

self.effect_cast = ParticleManager:CreateParticle("particles/red_zone.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
ParticleManager:SetParticleControl( self.effect_cast, 0, self.caster:GetOrigin() )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 0, -self.radius) )
ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( 1, 0, 0 ) )
return true
end 

function npc_muerta_ursa_clap:OnAbilityPhaseInterrupted()

if self.sign then
    ParticleManager:DestroyParticle(self.sign, true)
    ParticleManager:ReleaseParticleIndex(self.sign)
    ParticleManager:DestroyParticle(self.effect_cast, true)
    ParticleManager:ReleaseParticleIndex(self.effect_cast)
    self.sign = nil
    self.effect_cast = nil
end

self.caster:RemoveGesture(ACT_DOTA_CAST_ABILITY_1)
end

function npc_muerta_ursa_clap:OnSpellStart()

ParticleManager:DestroyParticle(self.sign, true)
ParticleManager:ReleaseParticleIndex(self.sign)

ParticleManager:DestroyParticle(self.effect_cast, true)
ParticleManager:ReleaseParticleIndex(self.effect_cast)

self.sign = nil
self.effect_cast = nil

self.caster:EmitSound("Hero_Ursa.Earthshock")

local trail_pfx = ParticleManager:CreateParticle("particles/neutral_fx/ursa_thunderclap.vpcf", PATTACH_ABSORIGIN, self.caster)
ParticleManager:SetParticleControl(trail_pfx, 1, Vector(self.radius, 0 ,0 ) )
ParticleManager:ReleaseParticleIndex(trail_pfx)    

for _,target in pairs(self.caster:FindTargets(self.radius)) do 
	if IsValid(self.caster.ursa_creep_passive) then 
		for i = 1, self.stacks do
			target:AddNewModifier(self.caster, self.caster.ursa_creep_passive, "modifier_npc_muerta_ursa_debuff", {duration = self.caster.ursa_creep_passive.duration})
		end
	end
	target:AddNewModifier(self.caster, self, "modifier_npc_muerta_ursa_slow", {duration = self.duration})
end

end


modifier_npc_muerta_ursa_slow = class(mod_visible)
function modifier_npc_muerta_ursa_slow:IsPurgable() return true end
function modifier_npc_muerta_ursa_slow:GetStatusEffectName()return "particles/status_fx/status_effect_snapfire_slow.vpcf" end
function modifier_npc_muerta_ursa_slow:StatusEffectPriority() return MODIFIER_PRIORITY_NORMAL end
function modifier_npc_muerta_ursa_slow:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.slow = self.ability.slow
if not IsServer() then return end
self.parent:GenericParticle("particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_debuff.vpcf", self)
end

function modifier_npc_muerta_ursa_slow:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_npc_muerta_ursa_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end