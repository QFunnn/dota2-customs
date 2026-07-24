--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function CDOTA_Modifier_Lua:GetUpgradeValueFor(value_name)
	if self.upgrade_values and self.upgrade_values[value_name] then return self.upgrade_values[value_name] end

	if not self.upgrade_name then
		local name = self:GetName()
		self.upgrade_name = name:gsub("modifier_", ""):gsub("_upgrade", "")
	end

	if not GENERIC_UPGRADES_DATA[self.upgrade_name] then return end

	local generic_boost = 100
	local rarity = GENERIC_UPGRADES_DATA[self.upgrade_name]["Rarity"]
	local specials = GENERIC_UPGRADES_DATA[self.upgrade_name]["specials"]

	if self:GetParent() then
		if rarity == "common" and self:GetParent():HasModifier("modifier_generic_common_stat_boost_upgrade_handler") then
			generic_boost = generic_boost + self:GetParent():GetModifierStackCount("modifier_generic_common_stat_boost_upgrade_handler", self:GetParent())
		end

		if rarity == "rare" and self:GetParent():HasModifier("modifier_generic_rare_stat_boost_upgrade_handler") then
			generic_boost = generic_boost + self:GetParent():GetModifierStackCount("modifier_generic_rare_stat_boost_upgrade_handler", self:GetParent())
		end
	end

	local base_value = specials[value_name]
	local base_boosted_value = base_value * generic_boost / 100

--	print("[CLIENT]: Upgrade (name, boost, pre, post):", value_name, generic_boost, base_value, base_boosted_value)
	return base_boosted_value
end


function CDOTA_Modifier_Lua:GetPrimaryAttributeOfParent()
	return self:GetParent():GetModifierStackCount("modifier_primary_attribute_reader", self:GetParent())
end


print("CLIENT EXTENTION LOADED IN")
print(IsClient(), CDOTA_Modifier_Lua, CDOTA_Modifier_Lua.GetUpgradeValueFor, C_DOTA_Modifier_Lua)