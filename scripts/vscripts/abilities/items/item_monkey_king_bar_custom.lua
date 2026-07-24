--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_monkey_king_bar_custom", "abilities/items/item_monkey_king_bar_custom", LUA_MODIFIER_MOTION_NONE)

item_monkey_king_bar_custom = class({})

function item_monkey_king_bar_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

end

function item_monkey_king_bar_custom:GetIntrinsicModifierName()
return "modifier_item_monkey_king_bar_custom"
end

modifier_item_monkey_king_bar_custom = class(mod_hidden)
function modifier_item_monkey_king_bar_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
    MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL,
    MODIFIER_PROPERTY_HEALTH_BONUS,
}
end

function modifier_item_monkey_king_bar_custom:GetModifierAttackRangeBonus()
if self.parent:IsRangedAttacker() then return end
return self.ability.melee_attack_range
end

function modifier_item_monkey_king_bar_custom:GetModifierPreAttack_BonusDamage()
return self.ability.bonus_damage
end

function modifier_item_monkey_king_bar_custom:GetModifierAttackSpeedBonus_Constant()
return self.ability.bonus_attack_speed
end

function modifier_item_monkey_king_bar_custom:GetModifierHealthBonus()
return self.ability.bonus_health
end

function modifier_item_monkey_king_bar_custom:CheckState()
return
{
    [MODIFIER_STATE_CANNOT_MISS] = true
}
end

function modifier_item_monkey_king_bar_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.ability.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")
self.ability.bonus_attack_speed = self.ability:GetSpecialValueFor("bonus_attack_speed")
self.ability.bonus_chance = self.ability:GetSpecialValueFor("bonus_chance")
self.ability.bonus_chance_damage = self.ability:GetSpecialValueFor("bonus_chance_damage")
self.ability.bonus_chance_damage_creeps = self.ability:GetSpecialValueFor("bonus_chance_damage_creeps")
self.ability.bonus_chance_damage_health = self.ability:GetSpecialValueFor("bonus_chance_damage_health")/100
self.ability.melee_attack_range = self.ability:GetSpecialValueFor("melee_attack_range")
self.ability.bonus_health = self.ability:GetSpecialValueFor("bonus_health")
end

function modifier_item_monkey_king_bar_custom:GetModifierProcAttack_BonusDamage_Magical(params)
if not IsServer() then return end 
if not params.target:IsUnit() then return end 
if self.parent ~= params.attacker then return end 
if not self.parent:IsRealHero() then return end
if not RollPseudoRandomPercentage(self.ability.bonus_chance, 4259, self.parent) then return end 

local target = params.target

local damage = self.ability.bonus_chance_damage + target:GetMaxHealth()*self.ability.bonus_chance_damage_health
if target:IsCreep() then
    damage = self.ability.bonus_chance_damage_creeps
end

target:EmitSound("DOTA_Item.MKB.melee")
target:SendNumber(4, damage)
return damage
end
