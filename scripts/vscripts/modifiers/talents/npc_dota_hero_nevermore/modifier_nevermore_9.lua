--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_nevermore_9=class({})

function modifier_nevermore_9:IsHidden() return true end
function modifier_nevermore_9:IsPurgable() return false end
function modifier_nevermore_9:IsPurgeException() return false end
function modifier_nevermore_9:RemoveOnDeath() return false end

function modifier_nevermore_9:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local ability = self:GetParent():FindAbilityByName("nevermore_necromastery_custom")
	if ability then
		self:GetParent():AddNewModifier(self:GetParent(), ability, "modifier_nevermore_necromastery_custom_orb", {})
	end
end

function modifier_nevermore_9:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end