--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_sliver=class({})

function modifier_woda_talent_sliver:IsHidden() return true end
function modifier_woda_talent_sliver:IsPurgable() return false end
function modifier_woda_talent_sliver:IsPurgeException() return false end
function modifier_woda_talent_sliver:RemoveOnDeath() return false end

function modifier_woda_talent_sliver:OnCreated()
	self.bonus={10,20}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_woda_talent_sliver:OnRefresh()
	self.bonus={10,20}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_woda_talent_sliver:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
	}
end

function modifier_woda_talent_sliver:GetModifierStatusResistanceStacking()
	return self.bonus[self:GetStackCount()]
end