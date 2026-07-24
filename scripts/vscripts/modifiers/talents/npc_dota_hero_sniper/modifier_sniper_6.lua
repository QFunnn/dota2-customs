--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_sniper_6=class({})

function modifier_sniper_6:IsHidden() return true end
function modifier_sniper_6:IsPurgable() return false end
function modifier_sniper_6:IsPurgeException() return false end
function modifier_sniper_6:RemoveOnDeath() return false end

function modifier_sniper_6:OnCreated()
    self.bonus = {75,150}
    self.bonus2 = {3,6}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_sniper_6:OnRefresh()
    self.bonus = {75,150}
    self.bonus2 = {3,6}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_sniper_6:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
        MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
    }
end

function modifier_sniper_6:GetModifierCastRangeBonusStacking()
    return self.bonus[self:GetStackCount()]
end

function modifier_sniper_6:GetModifierPercentageCooldown()
    return self.bonus2[self:GetStackCount()]
end