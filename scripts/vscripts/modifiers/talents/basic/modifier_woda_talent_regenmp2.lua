--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_regenmp2=class({})

function modifier_woda_talent_regenmp2:IsHidden() return true end
function modifier_woda_talent_regenmp2:IsPurgable() return false end
function modifier_woda_talent_regenmp2:IsPurgeException() return false end
function modifier_woda_talent_regenmp2:RemoveOnDeath() return false end

function modifier_woda_talent_regenmp2:OnCreated()
	self.bonus={0.5,1,1.5}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_woda_talent_regenmp2:OnRefresh()
	self.bonus={0.5,1,1.5}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_woda_talent_regenmp2:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE
	}
end

function modifier_woda_talent_regenmp2:GetModifierTotalPercentageManaRegen()
	return self.bonus[self:GetStackCount()]
end