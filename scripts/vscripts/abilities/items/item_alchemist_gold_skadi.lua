--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_alchemist_gold_skadi", "abilities/items/item_alchemist_gold_skadi", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_skadi_debuff", "abilities/items/item_alchemist_gold_skadi", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_skadi_debuff_active", "abilities/items/item_alchemist_gold_skadi", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_skadi_buff", "abilities/items/item_alchemist_gold_skadi", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_skadi_stun", "abilities/items/item_alchemist_gold_skadi", LUA_MODIFIER_MOTION_NONE)

item_alchemist_gold_skadi = class({})

function item_alchemist_gold_skadi:GetIntrinsicModifierName()
	return "modifier_item_alchemist_gold_skadi"
end

function item_alchemist_gold_skadi:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/generic_gameplay/generic_manaburn.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_frost_lich.vpcf", context )
PrecacheResource( "particle","particles/items_fx/diffusal_slow.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_drow/drow_hypothermia_counter_stack.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf", context )
end

function item_alchemist_gold_skadi:OnSpellStart()
local caster = self:GetCaster()
local duration = self:GetSpecialValueFor("purge_slow_duration")
local target = self:GetCursorTarget()

target:GenericParticle("particles/generic_gameplay/generic_manaburn.vpcf")
caster:EmitSound("Item.Disperser.Cast")

local target_mod = caster:GetTeamNumber() == target:GetTeamNumber() and "modifier_item_alchemist_gold_skadi_buff" or "modifier_item_alchemist_gold_skadi_debuff_active"

target:AddNewModifier(caster, self, target_mod, {duration = duration})
if caster ~= target then
	caster:AddNewModifier(caster, self, "modifier_item_alchemist_gold_skadi_buff", {duration = duration})
end

end

modifier_item_alchemist_gold_skadi_buff = class({})
function modifier_item_alchemist_gold_skadi_buff:IsHidden() return false end
function modifier_item_alchemist_gold_skadi_buff:IsPurgable() return true end
function modifier_item_alchemist_gold_skadi_buff:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.self_speed = self.ability:GetSpecialValueFor("self_speed")

if not IsServer() then return end
self.parent:Purge(false, true, false, false, false)
self.parent:EmitSound("Item.Disperser.Target.Ally")
self.parent:GenericParticle("particles/items_fx/disperser_buff.vpcf", self)
self.parent:GenericParticle("particles/items_fx/disperser_buff_feet.vpcf", self)
end

function modifier_item_alchemist_gold_skadi_buff:CheckState()
return
{
	[MODIFIER_STATE_UNSLOWABLE] = true
}
end

function modifier_item_alchemist_gold_skadi_buff:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_item_alchemist_gold_skadi_buff:GetModifierMoveSpeedBonus_Percentage()
return self.self_speed
end



modifier_item_alchemist_gold_skadi_debuff_active = class({})
function modifier_item_alchemist_gold_skadi_debuff_active:IsHidden() return false end
function modifier_item_alchemist_gold_skadi_debuff_active:IsPurgable() return true end
function modifier_item_alchemist_gold_skadi_debuff_active:GetEffectName() return "particles/items_fx/diffusal_slow.vpcf" end
function modifier_item_alchemist_gold_skadi_debuff_active:OnCreated(table)

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.purge_slow = self.ability:GetSpecialValueFor("purge_slow")
self.max = self.ability:GetSpecialValueFor("root_hits")
self.stun_duration = self.ability:GetSpecialValueFor("stun_duration")

if not IsServer() then return end
self.parent:Purge(true, false, false, false, false)
self.parent:GenericParticle("particles/items_fx/disperser_buff_feet.vpcf", self)
self.parent:EmitSound("Item.Disperser.Target.Enemy")
end


function modifier_item_alchemist_gold_skadi_debuff_active:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_item_alchemist_gold_skadi_debuff_active:GetModifierMoveSpeedBonus_Percentage()
 return self.purge_slow
end

function modifier_item_alchemist_gold_skadi_debuff_active:OnStackCountChanged(iStackCount)
if not IsServer() then return end

if not self.effect_cast then
	self.effect_cast = self.parent:GenericParticle("particles/units/heroes/hero_drow/drow_hypothermia_counter_stack.vpcf", self, true)
end

ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )
end


function modifier_item_alchemist_gold_skadi_debuff_active:AddStack(params)
if not IsServer() then return end
self:IncrementStackCount()

if self.proced then return end
if self:GetStackCount() < self.max then return end

self.proced = true
self:SetStackCount(0)

if self.effect_cast then
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
end

self.parent:EmitSound("Hero_Crystal.frostbite")
self.parent:AddNewModifier(self.caster, self.ability, "modifier_item_alchemist_gold_skadi_stun", {duration = self.stun_duration*(1 - self.parent:GetStatusResistance())})
end



modifier_item_alchemist_gold_skadi	= class(mod_hidden)
function modifier_item_alchemist_gold_skadi:RemoveOnDeath()	return false end

function modifier_item_alchemist_gold_skadi:OnCreated()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.bonus_strength = self.ability:GetSpecialValueFor("bonus_strength")
self.bonus_agility = self.ability:GetSpecialValueFor("bonus_agility")
self.bonus_intellect =  self.ability:GetSpecialValueFor("bonus_intellect")
self.cold_duration = self.ability:GetSpecialValueFor("cold_duration")

self.mana_burn = self.ability:GetSpecialValueFor("feedback_mana_burn")
self.mana_burn_illusion = self.ability:GetSpecialValueFor("feedback_mana_burn_illusion_melee")
end

function modifier_item_alchemist_gold_skadi:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL
}
end

function modifier_item_alchemist_gold_skadi:GetModifierBonusStats_Strength()
return self.bonus_strength
end

function modifier_item_alchemist_gold_skadi:GetModifierBonusStats_Agility()
return self.bonus_agility
end

function modifier_item_alchemist_gold_skadi:GetModifierBonusStats_Intellect()
return self.bonus_intellect
end

function modifier_item_alchemist_gold_skadi:GetModifierProcAttack_BonusDamage_Physical(params)
if not IsServer() then return end
if params.attacker:FindAllModifiersByName(self:GetName())[1] ~= self then return end 
if not params.target:IsUnit() then return end
if params.attacker ~= self.parent then return end
if self.parent:HasModifier("modifier_item_skadi_custom") or self.parent:HasModifier("modifier_item_disperser") or self.parent:HasModifier("modifier_item_diffusal_blade") then return end

local target = params.target
local mana = self.mana_burn_illusion


if self.parent:IsRealHero() then
	mana = self.mana_burn
	target:AddNewModifier(self.parent, self.ability, "modifier_item_alchemist_gold_skadi_debuff", {duration = self.cold_duration})

	local mod = target:FindModifierByName("modifier_item_alchemist_gold_skadi_debuff_active")
	if mod then
		mod:AddStack()
	end
end


mana = math.min(target:GetMana(), mana)
target:GenericParticle("particles/generic_gameplay/generic_manaburn.vpcf")

params.target:Script_ReduceMana(mana, self.ability)
return mana
end





modifier_item_alchemist_gold_skadi_debuff = class({})
function modifier_item_alchemist_gold_skadi_debuff:IsPurgable() return true end
function modifier_item_alchemist_gold_skadi_debuff:OnCreated()
self.ability = self:GetAbility()
self.attack_slow = self.ability:GetSpecialValueFor("attack_slow")
self.move_slow = self.ability:GetSpecialValueFor("cold_slow_ranged")
self.heal_reduction = self.ability:GetSpecialValueFor("heal_reduction")
end

function modifier_item_alchemist_gold_skadi_debuff:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	--MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
	MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	--MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end

function modifier_item_alchemist_gold_skadi_debuff:GetModifierMoveSpeedBonus_Percentage()
return self.move_slow
end

function modifier_item_alchemist_gold_skadi_debuff:GetModifierAttackSpeedBonus_Constant()
return self.attack_slow
end

function modifier_item_alchemist_gold_skadi_debuff:GetModifierLifestealRegenAmplify_Percentage()
return self.heal_reduction
end

function modifier_item_alchemist_gold_skadi_debuff:GetModifierHealChange()
return self.heal_reduction
end

function modifier_item_alchemist_gold_skadi_debuff:GetModifierHPRegenAmplify_Percentage()
return self.heal_reduction
end

function modifier_item_alchemist_gold_skadi_debuff:GetStatusEffectName()
return "particles/status_fx/status_effect_frost_lich.vpcf"
end

function modifier_item_alchemist_gold_skadi_debuff:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL 
end





modifier_item_alchemist_gold_skadi_stun = class({})
function modifier_item_alchemist_gold_skadi_stun:IsHidden() return true end
function modifier_item_alchemist_gold_skadi_stun:IsPurgable() return false end
function modifier_item_alchemist_gold_skadi_stun:IsStunDebuff() return true end
function modifier_item_alchemist_gold_skadi_stun:IsPurgeException() return true end


function modifier_item_alchemist_gold_skadi_stun:GetStatusEffectName()
return "particles/status_fx/status_effect_frost.vpcf"
end

function modifier_item_alchemist_gold_skadi_stun:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL 
end


function modifier_item_alchemist_gold_skadi_stun:CheckState()
return
{
    [MODIFIER_STATE_FROZEN] = true,
    [MODIFIER_STATE_STUNNED] = true
}
end