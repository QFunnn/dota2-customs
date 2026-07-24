--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_angels_demise_custom", "abilities/items/item_angels_demise_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_angels_demise_custom_break", "abilities/items/item_angels_demise_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_angels_demise_custom_cd", "abilities/items/item_angels_demise_custom", LUA_MODIFIER_MOTION_NONE)

item_angels_demise_custom = class({})

function item_angels_demise_custom:GetIntrinsicModifierName()
return "modifier_item_angels_demise_custom"
end

function item_angels_demise_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/empyreal_lens_target.vpcf", context )
PrecacheResource( "particle","particles/empyreal_lens.vpcf", context )
PrecacheResource( "particle","particles/items/khanda_active.vpcf", context )
PrecacheResource( "particle","particles/items/khanda_proc.vpcf", context )
end


modifier_item_angels_demise_custom = class(mod_hidden)
function modifier_item_angels_demise_custom:RemoveOnDeath() return false end
function modifier_item_angels_demise_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
}
end

function modifier_item_angels_demise_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if self.parent:IsRealHero() then 
	self.parent:AddDamageEvent_out(self, true)
	self.parent:AddSpellEvent(self, true)
end 

self.stats = self.ability:GetSpecialValueFor("bonus_all_stats")
self.damage = self.ability:GetSpecialValueFor("bonus_damage")

self.min_damage = self.ability:GetSpecialValueFor("min_damage_to_activate")
self.max_damage = self.ability:GetSpecialValueFor("max_damage")
self.crit_damage = self.ability:GetSpecialValueFor("crit_damage")/100
self.crit_chance = self.ability:GetSpecialValueFor("crit_chance")
self.crit_bonus = self.ability:GetSpecialValueFor("crit_bonus")
self.break_duration = self.ability:GetSpecialValueFor("break_duration")

self.damageTable = {attacker = self.parent, ability = self.ability, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION}
end 

function modifier_item_angels_demise_custom:SpellEvent(params)
if not IsServer() then return end
if not self.ability:IsFullyCastable() then return end
if self.parent ~= params.unit then return end

local target = params.target
if not target or not target:IsUnit() then return end
if target:GetTeamNumber() == self.parent:GetTeamNumber() then return end
if target:IsCreep() then return end

local particle_2 = ParticleManager:CreateParticle("particles/items_fx/phylactery.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(particle_2, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(particle_2, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(particle_2)

target:EmitSound("Item.Khanda_active")
target:AddNewModifier(self.parent, self.ability, "modifier_item_angels_demise_custom_break", {duration = (1 - target:GetStatusResistance())*self.break_duration})
self.ability:StartCd()
end

function modifier_item_angels_demise_custom:DamageEvent_out(params)
if not IsServer() then return end
if params.attacker ~= self.parent then return end
local unit = params.unit

if unit:GetTeamNumber() == self.parent:GetTeamNumber() then return end
if not self.parent:IsRealHero() then return end
if not params.inflictor or params.inflictor == self.ability then return end
if not self.parent:IsAlive() then return end
if params.original_damage < self.min_damage then return end

local chance = self.crit_chance + (unit:FindModifierByNameAndCaster("modifier_item_angels_demise_custom_break", self.parent) and self.crit_bonus or 0)
local index = params.original_damage > 150 and 5128 or 5129

if not RollPseudoRandomPercentage(chance, index, self.parent) then return end

local particle = ParticleManager:CreateParticle("particles/items/khanda_proc.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
ParticleManager:SetParticleControlEnt(particle, 0, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", unit:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(particle)

if unit:IsHero() then
	unit:EmitSound("Item.Khanda_proc")
end

local damage = math.min(self.max_damage, params.original_damage*self.crit_damage)
self.damageTable.victim = unit
self.damageTable.damage = damage
self.damageTable.damage_type = params.damage_type
DoDamage(self.damageTable)

unit:SendNumber(24, damage)
end

function modifier_item_angels_demise_custom:GetModifierSpellAmplify_Percentage()
return self.damage
end

function modifier_item_angels_demise_custom:GetModifierBonusStats_Strength()
return self.stats
end

function modifier_item_angels_demise_custom:GetModifierBonusStats_Agility()
return self.stats
end

function modifier_item_angels_demise_custom:GetModifierBonusStats_Intellect()
return self.stats
end

modifier_item_angels_demise_custom_break = class({})
function modifier_item_angels_demise_custom_break:IsHidden() return false end
function modifier_item_angels_demise_custom_break:IsPurgable() return false end
function modifier_item_angels_demise_custom_break:CheckState() return {[MODIFIER_STATE_PASSIVES_DISABLED] = true} end
function modifier_item_angels_demise_custom_break:GetEffectName() return "particles/items3_fx/silver_edge.vpcf" end

function modifier_item_angels_demise_custom_break:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_item_angels_demise_custom_break:OnCreated(table)
self.speed = self:GetAbility():GetSpecialValueFor("slow")
self.parent = self:GetParent()
if not IsServer() then return end
self.parent:EmitSound("DOTA_Item.SilverEdge.Target")
self.parent:GenericParticle("particles/generic_gameplay/generic_break.vpcf", self, true)
self.parent:GenericParticle("particles/items/khanda_active.vpcf", self)
end

function modifier_item_angels_demise_custom_break:GetModifierMoveSpeedBonus_Percentage()
return self.speed
end

modifier_item_angels_demise_custom_cd = class(mod_hidden)