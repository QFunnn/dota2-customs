--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_axe_7=class({})

function modifier_axe_7:IsHidden() return true end
function modifier_axe_7:IsPurgable() return false end
function modifier_axe_7:IsPurgeException() return false end
function modifier_axe_7:RemoveOnDeath() return false end

function modifier_axe_7:OnCreated()
	self.bonus={15}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_axe_7:OnRefresh()
	self.bonus={15}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_axe_7:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
end

function modifier_axe_7:GetModifierPhysicalArmorBonus()
	return self.bonus[self:GetStackCount()]
end