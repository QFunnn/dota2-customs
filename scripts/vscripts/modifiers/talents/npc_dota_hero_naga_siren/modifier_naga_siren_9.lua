--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_naga_siren_9=class({})

function modifier_naga_siren_9:IsHidden() return true end
function modifier_naga_siren_9:IsPurgable() return false end
function modifier_naga_siren_9:IsPurgeException() return false end
function modifier_naga_siren_9:RemoveOnDeath() return false end

function modifier_naga_siren_9:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local naga_siren_harpoon = self:GetParent():FindAbilityByName("naga_siren_harpoon")
    if naga_siren_harpoon then
        naga_siren_harpoon:SetLevel(1)
        naga_siren_harpoon:SetHidden(false)
    end
end

function modifier_naga_siren_9:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end