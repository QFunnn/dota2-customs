--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tiny_9=class({})

function modifier_tiny_9:IsHidden() return true end
function modifier_tiny_9:IsPurgable() return false end
function modifier_tiny_9:IsPurgeException() return false end
function modifier_tiny_9:RemoveOnDeath() return false end

function modifier_tiny_9:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local tiny_ring = self:GetCaster():FindAbilityByName("tiny_ring")
    if tiny_ring then
        tiny_ring:SetLevel(1)
        tiny_ring:SetHidden(false)
    end
    local tiny_grow_custom = self:GetCaster():FindAbilityByName("tiny_grow_custom")
    if tiny_grow_custom then
        tiny_grow_custom:SetLevel(0)
        tiny_grow_custom:SetHidden(true)
        self:GetParent():RemoveModifierByName("modifier_tiny_grow_custom")
    end
    self:GetParent():SetOriginalModel("models/heroes/tiny/tiny_01/tiny_01.vmdl")
    self:GetParent():SetModel("models/heroes/tiny/tiny_01/tiny_01.vmdl")
end

function modifier_tiny_9:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end