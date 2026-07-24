--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_fairy=class({})

function modifier_woda_talent_fairy:IsHidden() return true end
function modifier_woda_talent_fairy:IsPurgable() return false end
function modifier_woda_talent_fairy:IsPurgeException() return false end
function modifier_woda_talent_fairy:RemoveOnDeath() return false end

function modifier_woda_talent_fairy:OnCreated()
	self.bonus={15,30}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_woda_talent_fairy:OnRefresh()
	self.bonus={15,30}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_woda_talent_fairy:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING
	}
end

function modifier_woda_talent_fairy:GetModifierPercentageManacostStacking(params)
	return self.bonus[self:GetStackCount()]
end