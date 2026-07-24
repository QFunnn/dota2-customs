--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_zuus_11=class({})

function modifier_zuus_11:IsHidden() return true end
function modifier_zuus_11:IsPurgable() return false end
function modifier_zuus_11:IsPurgeException() return false end
function modifier_zuus_11:RemoveOnDeath() return false end

function modifier_zuus_11:OnCreated()
    self.health = {150,300}
    self.mana = {15,30}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_zuus_11:OnRefresh()
    self.health = {150,300}
    self.mana = {15,30}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_zuus_11:DeclareFunctions()
    return
    {
         
        MODIFIER_PROPERTY_HEALTH_BONUS,
    }
end

function modifier_zuus_11:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if self:GetParent():IsIllusion() then return end
    local mana = self.mana[self:GetStackCount()]
    self:GetParent():GiveMana(mana)
end

function modifier_zuus_11:GetModifierHealthBonus()
    return self.health[self:GetStackCount()]
end