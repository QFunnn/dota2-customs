--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_earthshaker_3=class({})

function modifier_earthshaker_3:IsHidden() return true end
function modifier_earthshaker_3:IsPurgable() return false end
function modifier_earthshaker_3:IsPurgeException() return false end
function modifier_earthshaker_3:RemoveOnDeath() return false end

function modifier_earthshaker_3:OnCreated()
	self.bonus={8,16}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_earthshaker_3:OnRefresh()
	self.bonus={8,16}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_earthshaker_3:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
	}
end

function modifier_earthshaker_3:GetModifierStatusResistanceStacking()
	return self.bonus[self:GetStackCount()]
end