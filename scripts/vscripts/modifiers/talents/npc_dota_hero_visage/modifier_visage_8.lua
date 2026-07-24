--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_visage_8=class({})

function modifier_visage_8:IsHidden() return true end
function modifier_visage_8:IsPurgable() return false end
function modifier_visage_8:IsPurgeException() return false end
function modifier_visage_8:RemoveOnDeath() return false end

function modifier_visage_8:OnCreated()
	self.bonus={5,10}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_visage_8:OnRefresh()
	self.bonus={5,10}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_visage_8:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
	}
end

function modifier_visage_8:GetModifierBonusStats_Strength()
	return self.bonus[self:GetStackCount()]
end