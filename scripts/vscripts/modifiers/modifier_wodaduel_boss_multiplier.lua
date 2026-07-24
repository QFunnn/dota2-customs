--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_wodaduel_boss_multiplier = class({})

function modifier_wodaduel_boss_multiplier:IsHidden() return true end
function modifier_wodaduel_boss_multiplier:IsPurgable() return false end

function modifier_wodaduel_boss_multiplier:OnCreated(data)
	if not IsServer() then return end
	self:SetStackCount(data.players)
    local multipliers = 
    {
        ["health"] = {1,1.75,2.5,3.25},
        ["damage"] = {1,1.15,1.3,1.45},
        ["status"] = {0,7.5,15,22.5}
    }
	self:GetParent():SetBaseDamageMin(self:GetParent():GetBaseDamageMin() * multipliers["damage"][self:GetStackCount()])
    self:GetParent():SetBaseDamageMax(self:GetParent():GetBaseDamageMax() * multipliers["damage"][self:GetStackCount()])
    self:GetParent():SetBaseMaxHealth(self:GetParent():GetMaxHealth() * multipliers["health"][self:GetStackCount()])
    self:GetParent():SetHealth(self:GetParent():GetMaxHealth())
    self.status_resist = multipliers["status"][self:GetStackCount()]
	self:SetHasCustomTransmitterData(true)
    self:StartIntervalThink(0.1)
end

function modifier_wodaduel_boss_multiplier:OnIntervalThink()
    if not IsServer() then return end
    self:SendBuffRefreshToClients()
end

function modifier_wodaduel_boss_multiplier:AddCustomTransmitterData()
    return 
    {
        status_resist = self.status_resist,
    }
end

function modifier_wodaduel_boss_multiplier:HandleCustomTransmitterData( data )
    self.status_resist = data.status_resist
end

function modifier_wodaduel_boss_multiplier:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
	}
end

function modifier_wodaduel_boss_multiplier:GetModifierStatusResistanceStacking()
	return self.status_resist
end