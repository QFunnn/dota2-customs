--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_doom_bringer_2=class({})

function modifier_doom_bringer_2:IsHidden() return true end
function modifier_doom_bringer_2:IsPurgable() return false end
function modifier_doom_bringer_2:IsPurgeException() return false end
function modifier_doom_bringer_2:RemoveOnDeath() return false end

function modifier_doom_bringer_2:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local doom_bringer_creep_doom_custom = self:GetCaster():FindAbilityByName("doom_bringer_creep_doom_custom")
	if doom_bringer_creep_doom_custom then
		doom_bringer_creep_doom_custom:SetLevel(self:GetStackCount())
		doom_bringer_creep_doom_custom:SetHidden(false)
	end
end

function modifier_doom_bringer_2:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	local doom_bringer_creep_doom_custom = self:GetCaster():FindAbilityByName("doom_bringer_creep_doom_custom")
	if doom_bringer_creep_doom_custom then
		doom_bringer_creep_doom_custom:SetLevel(self:GetStackCount())
		doom_bringer_creep_doom_custom:SetHidden(false)
	end
end