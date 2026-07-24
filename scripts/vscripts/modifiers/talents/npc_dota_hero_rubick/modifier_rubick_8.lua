--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rubick_8=class({})

function modifier_rubick_8:IsHidden() return true end
function modifier_rubick_8:IsPurgable() return false end
function modifier_rubick_8:IsPurgeException() return false end
function modifier_rubick_8:RemoveOnDeath() return false end

function modifier_rubick_8:OnCreated()
    self.bonus = {10,20,30}
    self.bonus2 = {5,10,15}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(false)
end

function modifier_rubick_8:OnRefresh()
    self.bonus = {10,20,30}
    self.bonus2 = {5,10,15}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(false)
end

function modifier_rubick_8:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING
    }
end

function modifier_rubick_8:GetModifierAttackSpeedBonus_Constant()
    return self.bonus[self:GetStackCount()]
end

function modifier_rubick_8:GetModifierPercentageManacostStacking()
    return self.bonus2[self:GetStackCount()]
end