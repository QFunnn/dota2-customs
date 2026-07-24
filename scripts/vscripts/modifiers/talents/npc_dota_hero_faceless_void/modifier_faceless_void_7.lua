--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_faceless_void_7=class({})

function modifier_faceless_void_7:IsHidden() return true end
function modifier_faceless_void_7:IsPurgable() return false end
function modifier_faceless_void_7:IsPurgeException() return false end
function modifier_faceless_void_7:RemoveOnDeath() return false end

function modifier_faceless_void_7:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetCaster():SwapAbilities("faceless_void_chronosphere_custom", "faceless_void_time_zone", false, true)
    local faceless_void_time_zone = self:GetCaster():FindAbilityByName("faceless_void_time_zone")
    if faceless_void_time_zone then
        faceless_void_time_zone:SetLevel(1)
    end
    local faceless_void_chronosphere_custom = self:GetCaster():FindAbilityByName("faceless_void_chronosphere_custom")
    if faceless_void_chronosphere_custom then
        faceless_void_chronosphere_custom:SetActivated(false)
    end
end

function modifier_faceless_void_7:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local faceless_void_time_zone = self:GetCaster():FindAbilityByName("faceless_void_time_zone")
    if faceless_void_time_zone then
        faceless_void_time_zone:SetLevel(1)
    end
end