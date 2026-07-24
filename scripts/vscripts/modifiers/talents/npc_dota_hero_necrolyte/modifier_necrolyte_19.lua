--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_necrolyte_19=class({})

function modifier_necrolyte_19:IsHidden() return true end
function modifier_necrolyte_19:IsPurgable() return false end
function modifier_necrolyte_19:IsPurgeException() return false end
function modifier_necrolyte_19:RemoveOnDeath() return false end

function modifier_necrolyte_19:OnCreated()
	if not IsServer() then return end
	self.bonus={3,6,9}
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_necrolyte_19:OnRefresh()
	if not IsServer() then return end
	self.bonus={3,6,9}
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_necrolyte_19:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
        MODIFIER_PROPERTY_EXTRA_MANA_PERCENTAGE
	}
end

function modifier_necrolyte_19:GetModifierExtraHealthPercentage()
	return self.bonus[self:GetStackCount()]
end

function modifier_necrolyte_19:GetModifierExtraManaPercentage()
	return self.bonus[self:GetStackCount()]
end