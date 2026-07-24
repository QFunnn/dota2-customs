--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tinker_10=class({})

function modifier_tinker_10:IsHidden() return true end
function modifier_tinker_10:IsPurgable() return false end
function modifier_tinker_10:IsPurgeException() return false end
function modifier_tinker_10:RemoveOnDeath() return false end

function modifier_tinker_10:OnCreated()
    self.bonus = {70,140,210}
    self.bonus2 = {140,280,420}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_tinker_10:OnRefresh()
    self.bonus = {70,140,210}
    self.bonus2 = {140,280,420}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_tinker_10:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
        MODIFIER_PROPERTY_HEALTH_BONUS,
    }
end

function modifier_tinker_10:GetModifierAttackRangeBonus()
    return self.bonus[self:GetStackCount()]
end

function modifier_tinker_10:GetModifierHealthBonus()
    return self.bonus2[self:GetStackCount()]
end