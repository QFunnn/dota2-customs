--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_lion_6=class({})

function modifier_lion_6:IsHidden() return true end
function modifier_lion_6:IsPurgable() return false end
function modifier_lion_6:IsPurgeException() return false end
function modifier_lion_6:RemoveOnDeath() return false end

function modifier_lion_6:OnCreated()
	if not IsServer() then return end
	self.bonus={6,12,18}
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_lion_6:OnRefresh()
	if not IsServer() then return end
	self.bonus={6,12,18}
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_lion_6:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE
	}
end

function modifier_lion_6:GetModifierExtraHealthPercentage()
	return self.bonus[self:GetStackCount()]
end