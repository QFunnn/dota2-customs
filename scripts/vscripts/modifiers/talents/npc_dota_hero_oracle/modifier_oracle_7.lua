--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_oracle_7=class({})

function modifier_oracle_7:IsHidden() return true end
function modifier_oracle_7:IsPurgable() return false end
function modifier_oracle_7:IsPurgeException() return false end
function modifier_oracle_7:RemoveOnDeath() return false end

function modifier_oracle_7:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	self:Swap("oracle_fates_edict_custom","oracle_change_of_fate")
end

function modifier_oracle_7:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_oracle_7:Swap(name1, name2)
if not IsServer() then return end
local ability1 = self:GetParent():FindAbilityByName(name1)
local ability2 = self:GetParent():FindAbilityByName(name2)
ability1:SetHidden(true)
ability2:SetHidden(false)
ability2:SetLevel(1)
self:GetParent():SwapAbilities(name1, name2, false, true)
end