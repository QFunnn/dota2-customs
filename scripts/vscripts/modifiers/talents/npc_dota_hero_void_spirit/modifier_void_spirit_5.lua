--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_void_spirit_5=class({})

function modifier_void_spirit_5:IsHidden() return true end
function modifier_void_spirit_5:IsPurgable() return false end
function modifier_void_spirit_5:IsPurgeException() return false end
function modifier_void_spirit_5:RemoveOnDeath() return false end

function modifier_void_spirit_5:OnCreated()
    self.bonus = {0,10,20}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(false)
end

function modifier_void_spirit_5:OnRefresh()
    self.bonus = {0,10,20}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(false)
end

function modifier_void_spirit_5:DeclareFunctions()
    return {MODIFIER_PROPERTY_STATS_STRENGTH_BONUS}
end

function modifier_void_spirit_5:GetModifierBonusStats_Strength()
    return self.bonus[self:GetStackCount()]
end