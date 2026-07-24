--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_naga_siren_4=class({})

function modifier_naga_siren_4:IsHidden() return true end
function modifier_naga_siren_4:IsPurgable() return false end
function modifier_naga_siren_4:IsPurgeException() return false end
function modifier_naga_siren_4:RemoveOnDeath() return false end

function modifier_naga_siren_4:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local naga_siren_reel_in_custom = self:GetParent():FindAbilityByName("naga_siren_reel_in_custom")
    if naga_siren_reel_in_custom then
        naga_siren_reel_in_custom:SetLevel(1)
        naga_siren_reel_in_custom:SetHidden(false)
    end
end

function modifier_naga_siren_4:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end