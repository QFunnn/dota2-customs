--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_terrorblade_3=class({})

function modifier_terrorblade_3:IsHidden() return true end
function modifier_terrorblade_3:IsPurgable() return false end
function modifier_terrorblade_3:IsPurgeException() return false end
function modifier_terrorblade_3:RemoveOnDeath() return false end

function modifier_terrorblade_3:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local terrorblade_conjure_image_custom = self:GetCaster():FindAbilityByName("terrorblade_conjure_image_custom")
	if terrorblade_conjure_image_custom then
		terrorblade_conjure_image_custom:SetActivated(false)
		terrorblade_conjure_image_custom:SetHidden(true)
		terrorblade_conjure_image_custom:SetLevel(0)
	end
end

function modifier_terrorblade_3:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end