--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_necrolyte_7=class({})

function modifier_necrolyte_7:IsHidden() return true end
function modifier_necrolyte_7:IsPurgable() return false end
function modifier_necrolyte_7:IsPurgeException() return false end
function modifier_necrolyte_7:RemoveOnDeath() return false end

function modifier_necrolyte_7:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
    local necrolyte_reapers_scythe_custom = self:GetParent():FindAbilityByName("necrolyte_reapers_scythe_custom")
    if necrolyte_reapers_scythe_custom then
        necrolyte_reapers_scythe_custom:SetActivated(false)
        necrolyte_reapers_scythe_custom:SetHidden(true)
    end
end

function modifier_necrolyte_7:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
    local necrolyte_reapers_scythe_custom = self:GetParent():FindAbilityByName("necrolyte_reapers_scythe_custom")
    if necrolyte_reapers_scythe_custom then
        necrolyte_reapers_scythe_custom:SetActivated(false)
        necrolyte_reapers_scythe_custom:SetHidden(true)
    end
end