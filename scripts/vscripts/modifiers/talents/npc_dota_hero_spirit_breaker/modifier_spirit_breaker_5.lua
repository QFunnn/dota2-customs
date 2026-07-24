--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_spirit_breaker_5=class({})

function modifier_spirit_breaker_5:IsHidden() return true end
function modifier_spirit_breaker_5:IsPurgable() return false end
function modifier_spirit_breaker_5:IsPurgeException() return false end
function modifier_spirit_breaker_5:RemoveOnDeath() return false end

function modifier_spirit_breaker_5:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local spirit_breaker_charge_of_darkness_custom = self:GetCaster():FindAbilityByName("spirit_breaker_charge_of_darkness_custom")
    if spirit_breaker_charge_of_darkness_custom then
        spirit_breaker_charge_of_darkness_custom:SetActivated(false)
        spirit_breaker_charge_of_darkness_custom:SetHidden(true)
    end
end

function modifier_spirit_breaker_5:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local spirit_breaker_charge_of_darkness_custom = self:GetCaster():FindAbilityByName("spirit_breaker_charge_of_darkness_custom")
    if spirit_breaker_charge_of_darkness_custom then
        spirit_breaker_charge_of_darkness_custom:SetActivated(false)
        spirit_breaker_charge_of_darkness_custom:SetHidden(true)
    end
end