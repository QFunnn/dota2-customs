--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_antimage_13=class({})

function modifier_antimage_13:IsHidden() return true end
function modifier_antimage_13:IsPurgable() return false end
function modifier_antimage_13:IsPurgeException() return false end
function modifier_antimage_13:RemoveOnDeath() return false end

function modifier_antimage_13:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local antimage_mana_overload = self:GetParent():FindAbilityByName("antimage_mana_overload_custom")
	if antimage_mana_overload then
		antimage_mana_overload:SetLevel(1+self:GetStackCount())
		antimage_mana_overload:SetHidden(false)
	end
end

function modifier_antimage_13:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	local antimage_mana_overload = self:GetParent():FindAbilityByName("antimage_mana_overload_custom")
	if antimage_mana_overload then
		antimage_mana_overload:SetLevel(1+self:GetStackCount())
		antimage_mana_overload:SetHidden(false)
	end
end