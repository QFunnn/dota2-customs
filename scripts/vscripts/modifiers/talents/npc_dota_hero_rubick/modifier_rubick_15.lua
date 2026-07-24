--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rubick_15=class({})

function modifier_rubick_15:IsHidden() return true end
function modifier_rubick_15:IsPurgable() return false end
function modifier_rubick_15:IsPurgeException() return false end
function modifier_rubick_15:RemoveOnDeath() return false end

function modifier_rubick_15:OnCreated()
    self.bonus = {5,10}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_rubick_15:OnRefresh()
    self.bonus = {5,10}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_rubick_15:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    }
end

function modifier_rubick_15:GetModifierBonusStats_Agility()
    return self.bonus[self:GetStackCount()]
end

function modifier_rubick_15:GetModifierBonusStats_Intellect()
    return self.bonus[self:GetStackCount()]
end