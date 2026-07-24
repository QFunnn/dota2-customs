--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_phoenix_14=class({})

function modifier_phoenix_14:IsHidden() return true end
function modifier_phoenix_14:IsPurgable() return false end
function modifier_phoenix_14:IsPurgeException() return false end
function modifier_phoenix_14:RemoveOnDeath() return false end

function modifier_phoenix_14:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetCaster():SwapAbilities("phoenix_supernova_custom", "phoenix_super_supernova_custom", false, true)
    local phoenix_super_supernova_custom = self:GetCaster():FindAbilityByName("phoenix_super_supernova_custom")
    if phoenix_super_supernova_custom then
        phoenix_super_supernova_custom:SetLevel(1)
    end
end

function modifier_phoenix_14:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end