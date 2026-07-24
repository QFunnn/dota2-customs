--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_arc_warden_5=class({})

function modifier_arc_warden_5:IsHidden() return true end
function modifier_arc_warden_5:IsPurgable() return false end
function modifier_arc_warden_5:IsPurgeException() return false end
function modifier_arc_warden_5:RemoveOnDeath() return false end

function modifier_arc_warden_5:OnCreated()
    self.bonus = {8,12,16}
	if not IsServer() then return end
	self:SetStackCount(1)
    self.attack_speed = 0
    self:SetHasCustomTransmitterData( true )
    self:SendBuffRefreshToClients()
    self:StartIntervalThink(0.1)
end

function modifier_arc_warden_5:OnRefresh()
    self.bonus = {8,12,16}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_arc_warden_5:AddCustomTransmitterData()
    local data = 
    {
        attack_speed = self.attack_speed,
    }
    return data
end

function modifier_arc_warden_5:HandleCustomTransmitterData( data )
    self.attack_speed = data.attack_speed
end

function modifier_arc_warden_5:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
end

function modifier_arc_warden_5:OnIntervalThink()
    if not IsServer() then return end
    self.attack_speed = ((100-self:GetParent():GetHealthPercent()) / 10) * self.bonus[self:GetStackCount()]
    self:SendBuffRefreshToClients()
end

function modifier_arc_warden_5:GetModifierAttackSpeedBonus_Constant()
    return self.attack_speed
end