--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_attack_range_upgrade = class(modifier_base_generic_upgrade)

function modifier_generic_attack_range_upgrade:RecalculateBonusPerUpgrade()
	-- This will have minor problems with Troll Warlord
	-- Not sure about the best way to efficiently refresh this bonus
	if self:GetParent():IsRangedAttacker() then
		self:CalculateBonusPerUpgrade("range_increase_ranged")
	else
		self:CalculateBonusPerUpgrade("range_increase_melee")
	end
end

function modifier_generic_attack_range_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()
end

function modifier_generic_attack_range_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_attack_range_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	}
end


function modifier_generic_attack_range_upgrade:GetModifierAttackRangeBonus()
	return self.bonus
end