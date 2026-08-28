--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_armor_upgrade = class(modifier_base_generic_upgrade)

function modifier_generic_armor_upgrade:RecalculateBonusPerUpgrade()
	self:CalculateBonusPerUpgrade("armor")
end

function modifier_generic_armor_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()
end

function modifier_generic_armor_upgrade:OnRefresh()
	self:RecalculateBonusPerUpgrade()
end

function modifier_generic_armor_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_generic_armor_upgrade:GetModifierPhysicalArmorBonus()
	return self.bonus
end