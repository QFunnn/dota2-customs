--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_armor1=class({})

function modifier_woda_talent_armor1:IsHidden() return true end
function modifier_woda_talent_armor1:IsPurgable() return false end
function modifier_woda_talent_armor1:IsPurgeException() return false end
function modifier_woda_talent_armor1:RemoveOnDeath() return false end

function modifier_woda_talent_armor1:OnCreated()
	self.bonus={3,6,9}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_woda_talent_armor1:OnRefresh()
	self.bonus={3,6,9}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_woda_talent_armor1:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
end

function modifier_woda_talent_armor1:GetModifierPhysicalArmorBonus()
	return self.bonus[self:GetStackCount()]
end