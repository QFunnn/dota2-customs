--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_vision_radius_upgrade = class(modifier_base_generic_upgrade)


function modifier_generic_vision_radius_upgrade:RecalculateBonusPerUpgrade()
	self.day_vision = self:CalculateBonusPerUpgrade("day_vision")
	self.night_vision = self:CalculateBonusPerUpgrade("night_vision")
end


function modifier_generic_vision_radius_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_vision_radius_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_vision_radius_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_BONUS_DAY_VISION, -- GetBonusDayVision
		MODIFIER_PROPERTY_BONUS_NIGHT_VISION, -- GetBonusNightVision
	}
end


function modifier_generic_vision_radius_upgrade:GetBonusDayVision()
	return self.day_vision
end


function modifier_generic_vision_radius_upgrade:GetBonusNightVision()
	return self.night_vision
end