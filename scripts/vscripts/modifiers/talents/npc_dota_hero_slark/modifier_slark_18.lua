--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-04 05:43:48 UTC
  ~ auto-generated — do not edit
]]


modifier_slark_18 = class({})

function modifier_slark_18:IsHidden()
	return true
end
function modifier_slark_18:IsPurgable()
	return false
end
function modifier_slark_18:IsPurgeException()
	return false
end
function modifier_slark_18:RemoveOnDeath()
	return false
end

function modifier_slark_18:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	local slark_fish_bait_custom = self:GetCaster():FindAbilityByName("slark_fish_bait_custom")
	if slark_fish_bait_custom then
		slark_fish_bait_custom:SetHidden(false)
		slark_fish_bait_custom:SetLevel(self:GetStackCount())
	end
end

function modifier_slark_18:OnRefresh()
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
	local slark_fish_bait_custom = self:GetCaster():FindAbilityByName("slark_fish_bait_custom")
	if slark_fish_bait_custom then
		slark_fish_bait_custom:SetHidden(false)
		slark_fish_bait_custom:SetLevel(self:GetStackCount())
	end
end