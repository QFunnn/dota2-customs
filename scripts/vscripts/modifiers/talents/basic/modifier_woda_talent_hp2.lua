--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_hp2=class({})

function modifier_woda_talent_hp2:IsHidden() return true end
function modifier_woda_talent_hp2:IsPurgable() return false end
function modifier_woda_talent_hp2:IsPurgeException() return false end
function modifier_woda_talent_hp2:RemoveOnDeath() return false end

function modifier_woda_talent_hp2:OnCreated()
	if not IsServer() then return end
	self.bonus={4,8,12}
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_woda_talent_hp2:OnRefresh()
	if not IsServer() then return end
	self.bonus={4,8,12}
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_woda_talent_hp2:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE
	}
end

function modifier_woda_talent_hp2:GetModifierExtraHealthPercentage()
	return self.bonus[self:GetStackCount()]
end