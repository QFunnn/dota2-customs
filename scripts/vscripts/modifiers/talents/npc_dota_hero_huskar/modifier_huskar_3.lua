--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_huskar_3=class({})

function modifier_huskar_3:IsHidden() return true end
function modifier_huskar_3:IsPurgable() return false end
function modifier_huskar_3:IsPurgeException() return false end
function modifier_huskar_3:RemoveOnDeath() return false end

function modifier_huskar_3:OnCreated()
    self.bonus = {25,50}
    self.bonus2 = {25,50}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_huskar_3:OnRefresh()
    self.bonus = {25,50}
    self.bonus2 = {25,50}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_huskar_3:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }
end

function modifier_huskar_3:GetModifierMoveSpeedBonus_Constant()
    if self:GetCaster():GetHealthPercent() >= 30 then return end
    return self.bonus[self:GetStackCount()]
end

function modifier_huskar_3:GetModifierAttackSpeedBonus_Constant()
    if self:GetCaster():GetHealthPercent() >= 30 then return end
    return self.bonus2[self:GetStackCount()]
end