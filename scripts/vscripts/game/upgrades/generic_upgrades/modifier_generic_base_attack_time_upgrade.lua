--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")

modifier_generic_base_attack_time_upgrade = modifier_generic_base_attack_time_upgrade
	or class(modifier_base_generic_upgrade)

function modifier_generic_base_attack_time_upgrade:RecalculateBonusPerUpgrade()
	self:CalculateBonusPerUpgrade("base_attack_time")
end

function modifier_generic_base_attack_time_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()
end

function modifier_generic_base_attack_time_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end

function modifier_generic_base_attack_time_upgrade:GetBaseAttackTimeDirectBonus()
	return self.bonus
end