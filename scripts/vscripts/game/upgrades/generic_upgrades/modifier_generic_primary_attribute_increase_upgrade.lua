--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_primary_attribute_increase_upgrade = class(modifier_base_generic_upgrade)


function modifier_generic_primary_attribute_increase_upgrade:RecalculateBonusPerUpgrade()
	self.attribute_increase = self:CalculateBonusPerUpgrade("attribute_increase") / 100
end


function modifier_generic_primary_attribute_increase_upgrade:OnCreated()
	self:RecalculateBonusPerUpgrade()

	self.parent = self:GetParent()

	self._agi = 0
	self._str = 0
	self._int = 0

	-- update current stat count every now and then
	self:StartIntervalThink(0.3)
	self:OnIntervalThink()
end


function modifier_generic_primary_attribute_increase_upgrade:OnRefresh(old_stack_count)
	self:RecalculateBonusPerUpgrade()
end


function modifier_generic_primary_attribute_increase_upgrade:OnIntervalThink()
	self.parent._generic_secondary_lock = true

	self._agi = self.parent:GetAgility()
	self._str = self.parent:GetStrength()
	self._int = self.parent:GetIntellect()

	self.parent._generic_secondary_lock = false

	if IsServer() then
		self.parent:CalculateStatBonus(true)
	end
end


function modifier_generic_primary_attribute_increase_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS, -- GetModifierBonusStats_Strength
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS, -- GetModifierBonusStats_Agility
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS, -- GetModifierBonusStats_Intellect
	}
end


function modifier_generic_primary_attribute_increase_upgrade:GetModifierBonusStats_Strength()
	if self:GetPrimaryAttributeOfParent() == DOTA_ATTRIBUTE_STRENGTH and not self.parent._generic_primary_lock then return self._str * self.attribute_increase end
end


function modifier_generic_primary_attribute_increase_upgrade:GetModifierBonusStats_Agility()
	if self:GetPrimaryAttributeOfParent() == DOTA_ATTRIBUTE_AGILITY  and not self.parent._generic_primary_lock then return self._agi * self.attribute_increase end
end

function modifier_generic_primary_attribute_increase_upgrade:GetModifierBonusStats_Intellect()
	if self:GetPrimaryAttributeOfParent() == DOTA_ATTRIBUTE_INTELLECT  and not self.parent._generic_primary_lock then return self._int * self.attribute_increase end
end