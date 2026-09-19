--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- Получить цель выброса
---@param last_target any
---@param team_number any
---@param position any
---@param radius any
---@param team_filter any
---@param type_filter any
---@param flag_filter any
---@param order any
---@param unit_table any
---@param can_bounce_bounced_unit any
---@return CDOTA_BaseNPC
function GetBounceTarget(
	last_target,
	team_number,
	position,
	radius,
	team_filter,
	type_filter,
	flag_filter,
	order,
	unit_table,
	can_bounce_bounced_unit
)
	local first_targets =
		FindUnitsInRadius(team_number, position, nil, radius, team_filter, type_filter, flag_filter, order, false)

	for i = #first_targets, 1, -1 do
		local unit = first_targets[i]
		if unit == last_target then
			table.remove(first_targets, i)
		end
	end

	local second_targets = {}
	for k, v in pairs(first_targets) do
		second_targets[k] = v
	end

	if unit_table and type(unit_table) == "table" then
		for i = #first_targets, 1, -1 do
			if TableFindKey(unit_table, first_targets[i]) then
				table.remove(first_targets, i)
			end
		end
	end

	local first_target = first_targets[1]
	local second_target = second_targets[1]

	if
		can_bounce_bounced_unit ~= nil
		and type(can_bounce_bounced_unit) == "boolean"
		and can_bounce_bounced_unit == true
	then
		return first_target or second_target
	else
		return first_target
	end
end