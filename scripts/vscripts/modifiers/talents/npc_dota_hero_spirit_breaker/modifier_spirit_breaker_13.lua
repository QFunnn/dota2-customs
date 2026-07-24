--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_spirit_breaker_13=class({})

function modifier_spirit_breaker_13:IsHidden() return true end
function modifier_spirit_breaker_13:IsPurgable() return false end
function modifier_spirit_breaker_13:IsPurgeException() return false end
function modifier_spirit_breaker_13:RemoveOnDeath() return false end

function modifier_spirit_breaker_13:OnCreated()
    self.bonus={0,0}
	if not IsServer() then return end
	self:SetStackCount(1)
    local spirit_breaker_nether_strike_custom = self:GetCaster():FindAbilityByName("spirit_breaker_nether_strike_custom")
    if spirit_breaker_nether_strike_custom then
        spirit_breaker_nether_strike_custom:SetHidden(true)
        spirit_breaker_nether_strike_custom:SetActivated(false)
    end
end

function modifier_spirit_breaker_13:OnRefresh()
    self.bonus={0,0}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local spirit_breaker_nether_strike_custom = self:GetCaster():FindAbilityByName("spirit_breaker_nether_strike_custom")
    if spirit_breaker_nether_strike_custom then
        spirit_breaker_nether_strike_custom:SetHidden(true)
        spirit_breaker_nether_strike_custom:SetActivated(false)
    end
end

function modifier_spirit_breaker_13:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
end

function modifier_spirit_breaker_13:GetModifierAttackSpeedBonus_Constant()
    return self.bonus[self:GetStackCount()]
end