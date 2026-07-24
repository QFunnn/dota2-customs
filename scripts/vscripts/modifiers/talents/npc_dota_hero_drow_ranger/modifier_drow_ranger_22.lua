--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_drow_ranger_22=class({})

function modifier_drow_ranger_22:IsHidden() return true end
function modifier_drow_ranger_22:IsPurgable() return false end
function modifier_drow_ranger_22:IsPurgeException() return false end
function modifier_drow_ranger_22:RemoveOnDeath() return false end

function modifier_drow_ranger_22:OnCreated()
	if not IsServer() then return end
	self.bonus={15}
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_drow_ranger_22:OnRefresh()
	if not IsServer() then return end
	self.bonus={15}
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_drow_ranger_22:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_EXTRA_MANA_PERCENTAGE
	}
end

function modifier_drow_ranger_22:GetModifierExtraManaPercentage()
	return self.bonus[self:GetStackCount()]
end