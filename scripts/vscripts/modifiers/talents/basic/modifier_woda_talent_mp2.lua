--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_mp2=class({})

function modifier_woda_talent_mp2:IsHidden() return true end
function modifier_woda_talent_mp2:IsPurgable() return false end
function modifier_woda_talent_mp2:IsPurgeException() return false end
function modifier_woda_talent_mp2:RemoveOnDeath() return false end

function modifier_woda_talent_mp2:OnCreated()
	if not IsServer() then return end
	self.bonus={5,10,15}
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_woda_talent_mp2:OnRefresh()
	if not IsServer() then return end
	self.bonus={5,10,15}
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_woda_talent_mp2:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_EXTRA_MANA_PERCENTAGE
	}
end

function modifier_woda_talent_mp2:GetModifierExtraManaPercentage()
	return self.bonus[self:GetStackCount()]
end