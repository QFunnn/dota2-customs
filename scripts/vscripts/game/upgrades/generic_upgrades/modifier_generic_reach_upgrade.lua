--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_reach_upgrade = class(modifier_base_generic_upgrade)


function modifier_generic_reach_upgrade:RecalculateBonusPerUpgrade()
	self.cast_range = self:CalculateBonusPerUpgrade("cast_range")

	local attack_range_variable_name = self:GetParent():IsRangedAttacker() and "range_increase_ranged" or "range_increase_melee"

	self.attack_range = self:CalculateBonusPerUpgrade(attack_range_variable_name)
end


function modifier_generic_reach_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_reach_upgrade:OnRefresh()
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_reach_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	}
end


function modifier_generic_reach_upgrade:GetModifierCastRangeBonusStacking()
	return self.cast_range
end


function modifier_generic_reach_upgrade:GetModifierAttackRangeBonus()
	return self.attack_range
end