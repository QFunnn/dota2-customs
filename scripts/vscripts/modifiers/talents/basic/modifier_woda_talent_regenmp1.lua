--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_regenmp1=class({})

function modifier_woda_talent_regenmp1:IsHidden() return true end
function modifier_woda_talent_regenmp1:IsPurgable() return false end
function modifier_woda_talent_regenmp1:IsPurgeException() return false end
function modifier_woda_talent_regenmp1:RemoveOnDeath() return false end

function modifier_woda_talent_regenmp1:OnCreated()
	self.bonus={5,10}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_woda_talent_regenmp1:OnRefresh()
	self.bonus={5,10}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_woda_talent_regenmp1:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
	}
end

function modifier_woda_talent_regenmp1:GetModifierConstantManaRegen()
	return self.bonus[self:GetStackCount()]
end