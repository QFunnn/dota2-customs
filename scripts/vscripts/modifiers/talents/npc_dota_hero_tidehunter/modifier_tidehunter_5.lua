--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tidehunter_5=class({})

function modifier_tidehunter_5:IsHidden() return true end
function modifier_tidehunter_5:IsPurgable() return false end
function modifier_tidehunter_5:IsPurgeException() return false end
function modifier_tidehunter_5:RemoveOnDeath() return false end

function modifier_tidehunter_5:OnCreated()
    self.bonus = {0.3,0.6}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_tidehunter_5:OnRefresh()
    self.bonus = {0.3,0.6}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_tidehunter_5:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
	}
end

function modifier_tidehunter_5:GetModifierHealthRegenPercentage()
	return self.bonus[self:GetStackCount()]
end