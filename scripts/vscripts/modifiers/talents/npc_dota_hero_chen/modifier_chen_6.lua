--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chen_6=class({})

function modifier_chen_6:IsHidden() return true end
function modifier_chen_6:IsPurgable() return false end
function modifier_chen_6:IsPurgeException() return false end
function modifier_chen_6:RemoveOnDeath() return false end

function modifier_chen_6:OnCreated()
    self.bonus = {250,300,350}
	if not IsServer() then return end
	self:SetStackCount(1)
    self.damage = 0
    self:SetHasCustomTransmitterData( true )
    self:SendBuffRefreshToClients()
    self:StartIntervalThink(0.1)
end

function modifier_chen_6:OnRefresh()
    self.bonus = {250,300,350}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_chen_6:AddCustomTransmitterData()
    local data = 
    {
        damage = self.damage,
    }
    return data
end

function modifier_chen_6:HandleCustomTransmitterData( data )
    self.damage = data.damage
end

function modifier_chen_6:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
end

function modifier_chen_6:OnIntervalThink()
    if not IsServer() then return end
    self.damage = (self:GetParent():GetDisplayAttackSpeed() * -1) + (self.bonus[self:GetStackCount()])
    self:SendBuffRefreshToClients()
end

function modifier_chen_6:GetModifierPreAttack_BonusDamage()
    return self.damage
end