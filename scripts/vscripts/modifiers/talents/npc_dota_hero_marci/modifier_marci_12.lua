--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_marci_12=class({})

function modifier_marci_12:IsHidden() return true end
function modifier_marci_12:IsPurgable() return false end
function modifier_marci_12:IsPurgeException() return false end
function modifier_marci_12:RemoveOnDeath() return false end

function modifier_marci_12:OnCreated()
	if not IsServer() then return end
	self.bonus = 0
	self:SetStackCount(1)
    self:SetHasCustomTransmitterData( true )
    self:SendBuffRefreshToClients()
	self:StartIntervalThink(0.1)
end

function modifier_marci_12:OnRefresh()
	if not IsServer() then return end
	self.bonus = 0
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_marci_12:OnIntervalThink()
	if not IsServer() then return end
	local evasion = (self:GetCaster():GetEvasion() * 100)
    local evasion_bonus = {3,2}
	self.bonus = (evasion / evasion_bonus[self:GetStackCount()]) * 3
    self:SendBuffRefreshToClients()
end

function modifier_marci_12:AddCustomTransmitterData()
    local data = 
    {
        bonus = self.bonus,
    }
    return data
end

function modifier_marci_12:HandleCustomTransmitterData( data )
    self.bonus = data.bonus
end

function modifier_marci_12:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_marci_12:GetModifierAttackSpeedBonus_Constant()
	return self.bonus
end