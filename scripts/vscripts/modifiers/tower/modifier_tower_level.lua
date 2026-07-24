--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




modifier_tower_level = class({})


function modifier_tower_level:IsHidden() return true end


function modifier_tower_level:IsPurgable() return false end

function modifier_tower_level:OnCreated(table)
self.dmg = 0
self.cd = false
if not IsServer() then return end

self.parent = self:GetParent()

self.armor = self.parent:GetPhysicalArmorBaseValue()
self:SetStackCount(1)
end


function modifier_tower_level:OnRefresh(table)
if not IsServer() then return end
self:SetStackCount(self:GetStackCount()+1)
self.parent:SetBaseMaxHealth(self.parent:GetBaseMaxHealth()*1.050)
self.parent:SetBaseDamageMin(self.parent:GetBaseDamageMin()*1.115)
self.parent:SetBaseDamageMax(self.parent:GetBaseDamageMax()*1.115)
end
