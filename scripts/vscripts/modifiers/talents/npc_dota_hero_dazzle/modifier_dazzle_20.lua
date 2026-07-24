--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_dazzle_20=class({})

function modifier_dazzle_20:IsHidden() return true end
function modifier_dazzle_20:IsPurgable() return false end
function modifier_dazzle_20:IsPurgeException() return false end
function modifier_dazzle_20:RemoveOnDeath() return false end

function modifier_dazzle_20:OnCreated()
    self.bonus_2 = {200,400,600}
    self.bonus = {7,14,21}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_dazzle_20:OnRefresh()
    self.bonus_2 = {200,400,600}
    self.bonus = {7,14,21}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_dazzle_20:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MANA_BONUS,
        MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
    }
end

function modifier_dazzle_20:GetModifierManaBonus()
    return self.bonus_2[self:GetStackCount()]
end

function modifier_dazzle_20:GetModifierStatusResistanceStacking()
    return self.bonus[self:GetStackCount()]
end