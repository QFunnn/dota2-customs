--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chaos_knight_10=class({})

function modifier_chaos_knight_10:IsHidden() return true end
function modifier_chaos_knight_10:IsPurgable() return false end
function modifier_chaos_knight_10:IsPurgeException() return false end
function modifier_chaos_knight_10:RemoveOnDeath() return false end

function modifier_chaos_knight_10:OnCreated()
    self.bonus = {0,0,0}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_chaos_knight_10:OnRefresh()
    self.bonus = {0,0,0}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_chaos_knight_10:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS
    }
end

function modifier_chaos_knight_10:GetModifierBonusStats_Agility()
    return self.bonus[self:GetStackCount()]
end