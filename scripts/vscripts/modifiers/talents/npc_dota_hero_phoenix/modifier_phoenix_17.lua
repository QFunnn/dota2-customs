--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_phoenix_17=class({})

function modifier_phoenix_17:IsHidden() return true end
function modifier_phoenix_17:IsPurgable() return false end
function modifier_phoenix_17:IsPurgeException() return false end
function modifier_phoenix_17:RemoveOnDeath() return false end

function modifier_phoenix_17:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local phoenix_freezing_storm = self:GetCaster():FindAbilityByName("phoenix_freezing_storm")
    if phoenix_freezing_storm then
        phoenix_freezing_storm:SetLevel(self:GetStackCount())
    end
    self:GetCaster():SwapAbilities("phoenix_fire_spirits_custom", "phoenix_freezing_storm", false, true)
end

function modifier_phoenix_17:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local phoenix_freezing_storm = self:GetCaster():FindAbilityByName("phoenix_freezing_storm")
    if phoenix_freezing_storm then
        phoenix_freezing_storm:SetLevel(self:GetStackCount())
    end
end