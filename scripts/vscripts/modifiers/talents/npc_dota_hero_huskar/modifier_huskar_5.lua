--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_huskar_5=class({})

function modifier_huskar_5:IsHidden() return true end
function modifier_huskar_5:IsPurgable() return false end
function modifier_huskar_5:IsPurgeException() return false end
function modifier_huskar_5:RemoveOnDeath() return false end

function modifier_huskar_5:OnCreated()
    self.bonus = {6,12}
    self.bonus2 = {25,50}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_huskar_5:OnRefresh()
    self.bonus = {6,12}
    self.bonus2 = {25,50}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_huskar_5:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE
    }
end

function modifier_huskar_5:GetModifierPhysicalArmorBonus()
    if self:GetCaster():GetHealthPercent() >= 30 then return end
    return self.bonus[self:GetStackCount()]
end

function modifier_huskar_5:GetModifierBaseAttack_BonusDamage()
    if self:GetCaster():GetHealthPercent() >= 30 then return end
    return self.bonus2[self:GetStackCount()]
end