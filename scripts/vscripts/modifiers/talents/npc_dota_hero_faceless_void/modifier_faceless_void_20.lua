--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_faceless_void_20=class({})

function modifier_faceless_void_20:IsHidden() return true end
function modifier_faceless_void_20:IsPurgable() return false end
function modifier_faceless_void_20:IsPurgeException() return false end
function modifier_faceless_void_20:RemoveOnDeath() return false end

function modifier_faceless_void_20:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local faceless_void_time_walk_reverse_custom = self:GetCaster():FindAbilityByName("faceless_void_time_walk_reverse_custom")
    if faceless_void_time_walk_reverse_custom then
        faceless_void_time_walk_reverse_custom:SetHidden(false)
        faceless_void_time_walk_reverse_custom:SetLevel(1)
        faceless_void_time_walk_reverse_custom:SetActivated(false)
    end
end

function modifier_faceless_void_20:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end