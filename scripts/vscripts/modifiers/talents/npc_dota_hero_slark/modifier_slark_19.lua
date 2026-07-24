--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_slark_19=class({})

function modifier_slark_19:IsHidden() return true end
function modifier_slark_19:IsPurgable() return false end
function modifier_slark_19:IsPurgeException() return false end
function modifier_slark_19:RemoveOnDeath() return false end

function modifier_slark_19:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local slark_depth_shroud_custom = self:GetCaster():FindAbilityByName("slark_depth_shroud_custom")
	if slark_depth_shroud_custom then
		slark_depth_shroud_custom:SetHidden(false)
		slark_depth_shroud_custom:SetLevel(self:GetStackCount())
	end
end

function modifier_slark_19:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	local slark_depth_shroud_custom = self:GetCaster():FindAbilityByName("slark_depth_shroud_custom")
	if slark_depth_shroud_custom then
		slark_depth_shroud_custom:SetHidden(false)
		slark_depth_shroud_custom:SetLevel(self:GetStackCount())
	end
end