--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_furion_15=class({})

function modifier_furion_15:IsHidden() return true end
function modifier_furion_15:IsPurgable() return false end
function modifier_furion_15:IsPurgeException() return false end
function modifier_furion_15:RemoveOnDeath() return false end

function modifier_furion_15:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local furion_curse_of_the_forest = self:GetCaster():FindAbilityByName("furion_curse_of_the_forest_custom")
	if furion_curse_of_the_forest then
		furion_curse_of_the_forest:SetLevel(1)
		furion_curse_of_the_forest:SetHidden(false)
	end
end

function modifier_furion_15:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end