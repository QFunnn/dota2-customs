--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_phylactery_custom", "abilities/items/item_phylactery_custom", LUA_MODIFIER_MOTION_NONE)

item_phylactery_custom = class({})

function item_phylactery_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items_fx/phylactery_target.vpcf", context )
PrecacheResource( "particle","particles/items_fx/phylactery.vpcf", context )
PrecacheResource( "particle","particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_phylactery.vpcf", context )
PrecacheResource( "particle","particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_phylactery_v2.vpcf", context )
PrecacheResource( "particle","particles/items/khanda_proc.vpcf", context )
end

function item_phylactery_custom:GetIntrinsicModifierName()
	return "modifier_item_phylactery_custom"
end

function item_phylactery_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "item_phylactery", self)
end


modifier_item_phylactery_custom = class(mod_hidden)
function modifier_item_phylactery_custom:RemoveOnDeath() return false end
function modifier_item_phylactery_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
}
end

function modifier_item_phylactery_custom:GetModifierSpellAmplify_Percentage()
return self.damage
end

function modifier_item_phylactery_custom:GetModifierBonusStats_Strength()
return self.bonus_all_stats
end

function modifier_item_phylactery_custom:GetModifierBonusStats_Agility()
return self.bonus_all_stats
end

function modifier_item_phylactery_custom:GetModifierBonusStats_Intellect()
return self.bonus_all_stats
end

function modifier_item_phylactery_custom:OnCreated(table)
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.bonus_all_stats = self.ability:GetSpecialValueFor("bonus_all_stats")
self.damage = self.ability:GetSpecialValueFor("bonus_damage")

self.min_damage = self.ability:GetSpecialValueFor("min_damage_to_activate")
self.max_damage = self.ability:GetSpecialValueFor("max_damage")
self.crit_damage = self.ability:GetSpecialValueFor("crit_damage")/100
self.crit_chance = self.ability:GetSpecialValueFor("crit_chance")

if self.parent:IsRealHero() then 
    self.parent:AddDamageEvent_out(self, true)
end 

self.damageTable = {attacker = self.parent, ability = self.ability, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION}
end


function modifier_item_phylactery_custom:DamageEvent_out(params)
if not IsServer() then return end
if params.attacker ~= self.parent then return end
local unit = params.unit

if unit:GetTeamNumber() == self.parent:GetTeamNumber() then return end
if not self.parent:IsRealHero() then return end
if not params.inflictor or params.inflictor == self.ability then return end
if not self.parent:IsAlive() then return end
if params.original_damage < self.min_damage then return end
if self.parent:HasModifier("modifier_item_angels_demise_custom") then return end

local index = params.original_damage > 150 and 5128 or 5129
if not RollPseudoRandomPercentage(self.crit_chance, index, self.parent) then return end

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