--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_void_spirit_15=class({})

function modifier_void_spirit_15:IsHidden() return true end
function modifier_void_spirit_15:IsPurgable() return false end
function modifier_void_spirit_15:IsPurgeException() return false end
function modifier_void_spirit_15:RemoveOnDeath() return false end

function modifier_void_spirit_15:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(false)
end

function modifier_void_spirit_15:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(false)
end

function modifier_void_spirit_15:DeclareFunctions()
    return {MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
            MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
            MODIFIER_PROPERTY_STATS_INTELLECT_BONUS}
end

function modifier_void_spirit_15:GetModifierBonusStats_Strength()
    if not self:GetParent():HasModifier("modifier_void_spirit_3") then return end
    if not self:GetParent():HasModifier("modifier_void_spirit_10") then return end
    if not self:GetParent():HasModifier("modifier_void_spirit_17") then return end
    return 15
end

function modifier_void_spirit_15:GetModifierBonusStats_Agility()
    if not self:GetParent():HasModifier("modifier_void_spirit_3") then return end
    if not self:GetParent():HasModifier("modifier_void_spirit_10") then return end
    if not self:GetParent():HasModifier("modifier_void_spirit_17") then return end
    return 15
end

function modifier_void_spirit_15:GetModifierBonusStats_Intellect()
    if not self:GetParent():HasModifier("modifier_void_spirit_3") then return end
    if not self:GetParent():HasModifier("modifier_void_spirit_10") then return end
    if not self:GetParent():HasModifier("modifier_void_spirit_17") then return end
    return 15
end