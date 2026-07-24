--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_marci_8=class({})

function modifier_marci_8:IsHidden() return true end
function modifier_marci_8:IsPurgable() return false end
function modifier_marci_8:IsPurgeException() return false end
function modifier_marci_8:RemoveOnDeath() return false end

function modifier_marci_8:OnCreated()
    self.bonus = {7,14}
    self.bonus2 = {5,10}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_marci_8:OnRefresh()
    self.bonus = {7,14}
    self.bonus2 = {5,10}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_marci_8:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_EVASION_CONSTANT,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
    }
end

function modifier_marci_8:GetModifierEvasion_Constant()
    return self.bonus[self:GetStackCount()]
end

function modifier_marci_8:GetModifierMagicalResistanceBonus()
    return self.bonus2[self:GetStackCount()]
end