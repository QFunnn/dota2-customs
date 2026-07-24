--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chen_12=class({})

function modifier_chen_12:IsHidden() return true end
function modifier_chen_12:IsPurgable() return false end
function modifier_chen_12:IsPurgeException() return false end
function modifier_chen_12:RemoveOnDeath() return false end

function modifier_chen_12:OnCreated()
    self.bonus={0}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_chen_12:OnRefresh()
    self.bonus={0}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_chen_12:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_HEALTH_BONUS
    }
end

function modifier_chen_12:CheckState()
    return
    {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

function modifier_chen_12:GetModifierMoveSpeedBonus_Percentage()
    return 5
end

function modifier_chen_12:GetModifierHealthBonus()
    return self.bonus[self:GetStackCount()]
end