--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_zuus_14=class({})

function modifier_zuus_14:IsHidden() return true end
function modifier_zuus_14:IsPurgable() return false end
function modifier_zuus_14:IsPurgeException() return false end
function modifier_zuus_14:RemoveOnDeath() return false end

function modifier_zuus_14:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:StartIntervalThink(FrameTime())
end

function modifier_zuus_14:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_zuus_14:GetModifierAttackSpeedAbsoluteMax()
    return 1
end

function modifier_zuus_14:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
        MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT
    }
end

function modifier_zuus_14:GetModifierBaseAttackTimeConstant()
    return 1.45
end