--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_antimage_17=class({})

function modifier_antimage_17:IsHidden() return true end
function modifier_antimage_17:IsPurgable() return false end
function modifier_antimage_17:IsPurgeException() return false end
function modifier_antimage_17:RemoveOnDeath() return false end

function modifier_antimage_17:OnCreated()
	self.bonus={18,36}
	self.bonus2={125,250}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_antimage_17:OnRefresh()
	self.bonus={18,36}
	self.bonus2={125,250}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_antimage_17:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS
	}
end

function modifier_antimage_17:GetModifierPercentageManacostStacking(params)
	return self.bonus[self:GetStackCount()]
end

function modifier_antimage_17:GetModifierHealthBonus()
	return self.bonus2[self:GetStackCount()]
end

function modifier_antimage_17:GetModifierManaBonus()
	return self.bonus2[self:GetStackCount()]
end