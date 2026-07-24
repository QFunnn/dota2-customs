--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_bounty_hunter_3=class({})

function modifier_bounty_hunter_3:IsHidden() return true end
function modifier_bounty_hunter_3:IsPurgable() return false end
function modifier_bounty_hunter_3:IsPurgeException() return false end
function modifier_bounty_hunter_3:RemoveOnDeath() return false end

function modifier_bounty_hunter_3:OnCreated()
	self.bonus={50,100,150}
	self.bonus2={10,20,30}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_bounty_hunter_3:OnRefresh()
	self.bonus={50,100,150}
	self.bonus2={10,20,30}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_bounty_hunter_3:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
		MODIFIER_PROPERTY_CASTTIME_PERCENTAGE
	}
end

function modifier_bounty_hunter_3:GetModifierCastRangeBonusStacking()
	return self.bonus[self:GetStackCount()]
end

function modifier_bounty_hunter_3:GetModifierPercentageCasttime()
    return self.bonus2[self:GetStackCount()]
end