--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_marci_2=class({})

function modifier_marci_2:IsHidden() return true end
function modifier_marci_2:IsPurgable() return false end
function modifier_marci_2:IsPurgeException() return false end
function modifier_marci_2:RemoveOnDeath() return false end

function modifier_marci_2:OnCreated()
    self.bonus = {15,30}
    self.bonus2 = {5,10}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_marci_2:OnRefresh()
    self.bonus = {15,30}
    self.bonus2 = {5,10}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_marci_2:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
    }
end

function modifier_marci_2:GetModifierMoveSpeedBonus_Constant()
    return self.bonus[self:GetStackCount()]
end

function modifier_marci_2:GetModifierStatusResistanceStacking()
    return self.bonus2[self:GetStackCount()]
end