--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tinker_7=class({})

function modifier_tinker_7:IsHidden() return true end
function modifier_tinker_7:IsPurgable() return false end
function modifier_tinker_7:IsPurgeException() return false end
function modifier_tinker_7:RemoveOnDeath() return false end

function modifier_tinker_7:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local tinker_keen_teleport_custom = self:GetCaster():FindAbilityByName("tinker_keen_teleport_custom")
    if tinker_keen_teleport_custom then
        tinker_keen_teleport_custom:SetHidden(false)
        tinker_keen_teleport_custom:SetLevel(1)
    end
end

function modifier_tinker_7:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local tinker_keen_teleport_custom = self:GetCaster():FindAbilityByName("tinker_keen_teleport_custom")
    if tinker_keen_teleport_custom then
        tinker_keen_teleport_custom:SetLevel(self:GetStackCount())
    end
end