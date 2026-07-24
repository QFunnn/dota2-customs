--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_cast_range_upgrade = class(modifier_base_generic_upgrade)

function modifier_generic_cast_range_upgrade:RecalculateBonusPerUpgrade()
	self:CalculateBonusPerUpgrade("cast_range")
end

function modifier_generic_cast_range_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()
end

function modifier_generic_cast_range_upgrade:OnRefresh()
	self:RecalculateBonusPerUpgrade()
end

function modifier_generic_cast_range_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
	}
end

function modifier_generic_cast_range_upgrade:GetModifierCastRangeBonusStacking()
	return self.bonus
end