--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_techies_5=class({})

function modifier_techies_5:IsHidden() return true end
function modifier_techies_5:IsPurgable() return false end
function modifier_techies_5:IsPurgeException() return false end
function modifier_techies_5:RemoveOnDeath() return false end

function modifier_techies_5:OnCreated()
    self.bonus = {5,3}
	if not IsServer() then return end
	self:SetStackCount(1)
    self.spell_amp = 0
    self:SetHasCustomTransmitterData( true )
    self:SendBuffRefreshToClients()
    self:StartIntervalThink(0.1)
end

function modifier_techies_5:OnRefresh()
    self.bonus = {5,3}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_techies_5:AddCustomTransmitterData()
    local data = 
    {
        spell_amp = self.spell_amp,
    }
    return data
end

function modifier_techies_5:HandleCustomTransmitterData( data )
    self.spell_amp = data.spell_amp
end

function modifier_techies_5:OnIntervalThink()
    if not IsServer() then return end
    self.spell_amp = ((self:GetParent():GetMaxHealth() - self:GetParent():GetHealth()) / self:GetParent():GetMaxHealth() * 100) / self.bonus[self:GetStackCount()]
    self:SendBuffRefreshToClients()
end

function modifier_techies_5:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
    }
end

function modifier_techies_5:GetModifierSpellAmplify_Percentage()
    return self.spell_amp * 1
end