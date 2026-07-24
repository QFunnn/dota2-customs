--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_zuus_12=class({})

function modifier_zuus_12:IsHidden() return true end
function modifier_zuus_12:IsPurgable() return false end
function modifier_zuus_12:IsPurgeException() return false end
function modifier_zuus_12:RemoveOnDeath() return false end

function modifier_zuus_12:OnCreated()
    self.bonus2 = {70,140}
    self.bonus = {7,14}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_zuus_12:OnRefresh()
    self.bonus2 = {70,140}
    self.bonus = {7,14}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_zuus_12:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
        MODIFIER_PROPERTY_MAGICAL_LIFESTEAL
    }
end

function modifier_zuus_12:GetModifierAttackRangeBonus()
    return self.bonus2[self:GetStackCount()]
end

function modifier_zuus_12:GetModifierProperty_MagicalLifesteal(params)
    return self.bonus[self:GetStackCount()]
end