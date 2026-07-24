--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_jakiro_1=class({})

function modifier_jakiro_1:IsHidden() return true end
function modifier_jakiro_1:IsPurgable() return false end
function modifier_jakiro_1:IsPurgeException() return false end
function modifier_jakiro_1:RemoveOnDeath() return false end

function modifier_jakiro_1:OnCreated()
    self.bonus = {4,8}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_jakiro_1:OnRefresh()
    self.bonus = {4,8}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_jakiro_1:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
    }
end

function modifier_jakiro_1:GetModifierBonusStats_Strength()
    return self.bonus[self:GetStackCount()]
end

function modifier_jakiro_1:GetModifierBonusStats_Intellect()
    return self.bonus[self:GetStackCount()]
end