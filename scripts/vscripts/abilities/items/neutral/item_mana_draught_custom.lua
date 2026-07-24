--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_mana_draught_custom", "abilities/items/neutral/item_mana_draught_custom", LUA_MODIFIER_MOTION_NONE)

item_mana_draught_custom = class({})

function item_mana_draught_custom:OnSpellStart()
local caster = self:GetCaster()
caster:EmitSound("Item.Draught_active")
caster:AddNewModifier(caster, self, "modifier_item_mana_draught_custom", {duration = self:GetSpecialValueFor("duration")})
end


modifier_item_mana_draught_custom = class({})
function modifier_item_mana_draught_custom:IsHidden() return false end
function modifier_item_mana_draught_custom:IsPurgable() return true end
function modifier_item_mana_draught_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.mana = self.ability:GetSpecialValueFor("mana")
self.health = self.ability:GetSpecialValueFor("health")

if not IsServer() then return end
self.parent:GenericParticle("particles/items_fx/mana_draught.vpcf", self)
end


function modifier_item_mana_draught_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
    MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
}
end

function modifier_item_mana_draught_custom:GetModifierConstantHealthRegen()
return self.mana
end

function modifier_item_mana_draught_custom:GetModifierConstantManaRegen()
return self.health
end