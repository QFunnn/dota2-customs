--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_oracle_17=class({})

function modifier_oracle_17:IsHidden() return true end
function modifier_oracle_17:IsPurgable() return false end
function modifier_oracle_17:IsPurgeException() return false end
function modifier_oracle_17:RemoveOnDeath() return false end

function modifier_oracle_17:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local oracle_rain_of_destiny_custom = self:GetCaster():FindAbilityByName("oracle_rain_of_destiny_custom")
	if oracle_rain_of_destiny_custom then
		oracle_rain_of_destiny_custom:SetHidden(false)
		oracle_rain_of_destiny_custom:SetLevel(1)
	end
end

function modifier_oracle_17:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end