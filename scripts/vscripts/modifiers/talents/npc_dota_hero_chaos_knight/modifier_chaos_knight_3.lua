--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chaos_knight_3=class({})

function modifier_chaos_knight_3:IsHidden() return true end
function modifier_chaos_knight_3:IsPurgable() return false end
function modifier_chaos_knight_3:IsPurgeException() return false end
function modifier_chaos_knight_3:RemoveOnDeath() return false end

function modifier_chaos_knight_3:OnCreated()
    self.bonus = {3,6,9}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_chaos_knight_3:OnRefresh()
    self.bonus = {3,6,9}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_chaos_knight_3:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
    }
end

function modifier_chaos_knight_3:GetModifierBonusStats_Strength()
    return self.bonus[self:GetStackCount()]
end