--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_yasha_and_kaya_custom", "abilities/items/item_yasha_and_kaya_custom", LUA_MODIFIER_MOTION_NONE)

item_yasha_and_kaya_custom = class({})

function item_yasha_and_kaya_custom:GetIntrinsicModifierName() 
return "modifier_item_yasha_and_kaya_custom" 
end


modifier_item_yasha_and_kaya_custom = class(mod_hidden)
function modifier_item_yasha_and_kaya_custom:IsHidden() return true end
function modifier_item_yasha_and_kaya_custom:IsPurgable() return false end
function modifier_item_yasha_and_kaya_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    MODIFIER_PROPERTY_HEALTH_BONUS,
}
end

function modifier_item_yasha_and_kaya_custom:GetModifierBonusStats_Agility()
return self.agi
end

function modifier_item_yasha_and_kaya_custom:GetModifierBonusStats_Intellect()
return self.int
end

function modifier_item_yasha_and_kaya_custom:GetModifierAttackSpeedBonus_Constant()
return self.bonus_attack_speed
end

function modifier_item_yasha_and_kaya_custom:GetModifierMoveSpeedBonus_Percentage() 
if self.parent:HasModifier("modifier_item_yasha") then return end
return self.move_bonus
end

function modifier_item_yasha_and_kaya_custom:GetModifierHealthBonus()
if self.parent:HasModifier("modifier_item_kaya_and_sange_custom") then return end 
return self.health_bonus*self.parent:GetMaxMana()
end

function modifier_item_yasha_and_kaya_custom:GetModifierSpellAmplify_Percentage() 
if self.parent:HasModifier("modifier_item_kaya_and_sange_custom") then return end 
if self.parent:HasModifier("modifier_item_kaya_custom") then return end
return self.spell_damage
end

function modifier_item_yasha_and_kaya_custom:GetModifierMPRegenAmplify_Percentage()
if self.parent:HasModifier("modifier_item_kaya_and_sange_custom") then return end 
if self.parent:HasModifier("modifier_item_kaya_custom") then return end
return self.regen_amp
end

function modifier_item_yasha_and_kaya_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.agi = self.ability:GetSpecialValueFor("bonus_agility")
self.int = self.ability:GetSpecialValueFor("bonus_intellect")
self.spell_damage = self.ability:GetSpecialValueFor("spell_amp")
self.move_bonus = self.ability:GetSpecialValueFor("movement_speed_percent_bonus")
self.regen_amp = self.ability:GetSpecialValueFor("mana_regen_multiplier")
self.bonus_attack_speed = self.ability:GetSpecialValueFor("bonus_attack_speed")
self.magic_damage = self.ability:GetSpecialValueFor("magic_damage")
self.health_bonus = self.ability:GetSpecialValueFor("health_bonus")/100
if not IsServer() then return end
self.damageTable = {attacker = self.parent, damage = self.magic_damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability}
self.parent:AddAttackEvent_out(self, true)
end


function modifier_item_yasha_and_kaya_custom:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

self.damageTable.victim = params.target
DoDamage(self.damageTable)
end
