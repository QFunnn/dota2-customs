--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_spirit_breaker_10=class({})

function modifier_spirit_breaker_10:IsHidden() return true end
function modifier_spirit_breaker_10:IsPurgable() return false end
function modifier_spirit_breaker_10:IsPurgeException() return false end
function modifier_spirit_breaker_10:RemoveOnDeath() return false end

function modifier_spirit_breaker_10:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local spirit_breaker_astral_charge = self:GetCaster():FindAbilityByName("spirit_breaker_astral_charge")
    if spirit_breaker_astral_charge then
        spirit_breaker_astral_charge:SetHidden(false)
        spirit_breaker_astral_charge:SetLevel(self:GetStackCount())
    end
end

function modifier_spirit_breaker_10:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local spirit_breaker_astral_charge = self:GetCaster():FindAbilityByName("spirit_breaker_astral_charge")
    if spirit_breaker_astral_charge then
        spirit_breaker_astral_charge:SetHidden(false)
        spirit_breaker_astral_charge:SetLevel(self:GetStackCount())
    end
end