--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_neutral_cone_armor_active_reduce", "abilities/neutral_creeps_active/neutral_cone_armor_active", LUA_MODIFIER_MOTION_NONE )

neutral_cone_armor_active = class({})



function neutral_cone_armor_active:OnSpellStart()
local caster = self:GetCaster()
local duration = self:GetSpecialValueFor("duration")

caster:AddNewModifier(caster, self, "modifier_neutral_cone_armor_active_reduce", {duration = duration}) 
end





modifier_neutral_cone_armor_active_reduce = class({})
function modifier_neutral_cone_armor_active_reduce:IsHidden() return false end
function modifier_neutral_cone_armor_active_reduce:IsPurgable() return true end

function modifier_neutral_cone_armor_active_reduce:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.reduce = self.ability:GetSpecialValueFor("reduce")
self.damage = self.ability:GetSpecialValueFor("damage")/100

if not IsServer() then return end

self.parent:EmitSound("UI.Generic_shield")

self.buff_particles = {}
self.buff_particles[1] = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_tailthump_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.buff_particles[1], 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,0), false) 
self:AddParticle(self.buff_particles[1], false, false, -1, true, false)
ParticleManager:SetParticleControl( self.buff_particles[1], 3, Vector( 255, 255, 255 ) )

self.buff_particles[2] = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_egg.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.buff_particles[2], 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,0), false) 
self:AddParticle(self.buff_particles[2], false, false, -1, true, false)

self.buff_particles[3] = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_tailthump_buff_streaks.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.buff_particles[3], 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,0), false) 
self:AddParticle(self.buff_particles[3], false, false, -1, true, false)

self.parent:AddDamageEvent_inc(self)
end 

function modifier_neutral_cone_armor_active_reduce:DamageEvent_inc(params)
if not IsServer() then return end
if params.attacker == nil then return end
if self.parent ~= params.unit then return end
if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then return end

local attacker = params.attacker
damage = params.original_damage * self.damage

DoDamage({ victim = attacker, attacker = self.parent, ability = self.ability, damage = damage, damage_type = params.damage_type, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_REFLECTION})
EmitSoundOnEntityForPlayer("DOTA_Item.BladeMail.Damage", attacker, attacker:GetPlayerOwnerID())
end

function modifier_neutral_cone_armor_active_reduce:CheckState()
return
{
  [MODIFIER_STATE_STUNNED] = true
}
end
function modifier_neutral_cone_armor_active_reduce:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_neutral_cone_armor_active_reduce:GetModifierIncomingDamage_Percentage()
return self.reduce
end