--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_lich_1=class({})

function modifier_lich_1:IsHidden() return true end
function modifier_lich_1:IsPurgable() return false end
function modifier_lich_1:IsPurgeException() return false end
function modifier_lich_1:RemoveOnDeath() return false end

function modifier_lich_1:OnCreated()
	self.bonus={70,140,210}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_lich_1:OnRefresh()
	self.bonus={70,140,210}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_lich_1:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_HEALTH_BONUS
	}
end

function modifier_lich_1:GetModifierHealthBonus()
	return self.bonus[self:GetStackCount()]
end