--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_hero_roshan_cheese", "items/item_hero_roshan_cheese", LUA_MODIFIER_MOTION_NONE)

item_hero_roshan_cheese = class({})

function item_hero_roshan_cheese:OnSpellStart()
    if not IsServer() then return end

    self:GetCaster():EmitSound("DOTA_Item.Cheese.Activate")

    local health = self:GetSpecialValueFor("health")
    self:GetCaster():Heal(health, self)

    local mana = self:GetSpecialValueFor("mana")
    self:GetCaster():GiveMana(mana)

    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_hero_roshan_cheese", {})
end

modifier_item_hero_roshan_cheese = class({})
function modifier_item_hero_roshan_cheese:IsPurgable() return false end
function modifier_item_hero_roshan_cheese:RemoveOnDeath() return false end