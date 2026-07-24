--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_int4=class({})

function modifier_woda_talent_int4:IsHidden() return true end
function modifier_woda_talent_int4:IsPurgable() return false end
function modifier_woda_talent_int4:IsPurgeException() return false end
function modifier_woda_talent_int4:RemoveOnDeath() return false end

function modifier_woda_talent_int4:OnCreated()
	self.bonus={1}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_woda_talent_int4:OnRefresh()
	self.bonus={1}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_woda_talent_int4:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end

function modifier_woda_talent_int4:GetModifierBonusStats_Intellect()
	return self.bonus[self:GetStackCount()] * self:GetParent():GetLevel()
end