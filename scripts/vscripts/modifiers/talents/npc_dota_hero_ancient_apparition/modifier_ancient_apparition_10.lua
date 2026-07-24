--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_ancient_apparition_10=class({})

function modifier_ancient_apparition_10:IsHidden() return true end
function modifier_ancient_apparition_10:IsPurgable() return false end
function modifier_ancient_apparition_10:IsPurgeException() return false end
function modifier_ancient_apparition_10:RemoveOnDeath() return false end

function modifier_ancient_apparition_10:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local ancient_apparition_cold_feet_custom = self:GetCaster():FindAbilityByName("ancient_apparition_cold_feet_custom")
    if ancient_apparition_cold_feet_custom then
        ancient_apparition_cold_feet_custom:SetHidden(true)
        ancient_apparition_cold_feet_custom:SetActivated(false)
    end
end

function modifier_ancient_apparition_10:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end