--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tinker_1=class({})

function modifier_tinker_1:IsHidden() return true end
function modifier_tinker_1:IsPurgable() return false end
function modifier_tinker_1:IsPurgeException() return false end
function modifier_tinker_1:RemoveOnDeath() return false end

function modifier_tinker_1:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local tinker_rearm_custom = self:GetCaster():FindAbilityByName("tinker_rearm_custom")
    if tinker_rearm_custom then
        tinker_rearm_custom:SetHidden(true)
        tinker_rearm_custom:SetActivated(false)
    end
end

function modifier_tinker_1:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_tinker_1:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_CONVERT_MANA_COST_TO_HEALTH_COST,
        MODIFIER_PROPERTY_FORCE_MAX_MANA,
    }
end

function modifier_tinker_1:GetModifierConvertManaCostToHealthCost()
    return 1
end

function modifier_tinker_1:GetModifierForceMaxMana()
    return 0
end