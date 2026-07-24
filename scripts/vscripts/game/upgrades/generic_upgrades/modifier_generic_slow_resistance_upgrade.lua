--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_slow_resistance_upgrade = modifier_generic_slow_resistance_upgrade or class(modifier_base_generic_upgrade)


function modifier_generic_slow_resistance_upgrade:RecalculateBonusPerUpgrade()
	self:CalculateBonusPerUpgrade("slow_res")
end

function modifier_generic_slow_resistance_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()
end

function modifier_generic_slow_resistance_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_slow_resistance_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING, -- GetModifierSlowResistance_Stacking
	}
end


function modifier_generic_slow_resistance_upgrade:GetModifierSlowResistance_Stacking()
	return self.bonus
end