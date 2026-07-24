--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_nyx_assassin_7=class({})

function modifier_nyx_assassin_7:IsHidden() return true end
function modifier_nyx_assassin_7:IsPurgable() return false end
function modifier_nyx_assassin_7:IsPurgeException() return false end
function modifier_nyx_assassin_7:RemoveOnDeath() return false end

function modifier_nyx_assassin_7:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local nyx_assassin_burrow_custom = self:GetCaster():FindAbilityByName("nyx_assassin_burrow_custom")
    if nyx_assassin_burrow_custom then
        nyx_assassin_burrow_custom:SetLevel(1)
        nyx_assassin_burrow_custom:SetHidden(false)
    end
end

function modifier_nyx_assassin_7:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local nyx_assassin_burrow_custom = self:GetCaster():FindAbilityByName("nyx_assassin_burrow_custom")
    if nyx_assassin_burrow_custom then
        nyx_assassin_burrow_custom:SetLevel(1)
        nyx_assassin_burrow_custom:SetHidden(false)
    end
end