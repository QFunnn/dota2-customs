--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_mp1=class({})

function modifier_woda_talent_mp1:IsHidden() return true end
function modifier_woda_talent_mp1:IsPurgable() return false end
function modifier_woda_talent_mp1:IsPurgeException() return false end
function modifier_woda_talent_mp1:RemoveOnDeath() return false end

function modifier_woda_talent_mp1:OnCreated()
	if not IsServer() then return end
	self.bonus={150,300,450}
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_woda_talent_mp1:OnRefresh()
	if not IsServer() then return end
	self.bonus={150,300,450}
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_woda_talent_mp1:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MANA_BONUS
	}
end

function modifier_woda_talent_mp1:GetModifierManaBonus()
	return self.bonus[self:GetStackCount()]
end