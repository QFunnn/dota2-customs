--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_visage_15=class({})

function modifier_visage_15:IsHidden() return true end
function modifier_visage_15:IsPurgable() return false end
function modifier_visage_15:IsPurgeException() return false end
function modifier_visage_15:RemoveOnDeath() return false end

function modifier_visage_15:OnCreated()
    self.bonus = {10,20}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_visage_15:OnRefresh()
    self.bonus = {10,20}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_visage_15:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
	}
end

function modifier_visage_15:GetModifierPercentageManacostStacking(params)
	return self.bonus[self:GetStackCount()]
end