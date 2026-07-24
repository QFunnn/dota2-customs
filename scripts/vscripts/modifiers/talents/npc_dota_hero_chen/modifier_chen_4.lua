--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chen_4=class({})

function modifier_chen_4:IsHidden() return true end
function modifier_chen_4:IsPurgable() return false end
function modifier_chen_4:IsPurgeException() return false end
function modifier_chen_4:RemoveOnDeath() return false end

function modifier_chen_4:OnCreated()
    self.bonus = {10,20,30}
	if not IsServer() then return end
	self:SetStackCount(1)
    self.damage = 0
    self:SetHasCustomTransmitterData( true )
    self:SendBuffRefreshToClients()
    self:StartIntervalThink(0.1)
end

function modifier_chen_4:OnRefresh()
    self.bonus = {10,20,30}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_chen_4:AddCustomTransmitterData()
    local data = 
    {
        damage = self.damage,
    }
    return data
end

function modifier_chen_4:HandleCustomTransmitterData( data )
    self.damage = data.damage
end

function modifier_chen_4:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
end

function modifier_chen_4:OnIntervalThink()
    if not IsServer() then return end
    self.damage = self:GetCaster():GetStrength() / 100 * self.bonus[self:GetStackCount()]
    self:SendBuffRefreshToClients()
end

function modifier_chen_4:GetModifierPreAttack_BonusDamage()
    return self.damage
end