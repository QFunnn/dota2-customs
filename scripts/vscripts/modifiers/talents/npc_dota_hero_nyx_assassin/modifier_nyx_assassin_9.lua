--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_nyx_assassin_9=class({})

function modifier_nyx_assassin_9:IsHidden() return true end
function modifier_nyx_assassin_9:IsPurgable() return false end
function modifier_nyx_assassin_9:IsPurgeException() return false end
function modifier_nyx_assassin_9:RemoveOnDeath() return false end

function modifier_nyx_assassin_9:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local nyx_assassin_revenge_custom = self:GetCaster():FindAbilityByName("nyx_assassin_revenge_custom")
    if nyx_assassin_revenge_custom then
        nyx_assassin_revenge_custom:SetLevel(1)
        nyx_assassin_revenge_custom:SetHidden(false)
    end
end

function modifier_nyx_assassin_9:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end