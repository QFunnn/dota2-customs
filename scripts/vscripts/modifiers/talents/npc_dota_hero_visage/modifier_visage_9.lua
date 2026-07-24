--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_visage_9=class({})

function modifier_visage_9:IsHidden() return true end
function modifier_visage_9:IsPurgable() return false end
function modifier_visage_9:IsPurgeException() return false end
function modifier_visage_9:RemoveOnDeath() return false end

function modifier_visage_9:OnCreated()
	self.bonus={5,10}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_visage_9:OnRefresh()
	self.bonus={5,10}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_visage_9:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS
	}
end

function modifier_visage_9:GetModifierBonusStats_Agility()
	return self.bonus[self:GetStackCount()]
end