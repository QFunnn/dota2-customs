--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_skywrath_mage_3 = class({})

function modifier_skywrath_mage_3:IsHidden() return true end
function modifier_skywrath_mage_3:IsPurgable() return false end
function modifier_skywrath_mage_3:IsPurgeException() return false end
function modifier_skywrath_mage_3:RemoveOnDeath() return false end

function modifier_skywrath_mage_3:OnCreated()
	self.bonus={10,20,30}
    self.lifesteal = {4,8,12}
	if not IsServer() then return end
	self:SetHasCustomTransmitterData(true)
	self.mana_regen = 0
	self:SetStackCount(1)
	self:StartIntervalThink(0.1)
end

function modifier_skywrath_mage_3:OnRefresh()
	self.bonus={10,20,30}
    self.lifesteal = {4,8,12}
	if not IsServer() then return end
	self:SendBuffRefreshToClients()
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_skywrath_mage_3:OnIntervalThink()
	if not IsServer() then return end
	self.mana_regen = self:GetParent():GetHealthRegen() / 100 * self.bonus[self:GetStackCount()]
	self:SendBuffRefreshToClients()
end

function modifier_skywrath_mage_3:AddCustomTransmitterData()
    return {
        mana_regen = self.mana_regen,
    }
end

function modifier_skywrath_mage_3:HandleCustomTransmitterData( data )
    self.mana_regen = data.mana_regen
end

function modifier_skywrath_mage_3:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MAGICAL_LIFESTEAL
	}
end

function modifier_skywrath_mage_3:GetModifierProperty_MagicalLifesteal(params)
    return self.lifesteal[self:GetStackCount()]
end

function modifier_skywrath_mage_3:GetModifierConstantManaRegen()
	return self.mana_regen
end