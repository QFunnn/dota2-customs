--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_cloak=class({})

function modifier_woda_talent_cloak:IsHidden() return true end
function modifier_woda_talent_cloak:IsPurgable() return false end
function modifier_woda_talent_cloak:IsPurgeException() return false end
function modifier_woda_talent_cloak:RemoveOnDeath() return false end

function modifier_woda_talent_cloak:OnCreated()
	self.bonus={6,12}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_woda_talent_cloak:OnRefresh()
	self.bonus={6,12}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_woda_talent_cloak:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
end

function modifier_woda_talent_cloak:GetModifierMagicalResistanceBonus()
	return self.bonus[self:GetStackCount()]
end