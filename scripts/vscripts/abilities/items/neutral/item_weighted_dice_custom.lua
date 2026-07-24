--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_weighted_dice_custom", "abilities/items/neutral/item_weighted_dice_custom", LUA_MODIFIER_MOTION_NONE)

item_weighted_dice_custom = class({})

function item_weighted_dice_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_item_weighted_dice_custom"
end


modifier_item_weighted_dice_custom = class(mod_hidden)
function modifier_item_weighted_dice_custom:RemoveOnDeath() return false end
function modifier_item_weighted_dice_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.chance = self.ability:GetSpecialValueFor("chance")
self.damage = self.ability:GetSpecialValueFor("damage")
self.gold = self.ability:GetSpecialValueFor("gold")

self.parent:AddDeathEvent(self, true)
end

function modifier_item_weighted_dice_custom:DeathEvent(params)
if not IsServer() then return end
if not params.unit:IsCreep() then return end
if params.unit:GetTeamNumber() ~= DOTA_TEAM_NEUTRALS then return end
if self.parent ~= players[params.attacker:GetId()] then return end
if not RollPseudoRandomPercentage(self.chance, 5234, self.parent) then return end

self.parent:GiveGold(self.gold)
end

function modifier_item_weighted_dice_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL
}
end

function modifier_item_weighted_dice_custom:GetModifierProcAttack_BonusDamage_Magical(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end
if not RollPseudoRandomPercentage(self.chance, 5233, self.parent) then return end

params.target:SendNumber(4, self.damage)
return self.damage
end