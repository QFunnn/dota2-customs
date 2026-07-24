--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_lina_9=class({})

function modifier_lina_9:IsHidden() return true end
function modifier_lina_9:IsPurgable() return false end
function modifier_lina_9:IsPurgeException() return false end
function modifier_lina_9:RemoveOnDeath() return false end

function modifier_lina_9:OnCreated()
    self.bonus = {150,300}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetCaster():CalculateStatBonus(true)
end

function modifier_lina_9:OnRefresh()
    self.bonus = {150,300}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetCaster():CalculateStatBonus(true)
end

function modifier_lina_9:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_HEALTH_BONUS,
    }
end

function modifier_lina_9:GetModifierHealthBonus()
    return self.bonus[self:GetStackCount()]
end