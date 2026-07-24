--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_bounty_hunter_2=class({})

function modifier_bounty_hunter_2:IsHidden() return true end
function modifier_bounty_hunter_2:IsPurgable() return false end
function modifier_bounty_hunter_2:IsPurgeException() return false end
function modifier_bounty_hunter_2:RemoveOnDeath() return false end

function modifier_bounty_hunter_2:OnCreated()
	self.bonus={0,8,16}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_bounty_hunter_2:OnRefresh()
	self.bonus={0,8,16}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_bounty_hunter_2:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
	}
end

function modifier_bounty_hunter_2:GetModifierBonusStats_Strength()
	return self.bonus[self:GetStackCount()]
end