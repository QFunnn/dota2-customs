--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_critical_strike_upgrade = class(modifier_base_generic_upgrade)


function modifier_generic_critical_strike_upgrade:RecalculateBonusPerUpgrade()
	self.crit_chance = self:GetUpgradeValueFor("fixed_crit_chance")

	self.crit_base = self:GetUpgradeValueFor("fixed_crit_damage_base")
	self.crit_bonus = self:CalculateBonusPerUpgrade("crit_damage_bonus")

	self.crit_damage = self.crit_base + self.crit_bonus
end


function modifier_generic_critical_strike_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_critical_strike_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_critical_strike_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE, -- GetModifierPreAttack_CriticalStrike
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK, -- GetModifierProcAttack_Feedback
	}
end


function modifier_generic_critical_strike_upgrade:GetCritDamage()
	return self.crit_damage / 100
end


function modifier_generic_critical_strike_upgrade:GetModifierPreAttack_CriticalStrike(params)
	if RollPercentage(self.crit_chance) then
		self._record = params.record
		return self.crit_damage
	end
end


function modifier_generic_critical_strike_upgrade:GetModifierProcAttack_Feedback(params)
	if params.record and params.record == self._record and IsValidEntity(params.target) then
		params.target:EmitSound("DOTA_Item.Daedelus.Crit")
	end
end