--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_oracle_4=class({})

function modifier_oracle_4:IsHidden() return true end
function modifier_oracle_4:IsPurgable() return false end
function modifier_oracle_4:IsPurgeException() return false end
function modifier_oracle_4:RemoveOnDeath() return false end

function modifier_oracle_4:OnCreated()
	if not IsServer() then return end
	self:SetHasCustomTransmitterData(true)
	self.bonus={-3,-6,-9}
	self.bonus2={12,8,4}
	self:SetStackCount(1)
	self.amp = 0
	self:GetParent():CalculateStatBonus(true)
	self:StartIntervalThink(0.1)
end

function modifier_oracle_4:OnRefresh()
	if not IsServer() then return end
	self.bonus={-3,-6,-9}
	self.bonus2={12,8,4}
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_oracle_4:OnIntervalThink()
	if not IsServer() then return end
	self.amp = self:GetParent():GetStrength() / self.bonus2[self:GetStackCount()]
	self:GetParent():CalculateStatBonus(true)
	self:SendBuffRefreshToClients()
end

function modifier_oracle_4:AddCustomTransmitterData()
    return 
    {
        amp = self.amp,
    }
end

function modifier_oracle_4:HandleCustomTransmitterData( data )
    self.amp = data.amp
end

function modifier_oracle_4:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
	}
end

function modifier_oracle_4:GetModifierExtraHealthPercentage()
	return self.bonus[self:GetStackCount()]
end

function modifier_oracle_4:GetModifierSpellAmplify_Percentage()
	return self.amp
end
	