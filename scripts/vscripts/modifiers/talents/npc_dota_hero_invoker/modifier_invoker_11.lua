--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_invoker_11=class({})

function modifier_invoker_11:IsHidden() return true end
function modifier_invoker_11:IsPurgable() return false end
function modifier_invoker_11:IsPurgeException() return false end
function modifier_invoker_11:RemoveOnDeath() return false end

function modifier_invoker_11:OnCreated()
	self.bonus={10,20}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_invoker_11:OnRefresh()
	self.bonus={10,20}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_invoker_11:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS
	}
end

function modifier_invoker_11:GetModifierBonusStats_Agility()
	return self.bonus[self:GetStackCount()]
end