--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_monkey_king_2=class({})

function modifier_monkey_king_2:IsHidden() return true end
function modifier_monkey_king_2:IsPurgable() return false end
function modifier_monkey_king_2:IsPurgeException() return false end
function modifier_monkey_king_2:RemoveOnDeath() return false end

function modifier_monkey_king_2:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local monkey_king_tree_dance_custom = self:GetParent():FindAbilityByName("monkey_king_tree_dance_custom")
    if monkey_king_tree_dance_custom then
        monkey_king_tree_dance_custom:SetHidden(true)
        monkey_king_tree_dance_custom:SetActivated(false)
    end
    local monkey_king_primal_spring_custom = self:GetParent():FindAbilityByName("monkey_king_primal_spring_custom")
    if monkey_king_primal_spring_custom then
        monkey_king_primal_spring_custom:SetHidden(true)
        monkey_king_primal_spring_custom:SetActivated(false)
    end
    local monkey_king_primal_spring_early_custom = self:GetParent():FindAbilityByName("monkey_king_primal_spring_early_custom")
    if monkey_king_primal_spring_early_custom then
        monkey_king_primal_spring_early_custom:SetHidden(true)
        monkey_king_primal_spring_early_custom:SetActivated(false)
    end
end

function modifier_monkey_king_2:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end