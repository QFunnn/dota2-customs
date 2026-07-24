--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_spectre_13=class({})

function modifier_spectre_13:IsHidden() return true end
function modifier_spectre_13:IsPurgable() return false end
function modifier_spectre_13:IsPurgeException() return false end
function modifier_spectre_13:RemoveOnDeath() return false end

function modifier_spectre_13:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local spectre_dispersion_custom = self:GetParent():FindAbilityByName("spectre_dispersion_custom")
	if spectre_dispersion_custom then
		spectre_dispersion_custom:SetHidden(true)
		spectre_dispersion_custom:SetLevel(0)
	end
end

function modifier_spectre_13:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end