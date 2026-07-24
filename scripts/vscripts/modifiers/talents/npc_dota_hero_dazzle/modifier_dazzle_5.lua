--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_dazzle_5=class({})

function modifier_dazzle_5:IsHidden() return true end
function modifier_dazzle_5:IsPurgable() return false end
function modifier_dazzle_5:IsPurgeException() return false end
function modifier_dazzle_5:RemoveOnDeath() return false end

function modifier_dazzle_5:OnCreated()
	self.bonus={20,40}
	if not IsServer() then return end
	self:SetHasCustomTransmitterData(true)
	self.mana_regen = 0
	self:SetStackCount(1)
	self:StartIntervalThink(0.1)
end

function modifier_dazzle_5:OnRefresh()
	self.bonus={20,40}
	if not IsServer() then return end
	self:SendBuffRefreshToClients()
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_dazzle_5:OnIntervalThink()
	if not IsServer() then return end
	self.mana_regen = self:GetParent():GetHealthRegen() / 100 * self.bonus[self:GetStackCount()]
	self:SendBuffRefreshToClients()
end

function modifier_dazzle_5:AddCustomTransmitterData()
    return {
        mana_regen = self.mana_regen,
    }
end

function modifier_dazzle_5:HandleCustomTransmitterData( data )
    self.mana_regen = data.mana_regen
end

function modifier_dazzle_5:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
	}
end

function modifier_dazzle_5:GetModifierConstantManaRegen()
	return self.mana_regen
end