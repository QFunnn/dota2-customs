--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_regenhp2=class({})

function modifier_woda_talent_regenhp2:IsHidden() return true end
function modifier_woda_talent_regenhp2:IsPurgable() return false end
function modifier_woda_talent_regenhp2:IsPurgeException() return false end
function modifier_woda_talent_regenhp2:RemoveOnDeath() return false end

function modifier_woda_talent_regenhp2:OnCreated()
	self.bonus={0.3,0.6,0.9}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_woda_talent_regenhp2:OnRefresh()
	self.bonus={0.3,0.6,0.9}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_woda_talent_regenhp2:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
	}
end

function modifier_woda_talent_regenhp2:GetModifierHealthRegenPercentage()
	return self.bonus[self:GetStackCount()]
end