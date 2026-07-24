--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_kunkka_5=class({})

function modifier_kunkka_5:IsHidden() return true end
function modifier_kunkka_5:IsPurgable() return false end
function modifier_kunkka_5:IsPurgeException() return false end
function modifier_kunkka_5:RemoveOnDeath() return false end

function modifier_kunkka_5:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local kunkka_torrent_storm_custom = self:GetParent():FindAbilityByName("kunkka_torrent_storm_custom")
	if kunkka_torrent_storm_custom then
		kunkka_torrent_storm_custom:SetHidden(false)
		kunkka_torrent_storm_custom:SetLevel(1)
	end
end

function modifier_kunkka_5:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end