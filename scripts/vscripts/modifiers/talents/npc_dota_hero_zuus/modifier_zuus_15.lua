--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_zuus_15=class({})

function modifier_zuus_15:IsHidden() return true end
function modifier_zuus_15:IsPurgable() return false end
function modifier_zuus_15:IsPurgeException() return false end
function modifier_zuus_15:RemoveOnDeath() return false end

function modifier_zuus_15:OnCreated()
    self.bonus = {3,6,9}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_zuus_15:OnRefresh()
    self.bonus = {3,6,9}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_zuus_15:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    }
end

function modifier_zuus_15:GetModifierBonusStats_Strength()
    return self.bonus[self:GetStackCount()]
end

function modifier_zuus_15:GetModifierBonusStats_Intellect()
    return self.bonus[self:GetStackCount()]
end