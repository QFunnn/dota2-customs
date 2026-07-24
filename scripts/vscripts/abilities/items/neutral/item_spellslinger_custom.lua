--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_spellslinger_custom", "abilities/items/neutral/item_spellslinger_custom", LUA_MODIFIER_MOTION_NONE)

item_spellslinger_custom = class({})

function item_spellslinger_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_item_spellslinger_custom"
end

function item_spellslinger_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/items8_fx/foragers_kit_buff_mana.vpcf", context )

end

modifier_item_spellslinger_custom = class(mod_hidden)
function modifier_item_spellslinger_custom:RemoveOnDeath() return false end
function modifier_item_spellslinger_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.health = self.ability:GetSpecialValueFor("health")/100
self.chance = self.ability:GetSpecialValueFor("chance")
self.mana = self.ability:GetSpecialValueFor("mana")/100
if not self.parent:IsRealHero() then return end
self.parent:AddSpellEvent(self, true)
end

function modifier_item_spellslinger_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_HEALTH_BONUS
}
end

function modifier_item_spellslinger_custom:GetModifierHealthBonus()
return self.health*self.parent:GetMaxMana()
end

function modifier_item_spellslinger_custom:SpellEvent(params)
if not IsServer() then return end
if not self.ability:IsFullyCastable() then return end
if self.parent ~= params.unit then return end
if params.ability:IsItem() then return end

local heal = self.parent:GetMaxMana()*self.mana
self.parent:GiveMana(heal)
self.parent:GenericHeal(heal, self.ability, true, "")
self.parent:SendNumber(OVERHEAD_ALERT_MANA_ADD, heal)
self.parent:GenericParticle("particles/items8_fx/foragers_kit_buff_mana.vpcf")

self.ability:UseResources(false, false, false, true)
end