--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--[[
Contents of this file are shared between Lua cliend and Lua server
Mainly utilities to calculate upgrade values with different operators properly
]]

UpgradesUtilities = UpgradesUtilities or {}
UpgradesUtilities._refresh_talents = {}


--- Check if passed talent name is registered to refresh upgrades cache on learn
---@param talent_name string
---@return boolean
function UpgradesUtilities:IsTalentRegisteredForRefresh(talent_name)
	return UpgradesUtilities._refresh_talents[talent_name] ~= nil
end


function UpgradesUtilities:RegisterTalents(talents)
	for talent_name, _ in pairs(talents) do
		UpgradesUtilities._refresh_talents[talent_name] = true
		print("[UpgradeUtilities] registered talent for refresh", talent_name)
	end
end


--- Parses upgrade KV into sane enum form
---@param upgrade_data table
---@param upgrade_name string @ either special value name or generic name
---@param upgrade_type UPGRADE_TYPE
---@param ability_name string @ ability name upgrade related to, or "generic"
function UpgradesUtilities:ParseUpgrade(upgrade_data, upgrade_name, upgrade_type, ability_name)
	upgrade_data.type = upgrade_type
	upgrade_data.upgrade_name = upgrade_name
	upgrade_data.operator = OPERATOR_TEXT_TO_ENUM[upgrade_data.operator or "OP_ADD"]
	upgrade_data.ability_name = ability_name or "generic"

	if upgrade_data.rarity then
		upgrade_data.rarity = RARITY_TEXT_TO_ENUM[upgrade_data.rarity] or UPGRADE_RARITY_COMMON
	end

	if upgrade_data.min_rarity then
		upgrade_data.min_rarity = RARITY_TEXT_TO_ENUM[upgrade_data.min_rarity] or UPGRADE_RARITY_COMMON
	end

	-- transform string to enum value
	if upgrade_data.attack_capability then
		upgrade_data.attack_capability = _G[upgrade_data.attack_capability]
	end

	-- linked is a table - operator assigned if defined, or defaults to OP_ADD (or override operator from parent)
	-- linked is a value - operator is OP_ADD (post-processed in upgrades.lua)

	local default_linked_operator = UPGRADE_OPERATOR.ADD

	if upgrade_data.linked_default_operator then
		default_linked_operator = OPERATOR_TEXT_TO_ENUM[upgrade_data.linked_default_operator]
		upgrade_data.linked_default_operator = nil
	end

	for _, linked_data in pairs(upgrade_data.linked_special_values or {}) do
		if type(linked_data) == "table" then
			linked_data.operator = (linked_data.operator and OPERATOR_TEXT_TO_ENUM[linked_data.operator]) or default_linked_operator
			UpgradesUtilities:RegisterTalents(linked_data.talents or {})
		end
	end

	for linked_ability, linked_data in pairs(upgrade_data.linked_abilities or {}) do
		for special_name, linked_special_data in pairs(linked_data or {}) do
			if type(linked_special_data) == "table" then
				linked_special_data.operator = (linked_special_data.operator and OPERATOR_TEXT_TO_ENUM[linked_special_data.operator]) or default_linked_operator
				UpgradesUtilities:RegisterTalents(linked_data.talents or {})
			end
		end
	end

	UpgradesUtilities:RegisterTalents(upgrade_data.talents or {})
end


--- Returns default base value for upgrade from certain ability at certain level
---@param hero any @ hero owning upgrades
---@param ability_level number
---@param ability_name string
---@param upgrade_name string
---@return number
function UpgradesUtilities:GetDefaultBaseValue(hero, ability_level, ability_name, upgrade_name)
	if not ability_name or not upgrade_name or ability_name == "generic" then return 0 end

	local ability = hero:FindAbilityByName(ability_name)
	if not IsValidEntity(ability) then return end

	return ability:GetLevelSpecialValueNoOverride(upgrade_name, ability_level or ability:GetLevel()) or 0
end



--- Returns calculated BONUS value from upgrades, accounting for different operators, talents etc.
---@param hero any @ hero owning upgrades
---@param upgrade_value number @ base value of specified upgrade instance
---@param count number @ count of specified upgrade instances
---@param upgrade_data table @ upgrade data itself, which should contain at least operator
---@param ability_level number @ optional, for ability base value calculations
---@param ability_name string @ optional, for ability base value calculations
---@param upgrade_name string @ optional, for ability base value calculations
---@return number
function UpgradesUtilities:CalculateUpgradeValue(hero, upgrade_value, count, upgrade_data, ability_level, ability_name, upgrade_name)
	local result = 0
	local final_multiplier = 1

	-- talent handling - either change the base value or fill final multiplier
	for talent_name, operation in pairs(upgrade_data.talents or {}) do
		local operator, value

		if type(operation) == "number" then
			operator = "+"
			value = operation
		else
			operator = string.sub(operation, 1, 1)
			value = tonumber(string.sub(operation, 2))
		end

		local talent = hero:FindAbilityByName(talent_name)
		if IsValidEntity(talent) and talent:GetLevel() > 0 then
			if operator == "+" then result = result + value end
			-- multiplier talents are processed after the final value is calculated
			-- this might need to be changed afterwards for multiplicative talents
			if operator == "x" then final_multiplier = final_multiplier * value end
		end
	end

	upgrade_value = upgrade_value * final_multiplier

	if not upgrade_data.operator or upgrade_data.operator == UPGRADE_OPERATOR.ADD then
		result = result + upgrade_value * count

		if upgrade_data.increment then
			-- arithmetic progression - using fomula N * (2a1 + (N - 1) * D) / 2, where N is count and D is an increment
			-- and since first increment is always 0 (using base value), then 2a1 can be skipped
			result = result + count * ((count - 1) * upgrade_data.increment) / 2.0
		end

	elseif upgrade_data.operator == UPGRADE_OPERATOR.MULTIPLY then
		local target = upgrade_data.multiplicative_target or DEFAULT_MULTIPLICATION_TARGET

		result = result + (upgrade_data.multiplicative_base_value or UpgradesUtilities:GetDefaultBaseValue(hero, ability_level, ability_name, upgrade_name))

		if result - target == 0 then return 0 end

		upgrade_value = math.abs(upgrade_value / (result - target))

		result = (target - result) * (1 - (1 - upgrade_value) ^ count)
	end

	return result
end