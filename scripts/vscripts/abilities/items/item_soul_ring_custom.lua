--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_soul_ring_custom", "abilities/items/item_soul_ring_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_soul_ring_custom_active", "abilities/items/item_soul_ring_custom", LUA_MODIFIER_MOTION_NONE)

item_soul_ring_custom = class({})


function item_soul_ring_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items2_fx/soul_ring.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf", context )
end

function item_soul_ring_custom:GetIntrinsicModifierName()
return "modifier_item_soul_ring_custom"
end


function item_soul_ring_custom:OnSpellStart()
local caster = self:GetCaster()
caster:EmitSound("DOTA_Item.SoulRing.Activate")
caster:AddNewModifier(caster, self, "modifier_item_soul_ring_custom_active", {duration = self:GetSpecialValueFor("duration")})
end


modifier_item_soul_ring_custom = class({})
function modifier_item_soul_ring_custom:IsHidden() return true end
function modifier_item_soul_ring_custom:IsPurgable() return false end
function modifier_item_soul_ring_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_soul_ring_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
}
end

function modifier_item_soul_ring_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.bonus_strength = self.ability:GetSpecialValueFor("bonus_strength")
self.bonus_armor = self.ability:GetSpecialValueFor("bonus_armor")
end

function modifier_item_soul_ring_custom:GetModifierBonusStats_Strength()
return self.bonus_strength
end

function modifier_item_soul_ring_custom:GetModifierPhysicalArmorBonus()
return self.bonus_armor
end



modifier_item_soul_ring_custom_active = class(mod_visible)
function modifier_item_soul_ring_custom_active:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.heal = self.ability:GetSpecialValueFor("heal")
self.mana_gain = self.ability:GetSpecialValueFor("mana_gain")
if not IsServer() then return end

self.parent:GiveMana(self.mana_gain)

self.pfx = ParticleManager:CreateParticle("particles/items2_fx/soul_ring.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(self.pfx, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.pfx, 1, Vector(self:GetRemainingTime(), 0, 0))
self:AddParticle(self.pfx, false, false, -1, false, true)
end


function modifier_item_soul_ring_custom_active:OnDestroy()
if not IsServer() then return end
if not self.parent:IsAlive() then return end

if self.mana_gain > 0 then
    self.parent:SetMana(math.max(0, self.parent:GetMana() - self.mana_gain))
end

self.parent:GenericHeal(self.heal, self.ability, false, "")
self.parent:GenericParticle("particles/units/heroes/hero_oracle/oracle_false_promise_heal.vpcf")
self.parent:EmitSound("Item.BM_heal")
end

function modifier_item_soul_ring_custom_active:DeclareFunctions()
return
{
    MODIFIER_EVENT_ON_SPENT_MANA 
}
end

function modifier_item_soul_ring_custom_active:OnSpentMana(params)
if not IsServer() then return end
if self.parent ~= params.unit then return end
if not params.cost then return end
if self.mana_gain <= 0 then return end

self.mana_gain = self.mana_gain - params.cost
end
