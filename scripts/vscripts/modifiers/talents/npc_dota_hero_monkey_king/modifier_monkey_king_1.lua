--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_monkey_king_1=class({})

function modifier_monkey_king_1:IsHidden() return true end
function modifier_monkey_king_1:IsPurgable() return false end
function modifier_monkey_king_1:IsPurgeException() return false end
function modifier_monkey_king_1:RemoveOnDeath() return false end

function modifier_monkey_king_1:OnCreated()
    self.bonus = 5
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(false)
end

function modifier_monkey_king_1:OnRefresh()
    self.bonus = 5
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(false)
end

function modifier_monkey_king_1:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    }
end

function modifier_monkey_king_1:GetModifierBonusStats_Strength()
    return self.bonus
end