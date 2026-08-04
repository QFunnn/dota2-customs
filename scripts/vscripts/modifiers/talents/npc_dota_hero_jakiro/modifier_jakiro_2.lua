--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-04 05:43:48 UTC
  ~ auto-generated — do not edit
]]


modifier_jakiro_2 = class({})

function modifier_jakiro_2:IsHidden()
	return true
end
function modifier_jakiro_2:IsPurgable()
	return false
end
function modifier_jakiro_2:IsPurgeException()
	return false
end
function modifier_jakiro_2:RemoveOnDeath()
	return false
end

function modifier_jakiro_2:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	local jakiro_fire_gush = self:GetCaster():FindAbilityByName("jakiro_fire_gush")
	if jakiro_fire_gush then
		jakiro_fire_gush:SetLevel(self:GetStackCount())
	end
	self:GetCaster():SwapAbilities("jakiro_ice_path_custom", "jakiro_fire_gush", false, true)
	local jakiro_ice_path_custom = self:GetParent():FindAbilityByName("jakiro_ice_path_custom")
	if jakiro_ice_path_custom then
		jakiro_ice_path_custom:SetLevel(0)
		self:GetParent():RemoveModifierByName("modifier_jakiro_ice_path_custom_handler")
	end
end

function modifier_jakiro_2:OnRefresh()
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
	local jakiro_fire_gush = self:GetCaster():FindAbilityByName("jakiro_fire_gush")
	if jakiro_fire_gush then
		jakiro_fire_gush:SetHidden(false)
		jakiro_fire_gush:SetLevel(self:GetStackCount())
	end
end