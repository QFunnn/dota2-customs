--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_satanic_custom", "abilities/items/item_satanic_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_satanic_custom_active", "abilities/items/item_satanic_custom", LUA_MODIFIER_MOTION_NONE)

item_satanic_custom = class({})

function item_satanic_custom:GetIntrinsicModifierName()
return "modifier_item_satanic_custom"
end

function item_satanic_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items2_fx/satanic_buff.vpcf", context )

end

function item_satanic_custom:OnSpellStart()
local caster = self:GetCaster()
caster:EmitSound("DOTA_Item.Satanic.Activate")

caster:Purge(false, true, false, false, false)
caster:AddNewModifier(caster, self, "modifier_item_satanic_custom_active", {duration = self.unholy_duration})
end


modifier_item_satanic_custom = class(mod_hidden)
function modifier_item_satanic_custom:RemoveOnDeath()	return false end
function modifier_item_satanic_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.ability.bonus_strength = self.ability:GetSpecialValueFor("bonus_strength") 
self.ability.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage") 
self.ability.bonus_health = self.ability:GetSpecialValueFor("bonus_health") 
self.ability.lifesteal_percent = self.ability:GetSpecialValueFor("lifesteal_percent")/100
self.ability.unholy_lifesteal_total_tooltip = self.ability:GetSpecialValueFor("unholy_lifesteal_total_tooltip")/100
self.ability.unholy_duration = self.ability:GetSpecialValueFor("unholy_duration") 

if not IsServer() then return end
if not self.parent:IsRealHero() then return end
self.parent:AddDamageEvent_out(self, true)
end

function modifier_item_satanic_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_HEALTH_BONUS
}
end

function modifier_item_satanic_custom:GetModifierHealthBonus()
return self.ability.bonus_health
end

function modifier_item_satanic_custom:GetModifierPreAttack_BonusDamage()
return self.ability.bonus_damage
end

function modifier_item_satanic_custom:GetModifierBonusStats_Strength()
return self.ability.bonus_strength
end

function modifier_item_satanic_custom:DamageEvent_out(params)
if not IsServer() then return end
local result = self.parent:CheckLifesteal(params, 2)
if not result then return end

local heal = self.parent:HasModifier("modifier_item_satanic_custom_active") and self.ability.unholy_lifesteal_total_tooltip or self.ability.lifesteal_percent
self.parent:GenericHeal(result*heal*params.damage, self.ability, not self.parent:HasModifier("modifier_item_satanic_custom_active"))
end


modifier_item_satanic_custom_active = class(mod_visible)
function modifier_item_satanic_custom_active:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

if not IsServer() then return end
self.parent:GenericParticle("particles/items2_fx/satanic_buff.vpcf", self)
end

	