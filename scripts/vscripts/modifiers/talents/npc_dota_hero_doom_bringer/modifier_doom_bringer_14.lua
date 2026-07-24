--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_doom_bringer_14=class({})

function modifier_doom_bringer_14:IsHidden() return true end
function modifier_doom_bringer_14:IsPurgable() return false end
function modifier_doom_bringer_14:IsPurgeException() return false end
function modifier_doom_bringer_14:RemoveOnDeath() return false end

function modifier_doom_bringer_14:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local doom_bringer_fueling_hell = self:GetCaster():FindAbilityByName("doom_bringer_fueling_hell")
	if doom_bringer_fueling_hell then
		doom_bringer_fueling_hell:SetLevel(1)
		doom_bringer_fueling_hell:SetHidden(false)
	end
	local doom_bringer_doom_custom = self:GetCaster():FindAbilityByName("doom_bringer_doom_custom")
	if doom_bringer_doom_custom then
		doom_bringer_doom_custom:SetLevel(3)
		doom_bringer_doom_custom:SetActivated(false)
		doom_bringer_doom_custom:SetHidden(true)
	end
end

function modifier_doom_bringer_14:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end