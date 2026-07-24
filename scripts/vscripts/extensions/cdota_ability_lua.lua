--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function CDOTA_Ability_Lua:GetUpgradeValueFor(value_name)
	if self.upgrade_values and self.upgrade_values[value_name] then return self.upgrade_values[value_name] end

	if not self.upgrade_name then
		local name = self:GetAbilityName()
		self.upgrade_name = name:gsub("modifier_", ""):gsub("_upgrade", "")
	end

	if not GenericUpgrades.generic_upgrades_data[self.upgrade_name] then return end

	self.upgrade_values = self.upgrade_values or {}

	self.upgrade_values[value_name] = GenericUpgrades.generic_upgrades_data[self.upgrade_name]["specials"][value_name]
	return self.upgrade_values[value_name]
end