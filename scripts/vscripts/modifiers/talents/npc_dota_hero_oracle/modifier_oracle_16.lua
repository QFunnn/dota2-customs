--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_oracle_16=class({})

function modifier_oracle_16:IsHidden() return true end
function modifier_oracle_16:IsPurgable() return false end
function modifier_oracle_16:IsPurgeException() return false end
function modifier_oracle_16:RemoveOnDeath() return false end

function modifier_oracle_16:OnCreated()
	self.bonus = {3,6,9}
	self.bonus2 = {2,4,6}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_oracle_16:OnRefresh()
	self.bonus = {3,6,9}
	self.bonus2 = {2,4,6}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_oracle_16:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_oracle_16:GetModifierMagicalResistanceBonus()
	return self.bonus[self:GetStackCount()]
end

function modifier_oracle_16:GetModifierPhysicalArmorBonus()
	return self.bonus2[self:GetStackCount()]
end