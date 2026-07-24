--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_health_regen_upgrade = class(modifier_base_generic_upgrade)

function modifier_generic_health_regen_upgrade:RecalculateBonusPerUpgrade()
	self:CalculateBonusPerUpgrade("health_regen")
end

function modifier_generic_health_regen_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()
end

function modifier_generic_health_regen_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_health_regen_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end


function modifier_generic_health_regen_upgrade:GetModifierConstantHealthRegen()
	return self.bonus
end