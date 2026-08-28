--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_attack_projectile_speed_upgrade = class(modifier_base_generic_upgrade)

function modifier_generic_attack_projectile_speed_upgrade:RecalculateBonusPerUpgrade()
	self:CalculateBonusPerUpgrade("projectile_speed")
end

function modifier_generic_attack_projectile_speed_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()
end

function modifier_generic_attack_projectile_speed_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end

function modifier_generic_attack_projectile_speed_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS, -- GetModifierProjectileSpeedBonus
	}
end

function modifier_generic_attack_projectile_speed_upgrade:GetModifierProjectileSpeedBonus()
	print("projectile speed bonus:", self.bonus)
	return self.bonus
end