--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_void_spirit_16=class({})

function modifier_void_spirit_16:IsHidden() return true end
function modifier_void_spirit_16:IsPurgable() return false end
function modifier_void_spirit_16:IsPurgeException() return false end
function modifier_void_spirit_16:RemoveOnDeath() return false end

function modifier_void_spirit_16:OnCreated()
    self.bonus = {5,10}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(false)
end

function modifier_void_spirit_16:OnRefresh()
    self.bonus = {5,10}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(false)
end

function modifier_void_spirit_16:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS
    }
end

function modifier_void_spirit_16:GetModifierBonusStats_Strength()
    return self.bonus[self:GetStackCount()]
end

function modifier_void_spirit_16:GetModifierBonusStats_Agility()
    return self.bonus[self:GetStackCount()]
end
