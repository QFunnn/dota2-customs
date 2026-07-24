--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_bristleback_12=class({})

function modifier_bristleback_12:IsHidden() return true end
function modifier_bristleback_12:IsPurgable() return false end
function modifier_bristleback_12:IsPurgeException() return false end
function modifier_bristleback_12:RemoveOnDeath() return false end

function modifier_bristleback_12:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local bristleback_sneezing = self:GetCaster():FindAbilityByName("bristleback_sneezing")
	if bristleback_sneezing then
		bristleback_sneezing:SetHidden(false)
		bristleback_sneezing:SetLevel(1)
	end
end

function modifier_bristleback_12:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	local bristleback_sneezing = self:GetCaster():FindAbilityByName("bristleback_sneezing")
	if bristleback_sneezing then
		bristleback_sneezing:SetHidden(false)
		bristleback_sneezing:SetLevel(1)
	end
end