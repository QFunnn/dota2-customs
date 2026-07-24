--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_all_attributes_per_level_upgrade = class(modifier_base_generic_upgrade)

function modifier_generic_all_attributes_per_level_upgrade:RecalculateBonusPerUpgrade()
	self:CalculateBonusPerUpgrade("attributes_gain", self:GetParent():GetLevel())
end

function modifier_generic_all_attributes_per_level_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()

	self:RefreshOnLevelGained()
end

function modifier_generic_all_attributes_per_level_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_all_attributes_per_level_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
end


function modifier_generic_all_attributes_per_level_upgrade:GetModifierBonusStats_Strength()
	return self.bonus
end

function modifier_generic_all_attributes_per_level_upgrade:GetModifierBonusStats_Agility()
	return self.bonus
end

function modifier_generic_all_attributes_per_level_upgrade:GetModifierBonusStats_Intellect()
	return self.bonus
end