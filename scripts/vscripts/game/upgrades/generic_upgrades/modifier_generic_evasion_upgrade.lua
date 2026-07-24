--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_evasion_upgrade = class(modifier_base_generic_upgrade)

function modifier_generic_evasion_upgrade:RecalculateBonusPerUpgrade()
	self:CalculateBonusPerUpgrade("evasion")
end

function modifier_generic_evasion_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()
end

function modifier_generic_evasion_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_evasion_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_EVASION_CONSTANT,
	}
end


function modifier_generic_evasion_upgrade:GetModifierEvasion_Constant()
	return self.bonus
end