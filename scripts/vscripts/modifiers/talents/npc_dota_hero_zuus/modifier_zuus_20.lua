--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_zuus_20=class({})

function modifier_zuus_20:IsHidden() return true end
function modifier_zuus_20:IsPurgable() return false end
function modifier_zuus_20:IsPurgeException() return false end
function modifier_zuus_20:RemoveOnDeath() return false end

function modifier_zuus_20:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local zuus_cloud_custom = self:GetParent():FindAbilityByName("zuus_cloud_custom")
    if zuus_cloud_custom then
        zuus_cloud_custom:SetLevel(self:GetStackCount())
        zuus_cloud_custom:SetHidden(false)
    end
end

function modifier_zuus_20:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local zuus_cloud_custom = self:GetParent():FindAbilityByName("zuus_cloud_custom")
    if zuus_cloud_custom then
        zuus_cloud_custom:SetLevel(self:GetStackCount())
        zuus_cloud_custom:SetHidden(false)
    end
end