--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_revenants_brooch_custom", "abilities/items/item_revenants_brooch_custom", LUA_MODIFIER_MOTION_NONE)

item_revenants_brooch_custom = class({})

function item_revenants_brooch_custom:GetIntrinsicModifierName()
return "modifier_item_revenants_brooch_custom"
end

function item_revenants_brooch_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items_fx/revenant_brooch_projectile.vpcf", context )
end

function item_revenants_brooch_custom:GetCooldown()
return (self.cooldown and self.cooldown or 0)/self:GetCaster():GetCooldownReduction()
end


modifier_item_revenants_brooch_custom	= class(mod_hidden)
function modifier_item_revenants_brooch_custom:RemoveOnDeath() return false end
function modifier_item_revenants_brooch_custom:OnCreated()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")
self.crit_chance = self.ability:GetSpecialValueFor("crit_chance")
self.bonus_health = self.ability:GetSpecialValueFor("bonus_health")
self.crit_damage = self.ability:GetSpecialValueFor("crit_damage")/100
self.spell_lifesteal = self.ability:GetSpecialValueFor("spell_lifesteal")/100   
self.ability.cooldown = self.ability:GetSpecialValueFor("AbilityCooldown")

if not IsServer() then return end
self.damageTable = {attacker = self.parent, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}
self.parent:AddDamageEvent_out(self, true)
self.parent:AddAttackEvent_out(self, true)
end

function modifier_item_revenants_brooch_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	MODIFIER_PROPERTY_HEALTH_BONUS
}
end

function modifier_item_revenants_brooch_custom:GetModifierPreAttack_BonusDamage()
return self.bonus_damage
end

function modifier_item_revenants_brooch_custom:GetModifierHealthBonus()
return self.bonus_health
end

function modifier_item_revenants_brooch_custom:AttackEvent_out(params)
if not IsServer() then return end
if self.parent:HasModifier("modifier_item_hydras_breath_custom") then return end
if params.attacker ~= self.parent then return end
local target = params.target

if not target:IsUnit() then return end
if not target:CheckCd("revenant_brooch", self.ability.cooldown, self.crit_chance, 9402) then return end

self.damageTable.victim = target
self.damageTable.damage = self.parent:GetAverageTrueAttackDamage(nil)*self.crit_damage
local real_damage = DoDamage(self.damageTable)
target:SendNumber(4, real_damage)

local mainParticle = ParticleManager:CreateParticle("particles/items_fx/revenant_brooch_projectile_explosion.vpcf", PATTACH_POINT_FOLLOW, target)
ParticleManager:SetParticleControlEnt(mainParticle, 3, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(mainParticle)

target:EmitSound("Item.Brooch.Attack")
end

function modifier_item_revenants_brooch_custom:DamageEvent_out(params)
if not IsServer() then return end
local result = self.parent:CheckLifesteal(params, 1)
if not result then return end

local heal = params.damage*self.spell_lifesteal*result
self.parent:GenericHeal(heal, self.ability, true, "particles/items3_fx/octarine_core_lifesteal.vpcf")
end