--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_axe_8=class({})

function modifier_axe_8:IsHidden() return true end
function modifier_axe_8:IsPurgable() return false end
function modifier_axe_8:IsPurgeException() return false end
function modifier_axe_8:RemoveOnDeath() return false end

function modifier_axe_8:OnCreated()
    self.bonus2={15}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_axe_8:OnRefresh()
    self.bonus2={15}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_axe_8:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
end

function modifier_axe_8:GetModifierSlowResistance_Stacking()
    local bonus = 15
    return bonus
end

function modifier_axe_8:GetModifierMoveSpeedBonus_Constant()
    return self.bonus2[self:GetStackCount()]
end