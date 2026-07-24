--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_naga_siren_18=class({})

function modifier_naga_siren_18:IsHidden() return true end
function modifier_naga_siren_18:IsPurgable() return false end
function modifier_naga_siren_18:IsPurgeException() return false end
function modifier_naga_siren_18:RemoveOnDeath() return false end

function modifier_naga_siren_18:OnCreated()
    self.bonus = {30,60,90}
    self.bonus2={15,30,45}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_naga_siren_18:OnRefresh()
    self.bonus = {30,60,90}
    self.bonus2={15,30,45}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_naga_siren_18:CheckState()
    return
    {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

function modifier_naga_siren_18:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_CASTTIME_PERCENTAGE,
    }
end

function modifier_naga_siren_18:GetModifierMoveSpeedBonus_Constant()
    return self.bonus2[self:GetStackCount()]
end

function modifier_naga_siren_18:GetModifierPercentageCasttime()
    return self.bonus[self:GetStackCount()]
end