--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Independent Stacks
function CDOTA_Modifier_Lua:AddIndependentStacks(stacks, duration, limit, remove_on_expire)
	self.independent_stack_timers = self.independent_stack_timers or {}
	self.current_stack_count = self.current_stack_count or 0

	local stacks_increment = stacks or 1
	self.current_stack_count = self.current_stack_count + stacks_increment

	local timer_name = Timers:CreateTimer(duration or self:GetRemainingTime(), function(inner_timer_name)
		if not self or self:IsNull() then return end

		self.current_stack_count = self.current_stack_count - stacks_increment

		local new_stack_count = limit and math.min(self.current_stack_count, limit) or self.current_stack_count
		self:SetStackCount(new_stack_count)

		self.independent_stack_timers[inner_timer_name] = nil
		if new_stack_count == 0 and self:GetDuration() == -1 and remove_on_expire then self:Destroy() end
	end)

	self.independent_stack_timers[timer_name] = true

	local new_stack_count = limit and math.min(self.current_stack_count, limit) or self.current_stack_count
	self:SetStackCount(new_stack_count)

	if duration > self:GetRemainingTime() then
		self:SetDuration(duration, true)
	end
end


function CDOTA_Modifier_Lua:CancelIndependentStacks()
	for timer_name, _ in pairs(self.independent_stack_timers or {}) do
		Timers:RemoveTimer(timer_name)
		self.independent_stack_timers[timer_name] = nil
	end
	self.current_stack_count = 0
	self:SetStackCount(0)
end


function CDOTA_Modifier_Lua:GetUpgradeValueFor(value_name)
	if self.upgrade_values and self.upgrade_values[value_name] then return self.upgrade_values[value_name] end

	if not self.upgrade_name then
		local name = self:GetName()
		self.upgrade_name = name:gsub("modifier_", ""):gsub("_upgrade", "")
	end

	if not GenericUpgrades.generic_upgrades_data[self.upgrade_name] then return end

	local generic_boost = 100
	local rarity = GenericUpgrades.generic_upgrades_data[self.upgrade_name]["Rarity"]
	local specials = GenericUpgrades.generic_upgrades_data[self.upgrade_name]["specials"]

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

--	print("[SERVER]: Upgrade (name, boost, pre, post):", value_name, generic_boost, base_value, base_boosted_value)
	return base_boosted_value
end


function CDOTA_Modifier_Lua:GetPrimaryAttributeOfParent()
	return self:GetParent():GetModifierStackCount("modifier_primary_attribute_reader", self:GetParent())
end