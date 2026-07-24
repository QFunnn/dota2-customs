--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_kez_19=class({})

function modifier_kez_19:IsHidden() return true end
function modifier_kez_19:IsPurgable() return false end
function modifier_kez_19:IsPurgeException() return false end
function modifier_kez_19:RemoveOnDeath() return false end

function modifier_kez_19:OnCreated()
	if not IsServer() then return end
	self.bonus={200,400}
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_kez_19:OnRefresh()
	if not IsServer() then return end
	self.bonus={200,400}
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_kez_19:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_HEALTH_BONUS
	}
end

function modifier_kez_19:GetModifierHealthBonus()
	return self.bonus[self:GetStackCount()]
end