--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_visage_16=class({})

function modifier_visage_16:IsHidden() return true end
function modifier_visage_16:IsPurgable() return false end
function modifier_visage_16:IsPurgeException() return false end
function modifier_visage_16:RemoveOnDeath() return false end

function modifier_visage_16:OnCreated()
	self.bonus_intellect = {5,10,15}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
	self:RefreshSoulAssumptionCharges()
end

function modifier_visage_16:OnRefresh()
	self.bonus_intellect = {5,10,15}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
	self:RefreshSoulAssumptionCharges()
end

function modifier_visage_16:RefreshSoulAssumptionCharges()
	local modifier_visage_soul_assumption_custom = self:GetParent():FindModifierByName("modifier_visage_soul_assumption_custom")
	if modifier_visage_soul_assumption_custom then
		modifier_visage_soul_assumption_custom:UpdateCharges()
	end
end

function modifier_visage_16:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end

function modifier_visage_16:GetModifierBonusStats_Intellect()
	return self.bonus_intellect[self:GetStackCount()]
end