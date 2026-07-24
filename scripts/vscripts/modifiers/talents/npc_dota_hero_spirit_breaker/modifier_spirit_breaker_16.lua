--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_spirit_breaker_16=class({})

function modifier_spirit_breaker_16:IsHidden() return true end
function modifier_spirit_breaker_16:IsPurgable() return false end
function modifier_spirit_breaker_16:IsPurgeException() return false end
function modifier_spirit_breaker_16:RemoveOnDeath() return false end

function modifier_spirit_breaker_16:OnCreated()
    self.bonus = {7,14}
    self.bonus2 = {200,400}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_spirit_breaker_16:OnRefresh()
    self.bonus = {7,14}
    self.bonus2 = {200,400}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_spirit_breaker_16:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_EVASION_CONSTANT,
        MODIFIER_PROPERTY_MANA_BONUS
    }
end

function modifier_spirit_breaker_16:GetModifierEvasion_Constant()
    return self.bonus[self:GetStackCount()]
end

function modifier_spirit_breaker_16:GetModifierManaBonus()
    return self.bonus2[self:GetStackCount()]
end