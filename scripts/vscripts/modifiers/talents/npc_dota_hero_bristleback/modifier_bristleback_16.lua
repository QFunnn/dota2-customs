--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_bristleback_16=class({})

function modifier_bristleback_16:IsHidden() return true end
function modifier_bristleback_16:IsPurgable() return false end
function modifier_bristleback_16:IsPurgeException() return false end
function modifier_bristleback_16:RemoveOnDeath() return false end

function modifier_bristleback_16:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local bristleback_hairball_custom = self:GetCaster():FindAbilityByName("bristleback_hairball_custom")
	if bristleback_hairball_custom then
		bristleback_hairball_custom:SetHidden(false)
		bristleback_hairball_custom:SetLevel(1)
	end
end

function modifier_bristleback_16:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	local bristleback_hairball_custom = self:GetCaster():FindAbilityByName("bristleback_hairball_custom")
	if bristleback_hairball_custom then
		bristleback_hairball_custom:SetHidden(false)
		bristleback_hairball_custom:SetLevel(1)
	end
end