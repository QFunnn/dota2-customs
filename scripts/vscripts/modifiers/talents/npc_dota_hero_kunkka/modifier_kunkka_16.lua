--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_kunkka_16=class({})

function modifier_kunkka_16:IsHidden() return true end
function modifier_kunkka_16:IsPurgable() return false end
function modifier_kunkka_16:IsPurgeException() return false end
function modifier_kunkka_16:RemoveOnDeath() return false end

function modifier_kunkka_16:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local kunkka_tidal_wave_custom = self:GetCaster():FindAbilityByName("kunkka_tidal_wave_custom")
	if kunkka_tidal_wave_custom then
		kunkka_tidal_wave_custom:SetLevel(self:GetStackCount())
		kunkka_tidal_wave_custom:SetHidden(false)
	end
end

function modifier_kunkka_16:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	local kunkka_tidal_wave_custom = self:GetCaster():FindAbilityByName("kunkka_tidal_wave_custom")
	if kunkka_tidal_wave_custom then
		kunkka_tidal_wave_custom:SetLevel(self:GetStackCount())
		kunkka_tidal_wave_custom:SetHidden(false)
	end
end