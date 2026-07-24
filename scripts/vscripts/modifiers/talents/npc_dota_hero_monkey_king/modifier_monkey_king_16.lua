--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_monkey_king_16=class({})

function modifier_monkey_king_16:IsHidden() return true end
function modifier_monkey_king_16:IsPurgable() return false end
function modifier_monkey_king_16:IsPurgeException() return false end
function modifier_monkey_king_16:RemoveOnDeath() return false end

function modifier_monkey_king_16:OnCreated()
    self.bonus = {5,10}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(false)
end

function modifier_monkey_king_16:OnRefresh()
    self.bonus = {5,10}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(false)
end

function modifier_monkey_king_16:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
    }
end

function modifier_monkey_king_16:GetModifierBonusStats_Intellect()
    return self.bonus[self:GetStackCount()]
end