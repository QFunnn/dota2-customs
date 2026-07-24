--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_muerta_18=class({})

function modifier_muerta_18:IsHidden() return true end
function modifier_muerta_18:IsPurgable() return false end
function modifier_muerta_18:IsPurgeException() return false end
function modifier_muerta_18:RemoveOnDeath() return false end

function modifier_muerta_18:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local muerta_spectral_slug = self:GetParent():FindAbilityByName("muerta_spectral_slug")
	if muerta_spectral_slug then
		muerta_spectral_slug:SetLevel(1)
		muerta_spectral_slug:SetHidden(false)
	end
end

function modifier_muerta_18:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end