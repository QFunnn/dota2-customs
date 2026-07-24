--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rubick_9=class({})

function modifier_rubick_9:IsHidden() return true end
function modifier_rubick_9:IsPurgable() return false end
function modifier_rubick_9:IsPurgeException() return false end
function modifier_rubick_9:RemoveOnDeath() return false end

function modifier_rubick_9:OnCreated()
    self.bonus = {30,20}
    self.bonus2 = 1
	if not IsServer() then return end
	self:SetStackCount(1)
    self.attack_speed = 0
    self:SetHasCustomTransmitterData( true )
    self:SendBuffRefreshToClients()
    self:StartIntervalThink(0.1)
end

function modifier_rubick_9:OnRefresh()
    self.bonus = {30,20}
    self.bonus2 = 1
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_rubick_9:AddCustomTransmitterData()
    local data = 
    {
        attack_speed = self.attack_speed,
    }
    return data
end

function modifier_rubick_9:HandleCustomTransmitterData( data )
    self.attack_speed = data.attack_speed
end

function modifier_rubick_9:OnIntervalThink()
    if not IsServer() then return end
    self.attack_speed = self:GetParent():GetDisplayAttackSpeed() / self.bonus[self:GetStackCount()]
    self:SendBuffRefreshToClients()
end

function modifier_rubick_9:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    }
end

function modifier_rubick_9:GetModifierSpellAmplify_Percentage()
    return self.attack_speed * self.bonus2
end