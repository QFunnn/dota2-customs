--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tinker_18=class({})

function modifier_tinker_18:IsHidden() return true end
function modifier_tinker_18:IsPurgable() return false end
function modifier_tinker_18:IsPurgeException() return false end
function modifier_tinker_18:RemoveOnDeath() return false end

function modifier_tinker_18:OnCreated()
	if not IsServer() then return end
    self:SetStackCount(1)
    self:GetCaster():SwapAbilities("tinker_deploy_turrets_custom", "tinker_defense_matrix_custom", false, true)
    local tinker_deploy_turrets_custom = self:GetCaster():FindAbilityByName("tinker_deploy_turrets_custom")
    if tinker_deploy_turrets_custom then
        tinker_deploy_turrets_custom:SetHidden(true)
        tinker_deploy_turrets_custom:SetActivated(false)
    end
    local tinker_defense_matrix_custom = self:GetCaster():FindAbilityByName("tinker_defense_matrix_custom")
    if tinker_defense_matrix_custom then
        tinker_defense_matrix_custom:SetLevel(self:GetStackCount())
    end
end

function modifier_tinker_18:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local tinker_defense_matrix_custom = self:GetCaster():FindAbilityByName("tinker_defense_matrix_custom")
    if tinker_defense_matrix_custom then
        tinker_defense_matrix_custom:SetLevel(self:GetStackCount())
    end
end