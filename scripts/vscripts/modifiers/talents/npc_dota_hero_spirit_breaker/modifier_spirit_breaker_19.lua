--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_spirit_breaker_19=class({})

function modifier_spirit_breaker_19:IsHidden() return true end
function modifier_spirit_breaker_19:IsPurgable() return false end
function modifier_spirit_breaker_19:IsPurgeException() return false end
function modifier_spirit_breaker_19:RemoveOnDeath() return false end

function modifier_spirit_breaker_19:OnCreated()
	self.bonus = {10,20,30}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_spirit_breaker_19:OnRefresh()
	self.bonus = {10,20,30}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_spirit_breaker_19:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_CASTTIME_PERCENTAGE
    }
    return funcs
end

function modifier_spirit_breaker_19:GetModifierPercentageCasttime()
    return self.bonus[self:GetStackCount()]
end