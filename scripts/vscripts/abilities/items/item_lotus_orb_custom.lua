--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_lotus_orb_custom", "abilities/items/item_lotus_orb_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_lotus_orb_custom_reflect", "abilities/items/item_lotus_orb_custom", LUA_MODIFIER_MOTION_NONE)

item_lotus_orb_custom = class({})

function item_lotus_orb_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items3_fx/lotus_orb_shield.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/lotus_orb_reflect.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_vengeful/vengeful_magic_missle_end.vpcf", context )
end

function item_lotus_orb_custom:GetIntrinsicModifierName()
return "modifier_item_lotus_orb_custom"
end

function item_lotus_orb_custom:Spawn()
self.bonus_armor = self:GetSpecialValueFor("bonus_armor")
self.bonus_stats = self:GetSpecialValueFor("bonus_stats")
self.bonus_health = self:GetSpecialValueFor("bonus_health")
self.bonus_mana = self:GetSpecialValueFor("bonus_mana")
self.active_duration = self:GetSpecialValueFor("active_duration")
self.damage_base = self:GetSpecialValueFor("damage_base")
self.damage_stats = self:GetSpecialValueFor("damage_stats")/100
self.stun = self:GetSpecialValueFor("stun")
self.attack_reduce = self:GetSpecialValueFor("attack_reduce")
self.attack_cd = self:GetSpecialValueFor("attack_cd")
end

function item_lotus_orb_custom:OnSpellStart()
local caster = self:GetCaster()
caster:Purge(false, true, false, false, false)
caster:EmitSound("Item.LotusOrb.Target")
caster:AddNewModifier(caster, self, "modifier_item_lotus_orb_custom_reflect", {duration = self.active_duration})
end

modifier_item_lotus_orb_custom = class(mod_hidden)
function modifier_item_lotus_orb_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
end

function modifier_item_lotus_orb_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    MODIFIER_PROPERTY_HEALTH_BONUS,
    MODIFIER_PROPERTY_MANA_BONUS,
    MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
}
end

function modifier_item_lotus_orb_custom:GetModifierBonusStats_Intellect()
return self.ability.bonus_stats
end

function modifier_item_lotus_orb_custom:GetModifierBonusStats_Agility()
return self.ability.bonus_stats
end

function modifier_item_lotus_orb_custom:GetModifierBonusStats_Strength()
return self.ability.bonus_stats
end

function modifier_item_lotus_orb_custom:GetModifierPhysicalArmorBonus()
return self.ability.bonus_armor
end

function modifier_item_lotus_orb_custom:GetModifierHealthBonus()
return self.ability.bonus_health
end

function modifier_item_lotus_orb_custom:GetModifierManaBonus()
return self.ability.bonus_mana
end


modifier_item_lotus_orb_custom_reflect = class(mod_visible)
function modifier_item_lotus_orb_custom_reflect:IsPurgable() return true end
function modifier_item_lotus_orb_custom_reflect:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.cd = self.ability.attack_cd
self.base = self.ability.damage_base
self.damage_pct = self.ability.damage_stats
self.stun = self.ability.stun
self.attack_reduce = self.ability.attack_reduce

if not IsServer() then return end
self.damageTable = {attacker = self.parent, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}

self.effect_cast = ParticleManager:CreateParticle("particles/items3_fx/lotus_orb_shield.vpcf", PATTACH_POINT_FOLLOW, self.parent )
ParticleManager:SetParticleControlEnt( self.effect_cast, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
self:AddParticle( self.effect_cast, false, false, -1, false, false )

self.parent:AddSpellEvent(self, true)
self.parent:AddAttackEvent_inc(self, true)
end

function modifier_item_lotus_orb_custom_reflect:DealDamage(target, is_attack)
if not IsServer() then return end

local k = is_attack and self.attack_reduce or 1
self.damageTable.damage = (self.base + self.parent:GetAllStats()*self.damage_pct)/k
self.damageTable.victim = target

local particle = ParticleManager:CreateParticle("particles/items3_fx/lotus_orb_reflect.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(particle)

local particle2 = ParticleManager:CreateParticle("particles/units/heroes/hero_vengeful/vengeful_magic_missle_end.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, target)
ParticleManager:SetParticleControlEnt(particle2, 3, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(particle2)

local effect = ParticleManager:CreateParticle("particles/items_fx/generic_item_spell_caster.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(effect, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(effect, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
ParticleManager:SetParticleControl(effect, 2, Vector(3, 0, 0))
ParticleManager:ReleaseParticleIndex(effect)

DoDamage(self.damageTable)
target:AddNewModifier(self.caster, self.ability, "modifier_stunned", {duration = (1 - target:GetStatusResistance())*self.stun/k})
self.parent:EmitSound("Item.LotusOrb.Activate")
end

function modifier_item_lotus_orb_custom_reflect:SpellEvent(params)
if not IsServer() then return end
if not params.target or params.target ~= self.parent then return end

local attacker = params.unit
if attacker:GetTeamNumber() == self.parent:GetTeamNumber() then return end

self:DealDamage(attacker)
end

function modifier_item_lotus_orb_custom_reflect:AttackEvent_inc(params)
if not IsServer() then return end
if params.target ~= self.parent then return end

local attacker = params.attacker
if not attacker:IsUnit() then return end
if attacker:GetTeamNumber() == self.parent:GetTeamNumber() then return end
if not attacker:CheckCd("lotus_attack", self.cd) then return end

self:DealDamage(attacker, true)
end

function modifier_item_lotus_orb_custom_reflect:OnDestroy()
if not IsServer() then return end
self.parent:EmitSound("Item.LotusOrb.Destroy")
end
