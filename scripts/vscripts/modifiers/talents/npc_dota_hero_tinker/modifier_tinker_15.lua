--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tinker_15=class({})

function modifier_tinker_15:IsHidden() return true end
function modifier_tinker_15:IsPurgable() return false end
function modifier_tinker_15:IsPurgeException() return false end
function modifier_tinker_15:RemoveOnDeath() return false end

function modifier_tinker_15:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local tinker_heat_seeking_missile_custom = self:GetParent():FindAbilityByName("tinker_heat_seeking_missile_custom")
    if tinker_heat_seeking_missile_custom then
        tinker_heat_seeking_missile_custom:SetLevel(1)
    end
    local tinker_march_of_the_machines_custom = self:GetParent():FindAbilityByName("tinker_march_of_the_machines_custom")
    if tinker_march_of_the_machines_custom then
        tinker_march_of_the_machines_custom:SetActivated(false)
    end
    self:GetCaster():SwapAbilities("tinker_march_of_the_machines_custom", "tinker_heat_seeking_missile_custom", false, true)
end

function modifier_tinker_15:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local tinker_heat_seeking_missile_custom = self:GetParent():FindAbilityByName("tinker_heat_seeking_missile_custom")
    if tinker_heat_seeking_missile_custom then
        tinker_heat_seeking_missile_custom:SetLevel(self:GetStackCount())
    end
end