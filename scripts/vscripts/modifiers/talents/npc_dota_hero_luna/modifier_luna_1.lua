--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_luna_1=class({})

function modifier_luna_1:IsHidden() return true end
function modifier_luna_1:IsPurgable() return false end
function modifier_luna_1:IsPurgeException() return false end
function modifier_luna_1:RemoveOnDeath() return false end

function modifier_luna_1:OnCreated()
    self.bonus = {8,16}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:SetHasCustomTransmitterData(true)
    self.is_night = "0"
    self:StartIntervalThink(1)
    self:SendBuffRefreshToClients()
end

function modifier_luna_1:OnRefresh()
    self.bonus = {8,16}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_luna_1:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
end

function modifier_luna_1:GetModifierPreAttack_BonusDamage()
    if self.is_night == "1" or (self:GetParent():HasModifier("modifier_luna_16") and self:GetParent():HasModifier("modifier_luna_lunar_orbit_custom")) then
        return self.bonus[self:GetStackCount()] * 2
    else
        return self.bonus[self:GetStackCount()]
    end
end

function modifier_luna_1:OnIntervalThink()
    if not IsServer() then return end
    if not GameRules:IsDaytime() then
        self.is_night = "1"
    else
        self.is_night = "0"
    end
    self:SendBuffRefreshToClients()
end

function modifier_luna_1:AddCustomTransmitterData()
    return 
    {
        is_night = self.is_night,
    }
end

function modifier_luna_1:HandleCustomTransmitterData( data )
    self.is_night = data.is_night
end