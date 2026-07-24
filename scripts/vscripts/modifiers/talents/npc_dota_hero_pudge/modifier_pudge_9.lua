--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_pudge_9=class({})

function modifier_pudge_9:IsHidden() return true end
function modifier_pudge_9:IsPurgable() return false end
function modifier_pudge_9:IsPurgeException() return false end
function modifier_pudge_9:RemoveOnDeath() return false end

function modifier_pudge_9:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	self:Swap("pudge_meat_hook_custom","pudge_chain_binding")
end

function modifier_pudge_9:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	local pudge_chain_binding = self:GetParent():FindAbilityByName("pudge_chain_binding")
	if pudge_chain_binding then
		pudge_chain_binding:SetLevel(self:GetStackCount())
	end
end

function modifier_pudge_9:Swap(name1, name2)
	if not IsServer() then return end

	local ability1 = self:GetParent():FindAbilityByName(name1)
	local ability2 = self:GetParent():FindAbilityByName(name2)

	ability1:SetHidden(true)
	ability2:SetHidden(false)
	ability2:SetLevel(self:GetStackCount())


	self:GetParent():SwapAbilities(name1, name2, false, true)
end