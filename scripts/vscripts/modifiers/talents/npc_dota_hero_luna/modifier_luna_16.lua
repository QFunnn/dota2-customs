--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_luna_16=class({})

function modifier_luna_16:IsHidden() return true end
function modifier_luna_16:IsPurgable() return false end
function modifier_luna_16:IsPurgeException() return false end
function modifier_luna_16:RemoveOnDeath() return false end

function modifier_luna_16:OnCreated()
    self.bonus = {1,2}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:SetHasCustomTransmitterData(true)
    self.is_night = "0"
    self:StartIntervalThink(1)
    self:SendBuffRefreshToClients()
end

function modifier_luna_16:OnRefresh()
    self.bonus = {1,2}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_luna_16:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
    }
end

function modifier_luna_16:GetModifierConstantHealthRegen()
    if self.is_night == "1" or (self:GetParent():HasModifier("modifier_luna_16") and self:GetParent():HasModifier("modifier_luna_lunar_orbit_custom")) then
        return self:GetParent():GetMaxMana() / 100 * self.bonus[self:GetStackCount()]
    end
end

function modifier_luna_16:OnIntervalThink()
    if not IsServer() then return end
    if not GameRules:IsDaytime() then
        self.is_night = "1"
    else
        self.is_night = "0"
    end
    self:SendBuffRefreshToClients()
end

function modifier_luna_16:AddCustomTransmitterData()
    return 
    {
        is_night = self.is_night,
    }
end

function modifier_luna_16:HandleCustomTransmitterData( data )
    self.is_night = data.is_night
end