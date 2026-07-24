--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_secondary_attributes_upgrade = class(modifier_base_generic_upgrade)

function modifier_generic_secondary_attributes_upgrade:RecalculateBonusPerUpgrade()
	self:CalculateBonusPerUpgrade("attributes")
end

function modifier_generic_secondary_attributes_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()
end

function modifier_generic_secondary_attributes_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_secondary_attributes_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end


function modifier_generic_secondary_attributes_upgrade:GetModifierBonusStats_Strength()
	if self:GetPrimaryAttributeOfParent() ~= DOTA_ATTRIBUTE_STRENGTH then
		return self.bonus
	end
end

function modifier_generic_secondary_attributes_upgrade:GetModifierBonusStats_Agility()
	if self:GetPrimaryAttributeOfParent() ~= DOTA_ATTRIBUTE_AGILITY then
		return self.bonus
	end
end

function modifier_generic_secondary_attributes_upgrade:GetModifierBonusStats_Intellect()
	if self:GetPrimaryAttributeOfParent() ~= DOTA_ATTRIBUTE_INTELLECT then
		return self.bonus
	end
end