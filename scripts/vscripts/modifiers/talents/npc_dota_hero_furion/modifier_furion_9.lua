--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_furion_9=class({})

function modifier_furion_9:IsHidden() return true end
function modifier_furion_9:IsPurgable() return false end
function modifier_furion_9:IsPurgeException() return false end
function modifier_furion_9:RemoveOnDeath() return false end

function modifier_furion_9:OnCreated()
	self.bonus = {5,10,15}
	if not IsServer() then return end
	self:SetStackCount(1)

	----------- Nature call
	local furion_force_of_nature_custom = self:GetParent():FindAbilityByName("furion_force_of_nature_custom")
	if furion_force_of_nature_custom then
		furion_force_of_nature_custom:SetLevel(0)
		furion_force_of_nature_custom:SetActivated(false)
		furion_force_of_nature_custom:SetHidden(true)
		self:GetParent():RemoveModifierByName("modifier_furion_force_of_nature_custom_immortal")
	end
	self:GetParent():CalculateStatBonus(true)
end

function modifier_furion_9:OnRefresh()
	self.bonus = {5,10,15}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_furion_9:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end

function modifier_furion_9:GetModifierBonusStats_Strength()
	if self.bonus == nil and self:GetStackCount() == 0 then return end
	return self.bonus[self:GetStackCount()]
end

function modifier_furion_9:GetModifierBonusStats_Agility()
	if self.bonus == nil and self:GetStackCount() == 0 then return end
	return self.bonus[self:GetStackCount()]
end

function modifier_furion_9:GetModifierBonusStats_Intellect()
	if self.bonus == nil and self:GetStackCount() == 0 then return end
	return self.bonus[self:GetStackCount()]
end