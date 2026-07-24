--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_nevermore_4=class({})

function modifier_nevermore_4:IsHidden() return true end
function modifier_nevermore_4:IsPurgable() return false end
function modifier_nevermore_4:IsPurgeException() return false end
function modifier_nevermore_4:RemoveOnDeath() return false end

function modifier_nevermore_4:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	if self:GetParent():HasAbility("nevermore_necromastery_custom") then
		self:GetParent():RemoveModifierByName("modifier_nevermore_necromastery_custom")
		self:GetParent():RemoveAbility("nevermore_necromastery_custom")
		self:GetParent():RemoveAbilityFromIndexByName( "nevermore_necromastery_custom" )
		self:GetParent():RemoveModifierByName("modifier_nevermore_necromastery_custom")
	end
end

function modifier_nevermore_4:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end