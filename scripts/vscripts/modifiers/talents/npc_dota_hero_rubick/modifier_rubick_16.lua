--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rubick_16=class({})

function modifier_rubick_16:IsHidden() return true end
function modifier_rubick_16:IsPurgable() return false end
function modifier_rubick_16:IsPurgeException() return false end
function modifier_rubick_16:RemoveOnDeath() return false end

function modifier_rubick_16:OnCreated()
    self.bonus = 3
    self.bonus2 = {1,2}
	if not IsServer() then return end
	self:SetStackCount(1)
    self.spell_amp = 0
    self:SetHasCustomTransmitterData( true )
    self:SendBuffRefreshToClients()
    self:StartIntervalThink(0.1)
end

function modifier_rubick_16:OnRefresh()
    self.bonus = 3
    self.bonus2 = {1,2}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_rubick_16:AddCustomTransmitterData()
    local data = 
    {
        spell_amp = self.spell_amp,
    }
    return data
end

function modifier_rubick_16:HandleCustomTransmitterData( data )
    self.spell_amp = data.spell_amp
end

function modifier_rubick_16:OnIntervalThink()
    if not IsServer() then return end
    self.spell_amp = (self:GetParent():GetSpellAmplification(false) * 100) / self.bonus
    self:SendBuffRefreshToClients()
end

function modifier_rubick_16:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
    }
end

function modifier_rubick_16:GetModifierBaseAttack_BonusDamage()
    return self.spell_amp * self.bonus2[self:GetStackCount()]
end