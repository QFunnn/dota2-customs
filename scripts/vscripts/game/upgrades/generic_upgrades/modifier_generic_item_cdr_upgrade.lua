--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_item_cdr_upgrade = class(modifier_base_generic_upgrade)

function modifier_generic_item_cdr_upgrade:RecalculateBonusPerUpgrade()
	self:CalculateBonusPerUpgrade("cooldown_reduction")
end

function modifier_generic_item_cdr_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()
end

function modifier_generic_item_cdr_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_item_cdr_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
	}
end


function modifier_generic_item_cdr_upgrade:GetModifierPercentageCooldown(params)
	if not self:GetParent():FindAbilityByName(params.ability:GetAbilityName()) then
		return self.bonus
	end

	return 0
end