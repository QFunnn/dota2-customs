--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_terrorblade_2=class({})

function modifier_terrorblade_2:IsHidden() return true end
function modifier_terrorblade_2:IsPurgable() return false end
function modifier_terrorblade_2:IsPurgeException() return false end
function modifier_terrorblade_2:RemoveOnDeath() return false end

function modifier_terrorblade_2:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local terrorblade_demon_zeal_custom = self:GetCaster():FindAbilityByName("terrorblade_demon_zeal_custom")
	if terrorblade_demon_zeal_custom then
		terrorblade_demon_zeal_custom:SetLevel(1)
		terrorblade_demon_zeal_custom:SetHidden(false)
	end
end

function modifier_terrorblade_2:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end