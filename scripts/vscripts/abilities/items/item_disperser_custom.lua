--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_disperser_custom", "abilities/items/item_disperser_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_disperser_custom_debuff_active", "abilities/items/item_disperser_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_disperser_custom_debuff_active_buff", "abilities/items/item_disperser_custom", LUA_MODIFIER_MOTION_NONE)

item_disperser_custom = class({})

function item_disperser_custom:GetIntrinsicModifierName()
return "modifier_item_disperser_custom"
end

function item_disperser_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/generic_gameplay/generic_manaburn.vpcf", context )
PrecacheResource( "particle","particles/items_fx/diffusal_slow.vpcf", context )
end

function item_disperser_custom:Spawn()
self.bonus_agility = self:GetSpecialValueFor("bonus_agility")
self.bonus_intellect = self:GetSpecialValueFor("bonus_intellect")
self.bonus_strength = self:GetSpecialValueFor("bonus_strength")
self.feedback_mana_burn = self:GetSpecialValueFor("feedback_mana_burn")
self.purge_rate = self:GetSpecialValueFor("purge_rate")
self.damage_per_burn = self:GetSpecialValueFor("damage_per_burn")
self.enemy_effect_duration = self:GetSpecialValueFor("enemy_effect_duration")
self.ally_effect_duration = self:GetSpecialValueFor("ally_effect_duration")
self.movement_speed_buff_rate = self:GetSpecialValueFor("movement_speed_buff_rate")
self.purge_slow = self:GetSpecialValueFor("purge_slow")
self.phase_movement_speed = self:GetSpecialValueFor("phase_movement_speed")
self.slow_resist = self:GetSpecialValueFor("slow_resist")
end

function item_disperser_custom:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()

if target:TriggerSpellAbsorb(self) then return end

caster:EmitSound("Item.Disperser.Cast")
caster:RemoveModifierByName("modifier_item_disperser_custom_debuff_active_buff")
caster:AddNewModifier(caster, self, "modifier_item_disperser_custom_debuff_active_buff", {duration = self.ally_effect_duration})

if target == caster then return end

local name = "modifier_item_disperser_custom_debuff_active"
local duration = self.enemy_effect_duration*(1 - target:GetStatusResistance())
if target:GetTeamNumber() == caster:GetTeamNumber() then
	name = "modifier_item_disperser_custom_debuff_active_buff"
	duration = self.ally_effect_duration
end

target:RemoveModifierByName(name)
target:AddNewModifier(caster, self, name, {duration = duration})
end

modifier_item_disperser_custom_debuff_active_buff = class({})
function modifier_item_disperser_custom_debuff_active_buff:IsHidden() return false end
function modifier_item_disperser_custom_debuff_active_buff:IsPurgable() return true end
function modifier_item_disperser_custom_debuff_active_buff:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.move = self.ability.phase_movement_speed
self.interval = self.ability.ally_effect_duration/self.ability.movement_speed_buff_rate
self.slow_resist = self.ability.slow_resist

self:StartIntervalThink(self.interval)
if not IsServer() then return end
self.parent:Purge(false, true, false, false, false)
self.parent:EmitSound("Item.Disperser.Target.Ally")
self.parent:GenericParticle("particles/items_fx/disperser_buff.vpcf", self)
self.parent:GenericParticle("particles/items_fx/disperser_buff_feet.vpcf", self)
end

function modifier_item_disperser_custom_debuff_active_buff:OnIntervalThink()
self.move = self.move - self.ability.phase_movement_speed/self.ability.movement_speed_buff_rate
end

function modifier_item_disperser_custom_debuff_active_buff:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING
}
end

function modifier_item_disperser_custom_debuff_active_buff:GetModifierSlowResistance_Stacking()
return self.slow_resist
end

function modifier_item_disperser_custom_debuff_active_buff:GetModifierMoveSpeedBonus_Percentage()
return self.move
end

modifier_item_disperser_custom_debuff_active = class({})
function modifier_item_disperser_custom_debuff_active:IsHidden() return false end
function modifier_item_disperser_custom_debuff_active:IsPurgable() return true end
function modifier_item_disperser_custom_debuff_active:GetEffectName() return "particles/items_fx/diffusal_slow.vpcf" end
function modifier_item_disperser_custom_debuff_active:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.slow = self.ability.purge_slow
self.interval = self.ability.enemy_effect_duration/self.ability.purge_rate

self:StartIntervalThink(self.interval)
if not IsServer() then return end
self.parent:Purge(true, false, false, false, false)
self.parent:EmitSound("Item.Disperser.Target.Enemy")
end

function modifier_item_disperser_custom_debuff_active:OnIntervalThink()
self.slow = self.slow - self.ability.purge_slow/self.ability.purge_rate
end

function modifier_item_disperser_custom_debuff_active:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_item_disperser_custom_debuff_active:GetModifierMoveSpeedBonus_Percentage()
 return self.slow
end



modifier_item_disperser_custom	= class(mod_hidden)
function modifier_item_disperser_custom:RemoveOnDeath() return false end
function modifier_item_disperser_custom:OnCreated()
self.ability = self:GetAbility()
self.parent = self:GetParent()
end

function modifier_item_disperser_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL
}
end

function modifier_item_disperser_custom:GetModifierBonusStats_Strength()
return self.ability.bonus_strength
end

function modifier_item_disperser_custom:GetModifierBonusStats_Agility()
return self.ability.bonus_agility
end

function modifier_item_disperser_custom:GetModifierBonusStats_Intellect()
return self.ability.bonus_intellect
end

function modifier_item_disperser_custom:GetModifierProcAttack_BonusDamage_Physical(params)
if not IsServer() then return end
if self.parent:IsIllusion() then return end
if not params.target:IsUnit() then return end
if params.attacker ~= self.parent then return end

local target = params.target
local mana = math.min(target:GetMana(), self.ability.feedback_mana_burn)
target:GenericParticle("particles/generic_gameplay/generic_manaburn.vpcf")
local real_mana = target:Script_ReduceMana(mana, self.ability)
return real_mana*self.ability.damage_per_burn
end