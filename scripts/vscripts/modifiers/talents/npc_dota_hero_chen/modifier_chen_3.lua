--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chen_3=class({})

function modifier_chen_3:IsHidden() return true end
function modifier_chen_3:IsPurgable() return false end
function modifier_chen_3:IsPurgeException() return false end
function modifier_chen_3:RemoveOnDeath() return false end

function modifier_chen_3:OnCreated()
    self.bonus = {2,4}
    self.bonus2 = {30,60}
	if not IsServer() then return end
	self:SetStackCount(1)
    self.armor = 0
    self:SetHasCustomTransmitterData( true )
    self:SendBuffRefreshToClients()
    self:StartIntervalThink(0.1)
end

function modifier_chen_3:OnRefresh()
    self.bonus = {2,4}
    self.bonus2 = {30,60}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_chen_3:AddCustomTransmitterData()
    local data = 
    {
        armor = self.armor,
    }
    return data
end

function modifier_chen_3:HandleCustomTransmitterData( data )
    self.armor = data.armor
end

function modifier_chen_3:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
end

function modifier_chen_3:OnIntervalThink()
    if not IsServer() then return end
    self.armor = self:GetCaster():GetStrength() / 100 * self.bonus[self:GetStackCount()]
    self:SendBuffRefreshToClients()
end

function modifier_chen_3:GetModifierPhysicalArmorBonus()
    return self.armor
end

function modifier_chen_3:GetModifierMoveSpeedBonus_Constant()
    return self.bonus2[self:GetStackCount()]
end