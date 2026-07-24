--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_bounty_hunter_19=class({})

function modifier_bounty_hunter_19:IsHidden() return true end
function modifier_bounty_hunter_19:IsPurgable() return false end
function modifier_bounty_hunter_19:IsPurgeException() return false end
function modifier_bounty_hunter_19:RemoveOnDeath() return false end

function modifier_bounty_hunter_19:OnCreated()
	self.bonus={7,14,21}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_bounty_hunter_19:OnRefresh()
	self.bonus={7,14,21}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_bounty_hunter_19:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end

function modifier_bounty_hunter_19:GetModifierBonusStats_Intellect()
	return self.bonus[self:GetStackCount()]
end