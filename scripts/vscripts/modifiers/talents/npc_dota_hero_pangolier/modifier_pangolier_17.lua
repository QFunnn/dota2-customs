--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-04 05:43:48 UTC
  ~ auto-generated — do not edit
]]


modifier_pangolier_17 = class({})

function modifier_pangolier_17:IsHidden()
	return true
end
function modifier_pangolier_17:IsPurgable()
	return false
end
function modifier_pangolier_17:IsPurgeException()
	return false
end
function modifier_pangolier_17:RemoveOnDeath()
	return false
end

function modifier_pangolier_17:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	local pangolier_rollup_custom = self:GetParent():FindAbilityByName("pangolier_rollup_custom")
	if pangolier_rollup_custom then
		pangolier_rollup_custom:SetLevel(1)
		pangolier_rollup_custom:SetHidden(false)
	end
end

function modifier_pangolier_17:OnRefresh()
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end