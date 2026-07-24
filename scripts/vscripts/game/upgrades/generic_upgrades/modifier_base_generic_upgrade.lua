--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- base generic upgrade definition to avoid repetitive code
modifier_base_generic_upgrade = class({bonus=0})


function modifier_base_generic_upgrade:IsHidden() return true end
function modifier_base_generic_upgrade:IsPurgable() return false end
function modifier_base_generic_upgrade:RemoveOnDeath() return false end


function modifier_base_generic_upgrade:RefreshOnLevelGained()
	if not IsServer() then return end

	self.parent = self:GetParent()

	if not self.parent:IsRealHero() or self.parent:IsIllusion() or self.parent:IsClone() or self.parent:GetUnitLabel() == "spirit_bear" then return end

	self.level_gained_listener = EventDriver:Listen("Events:level_gained", function()
		if not self:IsNull() then self:ForceRefresh() end
	end)
end


function modifier_base_generic_upgrade:OnDestroy()
	if not IsServer() then return end

	if self.level_gained_listener then
		EventDriver:CancelListener("Events:level_gained", self.level_gained_listener)
	end
end


function modifier_base_generic_upgrade:RecalculateBonusPerUpgrade()
	self.bonus = 0
end


function modifier_base_generic_upgrade:CalculateBonusPerUpgrade(name, multiplier)
	self.bonus_per_upgrade = self:GetUpgradeValueFor(name)

	local upgrade_data = IsServer() and GenericUpgrades.generic_upgrades_data[self.upgrade_name] or GENERIC_UPGRADES_DATA[self.upgrade_name]

	local upgrade_value = UpgradesUtilities:CalculateUpgradeValue(self.parent, self.bonus_per_upgrade, self:GetStackCount(), upgrade_data)

	local total_upgrade_value = upgrade_value * (multiplier or 1)
	self.bonus = total_upgrade_value

	return total_upgrade_value
end