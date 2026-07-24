--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_alchemist_gold_satanic", "abilities/items/item_alchemist_gold_satanic", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_alchemist_gold_satanic_active", "abilities/items/item_alchemist_gold_satanic", LUA_MODIFIER_MOTION_NONE)

item_alchemist_gold_satanic = class({})

function item_alchemist_gold_satanic:GetIntrinsicModifierName()
return "modifier_item_alchemist_gold_satanic"
end

function item_alchemist_gold_satanic:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/bristle_cdr.vpcf", context )
end

function item_alchemist_gold_satanic:OnSpellStart()
local caster = self:GetCaster()
local duration = self:GetSpecialValueFor("duration")

caster:EmitSound("DOTA_Item.BlackKingBar.Activate")
caster:EmitSound("DOTA_Item.Satanic.Activate")

caster:Purge(false, true, false, true, true)
caster:AddNewModifier(caster, self, "modifier_item_alchemist_gold_satanic_active", {duration = duration})
end


modifier_item_alchemist_gold_satanic = class(mod_hidden)
function modifier_item_alchemist_gold_satanic:RemoveOnDeath()	return false end
function modifier_item_alchemist_gold_satanic:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.bonus_str = self.ability:GetSpecialValueFor("bonus_strength")
self.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")
self.lifesteal = self.ability:GetSpecialValueFor("lifesteal")/100
self.creeps = self.ability:GetSpecialValueFor("creeps")
self.active_lifesteal = self.ability:GetSpecialValueFor("lifesteal_active")/100

if not IsServer() then return end
if not self.parent:IsRealHero() then return end
self.parent:AddDamageEvent_out(self, true)
end

function modifier_item_alchemist_gold_satanic:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
}
end


function modifier_item_alchemist_gold_satanic:GetModifierPreAttack_BonusDamage()
return self.bonus_damage
end

function modifier_item_alchemist_gold_satanic:GetModifierBonusStats_Strength()
return self.bonus_str
end

function modifier_item_alchemist_gold_satanic:DamageEvent_out(params)
if not IsServer() then return end
if not self.parent:CheckLifesteal(params, 2) then return end

local heal = self.parent:HasModifier("modifier_item_alchemist_gold_satanic_active") and params.damage*self.active_lifesteal or params.damage*self.lifesteal
heal = params.unit:IsCreep() and heal/self.creeps or heal

self.parent:GenericHeal(heal, self.ability, not self.parent:HasModifier("modifier_item_alchemist_gold_satanic_active"))
end



modifier_item_alchemist_gold_satanic_active = class(mod_visible)
function modifier_item_alchemist_gold_satanic_active:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.bonus_damage = (1 - self.parent:GetHealthPercent()/100)*self.ability:GetSpecialValueFor("active_damage")
self:SetStackCount(self.bonus_damage)

if not IsServer() then return end
self.parent:GenericParticle("particles/items2_fx/mask_of_madness.vpcf", self)
self.parent:AddNewModifier(self.parent, self.ability, "modifier_generic_debuff_immune", {duration = self:GetRemainingTime(), effect = 1})
end

function modifier_item_alchemist_gold_satanic_active:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	MODIFIER_PROPERTY_MODEL_SCALE
}
end

function modifier_item_alchemist_gold_satanic_active:GetModifierPreAttack_BonusDamage()
return self.bonus_damage
end

function modifier_item_alchemist_gold_satanic_active:GetModifierModelScale()
return 20
end