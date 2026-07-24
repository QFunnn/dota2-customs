--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_idol_of_screeauk_custom", "abilities/items/neutral/item_idol_of_screeauk_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_idol_of_screeauk_custom_bonus", "abilities/items/neutral/item_idol_of_screeauk_custom", LUA_MODIFIER_MOTION_NONE)

item_idol_of_screeauk_custom = class({})

function item_idol_of_screeauk_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items_fx/idol_of_screeauk.vpcf", context )
end

function item_idol_of_screeauk_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_item_idol_of_screeauk_custom"
end

modifier_item_idol_of_screeauk_custom = class(mod_hidden)
function modifier_item_idol_of_screeauk_custom:RemoveOnDeath() return false end
function modifier_item_idol_of_screeauk_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.movespeed = self.ability:GetSpecialValueFor("movespeed")
self.evasion = self.ability:GetSpecialValueFor("evasion")
self.duration = self.ability:GetSpecialValueFor("duration")
self.bonus = self.ability:GetSpecialValueFor("bonus")
self.parent:AddAttackEvent_inc(self, true)
end

function modifier_item_idol_of_screeauk_custom:AttackEvent_inc(params)
if not IsServer() then return end
if self.parent ~= params.target then return end
if not players[params.attacker:GetId()] then return end
if not self.ability:IsFullyCastable() then return end

self.ability:UseResources(false, false, false, true)
self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_idol_of_screeauk_custom_bonus", {duration = self.duration})
end

function modifier_item_idol_of_screeauk_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    MODIFIER_PROPERTY_EVASION_CONSTANT
}
end

function modifier_item_idol_of_screeauk_custom:GetModifierMoveSpeedBonus_Percentage()
return self.movespeed*(self.parent:HasModifier("modifier_item_idol_of_screeauk_custom_bonus") and self.bonus or 1)
end

function modifier_item_idol_of_screeauk_custom:GetModifierEvasion_Constant()
return self.evasion*(self.parent:HasModifier("modifier_item_idol_of_screeauk_custom_bonus") and self.bonus or 1)
end



modifier_item_idol_of_screeauk_custom_bonus = class(mod_visible)
function modifier_item_idol_of_screeauk_custom_bonus:IsPurgable() return true end
function modifier_item_idol_of_screeauk_custom_bonus:OnCreated()
if not IsServer() then return end
self.parent = self:GetParent()
self.parent:EmitSound("idol_of_screeauk")
self.parent:GenericParticle("particles/items_fx/idol_of_screeauk.vpcf", self)
end