--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tidehunter_3=class({})

function modifier_tidehunter_3:IsHidden() return true end
function modifier_tidehunter_3:IsPurgable() return false end
function modifier_tidehunter_3:IsPurgeException() return false end
function modifier_tidehunter_3:RemoveOnDeath() return false end

function modifier_tidehunter_3:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local tidehunter_arm_of_the_deep_custom = self:GetParent():FindAbilityByName("tidehunter_arm_of_the_deep_custom")
	if tidehunter_arm_of_the_deep_custom then
		tidehunter_arm_of_the_deep_custom:SetLevel(1)
		tidehunter_arm_of_the_deep_custom:SetHidden(false)
	end
end

function modifier_tidehunter_3:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end