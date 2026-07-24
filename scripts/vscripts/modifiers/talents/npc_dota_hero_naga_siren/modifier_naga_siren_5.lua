--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_naga_siren_5=class({})

function modifier_naga_siren_5:IsHidden() return true end
function modifier_naga_siren_5:IsPurgable() return false end
function modifier_naga_siren_5:IsPurgeException() return false end
function modifier_naga_siren_5:RemoveOnDeath() return false end

function modifier_naga_siren_5:OnCreated()
	if not IsServer() then return end
	self.bonus={400}
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_naga_siren_5:OnRefresh()
	if not IsServer() then return end
	self.bonus={400}
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_naga_siren_5:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_HEALTH_BONUS
	}
end

function modifier_naga_siren_5:GetModifierHealthBonus()
	return self.bonus[self:GetStackCount()]
end