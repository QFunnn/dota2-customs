--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_abaddon_14=class({})

function modifier_abaddon_14:IsHidden() return true end
function modifier_abaddon_14:IsPurgable() return false end
function modifier_abaddon_14:IsPurgeException() return false end
function modifier_abaddon_14:RemoveOnDeath() return false end

function modifier_abaddon_14:OnCreated()
    self.bonus = 15
    self.bonus2 = 15
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_abaddon_14:OnRefresh()
    self.bonus = 15
    self.bonus2 = 15
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_abaddon_14:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
    }
end

function modifier_abaddon_14:GetModifierMoveSpeedBonus_Percentage()
    return self.bonus
end

function modifier_abaddon_14:GetModifierStatusResistanceStacking()
    return self.bonus2
end