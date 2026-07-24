--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_huskar_14=class({})

function modifier_huskar_14:IsHidden() return true end
function modifier_huskar_14:IsPurgable() return false end
function modifier_huskar_14:IsPurgeException() return false end
function modifier_huskar_14:RemoveOnDeath() return false end

function modifier_huskar_14:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local huskar_burning_spear_custom = self:GetParent():FindAbilityByName("huskar_burning_spear_custom")
    if huskar_burning_spear_custom then
        huskar_burning_spear_custom:SetHidden(true)
        huskar_burning_spear_custom:SetActivated(false)
    end
end

function modifier_huskar_14:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_huskar_14:DeclareFunctions()
    return
    {
         
    }
end

function modifier_huskar_14:OnAbilityFullyCast(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    local heal_percent = 100
    if self:GetCaster():HasModifier("modifier_huskar_15") then
        local mana_cost = params.ability:GetEffectiveManaCost(-1)
        self:GetCaster():Heal(mana_cost / 100 * heal_percent, nil)
    else
        local health_cost = params.ability:GetEffectiveHealthCost(-1)
        params.ability:RefundHealthCost()
        self:GetCaster():Heal(health_cost / 100 * heal_percent, nil)
    end
end