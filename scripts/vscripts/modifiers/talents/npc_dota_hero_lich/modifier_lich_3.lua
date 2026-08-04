--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-04 05:43:48 UTC
  ~ auto-generated — do not edit
]]


modifier_lich_3 = class({})

function modifier_lich_3:IsHidden()
	return true
end
function modifier_lich_3:IsPurgable()
	return false
end
function modifier_lich_3:IsPurgeException()
	return false
end
function modifier_lich_3:RemoveOnDeath()
	return false
end

function modifier_lich_3:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	local lich_ice_spire_custom = self:GetCaster():FindAbilityByName("lich_ice_spire_custom")
	if lich_ice_spire_custom then
		lich_ice_spire_custom:SetLevel(1)
		lich_ice_spire_custom:SetHidden(false)
	end
end

function modifier_lich_3:OnRefresh()
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
	local lich_ice_spire_custom = self:GetCaster():FindAbilityByName("lich_ice_spire_custom")
	if lich_ice_spire_custom then
		lich_ice_spire_custom:SetLevel(1)
		lich_ice_spire_custom:SetHidden(false)
	end
end